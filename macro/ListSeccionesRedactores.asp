<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../include/asp/conn.asp" -->
<!-- #include file="../Include/Asp/fTienePermisoPagina.asp"-->
<!-- #include file="../Include/Asp/incVerificaAutorizacionPagina.asp" -->
<%if not IsNumeric(Request.QueryString("CodPub")) or Trim(Request.QueryString("CodPub"))="" then
		pMensaje "Ingrese una publicación válida", "../default.asp", "_top"
	end if%>
<!-- #include file="../Include/Asp/incVerificaAutorizacionPubSec.asp" -->
<!-- #include file="../Include/Asp/fValorCampo.asp" -->
<%'Declaración de variables
	dim oRs, sSql, iCodPublicacion, iCodSeccion, i, oConn, sNombreSeccion
	dim iTotalRegistros, iNumeroPagina, sScrollAction, iTotalPaginas _
	, iContadorFilas, iNumPagLinks, iPrimeraPagina, iUltimaPagina, iLinkPage%>
<%'Abrir la conexión
	set oConn= Server.CreateObject("ADODB.connection")
	oConn.Open constr%>
<%'Recoge el código de la publicación
	iCodPublicacion= CInt(Request.QueryString("CodPub"))%>
<%if not IsEmpty(Request.Form("hdnI")) then
		dim ixCodigo
		for i=1 to CInt(Request.Form("hdnI")) 
			ixCodigo= Request.Form("hdnCodigo" & CStr(i))
			if Request.Form("chkActivo" & CStr(i)) <> "" then
				sSql= "UPDATE seccion SET est_activo='1' WHERE cod_seccion=" & ixCodigo
			else
				sSql= "UPDATE seccion SET est_activo='0' WHERE cod_seccion=" & ixCodigo
			end if
			oConn.Execute sSql
		next
	end if%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Listado de secciones para redactores</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="../Include/Css/stilo.css" type="text/css" />
		<script language="JavaScript" src="../Include/Js/fConfirmAction.js"></script>
	</head>
	<body bgcolor="#FFFFFF" marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
		<form action="../Macro/ListSeccionesRedactores.asp?CodPub=<%=iCodPublicacion%>" method="post" name="frmListSeccionRedactor" id="frmListSeccionRedactor">
		<table width="500" border="0" cellspacing="1" cellpadding="2" bgcolor="#c0c0c0">
			<tr bgcolor="#FFFFFF">
				<td colspan="7" align="center" class="Titulo">Listado de Secciones / <%=fValorCampo("nom_publicacion", "publicacion", constr, "cod_publicacion=" & iCodPublicacion)%></td>
			</tr>
<%'Listado
	i= 0
	set oRs= Server.CreateObject("adodb.recordset")
	sSql= "SELECT a.cod_seccion, a.nom_seccion, a.est_generadoindice" & _
	", a.est_activo" & _
	" FROM seccion a, usuarioperfil b WHERE b.cod_usuario=" & Session("coduser") & _
	" AND b.cod_seccion=a.cod_seccion AND b.cod_publicacion=" & iCodPublicacion & _
	" ORDER BY nom_seccion ASC"
	oRs.Open sSql, oConn%>
<%
	if not oRs.EOF then%>
			<tr bgcolor="#FFFFFF">
				<td class="textobold" width="40%">Sección</td>
				<td class="textobold" align="center" width="10%">Notas</td>
				<td class="textobold" align="center" width="10%">Generar<br>todo</td>
				<td class="textobold" align="center" width="10%">Generar<br>índice</td>
				<td class="textobold" align="center" width="10%">Listo</td>
				<td class="textobold" align="center" width="10%">Notas<br>archivadas</td>
				<td class="textobold" align="center" width="10%">Activo</td>	
			</tr>
<%
		do while not oRs.EOF
			iCodSeccion= Trim(oRs("cod_seccion"))
			sNombreSeccion= Trim(oRs("nom_seccion"))
			i= i + 1%>
			<tr bgcolor="#FFFFFF">
				<td valign="middle" width="40%" class="texto">
					<%=sNombreSeccion%>
				</td>
				<td valign="middle" width="10%" align="center">
					<a href="ListNotas.asp?CodSec=<%=iCodSeccion%>&amp;CodPub=<%=iCodPublicacion%>" class="texto">Ir a</a>
				</td>
				<td valign="middle" width="10%" align="center">
					<a href="GenSeccion.asp?CodSec=<%=iCodSeccion%>&amp;CodPub=<%=iCodPublicacion%>&amp;UrlRetorno=<%=Server.URLPathEncode("ListSeccionesRedactores.asp")%>"><img src="../Image/htmlgrupo.gif" border="0" alt="Generar página html para el índice de la sección y todas sus notas" WIDTH="32" HEIGHT="32"></a>
				</td>
				<td valign="middle" width="10%" align="center">
					<a href="GenIndiceSeccion.asp?CodSec=<%=iCodSeccion%>&amp;CodPub=<%=iCodPublicacion%>&amp;UrlRetorno=<%=Server.URLPathEncode("ListSeccionesRedactores.asp")%>"><img src="../Image/html.gif" border="0" alt="Generar página html sólo para el índice de la sección" WIDTH="24" HEIGHT="25"></a>
				</td>
				<td valign="middle" width="10%" align="center">
<%'verifica si la sección ha completado su generación
			if Trim(oRs("est_generadoindice"))="1" then%>
					<font face="webdings" size="2" color="black">a</font>
<%
			end if%>	
				</td>
				<td valign="middle" width="10%" align="center">
					<a href="ListNotas.asp?CodSec=<%=iCodSeccion%>&CodPub=<%=iCodPublicacion%>&EstArch=0" class="texto"><font size="6" face="Wingdings">5</font></a>
				</td>
				<td valign="middle" width="10%" align="center">
					<input type="checkbox" name="chkActivo<%=i%>" value="1" <%if oRs("est_activo")="1" then%>checked<%end if%> >
					<input type="hidden" name="hdnCodigo<%=i%>" value="<%=iCodSeccion%>" >
				</td>
			</tr>
<%
			oRs.MoveNext
		loop%>
			<tr bgcolor="#FFFFFF">
				<td valign="top" align="left">
					<a href="GenPortadaPublicacion.asp?CodPub=<%=iCodPublicacion%>" class="texto">Genera portada</a>
				</td>
				<td valign="top" colspan="6" align="right">
					<input type="hidden" name="hdnI" value="<%=i%>">
					<a href="Javascript:document.frmListSeccionRedactor.submit()" class="texto">Activar/Desactivar</a>
				</td>
			</tr>
<%else%>
			<tr bgcolor="#FFFFFF">
				<td valign="middle" align="center" class="texto" colspan="7">
					Por el momento no existen secciones de esta publicación asignadas a usted
				</td>
			</tr>
<%end if
	oRs.Close
	set oRs= nothing%>
		</table>
		</form>
	</body>
</html>
<%oConn.Close
	set oConn= nothing%>