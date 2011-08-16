<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../Include/Asp/Conn.asp" -->
<!-- #include file="../Include/Asp/fTienePermisoPagina.asp"-->
<%'Autorización para la página
	if IsEmpty(Session("EstaAutorizadoPagina")) then
		pMensaje "No está autorizado para editar notas", "../Macro/ListNotas.asp?CodPub=" & _
		Request.QueryString("CodPub") & "&CodSec=" & Request.QueryString("CodSec") & _
		"&EstArch=" & Request.QueryString("EstArch"), "_self"
	end if%>
<%'Verifica que código sección exista o sea un número
	if not IsNumeric(Request.QueryString("CodSec")) or Trim(Request.QueryString("CodSec"))="" then
		pMensaje "Ingrese una sección válida", "../Macro/ListSeccionesRedactores.asp?" & Request.QueryString("CodPub"), "_self"
	end if%>
<%'Verifica que código nota exista o sea un número
	if not IsNumeric(Request.QueryString("CodNota")) or Trim(Request.QueryString("CodNota"))="" then
		pMensaje "Ingrese una nota válida", "../Macro/ListNotas.asp?CodPub=" & _
		Request.QueryString("CodPub") & "&CodSec=" & Request.QueryString("CodSec") & _
		"&EstArch=" & Request.QueryString("EstArch"), "_self"
	end if%>
<!-- #include file="../Include/Asp/fFiltraApostrofe.asp" -->
<!-- #include file="../Include/Asp/incVerificaAutorizacionPubSec.asp" -->
<!-- #include file="../Include/Asp/incConstantesNota.asp" -->
<!-- #include file="../Include/Asp/fValorCampo.asp" -->
<!-- #include file="../Include/Asp/fUrlNota.asp" -->
<!-- #include file="../Include/Asp/fColocaEspacioDeParrafo.asp" -->
<!-- #include file="../Include/Asp/fColocaEspacioDeParrafoInversa.asp" -->
<!-- #include file="../Include/Asp/pColocaEstadoNotaNoGenerada.asp" -->
<!-- #include file="../Include/Asp/incConstantesNombresSubDirectorios.asp" -->
<%'Declaración de variables
	dim oConn, oRs, sSql, iCodPublicacion, sAlias, iCodAuspicio, iCodPlantilla _
	, sTituloNota, sCabecera, sCuerpo, sAutor, sTextoAuxiliar, iNumeroPrioridad _
	, sActivo, sMensaje, iCodSeccion, iCodNota, bSePuedeGrabar _
	, sNombrePublicacion, sEstadoPortada, iNumeroPrioridadPortada _
	, sEstadoGenerado, sEstadoFotoAleatoria, dtFechaRegistro _
	, sEstadoArchivo%>
<%'Abrir la conexión
	set oConn= Server.CreateObject("ADODB.connection")
	oConn.Open constr%>
<%'Traer el código de la publicación
	iCodPublicacion= CInt(Request.QueryString("CodPub"))%>
<%'Recoge el código de la sección
	iCodSeccion= CInt(Request.QueryString("CodSec"))%>
<%'Recoge el código de la sección
	iCodNota= Request.QueryString("CodNota")%>
<%'Traer el nombre de la publicación
	sNombrePublicacion= fValorCampo("nom_publicacion", "publicacion", oConn, "cod_publicacion=" & iCodPublicacion)%>
<%'Trae dominio del servidor, si la publicación reside en otro diferente al servidor de ivmaker
	dim sDominio
	sDominio= fValorCampo("a.des_dominio", "servidores a, publicacion b", _
	oConn, "b.cod_publicacion=" & iCodPublicacion & _
	" AND b.cod_servidor=a.cod_servidor AND b.des_rutaftp<>''" & _
	" AND b.des_rutaftp is not null")
	if Trim(sDominio)<>"" then sDominio= "http://" & sDominio%>
