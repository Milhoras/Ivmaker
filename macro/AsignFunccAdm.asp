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
if icodUsuario="" then icodusuario=session("coduser")
'IcodPublicacion=request("icodPublicacion")
'icodPerfil=request("icodPerfil")
iNumColsPan="2"
set Conn= server.CreateObject("adodb.Connection")
    conn.Open constr
    'saca nombre de usuario
    set Urs=conn.Execute("select nom_usuario from usuario where cod_usuario="& iCodusuario)
    sNomUsuario=urs(0)
    UrS.close
   set Urs=nothing
	   
   if request("accion")<>"" then
		'Este borrado solo asign una publicaion o verifica los huerfoanos debues de la des-asignacion
		DeLStrSQl="DELETE perfilfuncion WHERE cod_usuario = "&icodusuario & " and cod_publicacion is null" 
		Conn.Execute(DelStrSQl)
		for each Key in request("Cod")
			Strsql="Insert perfilfuncion (cod_usuario,cod_funcion) values ("&icodusuario&","&key&")"
		 Conn.Execute(StrSQL)
		fMuestra=1
		Next
	'Esta condicion configura la tabla si ya hay datos asignados
	if fmuestra=1 then  inumColSpan="4"		
	%>
	<script>
		parent.frames[0].location.reload();
	</script>
	<%
   end if
   
function fMarcaCheckBox(CodFunc)    
   ' Devuelve el valor "checked" si la publicacion ya asignada al usuario en la tabla  usuarioPerfil
   Strsq="select cod_registro from perfilfuncion where cod_usuario="& icodusuario & " and cod_publicacion is null and cod_funcion="& CodFunc
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
      <td colspan="<%=iNumColSpan%>">Asignacion de  funciones Administrativas al usuario <br><b><%=snomUsuario%></b>
			<input type="hidden" name="icodUsuario" value="<%=iCodUsuario%>">
						
			</td>
    </tr>
    <%strsql="select funciones.cod_funcion,funciones.des_funcion from funciones,temafuncion" & _
			" where funciones.cod_tema=temafuncion.cod_tema and  " & _
			" temafuncion.tip_tema='G'  order by funciones.cod_tema"
    set Rs=Conn.Execute(strsql) %>
    <tr  class=CabeceraTabla> 
      <td>Funcion</td>
      <td>Asignar funcion</td>
    </tr>
    <tr class="LineaSeparadora"><td colspan="<%=iNumColSpan%>"></td></tr>
    <%if  rs.eof then%>
    <tr  class=PubRow><TD colspan="<%=iNumColSpan%>">No existen datos</td></tr>
    <%else
    do while not rs.eof
    iCodFuncion=rs(0)
    sDesFuncion=trim(rs(1))
    %>
	<tr><td colspan="<%=iNumColSpan%>"> </td> </tr>
    <tr class=<%if fMarcaCheckBox(icodFuncion)="Checked" then%>PubRows<%else%>PubRow<%end if%>> 
      <td width="60%"><%=sDesFuncion%></td>
      <td align="center"> 
        <input type="checkbox" name="Cod" value="<%=iCodFuncion%>" onclick="Toggle(this)" <%=fMarcaCheckBox(icodfuncion)%>>
      </td>
    </tr>
	<tr class="LineaSeparadora"><td colspan="<%=iNumColSpan%>"></td></tr>
     <%rs.movenext
    loop
    %>
    <tr align="center"> 
      <td colspan="<%=iNumColSpan%>"> 
        <input type="submit" name="accion" value="Asignar">
        <input type="button" name="accion" value="Volver" onclick='location.href="ListuserAdm.asp?icodusuario=<%=icodusuario%>"'> 
      </td>
    </tr>
    <%end if			' fin del if que verifica que el RS tenga datos
    rs.close
    set rs=nothing%>
    <tr><td colspan="<%=iNumColSpan%>" class="PubRow">
    <font size="1">
     
     </font></td></tr>
    </table>
</form>

</BODY>
</HTML>
