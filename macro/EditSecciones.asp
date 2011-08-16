<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../Include/Asp/Conn.asp" -->
<!-- #include file="../Include/Asp/fTienePermisoPagina.asp"-->
<!-- #include file="../Include/Asp/fFiltraApostrofe.asp" -->
<%'Verifica que código publicación exista o sea un número
	if not IsNumeric(Request.QueryString("CodPub")) or Trim(Request.QueryString("CodPub"))="" then
		pMensaje "Ingrese una publicación válida", "../Macro/ListPublicaciones.asp", "_self"
	end if%>
<%'Verifica que código sección exista o sea un número
	if not IsNumeric(Request.QueryString("CodSec")) or Trim(Request.QueryString("CodSec"))="" then
		pMensaje "Ingrese una sección válida", "../Macro/ListSecciones.asp?CodPub=" & Request.QueryString("CodPub"), "_self"
	end if%>
<%'Autorización para la página
	if IsEmpty(Session("EstaAutorizadoPagina")) then
		pMensaje "No está autorizado para modificar sección", "../Macro/ListSecciones.asp?CodPub=" & Request.QueryString("CodPub"), "_self"
	end if%>
<!-- #include file="../Include/Asp/fValorCampo.asp" -->
<!-- #include file="../Include/Asp/fVerificaCaracteresPermitidosArchivo.asp" -->
<%'Declaración de variables
	dim oConn, oRs, sSql, iCodPublicacion, sAlias, iCodAuspicio, iCodPlantilla _
	, sActivo, sMensaje, iCodSeccion, sNombreSeccion, sAliasAntiguo _
	, bSePuedeGrabar, iCodPlantillaDefectoNota%>
<%'Abrir la conexión
	set oConn= Server.CreateObject("ADODB.connection")
	oConn.Open constr%>
<%'Traer el código de la publicación y de sección
	iCodPublicacion= CInt(Request.QueryString("CodPub"))
	iCodSeccion= CInt(Request.QueryString("CodSec"))%>
<%'Traer los datos o modificarlos
	if not IsEmpty(Request.Form("sbmModificar")) then
		sNombreSeccion= fFiltraApostrofe(Request.Form("txtNombreSeccion"))
		sAlias= Trim(Request.Form("txtAlias"))
		sAliasAntiguo= Request.Form("hdnAliasAntiguo")
		iCodPlantilla= Request.Form("sltPlantilla")
		iCodPlantillaDefectoNota= Request.Form("sltPlantillaDefectoNota")
		if iCodPlantillaDefectoNota= "0" or Trim(iCodPlantillaDefectoNota)="" then _
			iCodPlantillaDefectoNota= "null"
		iCodAuspicio= Request.Form("sltAuspicio")
		sActivo= Request.Form("chkActivo")
		bSePuedeGrabar= true
		'Verifica que el nombre no exista en la misma publicación
		if fValorCampo("cod_seccion", "seccion", constr, "nom_seccion='" & _
		sNombreSeccion & "' AND cod_publicacion=" & iCodPublicacion & _
		" AND cod_seccion<>" & iCodSeccion)<>"" then
			sMensaje= sMensaje & "* El nombre de la sección YA EXISTE en esta publicación"
			bSePuedeGrabar= false
		end if
		'Verifica que el alias contenga caracteres permitidos
		if sAlias<>sAliasAntiguo then
			if not fVerificaCaracteresPermitidosArchivo(sAlias) then
				if sMensaje<>"" then sMensaje= sMensaje & "<br/>"
				sMensaje= "* El campo Alias contiene caracteres no permitidos"
				bSePuedeGrabar= false
			end if			
		end if
		'Verifica que el alias no existe en la misma publicacion
		if fValorCampo("cod_seccion", "seccion", constr, "des_alias='" & _
		sAlias & "' AND cod_publicacion=" & iCodPublicacion & _
		" AND cod_seccion<>" & iCodSeccion)<>"" then
			if sMensaje<>"" then sMensaje= sMensaje & "<br/>"
			sMensaje= sMensaje & "* El alias YA EXISTE en esta publicación"
			bSePuedeGrabar= false
		end if
		if bSePuedeGrabar then
			sSql= "UPDATE seccion SET cod_plantilla=" & iCodPlantilla & _
			", cod_auspicio=" & iCodAuspicio & ", nom_seccion='" & _
			sNombreSeccion & "', des_alias='" & sAlias & _
			"', cod_plantilladefectonota=" & iCodPlantillaDefectoNota & _
			", est_activo='" & sActivo & "' WHERE cod_seccion=" & iCodSeccion
			oConn.Execute sSql
			oConn.Close
			set oConn= nothing
			Response.Redirect "../Macro/ListSecciones.asp?CodPub=" & iCodPublicacion
		end if
	else
		sSql= "SELECT cod_plantilla,  cod_auspicio, nom_seccion, des_alias" & _
			", cod_plantilladefectonota, est_activo" & _
			" FROM seccion WHERE cod_seccion=" & iCodSeccion
		set oRs= server.CreateObject("ADODB.Recordset")
		oRs.Open sSql, oConn
		if not oRs.eof then
			iCodPlantilla= oRs("cod_plantilla")
			iCodAuspicio= oRs("cod_auspicio")
			sNombreSeccion= Trim(oRs("nom_seccion"))
			sAlias= Trim(oRs("des_alias"))
			iCodPlantillaDefectoNota= oRs("cod_plantilladefectonota")
			sActivo= oRs("est_activo")
			sAliasAntiguo= sAlias
		end if
		oRs.Close
		set oRs= nothing
	end if%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Modificar secciones</title>
		<link rel="stylesheet" href="../Include/Css/Stilo.css" type="text/css">
		<script language="javascript" src="../Include/Js/fTrim.js"></script>
		<script language="javascript" src="../Include/Js/fValidateTextBlank.js"></script>
		<script language="javascript" src="../Include/Js/fValidateSelectBlank.js"></script>
		<script language="javascript">
			function fValidafrmModificaSeccion(){
				var bFlag= fValidateTextBlank(document.frmModificaSeccion.txtNombreSeccion, "El campo NOMBRE está vacío");
				if (bFlag) {
					bFlag= fValidateTextBlank(document.frmModificaSeccion.txtAlias, "El campo ALIAS está vacío");
					if (bFlag) {
						bFlag= fValidateSelectBlank(document.frmModificaSeccion.sltPlantilla, 0, "El campo PLANTILLA INDICE SECCIÓN está vacío");
					}
				}
				return bFlag;
			}
		</script>
	</head>
	<body bgcolor="#FFFFFF" marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
		<form action="../Macro/EditSecciones.asp?CodPub=<%=iCodPublicacion%>&CodSec=<%=iCodSeccion%>" method="post" name="frmModificaSeccion" 
		id="frmModificaSeccion" onsubmit="return fValidafrmModificaSeccion()">
			<table cellpadding="2" cellspacing="1" border="0" width="480" bgcolor="#c0c0c0">
				<tr align="center" bgcolor="#FFFFFF">
					<td colspan="2" class="Titulo">Modificar secciones / <%=fValorCampo("nom_publicacion", "publicacion", constr, "cod_publicacion=" & iCodPublicacion)%></td>
				</tr>