<%'Traer los datos o modificarlos
	if not IsEmpty(Request.Form("sbmModificar")) then				
		iNumeroPrioridad= CInt(Request.Form("txtNumeroPrioridad"))
		iCodPlantilla= Request.Form("sltPlantilla")
		iCodAuspicio= Request.Form("sltAuspicio")
		sActivo= Request.Form("chkActivo")
		sEstadoPortada= Request.Form("chkPrioridadPortada")
		if sEstadoPortada="" then sEstadoPortada= "0"
		sEstadoFotoAleatoria= Request.Form("chbFotoAleatoria")
		if sEstadoFotoAleatoria="" then sEstadoFotoAleatoria= "0"
		sTituloNota= fFiltraApostrofe(Request.Form("txtTituloNota"))
		sCabecera= fFiltraApostrofe(Request.Form("txtCabecera"))
		sCuerpo= fFiltraApostrofe(Request.Form("txtCuerpo"))
		sAutor= fFiltraApostrofe(Request.Form("txtAutor"))
		sTextoAuxiliar= fFiltraApostrofe(Request.Form("txtTextoAuxiliar"))
		sEstadoArchivo= Trim(Request.Form("radEstadoArchivo"))
		'Cada vez que se modifique el estado generado vuelve a su inicial
		sSql= "UPDATE notas SET cod_auspicio=" & iCodAuspicio & _
		", cod_plantilla=" & iCodPlantilla & ", des_titulonota='" & _
		sTituloNota & "',  des_cabecera='" & sCabecera & _
		"', des_texto='" & sCuerpo & "', des_autor='" & sAutor & _
		"', des_textoauxiliar='" & sTextoAuxiliar & "', num_prioridad=" & _
		iNumeroPrioridad & ",  est_portada='" & sEstadoPortada & _
		"', est_fotoaleatoria='" & sEstadoFotoAleatoria & "', est_activo='" & _
		sActivo & "', est_archivo='" & sEstadoArchivo & _
		"' WHERE cod_nota=" & iCodNota
		oConn.Execute sSql

		'Cambia el estado de generación de la página
		pColocaEstadoNotaNoGenerada iCodNota, oConn
		'Graba en la tabla fotonota
		if iCodNota<>"" then
			dim x, aFoto, sInsert
			oConn.Execute("DELETE fotonota WHERE cod_nota=" & iCodNota)
			for each x in Request.Form("sltFoto")
				aFoto= Split(x, "|")
				sInsert= "INSERT fotonota(cod_nota, cod_foto, des_sumillafoto" & _
				", num_prioridad) VALUES(" & iCodNota & ", " & aFoto(1) & _
				", '" & fFiltraApostrofe(aFoto(3)) & "', " & aFoto(0) & ")"
				oConn.Execute(sInsert)
			next
		end if
		oConn.Close
		set oConn= nothing
		Response.Redirect "../Macro/ListNotas.asp?CodPub=" & iCodPublicacion & _
		"&CodSec=" & iCodSeccion & "&EstArch=" & Request.QueryString("EstArch")
	else
		sSql= "SELECT cod_auspicio, cod_plantilla, des_titulonota" & _
		", des_cabecera, des_texto, des_autor, des_textoauxiliar" & _
		", num_prioridad, num_prioridadportada, est_generado, est_portada" & _
		", est_fotoaleatoria, est_activo, est_archivo, fec_registro" & _
		" FROM notas WHERE cod_nota=" & iCodNota
		set oRs= Server.CreateObject("ADODB.Recordset")
		oRs.Open sSql, oConn
		if not oRs.EOF then
			iCodAuspicio= oRs("cod_auspicio")
			iCodPlantilla= oRs("cod_plantilla")
			sTituloNota= Trim(oRs("des_titulonota"))
			sCabecera= fColocaEspacioDeParrafoInversa(Trim(oRs("des_cabecera")))
			sCuerpo= fColocaEspacioDeParrafoInversa(oRs("des_texto"))
			sAutor= Trim(oRs("des_autor"))
			sTextoAuxiliar= Trim(oRs("des_textoauxiliar"))
			iNumeroPrioridad= oRs("num_prioridad")
			iNumeroPrioridadPortada= oRs("num_prioridadportada")
			sEstadoGenerado= Trim(oRs("est_generado"))
			sEstadoPortada= Trim(oRs("est_portada"))
			sEstadoFotoAleatoria= Trim(oRs("est_fotoaleatoria"))
			sActivo= Trim(oRs("est_activo"))
			sEstadoArchivo= Trim(oRs("est_archivo"))
			dtFechaRegistro= oRs("fec_registro")
		end if
		oRs.Close
		set oRs= nothing
	end if%>
	
<%
function RTESafe(strText)
	'returns safe code for preloading in the RTE
	dim tmpString

	tmpString = trim(strText)

	'convert all types of single quotes
	tmpString = replace(tmpString, chr(145), chr(39))
	tmpString = replace(tmpString, chr(146), chr(39))
	tmpString = replace(tmpString, "'", "&#39;")

	'convert all types of double quotes
	tmpString = replace(tmpString, chr(147), chr(34))
	tmpString = replace(tmpString, chr(148), chr(34))
