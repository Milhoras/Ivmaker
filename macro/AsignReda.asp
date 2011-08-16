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
if request("asignar")<>"" then
	icodpublicacion=request("icodpublicacion")
	set Conn = server.CreateObject("Adodb.Connection")
	Conn.Open constr
	for each key in Request.Form("icodusuario")
		strsql="insert usuarioperfil (cod_usuario, cod_publicacion) values("&key&","&icodpublicacion & ")"
		'Response.Write(strsql & "<br>")
		conn.Execute(strsql)
	next
	conn.Close
	set conn=nothing
	Response.Redirect("ListRedactores.asp?icodpublicacion="&icodpublicacion)
end if

icodpublicacion=request("icodpublicacion")
set rs= Server.CreateObject("Adodb.recordset")
strsql="select cod_usuario, nom_usuario from usuario where cod_usuario not in" & _
		" (select cod_usuario from usuarioperfil where cod_publicacion="&icodpublicacion&")" & _
		" order by 2 asc" 
rs.Open strsql, constr

inumColspan="2"%>

<form action="<%Request.ServerVariables("URL")%>" name="redactores" method="Post">
<input type="hidden" name="icodpublicacion" value="<%=icodpublicacion%>">
<TABLE cellSpacing=1 cellPadding=1 width="55%" align=center border=0>
  
  <TR>
    <TD colspan="2" class=Titulo align="center"> Relacion de usuario disponibles para asignacion a la publicacion </TD></TR>
  <TR  class=CabeceraTabla>
    <TD>usuario</TD>
    <TD>Asignar</TD></TR>
    <tr class="LineaSeparadora"><td colspan="<%=iNumColSpan%>"></td></tr>
    <tr class="LineaSeparadora"><td colspan="<%=iNumColSpan%>"></td></tr>
  <%do while not rs.eof 
  icodusuario=rs(0)
  snomusuario=rs(1)
  %>
  <TR class="PubRow">
    <TD><%=snomusuario%></TD>
    <TD align="center"><input type="checkbox" name="iCodUsuario" value="<%=icodusuario%>"  onclick="Toggle(this)" > </TD></TR>
  <tr class="LineaSeparadora"><td colspan="<%=iNumColSpan%>"></td></tr>
  <%rs.movenext
  loop
  rs.close
  set rs=nothing%>
  <tr class="LineaSeparadora"><td colspan="<%=iNumColSpan%>"></td></tr>
  <TR class=CabeceraTabla>
    <TD colspan="2" align="center"><input type="submit" name="asignar" value="Asignar">
    <%if request("Menu")<>1 then%>
		<input type="button" name="volver" value="Volver" onclick='location.href="listRedactores.asp?icodpublicacion=<%=icodpublicacion%>"'>
	<%end if%>
    </TD>
  </TR>
  </TABLE>
    </form>

</BODY>
</HTML>
