<%Option explicit
	Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/Conn.asp" -->
<!-- #include file="../Include/Asp/incConstantesNombresSubDirectorios.asp" -->
<!-- #include file="../Include/Asp/fValorCampo.asp" -->
<!-- #include file="../Include/Asp/incCreaDirectoriosPub.asp" -->
<!-- #include file="../Include/Asp/fNombreImagenReducida.asp" -->
<!-- #include file="../Include/Asp/pCambiaTamanoImagen.asp" -->
<!-- #include file="../Include/Asp/fFiltraApostrofe.asp" -->
<!-- #include file="../Include/Asp/pVerificaCreaDirectorio.asp" -->
<%'Declaración de variables
	dim oUpl, sArchivoFoto, sSumillaFoto, sMensaje, sElemento, iPrioridad _
	, oConn, iCodigoFoto, sAutorFoto, iCodPublicacion, bSePuedeEnviar _
	, oRs, i, sRutaVirtual%>
<%'constantes
	const ciMaximoCaracteresSumilla= 250%>
<%'Recoge el querystring
	sElemento= Request.QueryString("Elemento")%>
<%'Recoge el cósdigo de la publicación
	iCodPublicacion= Request.QueryString("CodPub")%>
<%'Saca la ruta virtual de la publicación
	sRutaVirtual= fValorCampo("des_rutavirtual", "publicacion", constr, "cod_publicacion=" & iCodPublicacion)%>
<%'Abre la conexión
	set oConn= Server.CreateObject("ADODB.Connection")
	oConn.Open constr%>
<%'Traer las variables con el objeto safileup
	Set oUpl= Server.CreateObject("SoftArtisans.FileUp")%>
<%'El proceso de carga de la foto
	if not IsEmpty(oUpl.Form("sbmCargar")) then
		dim sDirectorioVirtualPublicacion
		sSumillaFoto= oUpl.Form("txtSumillaFoto")
		sAutorFoto= oUpl.Form("txtAutorFoto")
		iPrioridad= oUpl.Form("txtPrioridad")
		if iPrioridad="" then 
			iPrioridad= 0
		else
			iPrioridad= CInt(iPrioridad)
		end if
		bSePuedeEnviar= true
		if Trim(oUpl.Form("sltFotoExistente"))<>"" then
			iCodigoFoto= CInt(oUpl.Form("sltFotoExistente"))
		else
			if Trim(oUpl.Form("fFoto").UserFilename)<>"" then%>
			<!-- #include file="../Include/Asp/incFotoNota.asp" -->
<%
			else
				bSePuedeEnviar= false
				sMensaje= "* No ha elegido ni cargado alguna foto"
			end if
		end if%>
<%set oUpl= nothing%>
<%'si se puede enviar, lo envía y cierra la ventana
		if bSePuedeEnviar then
			if  Trim(sArchivoFoto)="" then sArchivoFoto= _
			fValorCampo("des_nombrearchivo", "foto", constr, "cod_foto=" & iCodigoFoto)%>