'	tmpString = replace(tmpString, """", "\""")

	'replace carriage returns & line feeds
	tmpString = replace(tmpString, chr(10), " ")
	tmpString = replace(tmpString, chr(13), " ")

	RTESafe = tmpString
end function
%>

<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Modificar notas</title>
		<link rel="stylesheet" href="../Include/Css/Stilo.css" type="text/css">
		<script language="Javascript" src="../include/js/fSeleccionaTodas.js"></script>
		<script language="javascript" src="../Include/Js/fAbreVentana.js"></script>
		<script language="Javascript" src="../Include/Js/incContadorCaracteres.js"></script>
		<script language="Javascript" src="../Include/Js/fEliminaItemSelect.js"></script>
		<script language="Javascript" src="../Include/Js/fModificaItemSelect.js"></script>
		<script language="javascript" src="../Include/Js/fTrim.js"></script>
		<script language="javascript" src="../Include/Js/fValidateTextBlank.js"></script>
		<script language="javascript" src="../Include/Js/fLengthTextArea.js"></script>
		<script language="JavaScript" type="text/javascript" src="../include/JS/richtext.js"></script>
		<script language="javascript">
			function fValidafrmModificaNota(){
				var bFlag= fValidateTextBlank(document.frmModificaNota.txtTituloNota, "El campo TITULAR está vacío");
				if (bFlag) {
					bFlag= fLengthTextArea(document.frmModificaNota.txtTituloNota, <%=ciCaracteresTituloNota%>, "El campo TITULAR excede los <%=ciCaracteresTituloNota%> caracteres permitidos");
					 
					if (bFlag) {
						bFlag= fLengthTextArea(document.frmModificaNota.txtCabecera, <%=ciCaracteresCabeceraNota%>, "El campo PRIMER PÁRRAFO excede los <%=ciCaracteresCabeceraNota%> caracteres permitidos");
					}
				}
				submitForm();
				return bFlag;
				
			}
			
			function submitForm() {
	//make sure hidden and iframe values are in sync before submitting form
	//to sync only 1 rte, use updateRTE(rte)
	//to sync all rtes, use updateRTEs
	//updateRTE('rte1');
	updateRTEs();
//	alert("rte1 = " + document.RTEDemo.rte1.value);
//  alert("txtCabecera = " + document.frmModificaNota.txtCabecera.value);
//	alert("txtCuerpo = " + document.frmModificaNota.txtCuerpo.value);

	//change the following line to true to submit form
	return true;
}

//Usage: initRTE(imagesPath, includesPath, cssFile)
initRTE("../include/Editor/image/", "../include/Editor/", "");
		</script>
		<script language="Javascript1.2" src="../Include/Js/incContadorCaracteres.js"></script>
	</head>
	<body bgcolor="#FFFFFF" marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
	<base url="">
		<form action="../Macro/EditNotas.asp?CodPub=<%=iCodPublicacion%>&CodSec=<%=iCodSeccion%>&CodNota=<%=iCodNota%>&EstArch=<%=Request.QueryString("EstArch")%>"
		 method="post" name="frmModificaNota" id="frmModificaNota" onsubmit="fSeleccionaTodas(this.sltFoto); return fValidafrmModificaNota(); return submitForm();">
			<table cellpadding="2" cellspacing="1" border="0" width="480" bgcolor="#c0c0c0">
				<tr align="center" bgcolor="#FFFFFF">
					<td colspan="2" class="Titulo">Modificar notas / <%=sNombrePublicacion%>
					/ <%=fValorCampo("nom_seccion", "seccion", constr, "cod_seccion=" & iCodSeccion)%></td>
				</tr>
<%if sMensaje<>"" then%>
				<tr bgcolor="#FFFFFF">
					<td colspan="2" class="mensaje"><%=sMensaje%></td>
				</tr>
