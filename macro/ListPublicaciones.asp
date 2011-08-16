<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../include/asp/conn.asp" -->
<!-- #include file="../Include/Asp/fTienePermisoPagina.asp"-->
<!-- #include file="../Include/Asp/incVerificaAutorizacionPagina.asp" -->
<%'Declaración de variables
	dim oRs, sSql, iCodPublicacion, sNombrePublicacion, i, oConn
	dim iTotalRegistros, iNumeroPagina, sScrollAction, iTotalPaginas _
	, iContadorFilas, iNumPagLinks, iPrimeraPagina, iUltimaPagina, iLinkPage%>
<%'Abrir la conexión
	set oConn= Server.CreateObject("ADODB.connection")
	oConn.Open constr%>
<%'El proceso de activación
	if not IsEmpty(Request.Form("hdnI")) then
		dim ixCodigo
		for i=1 to CInt(Request.Form("hdnI")) 
			ixCodigo= Request.Form("hdnCodigo" & CStr(i))
			if Request.Form("chkActivo" & CStr(i)) <> "" then
				sSql= "UPDATE publicacion SET est_activo='1' WHERE cod_publicacion=" & ixCodigo
			else
				sSql= "UPDATE publicacion SET est_activo='0' WHERE cod_publicacion=" & ixCodigo
			end if
			oConn.Execute sSql
		next
	end if%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Listado de publicaciones</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="../Include/Css/stilo.css" type="text/css" />
		<script language="JavaScript" src="../Include/Js/fConfirmAction.js"></script>
	</head>
	<body bgcolor="#FFFFFF" marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
		<form action="../Macro/ListPublicaciones.asp" method="post" name="frmListPublicacion" id="frmListPublicacion">
		<table width="500" border="0" cellspacing="1" cellpadding="2" bgcolor="#c0c0c0">
			<tr bgcolor="#FFFFFF">
				<td colspan="5" align="center" class="Titulo">Listado de Publicaciones</td>
			</tr>
<%'Listado
	i= 0
	set oRs= Server.CreateObject("adodb.recordset")
	sSql= "SELECT cod_publicacion, nom_publicacion, est_activo" & _
	" FROM publicacion ORDER BY nom_publicacion ASC"
	oRs.Open sSql, oConn, 1, 1
	if not oRs.EOF then%>
			<tr bgcolor="#FFFFFF">
				<td class="textobold" width="40%">Publicación</td>
				<td class="textobold" align="center" width="15%">Secciones</td>
				<td class="textobold" align="center" width="15%">Modificar</td>
				<td class="textobold" align="center" width="15%">Eliminar</td>
				<td class="textobold" align="center" width="15%">Activo</td>
			</tr>
<%
		iTotalRegistros= oRs.RecordCount
		oRs.PageSize= 15 ' Número de registros por página 
		sScrollAction= Request.form("ScrollAction")
		if sScrollAction<>"" Then
			iNumeroPagina= cint(sScrollAction)
			if iNumeroPagina<1 Then iNumeroPagina= 1
		else
			iNumeroPagina= 1
		end if
		oRs.AbsolutePage= iNumeroPagina
		iTotalPaginas= oRs.PageCount
		iContadorFilas= oRs.PageSize
		do while not oRs.EOF and iContadorFilas>0
			iCodPublicacion= Trim(oRs("cod_publicacion"))
			sNombrePublicacion= Trim(oRs("nom_publicacion"))
			i= i + 1%>
			<tr bgcolor="#FFFFFF">
				<td valign="middle" width="40%" class="texto">
					<%=sNombrePublicacion%>
				</td>
				<td valign="middle" width="15%" align="center">
					<a href="ListSecciones.asp?CodPub=<%=iCodPublicacion%>" class="texto">Ir a</a>
				</td>
				<td valign="middle" width="15%" align="center">
					<a href="EditPublicaciones.asp?CodPub=<%=icodPublicacion%>" class="texto">Modificar</a>
				</td>
				<td valign="middle" width="15%" align="center">
					<a href="JavaScript:fConfirmAction('ElimPublicaciones.asp?CodPub=<%=icodPublicacion%>', '¿Está seguro de eliminar esta publicaci\ón\nRecuerde que al hacerlo eliminará todas sus secciones y notas?')" class="texto">Eliminar</a>
				</td>
				<td valign="middle" width="15%" align="center">
					<input type="checkbox" name="chkActivo<%=i%>" value="1" <%if oRs("est_activo")="1" then%>checked<%end if%>/>
					<input type="hidden" name="hdnCodigo<%=i%>" value="<%=icodPublicacion%>" />
				</td>
			</tr>
