<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../Include/Asp/Conn.asp" -->
<%'Autorización para la página
	if IsEmpty(Session("EstaAutorizadoPagina")) then
		pMensaje "No está autorizado modificar notas relacionadas externas", "../Macro/ListNotas.asp?CodPub=" & _
		Request.QueryString("CodPub") & "&CodSec=" & Request.QueryString("CodSec") & _
		"&CodNota=" & Request.QueryString("CodNota"), "_self"
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
<!-- #include file="../Include/Asp/fValorCampo.asp" -->
<!-- #include file="../Include/Asp/fFiltraApostrofe.asp" -->
<%'Declaración de variables
	dim oConn, oRs, iCodNota, iCodPublicacion, iCodSeccion, sTitulo, i _
	, sSql, sMensaje, sEnlace, iCodRelacional%>
<%'Recoge el código de la nota, publicación y sección
	iCodNota= CInt(Request.QueryString("CodNota"))%>
<%'Recoge el código de sección
	iCodSeccion= CInt(Request.QueryString("CodSec"))%>
<%'Recoge el código de publicación
	iCodPublicacion= CInt(Request.QueryString("CodPub"))%>
<%'Recoge el código de relación
	iCodRelacional= CInt(Request.QueryString("CodRelacional"))%>
<%'Abre la conexión
	set oConn= Server.CreateObject("ADODB.Connection")
	oConn.Open constr%>
<%'El proceso
	if not IsEmpty(Request.Form("sbmModificar")) then
		sTitulo= Request.Form("txtTitulo")
		sEnlace= Request.Form("txtEnlace")
		sSql= "UPDATE notasrelacionadas SET des_titulo='" & _
		fFiltraApostrofe(sTitulo) & "', des_enlace='" & sEnlace & "'" & _
		" WHERE cod_relacionnota=" & iCodRelacional
		oConn.Execute(sSql)
		oConn.Close
		set oConn= nothing
		Response.Redirect("ListNotasRelacionadas.asp?CodPub=" & _
		iCodPublicacion & "&CodSec=" & iCodSeccion & "&CodNota=" & iCodNota)
	else
		set oRs= Server.CreateObject("ADODB.Recordset")
		sSql= "SELECT des_titulo, des_enlace FROM notasrelacionadas" & _
		"  WHERE cod_relacionnota=" & iCodRelacional
		oRs.Open sSql, oConn
		if not oRs.EOF then
			sTitulo= Trim(oRs("des_titulo"))
			sEnlace= Trim(oRs("des_enlace"))
		end if
		oRs.Close
		set oRs= nothing
	end if%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Modificar notas relacionadas externas</title>
		<link rel="stylesheet" href="../Include/Css/Stilo.css" type="text/css">
		<script language="javascript" src="../Include/Js/fTrim.js"></script>
		<script language="javascript" src="../Include/Js/fValidateTextBlank.js"></script>
		<script language="javascript">
			function fValidafrmModificaNotaRelacionadaExterna(){
				var bFlag= fValidateTextBlank(document.frmModificaNotaRelacionadaExterna.txtTitulo, "El campo TITULO está vacío");
				if (bFlag) {
					bFlag= fValidateTextBlank(document.frmModificaNotaRelacionadaExterna.txtEnlace, "El campo ENLACE está vacío");
				}
				return bFlag;
			}
		</script>
	</head>
	<body bgcolor="#FFFFFF" marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
		<form action="../Macro/EditNotasRelacionadasExternas.asp?CodPub=<%=iCodPublicacion%>&CodSec=<%=iCodSeccion%>&CodNota=<%=iCodNota%>&CodRelacional=<%=iCodRelacional%>"
		method="post" name="frmModificaNotaRelacionadaExterna" id="frmModificaNotaRelacionadaExterna" onsubmit="return fValidafrmModificaNotaRelacionadaExterna()">
			<table cellpadding="2" cellspacing="1" border="0" width="480" bgcolor="#c0c0c0">
				<tr align="center" bgcolor="#FFFFFF">
					<td colspan="2" class="Titulo">Modificar nota relacionada externa <br>
					<%=fValorCampo("nom_publicacion", "publicacion", constr, "cod_publicacion=" & iCodPublicacion)%>
					/ <%=fValorCampo("nom_seccion", "seccion", constr, "cod_seccion=" & iCodSeccion)%><br>
					<span class="textobold"><%=fValorCampo("des_titulonota", "notas", constr, "cod_nota=" & iCodNota)%></span></td>
				</tr>
<%if sMensaje<>"" then%>
				<tr bgcolor="#FFFFFF">
					<td colspan="2" class="mensaje"><%=sMensaje%></td>
				</tr>
<%end if%>
				<tr bgcolor="#FFFFFF">
					<td valign="top" width="20%" class="texto">Título (*)</td>
					<td valign="top" width="80%">
						<input type="text" name="txtTitulo" size="60"
						maxlength="100" value="<%=sTitulo%>">
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top">Enlace (*)</td>
					<td valign="top">
						<input type="text" name="txtEnlace" value="<%=sEnlace%>"
						maxlength="150" size="60">
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="top" colspan="2">
						<a href="<%=sEnlace%>" target="_blank"><%=sTitulo%></a>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td valign="top" colspan="2" align="center">
						<input type="submit" name="sbmModificar" value="MODIFICAR" class="botones">&nbsp;&nbsp;
						<input type="button" name="btnVolver" value="VOLVER" class="botones" onclick="location.href='ListNotasRelacionadas.asp?CodPub=<%=iCodPublicacion%>&CodSec=<%=iCodSeccion%>&CodNota=<%=iCodNota%>'">
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