<%end if%>
				<tr bgcolor="#FFFFFF">
					<td colspan="2" valign="top">
						<table width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="#c0c0c0">
							<tr bgcolor="#FFFFFF">
								<td class="texto" valign="middle" align="center">
									N° Prioridad&nbsp;
									<input type="text" value="<%=iNumeroPrioridad%>" name="txtNumeroPrioridad"
									 maxlength="3" size="3" >
								</td>
								<td width="1" bgcolor="#c0c0c0"></td>
								<td class="texto" valign="middle" align="center">
									Portada de <%=sNombrePublicacion%>&nbsp;
									<input type="checkbox" name="chkPrioridadPortada" value="1" <%if sEstadoPortada="1" then%>checked<%end if%> >
								</td>
								<td width="1" bgcolor="#c0c0c0"></td>
								<td class="texto" valign="middle" align="center">
									Foto aleatoria&nbsp;
									<input type="checkbox" name="chkFotoAleatoria" value="1" <%if sEstadoFotoAleatoria="1" then%>checked<%end if%> >
								</td>
								<td width="1" bgcolor="#c0c0c0"></td>
								<td class="texto" valign="middle" align="center">
									Activo&nbsp;
									<input type="checkbox" name="chkActivo" value="1" <%if sActivo="1" then%>checked<%end if%> >
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td colspan="2" valign="top">
						<table width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="#c0c0c0">
							<tr bgcolor="#FFFFFF">
								<td class="texto" valign="middle" align="center">
									Plantilla&nbsp;
									<select name="sltPlantilla" size="1">
										<option value="0">Seleccionar</option>
<%'trae las plantillas
	set oRs= Server.CreateObject("ADODB.Recordset")
	sSql= "SELECT cod_plantilla, nom_plantilla FROM plantillas" & _
	" WHERE cod_publicacion=" & iCodPublicacion & _
	" AND tip_plantilla='N'" & _
	" AND est_activo='1' ORDER BY 2 ASC"
	oRs.Open sSql, oConn%>
<%do while not oRs.EOF%>
										<option value="<%=oRs("cod_plantilla")%>" <%if oRs("cod_plantilla")=iCodPlantilla then%>selected<%end if%>><%=Trim(oRs("nom_plantilla"))%></option>
<%	oRs.MoveNext
	loop
	oRs.Close
	set oRs= nothing%>
									</select>
<%if fTienePermisoPagina("ListPlantillas.asp", Session("coduser"), constr) then%>
									&nbsp;<a href="Javascript:fAbreVentana(500, 300, 0, '../Macro/ListPlantillas.asp?CodPub=<%=iCodPublicacion%>&CodSec=<%=iCodSeccion%>')" class="texto">Adicionar</a>
<%end if%>
								</td>
								<td width="1" bgcolor="#c0c0c0"></td>
								<td class="texto" valign="middle" align="center">
									Auspiciador&nbsp;
									<select name="sltAuspicio" size="1">
										<option value="0">Seleccionar</option>
<%'trae los auspicios si hubieran
	set oRs= Server.CreateObject("ADODB.Recordset")
	sSql= "SELECT cod_auspicio, nom_auspicio FROM auspicio" & _
	" WHERE est_activo='1' ORDER BY 2 ASC"
	oRs.Open sSql, oConn%>
<%do while not oRs.EOF%>
										<option value="<%=oRs("cod_auspicio")%>" <%if oRs("cod_auspicio")=iCodAuspicio then%>selected<%end if%>><%=Trim(oRs("nom_auspicio"))%></option>
<%	oRs.MoveNext
	loop
	oRs.Close
	set oRs= nothing%>
									</select>
<%if fTienePermisoPagina("ListAuspicio.asp", Session("coduser"), constr) then%>
									&nbsp;<a href="Javascript:fAbreVentana(500, 300, 0, '../Macro/ListAuspicio.asp?CodPub=<%=iCodPublicacion%>&CodSec=<%=iCodSeccion%>')" class="texto">Adicionar</a>
<%end if%>
								</td>
								<td width="1" bgcolor="#c0c0c0"></td>
								<td class="texto" valign="middle" align="center">
									<input type="checkbox" name="chkContadorCaracteres" checked
									onclick="fVerContadorCaracteres(this, document.frmModificaNota.txtTituloNota, 'divTituloNota', document.frmModificaNota.txtCabecera, 'divCabecera')"
									value="1">Ver contador caracteres
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td colspan="2" valign="top">
						<table width="100%" cellpadding="1" cellspacing="0" border="0">
							<tr>
								<td colspan="2" valign="top" class="texto">
									Títular (*) (No exceder <%=ciCaracteresTituloNota%> caracteres)
								</td>
							</tr>
							<tr>
								<td valign="top" width="85%">
									<textarea name="txtTituloNota" rows="2" cols="75"
									onkeyup="fCuentaCaracteres(this, 'divTituloNota')"
									onblur="fCuentaCaracteres(this, 'divTituloNota')"
									><%=sTituloNota%></textarea>
								</td>
								<td valign="top" width="15%" align="center">
									<div id="divTituloNota" name="divTituloNota" class="texto" align="center"></div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td colspan="2" valign="top">
						<table width="100%" cellpadding="1" cellspacing="0" border="0">
							<tr>
								<td colspan="2" valign="top" class="texto">
									Primer párrafo (No exceder <%=ciCaracteresCabeceraNota%> caracteres)
								</td>
							</tr>
							<tr>
								<td valign="top" width="85%">
