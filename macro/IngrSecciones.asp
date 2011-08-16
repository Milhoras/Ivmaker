<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../Include/Asp/Conn.asp" -->
<!-- #include file="../Include/Asp/fTienePermisoPagina.asp"-->
<!-- #include file="../Include/Asp/fFiltraApostrofe.asp" -->
<%'Verifica que el código de publicación exista y sea un número
	if not IsNumeric(Request.QueryString("CodPub")) or Trim(Request.QueryString("CodPub"))="" then
		pMensaje "Ingrese una publicación válida", "../Macro/ListPublicaciones.asp", "_self"
	end if%>
<%'Autorización a esta página
	if IsEmpty(Session("EstaAutorizadoPagina")) then
		pMensaje "No está autorizado para ingresar sección", "../Macro/ListSecciones.asp?" & Request.QueryString("CodPub"), "_self"
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
<%'Traer el código de la publicación
	iCodPublicacion= CInt(Request.QueryString("CodPub"))%>
<%'Traer los datos o modificarlos
	if not IsEmpty(Request.Form("sbmIngresar")) then
		sNombreSeccion= fFiltraApostrofe(Request.Form("txtNombreSeccion"))
		sAlias= Trim(Request.Form("txtAlias"))
		iCodPlantilla= Request.Form("sltPlantilla")
		iCodPlantillaDefectoNota= Request.Form("sltPlantillaDefectoNota")
		if iCodPlantillaDefectoNota= "0" or trim(iCodPlantillaDefectoNota)="" then _
			iCodPlantillaDefectoNota= null
		iCodAuspicio= Request.Form("sltAuspicio")
		sActivo= Request.Form("chkActivo")
		bSePuedeGrabar= true
		'Verifica que el nombre no exista en la misma publicación
		if fValorCampo("cod_seccion", "seccion", constr, "nom_seccion='" & _
		sNombreSeccion & "' AND cod_publicacion=" & iCodPublicacion)<>"" then
			sMensaje= sMensaje & "* El nombre de la sección YA EXISTE en esta publicación"
			bSePuedeGrabar= false
		end if
		'Verifica que el alias contenga caracteres permitidos
		if not fVerificaCaracteresPermitidosArchivo(sAlias) then
			if sMensaje<>"" then sMensaje= sMensaje & "<br/>"
			sMensaje= "* El campo Alias contiene caracteres no permitidos"
			bSePuedeGrabar= false
		end if
		'Verifica que el alias no existe en la misma publicacion
		if fValorCampo("cod_seccion", "seccion", constr, "des_alias='" & _
		sAlias & "' AND cod_publicacion=" & iCodPublicacion)<>"" then
			if sMensaje<>"" then sMensaje= sMensaje & "<br/>"
			sMensaje= sMensaje & "* El alias YA EXISTE en esta publicación"
			bSePuedeGrabar= false
		end if
		if bSePuedeGrabar then
			sSql= "INSERT seccion(cod_publicacion, cod_plantilla, cod_auspicio" & _
			", nom_seccion, des_alias, cod_plantilladefectonota, est_activo)" & _
			" VALUES(" & iCodPublicacion & ", " & iCodPlantilla & ", " & _
			iCodAuspicio & ", '" & sNombreSeccion & "', '" & sAlias & "', " & _
			iCodPlantillaDefectoNota & ", '" & sActivo & "')"
			oConn.Execute sSql
			oConn.Close
			set oConn= nothing
			Response.Redirect "../Macro/ListSecciones.asp?CodPub=" & iCodPublicacion
		end if
	else
		sActivo= "1"
	end if%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Ingresar secciones</title>
		<link rel="stylesheet" href="../Include/Css/Stilo.css" type="text/css">
		<script language="javascript" src="../Include/Js/fTrim.js"></script>
		<script language="javascript" src="../Include/Js/fValidateTextBlank.js"></script>
		<script language="javascript" src="../Include/Js/fValidateSelectBlank.js"></script>
		<script language="javascript">
			function fValidafrmIngresaSeccion(){
				var bFlag= fValidateTextBlank(document.frmIngresaSeccion.txtNombreSeccion, "El campo NOMBRE está vacío");
				if (bFlag) {
					bFlag= fValidateTextBlank(document.frmIngresaSeccion.txtAlias, "El campo ALIAS está vacío");
					if (bFlag) {
						bFlag= fValidateSelectBlank(document.frmIngresaSeccion.sltPlantilla, 0, "El campo PLANTILLA INDICE SECCIÓN está vacío");
					}
				}
				return bFlag;
			}
		</script>
	</head>
	<body bgcolor="#FFFFFF" marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
		<form action="../Macro/IngrSecciones.asp?CodPub=<%=iCodPublicacion%>" method="post" name="frmIngresaSeccion" 
		id="frmIngresaSeccion" onsubmit="return fValidafrmIngresaSeccion()">
			<table cellpadding="2" cellspacing="1" border="0" width="480" bgcolor="#c0c0c0">
				<tr align="center" bgcolor="#FFFFFF">
					<td colspan="2" class="Titulo">Ingresar sección / <%=fValorCampo("nom_publicacion", "publicacion", constr, "cod_publicacion=" & iCodPublicacion)%></td>
				</tr>
<%if sMensaje<>"" then%>
				<tr bgcolor="#FFFFFF">
					<td colspan="2" class="mensaje"><%=sMensaje%></td>
				</tr>
<%end if%>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top" width="35%">Nombre (*)</td>
					<td valign="top" width="65%">
						<input type="text" name="txtNombreSeccion" value="<%=sNombreSeccion%>" 
						maxlength="50" size="30"/>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top" width="35%">Alias (*)</td>
					<td valign="top" width="65%">
						<input type="text" name="txtAlias" value="<%=sAlias%>"
						maxlength="20" size="20"/>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top" width="35%">Plantilla índice sección (*)</td>
					<td valign="top" width="65%">
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
					<td class="texto" valign="top" width="35%">Auspiciador</td>
					<td valign="top" width="65%">
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
					<td class="texto" valign="top" width="35%">Activo</td>
					<td valign="top" width="65%">
						<input type="checkbox" name="chkActivo" value="1" <%if sActivo="1" then%>Checked<%end if%>/>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td valign="top" colspan="2" align="center">
						<input type="submit" name="sbmIngresar" value="INGRESAR" class="botones"/>&nbsp;&nbsp;
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