<%
			iContadorFilas= iContadorFilas - 1
			oRs.MoveNext
		loop%>
			<tr bgcolor="#FFFFFF">
				<td colspan="5" valign="middle">
					<table border="0" valign="top" cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td align="left" valign="top">
								<input type="hidden" name="ScrollAction" value="<%=sScrollAction%>" />
								<input type="hidden" name="PagIni" value="<%=(iPrimeraPagina)%>" />
<%	iNumPagLinks= 15  'Numero de Link Por página
		iNumPagLinks= iNumPagLinks - 1
		iPrimeraPagina = 1
		if Request.Form("PagIni") <> "" then iPrimeraPagina = Request.Form("PagIni")
		iUltimaPagina = iPrimeraPagina + iNumPagLinks
		'  muestra  el grupo inferior de links
		if iNumeroPagina > iNumPagLinks and iPrimeraPagina <> 1 then%>
								<a href="javascript:document.frmListPublicacion.ScrollAction.value='<%=(iPrimeraPagina - 1)%>';document.frmListPublicacion.PagIni.value='<%=(iPrimeraPagina-iNumPagLinks)-1%>'; document.frmListPublicacion.submit()" class="paginacion">[<<<]</a>&nbsp;
<%	end if%>
<%	if  iTotalPaginas > 1 then
			for iLinkPage = iPrimeraPagina to iUltimaPagina
				if iLinkPage <= iTotalPaginas then
					if iLinkPage = iNumeroPagina then%>
								<span class="paginacion"><b><%=iLinkPage%></b></span>&nbsp;
<%				else%>
								<a href="javascript:document.frmListPublicacion.ScrollAction.value='<%=iLinkPage%>'; document.frmListPublicacion.PagIni.value='<%=(iPrimeraPagina)%>'; document.frmListPublicacion.submit()" class="paginacion"><%=iLinkPage%></a>&nbsp;
<%				end if
				end if
			next
		end if%>
		<%'Muestra el grupo superior de links
		if iTotalPaginas>iNumPagLinks and iUltimaPagina<iTotalPaginas then%>
								<a href="javascript:document.frmListPublicacion.ScrollAction.value='<%=iLinkPage%>';document.frmListPublicacion.PagIni.value='<%=(iUltimaPagina+1)%>'; document.frmListPublicacion.submit()" class="paginacion">[&gt;&gt;&gt;]</a>
<%	end if%>
							</td>
							<td align="right" valign="top">
								<span class="paginacion">Total páginas <%=iTotalPaginas%></span>
							</td>
						</tr>
					</table>
				</td>
			</tr>
<%else%>
			<tr bgcolor="#FFFFFF">
				<td valign="middle" align="center" class="texto" colspan="5">
					Por el momento no existen publicaciones registradas
				</td>
			</tr>
<%end if
	oRs.Close
	set oRs= nothing%>
			<tr bgcolor="#FFFFFF">
				<td valign="top" colspan="<%if i>0 then%>3<%else%>6<%end if%>">
					<a href="../Macro/IngrPublicaciones.asp" class="texto">Nueva publicación</a>
				</td>
<%if i>0 then%>
				<td valign="top" colspan="3" align="right">
					<input type="hidden" name="hdnI" value="<%=i%>" />
					<a href="Javascript:document.frmListPublicacion.submit()" class="texto">Activar/Desactivar</a>
				</td>
<%end if%>
			</tr>
		</table>
		</form>
	</body>
</html>
<%oConn.Close
	set oConn= nothing%>