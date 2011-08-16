<!--#include file="../include/ASP/Conn.asp" -->

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<!--enlace a Style Sheet para funcionameinto de la lista de checkbox-->
<LINK rel="stylesheet" type="text/css" href="../include/Css/CheckBoxList.css">
<LINK rel="stylesheet" type="text/css" href="../include/Css/Stilo.css">
<SCRIPT LANGUAGE=Javascript src="../include/Js/fToggleCheckBox.js"></script>
</HEAD>
<BODY bgcolor="#FFFFFF">
<%
iCodUsuario=request("icodusuario")
IcodPublicacion=request("icodPublicacion")

iNumColsPan="3"
set Conn= server.CreateObject("adodb.Connection")
    conn.Open constr
    'saca nombre de usuario
    set Urs=conn.Execute("select nom_usuario from usuario where cod_usuario="& iCodusuario)
    sNomUsuario=urs(0)
    UrS.close
   set Urs=nothing
	   
   if request("accion")<>"" then
   icodusuario=request("icodusuario")
   icodpublicacion=request("icodpublicacion")
   
   iMaxContador=request("hdnMaxContador")
   for key=1 to imaxcontador
	if request("cod"&key)<>"" then
		icodfuncion=request("cod"&key)
		set rslock= conn.Execute("select cod_registro from perfilfuncion where cod_usuario="&icodusuario & " and cod_publicacion="&icodpublicacion & " and cod_funcion="&icodfuncion)
		if rslock.eof then
		sqlGraba="insert perfilfuncion (cod_usuario,cod_publicacion,cod_funcion )" & _
			" values("&icodusuario&","&icodpublicacion&","&icodfuncion&")"
		conn.Execute(sqlGraba)
		end if
		rslock.close
		set rslock =nothing
		fmuestra=1
			%>
	<script>
		parent.frames[0].location.reload();
	</script>
	<%	

	else
		icodFuncion=request("hdnCodigo"&key)
		sqlBorraFunc="delete perfilfuncion where cod_usuario="&icodusuario & " and cod_publicacion="& icodpublicacion &" and cod_funcion="&icodfuncion
		conn.Execute(sqlborrafunc)	
	end if
   
   
   next
   
end if
	'Esta condicion configura la tabla si ya hay datos asignados
	if fmuestra=1 then  inumColSpan="4"	

   
function fMarcaCheckBox(CodFunc)    
   ' Devuelve el valor "checked" si la publicacion ya asignada al usuario en la tabla  usuarioPerfil
   Strsq="select cod_registro from perfilfuncion where cod_usuario="& icodusuario & " and cod_publicacion="& icodpublicacion &" and cod_funcion="& CodFunc
   set IngresadosRS=Conn.Execute(strsq)
   if  IngresadosRs.eof then
   fMarcaCheckBox=""
   ELSE
	fMarcaCheckBox="Checked"
   END IF
   IngresadosRs.close
   set IngresadosRs =nothing
end function   
 
%>
<form name=ListPublicaciones method="post" action="<%=Request.ServerVariables("Url")%>">
  <table width="60%"  cellpadding=2 cellspacing=1 border=0 align="center">
    <tr align="center"  class=Titulo> 
      <td colspan="<%=iNumColSpan%>">Asignacion de  funciones al usuario <b><%=snomUsuario%></b>
			<input type="hidden" name="icodUsuario" value="<%=iCodUsuario%>">
			<input type="hidden" name="icodpublicacion" value="<%=iCodPublicacion%>">
			<%'solo para volver al listado de redactores%>
			<input type="hidden" name="BAck" value="<%=request("BAck")%>">
	  </td>
    </tr>
    <%strsql="select funciones.cod_funcion,funciones.des_funcion, funciones.tip_comando from funciones,temafuncion" & _
			" where funciones.cod_tema=temafuncion.cod_tema and  " & _
			" temafuncion.tip_tema='P' and funciones.est_Activo='1' order by funciones.des_funcion, funciones.cod_tema"
    set Rs=Conn.Execute(strsql) %>
    <tr class=CabeceraTabla> 
      <td>Funcion</td>
      <td>Asignar funcion</td>
      <td>Tipo Funcion</td>
    </tr>
    <tr class="LineaSeparadora"><td colspan="<%=iNumColSpan%>"></td></tr>
    <%if  rs.eof then%>
    <tr  class=PubRow><TD colspan="<%=iNumColSpan%>">No existen datos</td></tr>
    <%else
    contador=0
    do while not rs.eof
    iCodFuncion=rs(0)
    sDesFuncion=trim(rs(1))
    sTipoFuncion=rs(2)
    contador=contador+1
    %>
	<tr><td colspan="<%=iNumColSpan%>"> </td> </tr>
    <tr class=<%if fMarcaCheckBox(icodFuncion)="Checked" then%>PubRows<%else%>PubRow<%end if%>> 
      <td width="60%"><%=sDesFuncion%></td>
      <td align="center"> 
        <input type="checkbox" name="Cod<%=contador%>" value="<%=iCodFuncion%>" onclick="Toggle(this)" <%=fMarcaCheckBox(icodfuncion)%>>
        <input type="hidden" name="hdncodigo<%=contador%>" value="<%=icodfuncion%>">
      </td>
      <td align="center"><%=sTipoFuncion%></td>
    </tr>
	<tr class="LineaSeparadora"><td colspan="<%=iNumColSpan%>"></td></tr>
     <%rs.movenext
    loop  %>
    <tr align="center"> 
      <td colspan="<%=iNumColSpan%>"> 
        <input type="submit" name="accion" value="Asignar">
        <input type="hidden" name="hdnMaxContador" value="<%=contador%>">
        <input type="button" name="accion" value="Volver" onclick='location.href="AsignUsuario.asp?icodusuario=<%=icodusuario%>"'> 
      </td>
    </tr>
    <%end if			' fin del if que verifica que el RS tenga datos
    rs.close
    set rs=nothing%>
    <tr><td colspan="<%=iNumColSpan%>" class="PubRow">
    <font size="1">
     Nota: los tipos de funcion son: <blockquote> <b>L</b> (Enlace , debera aparecer en el Menú),<br> <b>P</b> (Procedure se aisgna pero no aparece en le menu )</blockquote>
     </font></td></tr>
    </table>
</form>

</BODY>
</HTML>
