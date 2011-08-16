<%option explicit%>
<%Response.Buffer= true
Response.CacheControl= "private"
Response.Expires= "0"%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../include/asp/conn.asp" -->
<%'Autorizaci�n para esta p�gina
	if IsEmpty(Session("EstaAutorizadoPagina")) then
		pMensaje "No est� autorizado para ver m�dulos", "../Macro/ListNotas.asp?CodPub=" & _
		Request.QueryString("CodPub") & "&CodSec=" & Request.QueryString("CodSec"), "_self"
	end if%>
<!-- #include file="../Include/Asp/incVerificaAutorizacionPubSec.asp" -->
<!-- #include file="../Include/Asp/fValorCampo.asp" -->
<%'Declaraci�n de variables
	dim oRs, iCodPublicacion, iCodSeccion, iCodNota, sTituloNota, oConn%>
<%'Recoge el c�digo de la publicaci�n
	iCodPublicacion= CInt(Request.QueryString("CodPub"))%>
<%'Recoge el c�digo de la secci�n
	iCodSeccion= CInt(Request.QueryString("CodSec"))%>
<%'Recoge el c�digo de la nota
	iCodNota= CInt(Request.QueryString("CodNota"))%>
<%'Abre la conexi�n
	set oConn= Server.CreateObject("ADODB.Connection")
	oConn.Open constr%>
<%'Trae el t�tulo de la nota
	sTituloNota= fValorCampo("des_titulonota", "notas", oConn, "cod_nota=" & _
		iCodNota)%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / M�dulos para publicaci�n</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="../Include/Css/stilo.css" type="text/css" />
		<script language="javascript" src="../Include/Js/fAbreVentana.js"></script>
	</head>
	<body bgcolor="#FFFFFF" marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
<%'Trae los m�dulos que est�n relacionados con esta publicaci�n
	set oRs= Server.CreateObject("ADODB.Recordset")
	oRs.Open "SELECT b.des_comando1, b.nom_modulo" & _
	" FROM publicacionmodulo a, modulo b" & _
	" WHERE a.cod_publicacion=" & iCodPublicacion & _
	" AND a.cod_modulo=b.cod_modulo AND b.est_activo='1'" & _
	" ORDER BY b.nom_modulo", oConn%>
<%
	if not oRs.EOF then%>
		<table width="100%" cellpadding="2" cellspacing="2" border="0">
<%
		do while not oRs.EOF%>
			<tr>
				<td valign="top">
					<a href="javascript:fAbreVentana(400, 400, 0, '<%=Trim(Replace(Replace(Replace(Replace(oRs("des_comando1"), "[CODPUB]", iCodPublicacion), "[CODSEC]", iCodSeccion), "[CODNOTA]", iCodNota), "[TITNOTA]", Server.URLEncode(sTituloNota)))%>'); " 
					class="texto"><%=Trim(oRs("nom_modulo"))%></a>
				</td>
			</tr>
<%
			oRs.MoveNext
		loop%>
		</table>
<%
	end if
	oRs.Close
	set oRs= nothing%>
	</body>
</html>
<%'Cierra la conexi�n
	oConn.Close
	set oConn= nothing%>