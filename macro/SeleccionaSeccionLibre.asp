<%@ Language=VBScript %>
<!--#include file="../include/asp/conn.asp"-->
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" type="text/css" href="../include/Css/Stilo.css">
<script LANGUAGE="JavaScript">
lck=0;
function r(hval) {
                opener.document.frmDeInteres.txtCodSeccion.value=hval;
}         
</script>

</HEAD>
<BODY>
<%icodSecc=request("icodSecc")
icodpub=request("codpub")
%>

<%
set rs= Server.CreateObject("adodb.Recordset")
strsql="select cod_Seccion, nom_seccion from seccion where cod_publicacion="&icodpub&" and cod_seccion not in " & _
		" (select cod_Seccion from deInteres )"
rs.Open strsql,constr
%>
<div align="center">
<form name="Lista" action="<%Request.ServerVariables("url")%>" method="post">
<table width="95%" cellpadding="1" cellspacing="1" align="center">
<tr><td Class="titulo">Lista de Secciones Libres</td></TR>
<tr><td></td></tr>
<tr><td><Select name="SeccionLibre" size=5>

<%do while not RS.eof %>
<option value="<%=rs(0)%>"><%=rs(1)%></option>
<%Rs.movenext
loop
rs.close
set rs=nothing%>
</select>
<br>
<a HREF="javascript:window.close()"
        onMouseOver="r(document.Lista.SeccionLibre.options[document.Lista.SeccionLibre.selectedIndex].value); return true">Seleccionar </a>
</table>
</form></div>
</BODY>
</HTML>