<%if sMensaje<>"" then%>
				<tr bgcolor="#FFFFFF">
					<td colspan="2" class="mensaje"><%=sMensaje%></td>
				</tr>
<%end if%>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top">Nombre (*)</td>
					<td valign="top">
						<input type="text" name="txtNombreSeccion" value="<%=sNombreSeccion%>" 
						maxlength="50" size="30"/>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top">Alias (*)</td>
					<td valign="top">
						<input type="text" name="txtAlias" value="<%=sAlias%>"
						maxlength="20" size="20"/>
						<input type="hidden" name="hdnAliasAntiguo" value="<%=sAliasAntiguo%>">
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top">Plantilla índice sección (*)</td>
					<td valign="top">
						<select name="sltPlantilla" size="1">
							<option value="0">Seleccionar</option>
<%'trae las plantillas
	set oRs= Server.CreateObject("ADODB.Recordset")
	sSql= "SELECT cod_plantilla, nom_plantilla" & _
		" FROM plantillas" & _
		" WHERE cod_publicacion=" & iCodPublicacion & _
		" AND tip_plantilla='S'" & _
		" ORDER BY 2 ASC"
	oRs.Open sSql, oConn%>
<%do while not oRs.EOF%>
							<option value="<%=oRs("cod_plantilla")%>" <%if oRs("cod_plantilla")=iCodPlantilla then%>selected<%end if%>><%=Trim(oRs("nom_plantilla"))%></option>
<%	oRs.MoveNext
	loop
	oRs.Close
	set oRs= nothing%>
						</select>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top" width="35%">Plantilla defecto nota</td>
					<td valign="top" width="65%">
						<select name="sltPlantillaDefectoNota" size="1">
							<option value="0">Seleccionar</option>
<%'trae las plantillas
	set oRs= Server.CreateObject("ADODB.Recordset")
	sSql= "SELECT cod_plantilla, nom_plantilla FROM plantillas" & _
	" WHERE cod_publicacion=" & iCodPublicacion & _
	" AND tip_plantilla='N'" & _
	" AND est_activo='1' ORDER BY 2 ASC"
	oRs.Open sSql, oConn%>
<%do while not oRs.EOF%>
							<option value="<%=oRs("cod_plantilla")%>" <%if oRs("cod_plantilla")=iCodPlantillaDefectoNota then%>selected<%end if%>><%=Trim(oRs("nom_plantilla"))%></option>
<%	oRs.MoveNext
	loop
	oRs.Close
	set oRs= nothing%>
						</select>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top">Auspiciador</td>
					<td valign="top">
						<select name="sltAuspicio" size="1">
							<option value="0">Seleccionar</option>
<%'trae los auspicios si hubieran
	set oRs= Server.CreateObject("ADODB.Recordset")
	sSql= "SELECT cod_auspicio, nom_auspicio FROM auspicio ORDER BY 2 ASC"
	oRs.Open sSql, oConn%>
<%do while not oRs.EOF%>
							<option value="<%=oRs("cod_auspicio")%>" <%if oRs("cod_auspicio")=iCodAuspicio then%>selected<%end if%>><%=Trim(oRs("nom_auspicio"))%></option>
<%	oRs.MoveNext
	loop
	oRs.Close
	set oRs= nothing%>
						</select>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top">Activo</td>
					<td valign="top">
						<input type="checkbox" name="chkActivo" value="1" <%if sActivo="1" then%>Checked<%end if%>/>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td valign="top" colspan="2" align="center">
						<input type="submit" name="sbmModificar" value="MODIFICAR" class="botones"/>&nbsp;&nbsp;
						<input type="button" name="btnVolver" value="VOLVER" class="botones" onclick="location.href='ListSecciones.asp?CodPub=<%=iCodPublicacion%>'"/>
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
<%oConn.Close
	set oConn= nothing%>