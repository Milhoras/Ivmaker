<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../Include/Asp/Conn.asp" -->
<%'Autorización para la página
	if IsEmpty(Session("EstaAutorizadoPagina")) then
		pMensaje "No está autorizado generar notas", "../Macro/ListNotas.asp?CodPub=" & _
		Request.QueryString("CodPub") & "&CodSec=" & Request.QueryString("CodSec"), "_self"
	end if%>
<%'Verifica que código sección exista o sea un número
	if not IsNumeric(Request.QueryString("CodSec")) or Trim(Request.QueryString("CodSec"))="" then
		pMensaje "Ingrese una sección válida", "../Macro/ListSeccionesRedactores.asp?" & Request.QueryString("CodPub"), "_self"
	end if%>
<%'Verifica que código nota exista o sea un número
	if not IsNumeric(Request.QueryString("CodNota")) or Trim(Request.QueryString("CodNota"))="" then
		pMensaje "Ingrese una nota válida", "../Macro/ListNotas.asp?CodPub=" & _
		Request.QueryString("CodPub") & "&CodSec=" & Request.QueryString("CodSec"), "_self"
	end if%>
<!-- #include file="../Include/Asp/incVerificaAutorizacionPubSec.asp" -->
<!-- #include file="../Include/Asp/incConstantesNombresSubDirectorios.asp" -->
<!-- #include file="../Include/Asp/fValorCampo.asp" -->
<!-- #include file="../Include/Asp/fUrlNota.asp" -->
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
<!-- #include file="../Include/Asp/fEnviaArchivoPorFtp.asp" -->
<!-- #include file="../Include/Asp/fMueveArchivoGenerado.asp" -->
<!-- #include file="../Include/Asp/fMueveElementosDeArchivoGenerado.asp" -->
<%'Declaración de variables
	dim oConn, oRs, iCodNota, iCodSeccion, iCodPublicacion, sTitularNota _
	, sEstadoGeneracion, sQueryString, sUrlNota, sEstadoEnviado _
	, sMensajeElementosEnviadosDeArchivoGenerado%>
<%'Recoge el código de la nota, publicación y sección de la nota principal
	iCodNota= CInt(Request.QueryString("CodNota"))
	iCodSeccion= CInt(Request.QueryString("CodSec"))
	iCodPublicacion= CInt(Request.QueryString("CodPub"))
	'Arma el querystring que pasa de página en página
	sQueryString=Request.ServerVariables("QUERY_STRING")%>
<%'Abre la conexión
	set oConn= Server.CreateObject("ADODB.Connection")
	oConn.Open constr%>
<%'Trae el titular de la nota
	sTitularNota= fValorCampo("des_titulonota", "notas", oConn, "cod_nota=" & iCodNota)	
	'Trae el url de la nota
	sUrlNota= fUrlNota(iCodNota, oConn)%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Generar nota</title>
		<link rel="stylesheet" href="../Include/Css/Stilo.css" type="text/css">
	</head>
	<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">
		<form id="frmGeneraNota" name="frmGeneraNota">
			<div align="center">
				<div id="divBarraGeneracion" name="divBarraGeneracion" 
				style="position:relative" class="texto">
				</div>
				<script>
					document.all["divBarraGeneracion"].innerHTML= '<br>GENERANDO: <%=sUrlNota%><br><img src="../Image/animbarrita.gif" border="0">';
					document.all["divBarraGeneracion"].style.visibility="visible";
				</script>
<%Response.Flush%>
				<script>
					document.all["divBarraGeneracion"].innerHTML= '';
					document.all["divBarraGeneracion"].style.visibility="hidden";
				</script>
				<table width="350" cellpadding="2" cellspacing="1" border="0" valign="middle" bgcolor="#c0c0c0">
<%'Llama al procedimiento de la generación de la nota
	sEstadoGeneracion= fGeneraNota(iCodNota, iCodSeccion, iCodPublicacion, oConn)%>
