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
if request("M")="E" then
	Set conn = server.CreateObject("adodb.Connection")
	Conn.open constr
	conn.execute("delete usuario where cod_usuario="& request("icodusuario"))
	conn.Execute("delete perfilfuncion where cod_usuario="& request("icodusuario"))
	conn.Execute("delete usuarioperfil where cod_usuario="& request("icodusuario"))
	conn.close
	set conn=nothing
end if

if request("hdni")<>"" then
set conn= server.CreateObject("adodb.Connection")
conn.open constr
	for key = 1 to request("hdni")
		if request("chkactivo"&key)="1" then
			sql="Update usuario set est_activo='1' where cod_usuario="&request("hdncodigo"&key)
		else
			sql="Update usuario set est_activo='0' where cod_usuario="&request("hdncodigo"&key)
		end if
		conn.execute(sql)
	next
conn.close
set conn =nothing	
end if
%>
<script language="JavaScript1.2" src="../Include/Js/Tooltip.js"></script>
<script language="JavaScript1.2" src="../Include/Js/fConfirmAction.js"></script>

<div id="tooltip" style="position:absolute;visibility:hidden;"></div>
<body bgcolor="#FFFFFF" text="#000000">

<form action="<%=Request.ServerVariables("url")%>" method="post" name="frmListUsuarios">

<table width="450" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr align="center">
    <td ColSpan="5"  class="Titulo">Lista de Usuarios creados en el sistema IvMaker</td>
  </tr>
<%  'Listado
	i= 0
	set Rs= Server.CreateObject("adodb.recordset")
	StrSQl="Select cod_usuario,nom_usuario,est_Activo from usuario order by 2 asc"
	Rs.Open StrSQl, constr, 1, 1
	if not Rs.EOF then%>

  <tr>
    <td class="Titulo">Usuario</td>
    <td class="Titulo" align="center">Configurar</td>
    <td class="Titulo" align="center">Modificar</td>
    <td class="Titulo" align="center">Activar</td>
    <td class="Titulo" align="center">Borrar</td>
  </tr><tr>
    <td ColSpan="5"  class="LineaSeparadora"></td>
  </tr>
 <%iTotalRegistros= Rs.RecordCount
		Rs.PageSize= 15 ' N�mero de registros por p�gina 
		sScrollAction= Request.form("ScrollAction")
		if sScrollAction<>"" Then
			iNumeroPagina= cint(sScrollAction)
			if iNumeroPagina<1 Then iNumeroPagina= 1
		else
			iNumeroPagina= 1
		end if
		Rs.AbsolutePage= iNumeroPagina
		iTotalPaginas= Rs.PageCount
		iContadorFilas= Rs.PageSize
do while not Rs.EOF and iContadorFilas>0
i=i+1
  icodUsuario=rs(0)
  sNomusuario=rs(1)
  factivo=rs(2)
  %>
  <tr>
    <td ColSpan="5"  class="LineaSeparadora"></td>
  </tr>
  <tr class="texto">
    <td  ><%=sNomusuario%> </td>
    <td align="center"><a href="AsignUsuario.asp?icodUsuario=<%=icodUsuario%>"  class="texto" onMouseover="showtip(this,event,'Asigna al usuario <%=replace(ucase(trim(sNomUsuario)),"'","\'")%> a las publicaciones')" onMouseout="hidetip()">Ir a</a></td>
      <td align="center"><a href="EditUsuarios.asp?M=M&icodUsuario=<%=icodUsuario%>" class="texto" onMouseover="showtip(this,event,'Modifica datos del usuario <%=replace(ucase(trim(sNomUsuario)),"'","\'")%>')" onMouseout="hidetip()">Modificar</a></td>
      <td align="center">
		<input type="checkbox" name="chkactivo<%=i%>" value="1" <%if factivo="1" then%>Checked<%end if%>>
		<input type="hidden" name="hdncodigo<%=i%>" value="<%=icodusuario%>">				
      </td>
      <td align="center"><a href="JavaScript:fConfirmAction('ListUsuario.asp?M=E&icodUsuario=<%=icodUsuario%>', 'Desea Eliminar el registro?')" class="texto" onMouseover="showtip(this,event,'Elimina los datos del usuario <%=replace(ucase(trim(sNomUsuario)),"'","\'")%> ')" onMouseout="hidetip()" >Borrar</a></td>
  </tr>

  <%
 iContadorFilas= iContadorFilas - 1
 rs.movenext
  loop
  rs.close
  set rs=nothing%>
  <tr>
    <td ColSpan="5"  class="LineaSeparadora"></td>
  </tr><tr>
    <td ColSpan="5"  class="LineaSeparadora"></td>
  </tr>
   <tr bgcolor="#FFFFFF">
      <td ColSpan="5" valign="middle">
		<table border="0" valign="top" cellpadding="0" cellspacing="0" width="100%">
		<tr>
					<td align="left" valign="top">
						<input type="hidden" name="ScrollAction" value="<%=sScrollAction%>" />
						<input type="hidden" name="PagIni" value="<%=(iPrimeraPagina)%>" />
