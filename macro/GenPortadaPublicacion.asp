<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../Include/Asp/Conn.asp" -->
<%if not IsNumeric(Request.QueryString("CodPub")) or Trim(Request.QueryString("CodPub"))="" then
		pMensaje "Ingrese una publicación válida", "../default.asp", "_top"
	end if%>
<%'Autorización para la página
	if IsEmpty(Session("EstaAutorizadoPagina")) then
		pMensaje "No está autorizado generar portada de publicación", _
			"../Macro/ListSeccionesRedactores.asp?CodPub=" & _
			Request.QueryString("CodPub"), "_self"
	end if%>
<!-- #include file="../Include/Asp/incConstantesNombresSubDirectorios.asp" -->
<!-- #include file="../Include/Asp/pVerificaCreaDirectorio.asp" -->
<!-- #include file="../Include/Asp/fCreaPaginaHtmlDesdePaginaAsp.asp" -->
<!-- #include file="../Include/Asp/fMueveArchivoPortadaPublicacionGenerado.asp" -->
<!-- #include file="../Include/Asp/fEnviaArchivoPorFtp.asp" -->
<!-- #include file="../Include/Asp/fValorCampo.asp" -->
<%'Declaración de variables
	dim iCodPub, oRs, sPaginaAsp, sArchivoHtml, oConn, sRutaVirtual _
		, sRutaPaginaAsp, sRutaArchivoHtml, bEstadoEnviado _
		, bEstadoCreado, sMensaje%>
<%'Recoger variables
	iCodPub= Request.QueryString("CodPub")%>
<%'Abre la conexión
	set oConn= Server.CreateObject("ADODB.Connection")
	oConn.Open constr%>
<%'Trae el nombre de la página asp que genera la portada de la publicación,
	' el nombre de la página html principal a generar, la ruta virtual de la publicación
	set oRs= Server.CreateObject("ADODB.Recordset")
	oRs.Open "SELECT nom_paginaaspportada, nom_paginaprincipal" & _
		", des_rutavirtual" & _
		" FROM publicacion" & _
		" WHERE cod_publicacion=" & iCodPub, oConn
	if not oRs.EOF then
		sPaginaAsp= Trim(oRs("nom_paginaaspportada"))
		sArchivoHtml= Trim(oRs("nom_paginaprincipal"))
		sRutaVirtual= Trim(oRs("des_rutavirtual"))
	end if
	oRs.Close
	set oRs= nothing%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Generar portada de publicación</title>
		<link rel="stylesheet" href="../Include/Css/Stilo.css" type="text/css">
	</head>
	<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">
		<form id="frmGeneraNota" name="frmGeneraNota">
			<div align="center">
				<br>
				<div id="divBarraGeneracion" name="divBarraGeneracion" 
				style="position:relative" class="texto">
				</div>
				<script>
					document.all["divBarraGeneracion"].innerHTML= '<br>GENERANDO PORTADA DE PUBLICACIÓN<br><img src="../Image/animbarrita.gif" border="0">';
					document.all["divBarraGeneracion"].style.visibility="visible";
				</script>
<%Response.Flush%>
				<script>
					document.all["divBarraGeneracion"].innerHTML= '';
					document.all["divBarraGeneracion"].style.visibility="hidden";
				</script>
<%'El proceso de generación de la página y el envío
	if Trim(sPaginaAsp)<>"" and Trim(sArchivoHtml)<>"" then
		sRutaPaginaAsp= "http://" & Request.ServerVariables("SERVER_NAME") & _
			"/" & sRutaVirtualIVMaker & "/" & sRutaVirtual & "/" & _
			csSubDirectorioMacro & "/" & sPaginaAsp
		sRutaArchivoHtml= "../" & sRutaVirtual & "/" & csSubDirectorioHtml & "/" & sArchivoHtml
		'Genera la página principal de la portada de la publicación
		bEstadoCreado= fCreaPaginaHtmlDesdePaginaAsp(sRutaPaginaAsp, sRutaArchivoHtml)
		if bEstadoCreado= "0" then
			sMensaje= "- Portada de publicación ha sido generada satisfactoriamente."
			'Envía el archivo generado a la localización que pertenece. vía ftp o por copia
			bEstadoEnviado= fMueveArchivoPortadaPublicacionGenerado(iCodPub, _
				oConn, sRutaArchivoHtml)
			select case bEstadoEnviado
			case "0"
				sMensaje= sMensaje &  "<br>- No fue enviado por no asignar dirección de entrega.<br>Comunique al Administrador."
			case "2"
				sMensaje= sMensaje & "<br>- No fue enviado por problemas en el FTP.<br>Comunique al Administrador."
			case "2.1"
				sMensaje= sMensaje & "<br>- No fue enviado por no asignar servidor para ftp.<br>Comunique al Administrador."
			case "4"
				sMensaje= sMensaje & "<br>- No fue enviado por problemas al moverlo.<br>Comunique al Administrador."
			case else
				sMensaje= sMensaje & "<br>- Archivo generado ha sido enviado."
			end select 
		else
			sMensaje= "No generó la portada de publicación<br>Comunique al Administrador"
		end if
	end if%>
				<table width="350" cellpadding="2" cellspacing="1" border="0" valign="middle" bgcolor="#c0c0c0">
<%if sMensaje<>"" then%>
					<tr bgcolor="#FFFFFF">
						<td valign="middle" align="left" class="texto">
							<%=sMensaje%>
						</td>
					</tr>		
<%end if%>
					<tr bgcolor="#FFFFFF">
						<td valign="top" align="center">
							<form action="" method="get" id="frmGenPortadaPublicacion" name="frmGenPortadaPublicacion">
								<input type="button" name="btnVolver" id="btnVolver" value="Volver" 
								onclick="javascript:location.href='ListSeccionesRedactores.asp?CodPub=<%=iCodPub%>'">
							</form>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</body>
</html>
<%'Cierra la conexión
	oConn.Close
	set oConn= nothing%>