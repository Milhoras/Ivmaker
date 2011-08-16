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
<%'Declaraci�n de variables
	dim oUpl, sArchivoFoto, sSumillaFoto, sMensaje, sElemento, iPrioridad _
	, oConn, iCodigoFoto, sAutorFoto, iCodPublicacion, bSePuedeEnviar _
	, oRs, i, iIndice, sRutaVirtual%>
<%'constantes
	const ciMaximoCaracteresSumilla= 250%>
<%'Recoge el querystring del elemento y el �ndice
	sElemento= Request.QueryString("Elemento")
	iIndice= Request.QueryString("Indice")%>
<%'Recoge el c�sdigo de la publicaci�n
	iCodPublicacion= Request.QueryString("CodPub")%>
<%'Abre la conexi�n
	set oConn= Server.CreateObject("ADODB.Connection")
	oConn.Open constr%>
<%'Saca la ruta virtual de la publicaci�n
	sRutaVirtual= fValorCampo("des_rutavirtual", "publicacion", constr, "cod_publicacion=" & iCodPublicacion)%>
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
<%	set oUpl= nothing%>
<%'si se puede enviar, lo env�a y cierra la ventana
		if bSePuedeEnviar then
			if Trim(sArchivoFoto)="" then sArchivoFoto= _
			fValorCampo("des_nombrearchivo", "foto", constr, "cod_foto=" & iCodigoFoto)%>
<html>
	<body>
		<script language="Javascript">
			opener.<%=sElemento%>.options[<%=iIndice%>]= null;
			var sValor= "<%=iPrioridad%>|<%=iCodigoFoto%>|<%=Replace(sArchivoFoto, """", "\""")%>|<%=Replace(sSumillaFoto, """", "\""")%>";
			var iIndice= opener.<%=sElemento%>.options.length;

			var oOpcion= opener.document.createElement("OPTION")
			oOpcion.text= sValor;
			oOpcion.value= sValor;
			
			eval("opener.<%=sElemento%>.options[iIndice]= oOpcion");
			window.close();
		</script>
	</body>
</html>
<%		'Vuelve a 0 el codigo de foto inicial//No s� porqu� pero se va hacia abajo y arroja un error en la l�nea 146
			iCodigoFoto= 0
		end if%>
<%
	else
		dim aItem
		aItem= Split(Request.QueryString("Item"), "|")
		if IsNumeric(aItem(0)) then iPrioridad= CInt(aItem(0))
		if IsNumeric(aItem(1)) then iCodigoFoto= CInt(aItem(1))
		sSumillaFoto= aItem(3)
	end if%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Modificar asignaci�n foto a nota</title>
		<link rel="stylesheet" href="../Include/Css/stilo.css" type="text/css" />
		<script language="javascript" src="../Include/Js/fLengthTextArea.js"></script>
		<script language="javascript" src="../Include/Js/fValidateTextNumber.js"></script>
		<script language="javascript" src="../Include/Js/fValidateTextBlank.js"></script>
		<script language="javascript" src="../Include/Js/fTrim.js"></script>
		<script language="javascript">
			function fValidafrmModificaFoto(){
				var bFlag= fLengthTextArea(document.frmModificaFoto.txtSumillaFoto, <%=ciMaximoCaracteresSumilla%>, "El campo DESCRIPCION excede los <%=ciMaximoCaracteresSumilla%> caracteres permitidos");
				if (bFlag) {
					bFlag= fValidateTextNumber(document.frmModificaFoto.txtPrioridad, "El campo PRIORIDAD debe ser num�rico");
				}
				return bFlag;
			}
		</script>
<%'sacar las fotos que pertenecen a esta publicaci�n
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
			<form action="EditFotoNota.asp?CodPub=<%=iCodPublicacion%>&Elemento=<%=sElemento%>&Indice=<%=iIndice%>" method="post"
			enctype="multipart/form-data" name="frmModificaFoto" id="frmModificaFoto"
			onsubmit="return fValidafrmModificaFoto()">
				<table cellpadding="3" cellspacing="1" border="0" width="300" bgcolor="#c0c0c0">
					<tr bgcolor="#FFFFFF">
						<td align="center" class="textobold" colspan="2">Modificar foto</td>
					</tr>
<%if trim(sMensaje)<>"" then%>
					<tr bgcolor="#FFFFFF">
						<td class="textobold" colspan="2">
							<%=sMensaje%>
						</td>
					</tr>
<%end if%>
<%'sacar las fotos que pertenecen a esta publicaci�n
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
							<select name="sltFotoExistente" style="width:140pt"
							onchange="fCargaFoto(this.options[this.selectedIndex].value, document.frmModificaFoto.txtAutorFoto, document.frmModificaFoto.fFoto, document.imgFoto)">
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
							Si no ubica la foto en esta lista, adici�nela desde su 
							computadora.<br>Utilice la opci�n 
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
<%'Sacar todos los tama�os a los que se puede reducir la foto
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
<%
		else%>
										<input type="checkbox" name="chkTamanos" value="<%=Trim(oRs("des_tamanio"))%>" checked>
<%
		end if%>
										<%=Trim(oRs("des_tamanio"))%> px.
									</td>
<%
		oRs.Movenext
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
<script>
	fCargaFoto("<%=iCodigoFoto%>", document.frmModificaFoto.txtAutorFoto, document.frmModificaFoto.fFoto, document.imgFoto);
</script>
<%
	oConn.Close
	set oConn= nothing%>