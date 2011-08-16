<!--#include file="../include/asp/conn.asp"-->
<!--VALIDALOGIN-->

<html>
<head>
<title>Relacion de Servidores por usuario</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../include/css/Stilo.css" type="text/css">
</head>
<%
if request("M")="E" then
	Set conn = server.CreateObject("adodb.Connection")
	Conn.open constr
	conn.execute("delete Servidores where cod_Servidor="& request("icodServidor"))
	conn.close
	set conn=nothing


end if
%>

<%
Set RS= server.CreateObject("adodb.recordset")
	StrSQl="Select cod_servidor,nom_servidor from Servidores order by 2 asc"
Rs.open strsQL, ConStr%>
<script language="JavaScript1.2" src="../Include/Js/Tooltip.js"></script>
<script language="JavaScript1.2" src="../Include/Js/fConfirmAction.js"></script>
<div id="tooltip" style="position:absolute;visibility:hidden;"></div>
<body bgcolor="#FFFFFF" text="#000000">
<table width="450" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr align="center">
    <td colspan="4" class="Titulo">Lista de Servidores Creados en el sistema</td>
  </tr>
  <tr>
    <td class="Titulo">Servidor</td>
    <td class="Titulo" align="center">Modificar</td>
    <td class="Titulo" align="center">Borrar</td>
  </tr>
  <tr><td colspan="4" class="LineaSeparadora" ></td></tr>
  
  <%do while not rs.eof
  icodServidor=trim(rs(0))
  sNomServidor=rs(1)
  %>
  <tr>
    <td  class="texto"><%=SnomServidor%> </td>
    <td align="center"><a href="EditServidor.asp?M=M&icodServidor=<%=icodServidor%>"  class="texto" onMouseover="showtip(this,event,'Modificar datos del servidor <%=ucase(trim(sNomservidor))%>')" onMouseout="hidetip()">Modificar      </a></td>
    <td align="center"><a href="JavaScript:fConfirmAction('ListTemas.asp?M=E&iCodTema=<%=iCodTema%>', 'Desea Eliminar el registro?')" class="texto" onMouseover="showtip(this,event,'Elimina los datos del servidor <%=ucase(trim(sNomservidor))%> ')" onMouseout="hidetip()" >Borrar</a></td>
  </tr>
<tr><td colspan="4" class="LineaSeparadora" ></td></tr>
  
  <%rs.movenext
  loop
  rs.close
  set rs=nothing%>
  <tr>
    <td  class="texto"><a href="Edit.asp?M=N" onMouseover="showtip(this,event,'Crear nuevo Servidor ')" onMouseout="hidetip()">Nueva estacion</a></td>
    <td></td><td></td>
    <td></td>
  </tr>
</table>
</body>


</html>