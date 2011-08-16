<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../Include/Asp/Conn.asp" -->
<%'Autorización para la página
	if IsEmpty(Session("EstaAutorizadoPagina")) then
		pMensaje "No está autorizado generar sección", "../Macro/ListSeccionesRedactores.asp?CodPub=" & _
		Request.QueryString("CodPub"), "_self"
	end if%>
<%'Verifica que código sección exista o sea un número
	if not IsNumeric(Request.QueryString("CodSec")) or Trim(Request.QueryString("CodSec"))="" then
		pMensaje "Ingrese una sección válida", "../Macro/ListSeccionesRedactores.asp?" & _
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
<!-- #include file="../Include/Asp/fGeneraNota.asp" -->
<!-- #include file="../Include/Asp/fGeneraIndiceSeccion.asp" -->
<!-- #include file="../Include/Asp/fMueveArchivoGenerado.asp" -->
<!-- #include file="../Include/Asp/fEnviaArchivoPorFtp.asp" -->
<!-- #include file="../Include/Asp/fMueveArchivoIndiceSeccionGenerado.asp" -->
<!-- #include file="../Include/Asp/fMueveElementosDeArchivoGenerado.asp" -->
<%'Declaración de variables
	dim oConn, oRs, iCodNota, iCodSeccion, iCodPublicacion _
		, sEstadoGeneracion, sTitularNota, iNotasGeneradas _
		, iNotasNoGeneradasPorFaltaAsignarPlantilla _
		, iNotasNoGeneradasPorNoExistePlantillaFisica, sUrlNota _
		, i, sUrlRetorno, sEstadoEnviado, iArchivosEnviados _
		, iArchivosNoEnviados, sMensajeElementosEnviadosDeArchivoGenerado _
		, sNombreSeccion, sEstadoGeneracionIndiceSeccion _
		, sMensajeIndiceSeccion, sEstadoEnvioIndiceSeccion%>
<%'Recoge el código de la nota, publicación
	iCodSeccion= CInt(Request.QueryString("CodSec"))
	iCodPublicacion= CInt(Request.QueryString("CodPub"))%>
<%'Recoge la página a la que tiene que regresar
	sUrlRetorno= Request.QueryString("UrlRetorno")%>
<%'Abre la conexión
	set oConn= Server.CreateObject("ADODB.Connection")
	oConn.Open constr%>
<%'Inicializa los variables
	iNotasGeneradas= 0
	iNotasNoGeneradasPorFaltaAsignarPlantilla= 0
	iNotasNoGeneradasPorNoExistePlantillaFisica= 0
	iArchivosEnviados= 0
	iArchivosNoEnviados= 0%>
<%'Nombre de la sección
	sNombreSeccion= fValorCampo("nom_seccion", "seccion", oConn, _
		"cod_seccion=" & iCodSeccion)%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Generar sección</title>
		<link rel="stylesheet" href="../Include/Css/Stilo.css" type="text/css">
	</head>
	<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">
		<div align="center">
				<div id="divBarraGeneracion" name="divBarraGeneracion" 
				style="position:relative" class="texto">
				</div>
				<script>
					document.all["divBarraGeneracion"].innerHTML= '<br>GENERANDO: <%=sNombreSeccion%><br><img src="../Image/animbarrita.gif" border="0">';
					document.all["divBarraGeneracion"].style.visibility="visible";
				</script>
<%Response.Flush%>
				<script>
					document.all["divBarraGeneracion"].innerHTML= '';
					document.all["divBarraGeneracion"].style.visibility="hidden";
				</script>
			<table width="350" cellpadding="2" cellspacing="1" border="0" height="200" valign="top" bgcolor="#c0c0c0">
<%'Traer todas las notas de la sección
	set oRs= Server.CreateObject("ADODB.Recordset")
	oRs.Open "SELECT cod_nota" & _
	" FROM notas WHERE cod_seccion=" & iCodSeccion & _
	" AND est_archivo='1'" & _
	" ORDER BY num_prioridad ASC", oConn
	if not oRs.EOF then
		do while not oRs.EOF
			i= i + 1
			'Trae el titular de la nota
			sTitularNota= fValorCampo("des_titulonota", "notas", oConn, "cod_nota=" & oRs("cod_nota"))	
			'Trae el url de la nota
			sUrlNota= fUrlNota(oRs("cod_nota"), oConn)
			'Llama a la función de la generación de la nota
			sEstadoGeneracion= fGeneraNota(oRs("cod_nota"), iCodSeccion, iCodPublicacion, oConn)
			select case sEstadoGeneracion
			case "0"	' Ok en creación de nota
				iNotasGeneradas= iNotasGeneradas + 1
				sEstadoEnviado= fMueveArchivoGenerado(oRs("cod_nota"), oConn)%>
					<tr bgcolor="#FFFFFF">
						<td valign="middle" align="left" class="texto">
							<%=i%>. <%=fFiltraSignosMayorMenor(sTitularNota)%><br>
							<%=sUrlNota%><br>
							Página generada satisfactoriamente<br>
<%	'Verificar estado de envío
				select case sEstadoEnviado
				case "0"
					iArchivosNoEnviados= iArchivosNoEnviados + 1%>
							Archivo generado NO fue enviado por no asignar dirección de entrega.
							Comunique al Administrador<br>