<%'Verifica el error de generación si lo hubiera
	select case sEstadoGeneracion
	case "0"
		sEstadoEnviado= fMueveArchivoGenerado(iCodNota, oConn)%>
					<tr bgcolor="#FFFFFF">
						<td valign="middle" align="left" class="texto">
							Generado Satisfactoriamente: <%=fFiltraSignosMayorMenor(sTitularNota)%>
							en <i><%=sUrlNota%></i>
						</td>
					</tr>
<%	'Verificar estado de envío
		select case sEstadoEnviado
		case "0"%>
					<tr bgcolor="#FFFFFF">
						<td valign="middle" align="left" class="texto">
							Archivo generado <i><%=sUrlNota%></i><br>
							no fue enviado por no asignar dirección de entrega.<br>
							Comunique al Administrador.
						</td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td valign="middle" align="center" class="texto">
							<input type="button" name="btnCancelar" value="Cancelar" onclick="location.href='ListNotas.asp?<%=sQueryString%>'">
						</td>
					</tr>
<%
		case "2"%>
					<tr bgcolor="#FFFFFF">
						<td valign="middle" align="left" class="texto">
							Archivo generado <i><%=sUrlNota%></i><br>
							no fue enviado por problemas en el FTP.<br>
							Comunique al Administrador.
						</td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td valign="middle" align="center" class="texto">
							<input type="button" name="btnCancelar" value="Cancelar" onclick="location.href='ListNotas.asp?<%=sQueryString%>'">
						</td>
					</tr>
<%
		case "2.1"%>
					<tr bgcolor="#FFFFFF">
						<td valign="middle" align="left" class="texto">
							Archivo generado <i><%=sUrlNota%></i><br>
							no fue enviado por no asignar servidor para ftp.<br>
							Comunique al Administrador.
						</td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td valign="middle" align="center" class="texto">
							<input type="button" name="btnCancelar" value="Cancelar" onclick="location.href='ListNotas.asp?<%=sQueryString%>'">
						</td>
					</tr>
<%
		case "4"%>
					<tr bgcolor="#FFFFFF">
						<td valign="middle" align="left" class="texto">
							Archivo generado <i><%=sUrlNota%></i><br>
							no fue enviado por problemas al moverlo.<br>
							Comunique al Administrador.
						</td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td valign="middle" align="center" class="texto">
							<input type="button" name="btnCancelar" value="Cancelar" onclick="location.href='ListNotas.asp?<%=sQueryString%>'">
						</td>
					</tr>
<%
		case else
			sMensajeElementosEnviadosDeArchivoGenerado= fMueveElementosDeArchivoGenerado(iCodNota, oConn)%>
					<tr bgcolor="#FFFFFF">
						<td valign="top" class="texto">
							<%=sMensajeElementosEnviadosDeArchivoGenerado%>
						</td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td valign="top" class="texto">
							<script language="javascript">
								location.href="listNotas.asp?CodPub=<%=iCodPublicacion%>&CodSec=<%=iCodSeccion%>"
							</script>
						</td>
					</tr>
<%	
		end select%>
<%
	case "1"%>
					<tr bgcolor="#FFFFFF">
						<td valign="middle" align="center" class="texto">
							La nota: &quot;<%=fFiltraSignosMayorMenor(sTitularNota)%>&quot;<br>
							NO tiene una plantilla asignada.<br>
							Por favor elija una para continuar con la generación:<p>
							<iframe width="300" height="40" src="AsignPlantillaNota.asp?<%=sQueryString%>" frameborder="0"></iframe><br>
							o Cancele el proceso <input type="button" name="btnCancelar" value="Cancelar" onclick="location.href='listNotas.asp?<%=sQueryString%>'">
						</td>
					</tr>
<%
	case "2"%>
					<tr bgcolor="#FFFFFF">
						<td valign="middle" align="center" class="texto">
							El archivo fisico de la plantilla no existe.<br>
							Comunique al administrador<br>
								<input type="button" name="btnCancelar" value="Cancelar" onclick="location.href='ListNotas.asp?<%=sQueryString%>'">
						</td>
					</tr>
<%
	case else%>
<%
	end select%>
				</table>	
			</div>
		</form>
	</body>
</html>
<%'Cierra la conexión
	oConn.Close
	set oConn= nothing%>