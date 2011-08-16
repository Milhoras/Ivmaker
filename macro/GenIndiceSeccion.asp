<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../Include/Asp/Conn.asp" -->
<%'Autorizaci�n para la p�gina
	if IsEmpty(Session("EstaAutorizadoPagina")) then
		pMensaje "No est� autorizado generar �ndice secci�n", _
			"../Macro/ListSeccionesRedactores.asp?CodPub=" & _
			Request.QueryString("CodPub"), "_self"
	end if%>
<%'Verifica que c�digo secci�n exista o sea un n�mero
	if not IsNumeric(Request.QueryString("CodSec")) or Trim(Request.QueryString("CodSec"))="" then
		pMensaje "Ingrese una secci�n v�lida", _
			"../Macro/ListSeccionesRedactores.asp?" & _
			Request.QueryString("CodPub"), "_self"
	end if%>
<!-- #include file="../Include/Asp/incVerificaAutorizacionPubSec.asp" -->
<!-- #include file="../Include/Asp/incConstantesNombresSubDirectorios.asp" -->
<!-- #include file="../Include/Asp/fValorCampo.asp" -->
<!-- #include file="../Include/Asp/fUrlNota.asp" -->
<!-- #include file="../Include/Asp/fUrlIndiceSeccion.asp" -->
<!-- #include file="../Include/Asp/pVerificaCreaDirectorio.asp" -->
<!-- #include file="../Include/Asp/fColocaEspacioDeParrafo.asp" -->
<!-- #include file="../Include/Asp/fEsquivaTags.asp" -->
<!-- #include file="../Include/Asp/fTraeEntreTags.asp" -->
<!-- #include file="../Include/Asp/fReemplazarEntreTags.asp" -->
<!-- #include file="../Include/Asp/fFechaCompleta.asp" -->
<!-- #include file="../Include/Asp/fFiltraSignosMayorMenor.asp" -->
<!-- #include file="../Include/Asp/fFiltraCorchetes.asp" -->
<!-- #include file="../Include/Asp/fNombreImagenReducida.asp" -->
<!-- #include file="../Include/Asp/fGeneraIndiceSeccion.asp" -->
<!-- #include file="../Include/Asp/fEnviaArchivoPorFtp.asp" -->
<!-- #include file="../Include/Asp/fMueveArchivoIndiceSeccionGenerado.asp" -->
<!-- #include file="../Include/Asp/fMueveElementosDeArchivoGenerado.asp" -->
<%'Declaraci�n de variables
	dim oConn, oRs, iCodigoNota, iCodSeccion, iCodPublicacion _
		, sEstadoGeneracion, sTitularNota _
		, i, sUrlRetorno, sEstadoEnviado _
		, sMensajeElementosEnviadosDeArchivoGenerado _
		, sNombreSeccion, sEstadoGeneracionIndiceSeccion _
		, sMensajeIndiceSeccion, sEstadoEnvioIndiceSeccion%>
<%'Recoge el c�digo de la nota, publicaci�n
	iCodSeccion= CInt(Request.QueryString("CodSec"))
	iCodPublicacion= CInt(Request.QueryString("CodPub"))%>
<%'Recoge la p�gina a la que tiene que regresar
	sUrlRetorno= Request.QueryString("UrlRetorno")%>
<%'Abre la conexi�n
	set oConn= Server.CreateObject("ADODB.Connection")
	oConn.Open constr%>
<%'Nombre de la secci�n
	sNombreSeccion= fValorCampo("nom_seccion", "seccion", oConn, _
		"cod_seccion=" & iCodSeccion)%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Generar �ndice secci�n</title>
		<link rel="stylesheet" href="../Include/Css/Stilo.css" type="text/css">
	</head>
	<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">
		<div align="center">
			<div id="divBarraGeneracion" name="divBarraGeneracion" 
			style="position:relative" class="texto">
			</div>
			<script>
				document.all["divBarraGeneracion"].innerHTML= '<br>GENERANDO �NDICE: <%=sNombreSeccion%><br><img src="../Image/animbarrita.gif" border="0">';
				document.all["divBarraGeneracion"].style.visibility="visible";
			</script>
<%Response.Flush%>
			<script>
				document.all["divBarraGeneracion"].innerHTML= '';
				document.all["divBarraGeneracion"].style.visibility="hidden";
			</script>
			<table width="350" cellpadding="2" cellspacing="1" border="0" height="200" valign="top" bgcolor="#c0c0c0">
<%'Ver la generaci�n del �ndice de secci�n
	sEstadoGeneracionIndiceSeccion= fGeneraIndiceSeccion(iCodSeccion, iCodPublicacion, oConn)
	select case sEstadoGeneracionIndiceSeccion
	case "0"
		sMensajeIndiceSeccion= "�ndice generado satisfactoriamente<br>"
		'Ver el env�o del archivo html
		sEstadoEnvioIndiceSeccion= fMueveArchivoIndiceSeccionGenerado(iCodSeccion, oConn)
		select case sEstadoEnvioIndiceSeccion
		case "0"
			sMensajeIndiceSeccion= sMensajeIndiceSeccion & _
				"<br>Alguno o los dos archivos NO fueron enviados por no asignar direcci�n de entrega."
		case "2"
			sMensajeIndiceSeccion= sMensajeIndiceSeccion & _
				"<br>Alguno o los dos archivos NO fueron enviados por problemas en el FTP."
		case "4"
			sMensajeIndiceSeccion= sMensajeIndiceSeccion & _
				"<br>Alguno o los dos archivos NO fueron enviados por error al moverlos."
		case else
			sMensajeIndiceSeccion= sMensajeIndiceSeccion & _
				"�ndice enviado correctamente"
			'Ver el env�o de los elementos (fotos) del archivo generado
			iCodigoNota= fValorCampo("cod_nota, MIN(num_prioridad)", _
				" notas", oConn, "cod_seccion=" & iCodSeccion & _
				" AND est_activo='1' AND est_archivo='1' GROUP BY cod_nota")
			sMensajeElementosEnviadosDeArchivoGenerado= _
				fMueveElementosDeArchivoGenerado(iCodigoNota, oConn)
		end select
	case "1"
		sMensajeIndiceSeccion= "No hay plantilla asignada para �ndice"
	case "2"
		sMensajeIndiceSeccion= "No existe plantilla f�sica para �ndice"
	end select%>
<%'Visualiza el mensaje para el �ndice de secci�n
	if sMensajeIndiceSeccion<>"" then%>
					<tr bgcolor="#FFFFFF">
						<td valign="middle" align="left" class="texto">
							<%=sMensajeIndiceSeccion%><br>
							<%=sMensajeElementosEnviadosDeArchivoGenerado%>
 						</td>
					</tr>
<%
	end if%>
					<tr bgcolor="#FFFFFF">
						<td valign="top" align="center">
							<form action="" method="get" id="frmGenIndiceSeccion" name="frmGenIndiceSeccion">
								<input type="button" name="btnVolver" id="btnVolver" value="Volver" 
								onclick="javascript:location.href='<%=sUrlRetorno%>?<%=Request.ServerVariables("QUERY_STRING")%>'">
							</form>
						</td>
					</tr>
			</table>
		</div>
	</body>
</html>
<%'Cierra la conexi�n
	oConn.Close
	set oConn= nothing%>