<script language="JavaScript" type="text/javascript">
<!--
//Usage: writeRichText(fieldname, html, width, height, buttons, readOnly)
writeRichText('txtCabecera', '<%=RTESafe(sCabecera)%>', 350, 150, true, false);
//-->
</script>
								</td>
								<td valign="top" width="15%" align="center">
									<div id="divCabecera" name="divCabecera" class="texto"></div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td colspan="2" valign="top" class="texto">
						Cuerpo<br/>
<script language="JavaScript" type="text/javascript">
<!--
//Usage: writeRichText(fieldname, html, width, height, buttons, readOnly)
writeRichText('txtCuerpo', '<%=RTESafe(sCuerpo)%>', 350, 300, true, false);
//-->
</script>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top">Autor</td>
					<td valign="top">
						<input type="text" name="txtAutor" value="<%=sAutor%>"
						maxlength="100" size="60">
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top">Texto auxiliar</td>
					<td valign="top">
						<input type="text" name="txtTextoAuxiliar" value="<%=sTextoAuxiliar%>"
						maxlength="200" size="60">
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td valign="middle">
						<a href="Javascript:fAbreVentana(350, 500, 0, 'IngrFotoNota.asp?CodPub=<%=iCodPublicacion%>&Elemento=frmModificaNota.sltFoto')"><li>Adicionar foto</a>
					</td>
					<td valign="top">
						<table cellpadding="0" cellspacing="0" border="0" width="100%">
							<tr>
								<td valign="top" align="left" width="65%">
									<select name="sltFoto" multiple size="3" style="width='170pt'">
<%'Trae las fotos que han sido asignadas a esta nota
	set oRs= Server.CreateObject("ADODB.Recordset")
	oRs.Open "SELECT a.num_prioridad, b.cod_foto, b.des_nombrearchivo" & _
	", a.des_sumillafoto FROM fotonota a, foto b" & _
	" WHERE a.cod_nota=" & iCodNota & " AND a.cod_foto=b.cod_foto" & _
	" ORDER BY a.num_prioridad ASC", oConn
	do while not oRs.EOF%>
										<option value="<%=oRs("num_prioridad")%>|<%=oRs("cod_foto")%>|<%=Trim(oRs("des_nombrearchivo"))%>|<%=Trim(oRs("des_sumillafoto"))%>"><%=oRs("num_prioridad")%>|<%=oRs("cod_foto")%>|<%=Trim(oRs("des_nombrearchivo"))%>|<%=Trim(oRs("des_sumillafoto"))%></option>
<%
		oRs.Movenext
	loop
	oRs.Close
	set oRs= nothing%>
									</select>
								</td>
								<td valign="top" align="left" width="35%">
									<a href="Javascript:fEliminaItemSelect(frmModificaNota.sltFoto)"><li>Eliminar foto</a><br>
									<a href="Javascript:fModificaItemSelect(frmModificaNota.sltFoto, 'frmModificaNota.sltFoto', 'EditFotoNota.asp?CodPub=<%=iCodPublicacion%>', 350, 500)"><li>Modificar / Ver foto</a>
								</td>
						</table>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top">¿Archivar?</td>
					<td class="texto" valign="top">
						No<input type="radio" name="radEstadoArchivo" value="1" <%if sEstadoArchivo="1" then%>checked<%end if%> >
						&nbsp;
						Si<input type="radio" name="radEstadoArchivo" value="0" <%if sEstadoArchivo="0" then%>checked<%end if%> >
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top">Página</td>
					<td valign="top" class="texto">
<%if sEstadoGenerado="0" then%>
						Aún no ha sido generada
<%else%>
						<a href="<%=sDominio%><%=fUrlNota(iCodNota, oConn)%>" target="_blank"><%=fUrlNota(iCodNota, oConn)%></a>
<%end if%>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td valign="top" colspan="2" align="center">
						<input type="submit" name="sbmModificar" value="MODIFICAR" class="botones"/>&nbsp;&nbsp;
						<input type="button" name="btnVolver" value="VOLVER" class="botones" onclick="location.href='ListNotas.asp?CodPub=<%=iCodPublicacion%>&CodSec=<%=iCodSeccion%>&EstArch=<%=Request.QueryString("EstArch")%>'"/>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td valign="top" colspan="2" align="center">
						<span class="mensaje">Los campos marcados con asterisco (*) deberán ser ingresados obligatoriamente</span><br/>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>