<%
				case "2"
					iArchivosNoEnviados= iArchivosNoEnviados + 1%>
							Archivo generado NO fue enviado por problemas en el FTP.
							Comunique al Administrador<br>
<%
				case "4"
					iArchivosNoEnviados= iArchivosNoEnviados + 1%>
							Archivo generado NO fue enviado al moverlo.
							Comunique al Administrador<br>
<%
				case else
					iArchivosEnviados= iArchivosEnviados + 1%>
							Enviado correctamente<br>
<%
				end select%>
<%'Enviar los elementos adjuntos de la nota (fotos)
				sMensajeElementosEnviadosDeArchivoGenerado= _
					fMueveElementosDeArchivoGenerado(oRs("cod_nota"), oConn)%>
							<%=sMensajeElementosEnviadosDeArchivoGenerado%>
							</p>
						</td>
					</tr>
<%
			case "1"
				iNotasNoGeneradasPorFaltaAsignarPlantilla= iNotasNoGeneradasPorFaltaAsignarPlantilla + 1%>
					<tr bgcolor="#FFFFFF">
						<td valign="middle" align="left" class="texto">
							<%=i%>. <%=fFiltraSignosMayorMenor(sTitularNota)%><br>
							No generado por no asignar plantilla
						</td>
					</tr>
<%
			case "2"
				iNotasNoGeneradasPorFaltaAsignarPlantilla= iNotasNoGeneradasPorFaltaAsignarPlantilla + 1%>
					<tr bgcolor="#FFFFFF">
						<td valign="middle" align="left" class="texto">
							<%=i%>. <%=fFiltraSignosMayorMenor(sTitularNota)%><br>
							No generado por no existir plantilla física
						</td>
					</tr>
<%
			end select
			oRs.MoveNext
		loop
		'Ver la generación del índice de sección
		sEstadoGeneracionIndiceSeccion= fGeneraIndiceSeccion(iCodSeccion, iCodPublicacion, oConn)
		select case sEstadoGeneracionIndiceSeccion
		case "0"
			sMensajeIndiceSeccion= "Índice generado satisfactoriamente"
			'Ver el envío del archivo html
			sEstadoEnvioIndiceSeccion= fMueveArchivoIndiceSeccionGenerado(iCodSeccion, oConn)
			select case sEstadoEnvioIndiceSeccion
			case "0"
				sMensajeIndiceSeccion= sMensajeIndiceSeccion & _
					"<br>Alguno o los dos archivos NO fueron enviados por no asignar dirección de entrega."
			case "2"
				sMensajeIndiceSeccion= sMensajeIndiceSeccion & _
					"<br>Alguno o los dos archivos NO fueron enviados por problemas en el FTP."
			case "4"
				sMensajeIndiceSeccion= sMensajeIndiceSeccion & _
					"<br>Alguno o los dos archivos NO fueron enviados por error al moverlos."
			case else
				sMensajeIndiceSeccion= sMensajeIndiceSeccion & _
					"<br>Enviado correctamente"
			end select
		case "1"
			sMensajeIndiceSeccion= "No hay plantilla asignada"
		case "2"
			sMensajeIndiceSeccion= "No existe plantilla física"
		end select
	end if
	oRs.Close
	set oRs= nothing%>
					<tr bgcolor="#FFFFFF">
						<td valign="middle" align="left" class="texto">
							<%=CStr(iNotasGeneradas)%>&nbsp;<%if iNotasGeneradas=1 then%>nota generada<%else%>notas generadas<%end if%>&nbsp;-&nbsp;
							<%=CStr(iArchivosEnviados)%>&nbsp;<%if iArchivosEnviados=1 then%>nota enviada<%else%>notas enviadas<%end if%>&nbsp;-&nbsp;
							<%=CStr(iArchivosNoEnviados)%>&nbsp;<%if iArchivosNoEnviados=1 then%>nota no enviada<%else%>notas no enviadas<%end if%>
							<br>
							<%=(iNotasNoGeneradasPorFaltaAsignarPlantilla + iNotasNoGeneradasPorNoExistePlantillaFisica)%>&nbsp;<%if (iNotasNoGeneradasPorFaltaAsignarPlantilla + iNotasNoGeneradasPorNoExistePlantillaFisica)=1 _
							then%>nota no generada<%else%>notas no generadas<%end if%>
 						</td>
					</tr>
<%'Visualiza el mensaje para el índice de sección
	if sMensajeIndiceSeccion<>"" then%>
					<tr bgcolor="#FFFFFF">
						<td valign="middle" align="left" class="texto">
							<%=sMensajeIndiceSeccion%>
 						</td>
					</tr>
<%
	end if%>
					<tr bgcolor="#FFFFFF">
						<td valign="top" align="center">
							<form action="" method="get" id="frmGenSeccion" name="frmGenSeccion">
								<input type="button" name="btnVolver" id="btnVolver" value="Volver" 
								onclick="javascript:location.href='<%=sUrlRetorno%>?<%=Request.ServerVariables("QUERY_STRING")%>'">
							</form>
						</td>
					</tr>
			</table>
		</div>
	</body>
</html>
<%'Cierra la conexión
	oConn.Close
	set oConn= nothing%>