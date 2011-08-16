<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../Include/Asp/Conn.asp" -->
<%'Autorización para la página
	if IsEmpty(Session("EstaAutorizadoPagina")) then
		pMensaje "No está autorizado relacionar notas", "../Macro/ListNotas.asp?CodPub=" & _
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
<!-- #include file="../Include/Asp/fFiltraSignosMayorMenor.asp" -->
<!-- #include file="../Include/Asp/pColocaEstadoNotaNoGenerada.asp" -->
<%'Declaración de variables
	dim oConn, oRs, iCodNota, iCodRelacional, sTituloNotaRelacionada _
	, iCodPublicacion, iCodSeccion, i, sSql, iNumeroPrioridad _
	, sTituloNota%>
<%'Recoge el código de la nota, publicación y sección
	iCodNota= CInt(Request.QueryString("CodNota"))%>
<%'Recoge el código de sección
	iCodSeccion= CInt(Request.QueryString("CodSec"))%>
<%'Recoge el código de publicación
	iCodPublicacion= CInt(Request.QueryString("CodPub"))%>
<%'Abre la conexión
	set oConn= Server.CreateObject("ADODB.Connection")
	oConn.Open constr%>
<%'El proceso de activación y actualización
	if not IsEmpty(Request.Form("hdnI")) then
		dim ixNumeroPrioridad, ixCodigo
		for i=1 to CInt(Request.Form("hdnI")) 
			ixCodigo= Request.Form("hdnCodigo" & CStr(i))
			ixNumeroPrioridad= Request.Form("txtNumeroPrioridad" & CStr(i))
			if IsNumeric(ixNumeroPrioridad) or ixNumeroPrioridad="" then
				if ixNumeroPrioridad="" then ixNumeroPrioridad= 0
				oConn.Execute "UPDATE notasrelacionadas SET num_prioridad=" & _
				ixNumeroPrioridad & " WHERE cod_relacionnota=" & ixCodigo
			end if
		next
		'Cambia el estado de generación de la página
		pColocaEstadoNotaNoGenerada iCodNota, oConn
	end if%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Listado de notas relacionadas</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="../Include/Css/stilo.css" type="text/css" />
		<script language="javascript" src="../Include/Js/fAbreVentana.js"></script>
		<script language="JavaScript" src="../Include/Js/fConfirmAction.js"></script>
	</head>
	<body bgcolor="#FFFFFF" marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
		<form action="../Macro/ListNotasRelacionadas.asp?CodPub=<%=iCodPublicacion%>&amp;CodSec=<%=iCodSeccion%>&amp;CodNota=<%=iCodNota%>" method="post" name="frmListNotaRelacionada" id="frmListNotaRelacionada">
		<table width="500" border="0" cellspacing="1" cellpadding="3" bgcolor="#c0c0c0">
			<tr bgcolor="#FFFFFF">
				<td colspan="3" align="center" class="Titulo">Listado de Notas Relacionadas / <%=fValorCampo("nom_publicacion", "publicacion", constr, "cod_publicacion=" & iCodPublicacion)%>
				/ <%=fValorCampo("nom_seccion", "seccion", constr, "cod_seccion=" & iCodSeccion)%><br>
				<span class="textobold"><%=fValorCampo("des_titulonota", "notas", constr, "cod_nota=" & iCodNota)%></span>
				</td>
			</tr>
<%'Listado
	i= 0
	set oRs= Server.CreateObject("adodb.recordset")
	sSql= "SELECT b.cod_relacionnota, a.des_titulonota, a.cod_nota" & _
	", b.des_titulo, b.des_enlace, b.num_prioridad" & _
	" FROM notas a, notasrelacionadas b" & _
	" WHERE b.cod_nota=" & iCodNota & _
	" AND b.cod_notarelacionada*=a.cod_nota" & _
	" AND a.est_archivo='1'" & _
	" ORDER BY b.num_prioridad"
	oRs.Open sSql, oConn, 1, 1
	if not oRs.EOF then%>
			<tr bgcolor="#FFFFFF">
				<td class="textobold" width="15%" align="center">Prioridad</td>
				<td class="textobold" width="70%">Titulo</td>
				<td class="textobold" align="center" width="15%">Eliminar</td>
			</tr>
