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
icodPublicacion=request("icodPublicacion")
iNumColsPan="2"
set Conn= server.CreateObject("adodb.Connection")
    conn.Open constr
    'saca nombre de usuario
    set Urs=conn.Execute("select nom_usuario from usuario where cod_usuario="& request("icodusuario"))
    sNomUsuario=urs(0)
    UrS.close
   set Urs=nothing
   
   if request("accion")<>"" then
		DeLStrSQl="delete usuarioperfil where cod_usuario="&icodusuario&" and cod_publicacion="&icodpublicacion&" and not cod_seccion is null"
		Conn.Execute(DelStrSQl)
		for each Key in request("Cod")
			Strsql="Insert usuarioperfil (cod_usuario, cod_publicacion,cod_seccion) values ("&icodusuario&","&icodpublicacion&","&key&")"
		 Conn.Execute(StrSQL)
		Next
   end if
function fMarcaCheckBox(CodPub,CodSecc)    
   ' Devuelve el Mcalor "checked" si la publicaiocn ya asignada al usuario en la tabla  usuarioPerfil
   Strsq="select cod_perfil from usuarioperfil where cod_usuario="& _
		icodusuario & " and cod_publicacion="& icodpublicacion & _
		" and cod_Seccion="& CodSecc
   set IngresadosRS=Conn.Execute(strsq)
   if  IngresadosRs.eof then
   fMarcaCheckBox=""
   ELSE
	fMarcaCheckBox="Checked"
   END IF
end function   
%>
<form name=ListPublicaciones method="post" action="<%=Request.ServerVariables("Url")%>">
  <table width="60%"  cellpadding=2 cellspacing=1 border=0 align="center">
    <tr align="center"  class=Titulo> 
      <td colspan="<%=iNumColSpan%>">Asignacion de  Secciones de la publicacion <%=snomPublicacion%>al usuario <b><%=snomUsuario%></b>
			<input type="hidden" name="icodUsuario" value="<%=icodusuario%>">
			<input type="hidden" name="icodpublicacion" value="<%=icodpublicacion%>">
			</td>
    </tr>
    <%strsql="select cod_Seccion,nom_Seccion from Seccion where cod_publicacion="&icodPublicacion &" order by 2"
    set Rs=Conn.Execute(strsql) %>
    <tr  class=CabeceraTabla> 
      <td>Seccion</td>
      <td>Asignar seccion</td>
    </tr>
    <tr class="LineaSeparadora"><td colspan="<%=iNumColSpan%>"></td></tr>
    <%if  rs.eof then%>
    <tr  class=PubRow><TD colspan="<%=iNumColSpan%>">No existen datos</td></tr>
    <%else
    do while not rs.eof
    iCodSeccion=rs(0)
    sNomSeccion=trim(rs(1))
    %>
	<tr><td colspan="<%=iNumColSpan%>"> </td> </tr>
    <tr class=<%if fMarcaCheckBox(iCodPublicacion,iCodSeccion)="Checked" then%>PubRows<%else%>PubRow<%end if%>> 
      <td width="60%"><%=sNomSeccion%></td>
      <td align="center"> 
        <input type="checkbox" name="Cod" value="<%=iCodSeccion%>" onclick="Toggle(this)" <%=fMarcaCheckBox(icodPublicacion,icodSeccion)%>>
      </td>
    </tr>
	<tr class="LineaSeparadora"><td colspan="<%=iNumColSpan%>"></td></tr>
     <%rs.movenext
    loop
    %>
    <tr align="center"> 
      <td colspan="<%=iNumColSpan%>"> 
        <input type="submit" name="accion" value="Asignar">
        <input type="button" name="accion" value="volver" onclick="location.href='ListRedactores.asp?iCodUsuario=<%=iCodUsuario%>&icodpublicacion=<%=icodpublicacion%>'">
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
