<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../Include/Asp/Conn.asp" -->
<!-- #include file="../Include/Asp/fFiltraApostrofe.asp" -->
<%'Autorización para esta página
	if IsEmpty(Session("EstaAutorizadoPagina")) then
		pMensaje "No está autorizado para adicionar publicación", "../Macro/ListPublicaciones.asp", "_self"
	end if%>
<!-- #include file="../Include/Asp/fValorCampo.asp" -->
<!-- #include file="../Include/Asp/incCreaDirectoriosPub.asp" -->
<%'Declaración de variables
	dim oConn, oRs, sSql, iCodPublicacion, sNombrePublicacion _
	, sDescripcionPublicacion, sRutaFtp, sRutaVirtual, sPaginaPrincipal _
	, iCodAuspicio, iCodServidor, sActivo, sMensaje, sRutaFisica _
	, sPaginaAspPortada%>
<%'Abrir la conexión
	set oConn= Server.CreateObject("ADODB.connection")
	oConn.Open constr%>
<%'Traer el código de la publicación
	iCodPublicacion= CInt(Request.QueryString("CodPub"))%>
<%'Traer los datos o modificarlos
	if not IsEmpty(Request.Form("sbmIngresar")) then
		sNombrePublicacion= fFiltraApostrofe(Request.Form("txtNombrePublicacion"))
		sDescripcionPublicacion= fFiltraApostrofe(Request.Form("txtDescripcionPublicacion"))
		sRutaFtp= Request.Form("txtRutaFtp")
		sRutaFisica= Request.Form("txtRutaFisica")
		sRutaVirtual= Request.Form("txtRutaVirtual")
		sPaginaPrincipal= Request.Form("txtPaginaPrincipal")
		sPaginaAspPortada= Request.Form("txtPaginaAspPortada")
		iCodAuspicio= Request.Form("sltAuspicio")
		iCodServidor= Request.Form("sltServidor")
		sActivo= Request.Form("chkActivo")
		'Verifica que el nombre de la publicacion no exista
		if fValorCampo("cod_publicacion", "publicacion", oConn, "nom_publicacion='" & sNombrePublicacion & "'")<>"" then
			sMensaje= "* El nombre de la publicación YA EXISTE"
		else
			if fValorCampo("des_rutavirtual", "publicacion", oConn, _
				"des_rutavirtual='" & sRutaVirtual & "'")<>"" then
				sMensaje= "* La Ruta Virtual YA EXISTE"
			else
				sSql= "INSERT publicacion (cod_servidor, nom_publicacion" & _
					", des_publicacion, des_rutafisica, des_rutaftp" & _
					", des_rutavirtual, nom_paginaprincipal, nom_paginaaspportada" & _
					", cod_auspicio) VALUES (" & iCodServidor & ", '" & _
					sNombrePublicacion & "', '" & sDescripcionPublicacion & "', '" & _
					sRutaFisica & "', '" & sRutaFtp & "', '" & sRutaVirtual & "', '" & _
					sPaginaPrincipal & "', '" & sPaginaAspPortada & "', " & _
					iCodAuspicio & ")"
				oConn.Execute sSql
				'Crea los subdirectorios del virtual, para eso trae el código de cod_publicacion
				set oRs= Server.CreateObject("ADODB.Recordset")
				oRs.Open "SELECT @@identity FROM publicacion", oConn
				if not oRs.EOF then CreaDirectoriosPub(oRs(0))
				oRs.Close
				set oRs= nothing
				oConn.Close
				set oConn= nothing
				Response.Redirect "../Macro/ListPublicaciones.asp"
			end if
		end if
	else
		sActivo= "1"
	end if%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Ingresar publicaciones</title>
		<link rel="stylesheet" href="../Include/Css/Stilo.css" type="text/css">
		<script language="javascript" src="../Include/Js/fTrim.js"></script>
		<script language="javascript" src="../Include/Js/fValidateTextBlank.js"></script>
		<script language="javascript">
			function fValidafrmIngresaPublicacion(){
				var bFlag= fValidateTextBlank(document.frmIngresaPublicacion.txtNombrePublicacion, "El campo NOMBRE está vacío");
				if (bFlag) {
					bFlag= fValidateTextBlank(document.frmIngresaPublicacion.txtRutaVirtual, "El campo RUTA VIRTUAL está vacío");
				}
				return bFlag;
			}
			
			//Habilita y deshabilita los campos ruta física o ruta ftp según sea el caso
			function fDeshabilitaElemento(elementoHabil, elementoNoHabil) {
				if (elementoHabil.value.length==0) {
					elementoNoHabil.style.backgroundColor= elementoHabil.style.backgroundColor;
					elementoNoHabil.disabled= false;
				} else {
					elementoNoHabil.style.backgroundColor= "#C0C0C0";
					elementoNoHabil.disabled= true;
				}
			}
		</script>
	</head>
	<body bgcolor="#FFFFFF" marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
		<form action="../Macro/IngrPublicaciones.asp" method="post" name="frmIngresaPublicacion" 
		id="frmIngresaPublicacion" onsubmit="return fValidafrmIngresaPublicacion()">
			<table cellpadding="2" cellspacing="1" border="0" width="480" bgcolor="#c0c0c0">
				<tr align="center" bgcolor="#FFFFFF">
					<td colspan="2" class="Titulo">Ingresar publicación</td>
				</tr>