<html>
	<body>
		<script language="Javascript">
			var iIndice= opener.<%=sElemento%>.options.length;
			var sValor= "<%=iPrioridad%>|<%=iCodigoFoto%>|<%=Replace(sArchivoFoto, """", "\""")%>|<%=Replace(sSumillaFoto, """", "\""")%>";

			var oOpcion= opener.document.createElement("OPTION")
			oOpcion.text= sValor;
			oOpcion.value= sValor;
			
			eval("opener.<%=sElemento%>.options[iIndice]= oOpcion");
			window.close();
		</script>
	</body>
</html>
<%		'Vuelve a 0 el codigo de foto inicial//No sé porqué pero se va hacia abajo y arroja un error en la línea 146
			iCodigoFoto= 0
		end if
	end if%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Adicionar foto a nota</title>
		<link rel="stylesheet" href="../Include/Css/stilo.css" type="text/css" />
		<script language="javascript" src="../Include/Js/fLengthTextArea.js"></script>
		<script language="javascript" src="../Include/Js/fValidateTextNumber.js"></script>
		<script language="javascript" src="../Include/Js/fValidateTextBlank.js"></script>
		<script language="javascript" src="../Include/Js/fTrim.js"></script>
		<script language="javascript">
			function fValidafrmIngresaFoto() {
				var bFlag= fLengthTextArea(document.frmIngresaFoto.txtSumillaFoto, <%=ciMaximoCaracteresSumilla%>, "El campo DESCRIPCION excede los <%=ciMaximoCaracteresSumilla%> caracteres permitidos");
				if (bFlag) {
					bFlag= fValidateTextNumber(document.frmIngresaFoto.txtPrioridad, "El campo PRIORIDAD debe ser numérico");
				}
				return bFlag;
			}
		</script>
<%'sacar las fotos que pertenecen a esta publicación
	set oRs= Server.CreateObject("ADODB.Recordset")
	oRs.Open "SELECT cod_foto, des_autor, des_nombrearchivo FROM foto" & _
	" WHERE cod_publicacion=" & iCodPublicacion & _
	" ORDER BY des_nombrearchivo", oConn
	if not oRs.EOF then
		i= 0%>
		<script language="javascript1.2">
		var aFoto= new Array();
<%
		do while not oRs.EOF
			i= i + 1%>
		aFoto[<%=i%>]= new Array(3);
		aFoto[<%=i%>][1]= "<%=oRs("cod_foto")%>";
		aFoto[<%=i%>][2]= "<%=Trim(oRs("des_autor"))%>";
		aFoto[<%=i%>][3]= "<%=Trim(oRs("des_nombrearchivo"))%>";
<%	
			oRs.MoveNext
		loop%>
		function fCargaFoto(iCodigoFoto, elementoAutorTexto, elementoFotoFile, objetoImagen) {
			if (iCodigoFoto!="") {
				for (var i=1; i<aFoto.length; i++) {
					if (iCodigoFoto==aFoto[i][1]) {
						elementoAutorTexto.value= aFoto[i][2];
						elementoAutorTexto.text= aFoto[i][2];
						objetoImagen.src= '../<%=sRutaVirtual%>/<%=csSubDirectorioFoto%>/' + aFoto[i][3];
					}
				}
				elementoAutorTexto.disabled= true;
				elementoFotoFile.disabled= true;
			} else {
				elementoAutorTexto.value= "";
				elementoAutorTexto.text= "";
				elementoAutorTexto.disabled= false;
				elementoFotoFile.disabled= false;
				objetoImagen.src= '';
			}
		}
<%
	end if
	oRs.close
	set oRs= nothing%>		
		</script>
	</head>
	<body bgcolor="#FFFFFF" marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
		<div align="center"><center>
			<form action="IngrFotoNota.asp?CodPub=<%=iCodPublicacion%>&Elemento=<%=sElemento%>" method="post"
			enctype="multipart/form-data" name="frmIngresaFoto" id="frmIngresaFoto"
			onsubmit="return fValidafrmIngresaFoto()">
				<table cellpadding="3" cellspacing="1" border="0" width="300" bgcolor="#c0c0c0">
					<tr bgcolor="#FFFFFF">
						<td align="center" class="textobold" colspan="2">Ingresar foto</td>
					</tr>
<%if trim(sMensaje)<>"" then%>
					<tr bgcolor="#FFFFFF">
						<td class="textobold" colspan="2">
							<%=sMensaje%>
						</td>
					</tr>
<%end if%>
<%'sacar las fotos que pertenecen a esta publicación
	set oRs= Server.CreateObject("ADODB.Recordset")
	oRs.Open "SELECT cod_foto, des_nombrearchivo FROM foto" & _
	" WHERE cod_publicacion=" & iCodPublicacion & _
	" ORDER BY des_nombrearchivo", oConn
	if not oRs.EOF then%>
					<tr bgcolor="#FFFFFF">
						<td valign="top" class="texto">
							Fotos							
						</td>
						<td valign="top" class="texto">
							<select name="sltFotoExistente"  style="width='140pt'"
							onchange="fCargaFoto(this.options[this.selectedIndex].value, document.frmIngresaFoto.txtAutorFoto, document.frmIngresaFoto.fFoto, document.imgFoto)">
								<option value="">----</option>
<%
		do while not oRs.EOF%>
								<option value="<%=oRs("cod_foto")%>" <%if oRs("cod_foto")=iCodigoFoto then%>selected<%end if%>><%=Trim(oRs("des_nombrearchivo"))%></option>
<%	
			oRs.MoveNext
		loop%>
							</select>
						</td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td valign="top" class="texto" colspan="2">
							Si no ubica la foto en esta lista, adiciónela desde su 
							computadora.<br>Utilice la opción 
							"Cargar foto desde mi computadora"
						</td>
					</tr>
<%
	end if
	oRs.Close
	set oRs= nothing%>
					<tr bgcolor="#FFFFFF">
						<td valign="top" class="texto">
							Reducir a (ancho)
						</td>
						<td valign="top">
							<table width="100%" cellpadding="1" cellspacing="1" border="0">
<%'Sacar todos los tamaños a los que se puede reducir la foto
	dim j
	set oRs= Server.CreateObject("ADODB.Recordset")
	oRs.Open "SELECT a.des_tamanio, est_defecto" & _
	" FROM tamaniofoto a, tamaniofotopublicacion b" & _
	" WHERE a.cod_tamanio=b.cod_tamanio" & _
	" AND a.est_activo='1' AND b.cod_publicacion=" & _
	iCodPublicacion, oConn
	do while not oRs.EOF
		j= j + 1
		if j=1 then%>
								<tr>
<%
		end if%>
									<td valign="top" class="texto">
<%	if Trim(oRs("est_defecto"))="1" then%>
										<input type="hidden" name="chkTamanos" value="<%=Trim(oRs("des_tamanio"))%>">
										<font face="webdings" size="3">a</font>
<%	else%>
										<input type="checkbox" name="chkTamanos" value="<%=Trim(oRs("des_tamanio"))%>" checked>
<%	end if%>
										<%=Trim(oRs("des_tamanio"))%>
									</td>
<%	oRs.Movenext
		if j=3 then
			j= 0%>
								</tr>
<%
		end if
	loop
	oRs.Close
	set oRs= nothing
	Response.Write "<td colspan=""" & 3-j & """></td></tr>"%>
							</table>
						</td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td valign="top" class="texto">
							Cargar foto desde mi computadora
						</td>
						<td valign="top">
							<input type="file" name="fFoto">
						</td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td valign="top" class="texto">
							Leyenda<br>
							(<%=ciMaximoCaracteresSumilla%> caracteres)
						</td>
						<td valign="top">
							<textarea name="txtSumillaFoto" cols="29" rows="5"><%=sSumillaFoto%></textarea>
						</td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td valign="top" class="texto">
							Autor
						</td>
						<td valign="top">
							<input type="text" name="txtAutorFoto" size="30" maxlength="30"
							value="<%=sAutorFoto%>">
						</td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td valign="top" class="texto">
							Prioridad
						</td>
						<td valign="top">
							<input type="text" name="txtPrioridad" size="2" maxlength="2"
							value="<%=iPrioridad%>">
						</td>
					</tr>
					<tr bgcolor="#FFFFFF">
						<td align="center" colspan="2"><input type="submit" value="CARGAR" name="sbmCargar">
						&nbsp;&nbsp;&nbsp;<input type="button" value="CANCELAR" name="butCancelar" 
						onclick="window.close()">
						</td>
					</tr>
				</table>
				<p>
				<table cellpadding="3" cellspacing="1" border="0" width="300" bgcolor="#c0c0c0">
					<tr bgcolor="#FFFFFF">
						<td valign="top" align="center">
							<IMG name="imgFoto"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
<%
	oConn.Close
	set oConn= nothing%>