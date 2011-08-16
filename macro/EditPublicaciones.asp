<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../Include/Asp/Conn.asp" -->
<!-- #include file="../Include/Asp/fFiltraApostrofe.asp" -->
<%'Verifica que código publicación exista o sea un número
	if not IsNumeric(Request.QueryString("CodPub")) or Trim(Request.QueryString("CodPub"))="" then
		pMensaje "Ingrese una publicación válida", "../Macro/ListPublicaciones.asp", "_self"
	end if%>
<%'Autorización para la página
	if IsEmpty(Session("EstaAutorizadoPagina")) then
		pMensaje "No está autorizado para modificar esta publicación", "../Macro/ListPublicaciones.asp", "_self"
	end if%>
<!-- #include file="../Include/Asp/fValorCampo.asp" -->
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
	if not IsEmpty(Request.Form("sbmModificar")) then
		sNombrePublicacion= fFiltraApostrofe(Request.Form("txtNombrePublicacion"))
		sDescripcionPublicacion= fFiltraApostrofe(Request.Form("txtDescripcionPublicacion"))
		sRutaFtp= Request.Form("txtRutaFtp")
		sRutaFisica= Request.Form("txtRutaFisica")
		sPaginaPrincipal= Request.Form("txtPaginaPrincipal")
		sPaginaAspPortada= Request.Form("txtPaginaAspPortada")
		iCodAuspicio= Request.Form("sltAuspicio")
		if Trim(iCodAuspicio)<>"" then iCodAuspicio= CInt(iCodAuspicio)
		iCodServidor= Request.Form("sltServidor")
		if Trim(iCodServidor)<>"" then iCodServidor= CInt(iCodServidor)
		sActivo= Request.Form("chkActivo")
		'Verifica que el nombre de publicacion no exista
		if fValorCampo("cod_publicacion", "publicacion", constr, "nom_publicacion='" & _
		sNombrePublicacion & "' AND cod_publicacion<>" & iCodPublicacion)<>"" then
			sMensaje= "* El nombre de la publicación YA EXISTE"
		else
			sSql= "UPDATE publicacion SET cod_servidor=" & iCodServidor & _
				", nom_publicacion='" & sNombrePublicacion & _
				"', des_publicacion='" & sDescripcionPublicacion & _
				"', des_rutafisica='" & sRutaFisica & "', des_rutaftp='" & _
				sRutaFtp & "', nom_paginaprincipal='" & sPaginaPrincipal & _
				"', nom_paginaaspportada='" & sPaginaAspPortada & _
				"', cod_auspicio=" & iCodAuspicio & ", est_activo='" & _
				sActivo & "' WHERE cod_publicacion=" & iCodPublicacion
			oConn.Execute sSql
			oConn.Close
			set oConn= nothing
			Response.Redirect "../Macro/ListPublicaciones.asp"
		end if
	else
		sSql= "SELECT cod_servidor, nom_publicacion" & _
			", des_publicacion, des_rutaftp, des_rutafisica" & _
			", des_rutavirtual, nom_paginaprincipal, nom_paginaaspportada" & _
			", cod_auspicio, est_activo" & _
			" FROM publicacion" & _
			" WHERE cod_publicacion=" & iCodPublicacion
		set oRs= server.CreateObject("ADODB.Recordset")
		oRs.Open sSql, oConn
		if not oRs.eof then
			iCodServidor= oRs("cod_Servidor")
			sNombrePublicacion= Trim(oRs("nom_publicacion"))
			sDescripcionPublicacion= Trim(oRs("des_publicacion"))
			sRutaFtp= Trim(oRs("des_rutaftp"))
			sRutaFisica= Trim(oRs("des_rutafisica"))
			sRutaVirtual= Trim(oRs("des_rutavirtual"))
			sPaginaPrincipal= Trim(oRs("nom_paginaprincipal"))
			sPaginaAspPortada= Trim(oRs("nom_paginaaspportada"))
			iCodAuspicio= oRs("cod_auspicio")
			sActivo= oRs("est_activo")
		end if
		oRs.Close
		set oRs= nothing
	end if%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Modificar publicaciones</title>
		<link rel="stylesheet" href="../Include/Css/Stilo.css" type="text/css">
		<script language="javascript" src="../Include/Js/fTrim.js"></script>
		<script language="javascript" src="../Include/Js/fValidateTextBlank.js"></script>
		<script language="javascript">
			function fValidafrmModificaPublicacion(){
				var bFlag= fValidateTextBlank(document.frmModificaPublicacion.txtNombrePublicacion, "El campo NOMBRE está vacío");
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
		<form action="../Macro/EditPublicaciones.asp?CodPub=<%=iCodPublicacion%>" method="post" name="frmModificaPublicacion" 
		id="frmModificaPublicacion" onsubmit="return fValidafrmModificaPublicacion()">
			<table cellpadding="2" cellspacing="1" border="0" width="480" bgcolor="#c0c0c0">
				<tr align="center" bgcolor="#FFFFFF">
					<td colspan="2" class="Titulo">Modificar publicaciones</td>
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
							<option value="<%=oRs("cod_servidor")%>" <%if oRs("cod_servidor")=iCodServidor then%>selected<%end if%>><%=Trim(oRs("nom_servidor"))%></option>
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
					<td class="texto" valign="top">Ruta Virtual</td>
					<td class="texto" valign="top">
						<%=sRutaVirtual%>
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
						<input type="button" name="btnVolver" value="VOLVER" class="botones" onclick="location.href='../Macro/ListPublicaciones.asp'"/>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td valign="top" colspan="2" align="center">
						<div><span class="mensaje">Los campos marcados con asterisco (*) deberán ser ingresados obligatoriamente<br/>
						(**) Puede utilizar el campo Ruta Física ó Ruta Ftp pero no los dos juntos</span></div>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>