<%if sMensaje<>"" then%>
				<tr bgcolor="#FFFFFF">
					<td colspan="2" class="mensaje"><%=sMensaje%></td>
				</tr>
<%end if%>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top">Nombre (*)</td>
					<td valign="top">
						<input type="text" name="txtNombrePublicacion" value="<%=sNombrePublicacion%>" 
						maxlength="50" size="50">
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top">Descripción</td>
					<td valign="top">
						<input type="text" name="txtDescripcionPublicacion" value="<%=sDescripcionPublicacion%>"
						maxlength="50" size="50">
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top">Servidor</td>
					<td valign="top">
						<select name="sltServidor" size="1">
							<option value="0">Seleccionar</option>
<%'trae los servidores
	set oRs= Server.CreateObject("ADODB.Recordset")
	sSql= "SELECT cod_servidor, nom_servidor FROM servidores ORDER BY 2 ASC"
	oRs.Open sSql, oConn%>
<%do while not oRs.EOF%>
							<option value="<%=oRs("cod_servidor")%>" <%if oRs("cod_servidor")=CInt(iCodServidor) then%>selected<%end if%>><%=Trim(oRs("nom_servidor"))%></option>
<%	oRs.MoveNext
	loop
	oRs.Close
	set oRs= nothing%>
						</select>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top">Ruta Física (**)</td>
					<td valign="top">
						<input type="text" name="txtRutaFisica"
						value="<%=sRutaFisica%>" maxlength="150" size="50" 
						onkeyup="fDeshabilitaElemento(this, document.forms[0].txtRutaFtp)">
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top">Ruta FTP (**)</td>
					<td valign="top">
						<input type="text" name="txtRutaFtp" 
						value="<%=sRutaFtp%>" maxlength="100" size="50"
						onkeyup="fDeshabilitaElemento(this, document.forms[0].txtRutaFisica)">
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top">Ruta Virtual (*)(***)</td>
					<td valign="top">
						<input type="text" name="txtRutaVirtual" value="<%=sRutaVirtual%>"
						maxlength="50" size="50">
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top">Página portada html</td>
					<td valign="top">
						<input type="text" name="txtPaginaPrincipal" value="<%=sPaginaPrincipal%>"
						maxlength="30" size="30">
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top">Página asp que<br>genera portada</td>
					<td valign="top">
						<input type="text" name="txtPaginaAspPortada" value="<%=sPaginaAspPortada%>"
						maxlength="30" size="30">
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
							<option value="<%=oRs("cod_auspicio")%>" <%if oRs("cod_auspicio")=CInt(iCodAuspicio) then%>selected<%end if%>><%=Trim(oRs("nom_auspicio"))%></option>
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
						<input type="submit" name="sbmIngresar" value="INGRESAR" class="botones"/>&nbsp;&nbsp;
						<input type="button" name="btnVolver" value="VOLVER" class="botones" onclick="location.href='../Macro/ListPublicaciones.asp'"/>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td valign="top" colspan="2" align="center">
						<div><span class="mensaje">(*) Los campos marcados con asterisco deberán ser ingresados obligatoriamente<br/>
						(**) Puede utilizar el campo Ruta Física ó Ruta Ftp pero no los dos juntos<br>
						(***) El campo Ruta Virtual no se podrá modificar en el futuro.</span></div>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>