<%iNumPagLinks= 15  'Numero de Link Por p�gina
iNumPagLinks= iNumPagLinks - 1
iPrimeraPagina = 1
if Request.Form("PagIni") <> "" then iPrimeraPagina = Request.Form("PagIni")
iUltimaPagina = iPrimeraPagina + iNumPagLinks
'  muestra  el grupo inferior de links
if iNumeroPagina > iNumPagLinks and iPrimeraPagina <> 1 then%>
			<a href="javascript:document.frmListUsuarios.ScrollAction.value='<%=(iPrimeraPagina - 1)%>';document.frmListUsuarios.PagIni.value='<%=(iPrimeraPagina-iNumPagLinks)-1%>'; document.frmListUsuarios.submit()" class="paginacion">[<<<]</a>&nbsp;
<%	end if%>
<%	if  iTotalPaginas > 1 then
	for iLinkPage = iPrimeraPagina to iUltimaPagina
	 if iLinkPage <= iTotalPaginas then
	 	if iLinkPage = iNumeroPagina then%>
			<span class="paginacion"><b><%=iLinkPage%></b></span>&nbsp;
<%		else%>
			<a href="javascript:document.frmListUsuarios.ScrollAction.value='<%=iLinkPage%>'; document.frmListUsuarios.PagIni.value='<%=(iPrimeraPagina)%>'; document.frmListUsuarios.submit()" class="paginacion"><%=iLinkPage%></a>&nbsp;
<%		end if
	 end if
	next
end if%>
<%'Muestra el grupo superior de links
if iTotalPaginas>iNumPagLinks and iUltimaPagina<iTotalPaginas then%>
			<a href="javascript:document.frmListUsuarios.ScrollAction.value='<%=iLinkPage%>';document.frmListUsuarios.PagIni.value='<%=(iUltimaPagina+1)%>'; document.frmListUsuarios.submit()" class="paginacion">[&gt;&gt;&gt;]</a>
<%	end if%>
					</td>
					<td align="right" valign="top">
						<span class="paginacion">Total p�ginas <%=iTotalPaginas%></span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
<%else%>
			<tr bgcolor="#FFFFFF">
				<td valign="middle" align="center" class="texto" colspan="5">
					Por el momento no existen Auspicios registradas
				</td>
			</tr>
<%end if
'	Rs.Close
'	set Rs= nothing%>
			<tr bgcolor="#FFFFFF">
				<td valign="top" colspan="<%if i>0 then%>3<%else%>6<%end if%>">
					<a href="EditUsuarios.asp?M=N" class="texto">Nuevo usuario</a>
				</td>
<%if i>0 then%>
				<td valign="top" ColSpan="5"  align="right">
					<input type="hidden" name="hdnI" value="<%=i%>" />
					<a href="Javascript:document.frmListUsuarios.submit()" class="texto">Activar/Desactivar</a>
				</td>
<%end if%>
			</tr></table>

</body>


</html>