<!--#include file="../include/asp/conn.asp"-->
<!--VALIDALOGIN-->
<%session.Timeout=120%>
<html>
<head>
<title>Relacion de Usuarios</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../include/css/Stilo.css" type="text/css">
</head>
<%
icodPublicacion=request("iCodPublicacion")

if request("M")="E" then
	Set conn = server.CreateObject("adodb.Connection")
	Conn.open constr
	conn.execute("delete usuarioperfil where cod_usuario="& request("icodusuario") &" and cod_publicacion="& icodPublicacion)
	Conn.Execute("delete perfilfuncion where cod_usuario="& request("icodusuario") &" and cod_publicacion="&icodpublicacion)
	conn.close
	set conn=nothing
end if
%>
<%
Set RS= server.CreateObject("adodb.recordset")
	StrSQl="Select cod_usuario,nom_usuario from usuario " & _
	" where cod_usuario in(select cod_usuario from usuarioperfil where cod_publicacion="&icodpublicacion&")"& _
	" order by 2 asc"
Rs.open strsQL, ConStr%>
<script language="JavaScript1.2" src="../Include/Js/Tooltip.js"></script>
<script language="JavaScript1.2" src="../Include/Js/fConfirmAction.js"></script>

<div id="tooltip" style="position:absolute;visibility:hidden;"></div>
<body bgcolor="#FFFFFF" text="#000000">
<table width="450" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr align="center">
    <td colspan="5" class="Titulo">Lista de Usuarios creados en el sistema IvMaker</td>
  </tr>
  <tr>
    <td class="Titulo">Usuario</td>
    <td class="Titulo" align="center">Secciones</td>
    <td class="Titulo" align="center">Permisos</td>
    <td class="Titulo" align="center">Modificar</td>
    <td class="Titulo" align="center">Borrar</td>
  </tr><tr>
    <td colspan="5" class="LineaSeparadora"></td>
  </tr>
  <%do while not rs.eof
  icodUsuario=rs(0)
  sNomusuario=rs(1)
  %>
  <tr>
    <td colspan="5" class="LineaSeparadora"></td>
  </tr>
<tr class="texto">
  <td  ><%=sNomusuario%> </td>
  <td align="center"><a href="AsignSeccReda.asp?icodUsuario=<%=icodUsuario%>&icodpublicacion=<%=icodpublicacion%>&Back=U"  class="texto" onMouseover="showtip(this,event,'Asigna al usuario <%=replace(ucase(trim(sNomUsuario)),"'","\'")%> a las secciones')" onMouseout="hidetip()">Ir a</a></td>
  <td align="center"><a href="AsignFunccionReda.asp?icodUsuario=<%=icodUsuario%>&icodpublicacion=<%=icodpublicacion%>&Back=U"  class="texto" onMouseover="showtip(this,event,'Asigna al usuario <%=replace(ucase(trim(sNomUsuario)),"'","\'")%> a las secciones')" onMouseout="hidetip()">Ir a</a></td>
  <td align="center"><a href="EditRedactores.asp?M=M&icodUsuario=<%=icodUsuario%>&icodpublicacion=<%=icodpublicacion%>" class="texto" onMouseover="showtip(this,event,'Modifica datos del usuario <%=replace(ucase(trim(sNomUsuario)),"'","\'")%>')" onMouseout="hidetip()">Modificar</a></td>
  <td align="center"><a href="JavaScript:fConfirmAction('ListRedactores.asp?M=E&icodUsuario=<%=icodUsuario%>&icodpublicacion=<%=icodpublicacion%>', 'Desea Eliminar el registro?')" class="texto" onMouseover="showtip(this,event,'Elimina los datos del usuario <%=replace(ucase(trim(sNomUsuario)),"'","\'")%> ')" onMouseout="hidetip()" >Borrar</a></td>
</tr>

  <%rs.movenext
  loop
  rs.close
  set rs=nothing%>
  <tr>
    <td colspan="5" class="LineaSeparadora"></td>
  </tr><tr>
    <td colspan="5" class="LineaSeparadora"></td>
  </tr>
  <tr>
    <td  class="texto"><a href="EditRedactores.asp?M=N" onMouseover="showtip(this,event,'Crear nuevo redactor ')" onMouseout="hidetip()">Nuevo Usuario</a></td>
    <td colspan="2" class="texto"><a href="AsignReda.asp?icodpublicacion=<%=icodpublicacion%>" onMouseover="showtip(this,event,'asignar nuevo redactor ')" onMouseout="hidetip()">Asignar usuario existente</a></td>
    <td></td>    <td></td>    
  </tr>
  <tr><td colspan="5" class="texto" bgcolor="#eeeeee">Nota: un usuario creado esta por defecto con todos los permisos concedidos, si desea restringir los permisos estos deben ser configurados</td></tr>
</table>

</body>


</html>