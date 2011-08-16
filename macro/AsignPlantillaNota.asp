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
		pMensaje "No está autorizado asignar plantillas a notas", "../Macro/ListNotas.asp?CodPub=" & _
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
<!-- #include file="../Include/Asp/fValorCampo.asp" -->
<%'Declaración de variables
	dim oConn, oRs, sQueryString, iCodNota, iCodSeccion, iCodPublicacion _
	, sSql, icodPlantilla%>
<%'Recoge el código de la nota, publicación y sección de la nota principal
	iCodNota= CInt(Request.QueryString("CodNota"))
	iCodSeccion= CInt(Request.QueryString("CodSec"))
	iCodPublicacion= CInt(Request.QueryString("CodPub"))
	'Arma el querystring que trae de la nota principal
	sQueryString= "CodPub=" & iCodPublicacion & _
		"&CodSec=" & iCodSeccion & "&CodNota=" & iCodNota%>
<%'Abre la conexión
	set oConn= Server.CreateObject("ADODB.Connection")
	oConn.Open constr%>
<%'El proceso
	if not IsEmpty(Request.Form("sbmEnviar")) then
		oConn.Execute "UPDATE notas SET cod_plantilla=" & _
			Request.Form("sltPlantilla") & _
			" WHERE cod_nota=" & iCodNota%>
<script language="javascript">
	parent.location.reload();
</script>
<%
	end if%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Asignar plantilla a notas</title>
		<link rel="stylesheet" href="../Include/Css/Stilo.css" type="text/css">
		<script language="javascript" src="../Include/Js/fAbreVentana.js"></script>
		<script language="javascript" src="../Include/Js/fValidateSelectBlank.js"></script>
		<script language="javascript">
			function fValidafrmAsignaPlantilla(){
				var bFlag= fValidateSelectBlank(document.frmAsignaPlantilla.sltPlantilla, 0, "La asignación de la plantilla es obligatoria");
				return bFlag;
			}
		</script>
	</head>
	<body bgcolor="#FFFFFF" marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
		<form action="AsignPlantillaNota.asp?<%=sQueryString%>" method="post"
		onsubmit="return fValidafrmAsignaPlantilla()" name="frmAsignaPlantilla" id="frmAsignaPlantilla">
			<table width="100%" cellpadding="1" cellspacing="0" border="0" valign="top">
				<tr bgcolor="#FFFFFF">
					<td class="texto" valign="middle" align="center">
						<select name="sltPlantilla" size="1">
							<option value="0">Seleccionar</option>
<%'trae las plantillas
	set oRs= Server.CreateObject("ADODB.Recordset")
	sSql= "SELECT cod_plantilla, nom_plantilla" & _
		" FROM plantillas" & _
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
						&nbsp;<input type="submit" name="sbmEnviar" value="Asignar">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
<%'Cierra la conexión
	oConn.Close
	set oConn= nothing%>