<%
		do while not oRs.EOF
			iCodRelacional= Trim(oRs("cod_relacionnota"))
			sTituloNotaRelacionada= Trim(oRs("des_titulonota"))
			iNumeroPrioridad= oRs("num_prioridad")
			i= i +1%>
			<tr bgcolor="#FFFFFF">
				<td valign="top" width="15%" align="center">
					<input type="text" name="txtNumeroPrioridad<%=i%>" value="<%=iNumeroPrioridad%>" maxlength="3" size="3" />
					<input type="hidden" name="hdnCodigo<%=i%>" value="<%=iCodRelacional%>">
				</td>
				<td valign="middle" width="70%">
<%if not IsNull(sTituloNotaRelacionada) then%>
					<a href="Javascript:fAbreVentana(400, 500, 0, 'VerNota.asp?CodNota=<%=oRs("cod_nota")%>')" class="texto"><%=fFiltraSignosMayorMenor(sTituloNotaRelacionada)%></a>
					&nbsp;
					<span class="texto">(<%=fValorCampo("a.nom_publicacion", "publicacion a, seccion b, notas c", constr, "c.cod_nota=" & oRs("cod_nota") & " AND c.cod_seccion=b.cod_seccion AND b.cod_publicacion=a.cod_publicacion")%>
					/ <%=fValorCampo("a.nom_seccion", "seccion a, notas b", constr, "b.cod_nota=" & oRs("cod_nota") & " AND b.cod_seccion=a.cod_seccion")%>)</span>
<%else%>
					<a href="EditNotasRelacionadasExternas.asp?CodPub=<%=icodPublicacion%>&CodSec=<%=iCodSeccion%>&CodNota=<%=iCodNota%>&CodRelacional=<%=iCodRelacional%>"><%=Trim(oRs("des_titulo"))%></a>
					&nbsp;<span class="texto">(externo)</span>
<%end if%>
				</td>
				<td align="center" width="15%">
					<a href="JavaScript:fConfirmAction('ElimNotasRelacionadas.asp?CodPub=<%=icodPublicacion%>&CodSec=<%=iCodSeccion%>&CodNota=<%=iCodNota%>&CodRelacional=<%=iCodRelacional%>', '¿Está seguro de eliminar la relación?')"><img src="../Image/papelera.gif" 
					border="0" WIDTH="15" HEIGHT="16" alt="Eliminar la asignación"></a>
				</td>
			</tr>
<%
			oRs.MoveNext
		loop%>
<%else%>
			<tr bgcolor="#FFFFFF">
				<td valign="middle" align="center" colspan="3" class="texto">
					No hay notas relacionadas
				</td>
			</tr>
<%end if
	oRs.Close
	set oRs= nothing%>
			<tr bgcolor="#FFFFFF">
				<td valign="top" colspan="<%if i>0 then%>2<%else%>3<%end if%>" align="left">
					<a href="AsignNotasRelacionadas.asp?CodPub=<%=icodPublicacion%>&amp;CodSec=<%=iCodSeccion%>&amp;CodNota=<%=iCodNota%>">Relacionar notas</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="IngrNotasRelacionadasExternas.asp?CodPub=<%=icodPublicacion%>&amp;CodSec=<%=iCodSeccion%>&amp;CodNota=<%=iCodNota%>">Nueva nota externa</a>
				</td>
<%if i>0 then%>
				<td valign="top" colspan="1" align="right">
					<input type="hidden" name="hdnI" value="<%=i%>" />
					<a href="Javascript:document.frmListNotaRelacionada.submit()" class="texto">Actualizar</a>
				</td>
<%end if%>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td valign="middle" colspan="8" class="texto">
					<a href="../Macro/ListNotas.asp?CodPub=<%=iCodPublicacion%>&amp;CodSec=<%=iCodSeccion%>" class="texto">&lt;&lt;Volver</a>
				</td>
			</tr>
		</table>
		</form>
	</body>
</html>
<%oConn.Close
	set oConn= nothing%>