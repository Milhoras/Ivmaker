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
<!-- #include file="../Include/Asp/fFiltraApostrofe.asp" -->
<!-- #include file="../Include/Asp/pColocaEstadoNotaNoGenerada.asp" -->
<%'Declaración de variables
	dim oConn, oRs, iCodNota, sTituloNotaRelacionada, iCodPublicacion _
	, iCodSeccion, i, sSql, sQueryString, bAbiertoPublicacion, iCodPublicacionx _
	, iCodSeccionx, iCodPublicaciony, iCodSecciony, bAbiertoSeccion _
	, iCodPublicacionR, iCodSeccionR, oRs2%>
<%'Recoge el código de la nota, publicación y sección de la nota principal
	iCodNota= CInt(Request.QueryString("CodNota"))
	iCodSeccion= CInt(Request.QueryString("CodSec"))
	iCodPublicacion= CInt(Request.QueryString("CodPub"))
	'Arma el querystring que trae de la nota principal
	sQueryString= "CodPub=" & iCodPublicacion & "&CodSec=" & iCodSeccion & _
	"&CodNota=" & iCodNota%>
<%'Recoge el código de publicación y de sección para ver sus notas, también recoge el booleano de abrir o cerrar publicación
	bAbiertoPublicacion= CBool(Request.QueryString("AP"))
	bAbiertoSeccion= CBool(Request.QueryString("AS"))
	iCodPublicacionR= CInt(Request.QueryString("CodPubR"))
	iCodSeccionR= CInt(Request.QueryString("CodSecR"))%>
<%'Abre la conexión
	set oConn= Server.CreateObject("ADODB.Connection")
	oConn.Open constr%>
<%'El proceso de asignación
	if not IsEmpty(Request.Form("hdnI")) and Request.Form("hdnI")<>"" then
		dim ixCodigo, bActualizo
		bActualizo= false
		for i=1 to CInt(Request.Form("hdnI")) 
			ixCodigo= Request.Form("hdnCodigo" & CStr(i))
			if Request.Form("chkNotaRelacionada" & CStr(i)) <> "" then
				if fValorCampo("cod_relacionnota", "notasrelacionadas", constr, _
				"cod_nota=" & iCodNota & " AND cod_notarelacionada=" & ixCodigo)="" then
					sSql= "INSERT notasrelacionadas(cod_nota, cod_notarelacionada" & _
					", num_prioridad) VALUES(" & iCodNota & ", " & ixCodigo & ", 0)"
					oConn.Execute sSql
				end if
			else
				sSql= "DELETE notasrelacionadas WHERE cod_nota=" & _
				iCodNota & " AND cod_notarelacionada=" & ixCodigo
				oConn.Execute sSql
			end if
			bActualizo= true
		next
			'Cambia el estado de generación de la página
		if bActualizo then pColocaEstadoNotaNoGenerada iCodNota, oConn
		if Request.QueryString("SeVa")="1" then
			oConn.Close
			set oConn= nothing
			Response.Redirect("ListNotasRelacionadas.asp?" & sQueryString)
		end if
	end if%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Asignar notas relacionadas</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="../Include/Css/stilo.css" type="text/css" />
		<script language="javascript" src="../Include/Js/fAbreVentana.js"></script>
	</head>
	<body bgcolor="#FFFFFF" marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
		<form action="../Macro/AsignNotasRelacionadas.asp?CodPub=<%=iCodPublicacion%>&CodSec=<%=iCodSeccion%>&CodNota=<%=iCodNota%>"
		method="post" name="frmAsignNotaRelacionada" id="frmAsignNotaRelacionada">
		<table width="500" border="0" cellspacing="1" cellpadding="3" bgcolor="#c0c0c0">
			<tr bgcolor="#FFFFFF">
				<td colspan="4" align="center" class="Titulo">Asignar Notas Relacionadas / <%=fValorCampo("nom_publicacion", "publicacion", constr, "cod_publicacion=" & iCodPublicacion)%>
				/ <%=fValorCampo("nom_seccion", "seccion", constr, "cod_seccion=" & iCodSeccion)%><br>
				<span class="textobold"><%=fValorCampo("des_titulonota", "notas", constr, "cod_nota=" & iCodNota)%></span>
				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td colspan="4" class="texto">
					Buscador rápido por palabra&nbsp;&nbsp;
					<input type="text" name="txtBuscadorPalabra" value="<%=Trim(Request.Form("txtBuscadorPalabra"))%>"
					size="15">&nbsp;&nbsp;
					<input type="submit" name="sbmBuscar" value="Buscar">
				</td>
			</tr>
<%'Recoge la palabra buscador para implementar la búsqueda
	if Trim(Request.Form("txtBuscadorPalabra"))<>"" then
		dim aBuscadorPalabra, sBuscadorPalabra, j
		sBuscadorPalabra= Trim(Request.Form("txtBuscadorPalabra"))
		aBuscadorPalabra= Split(sBuscadorPalabra, " ")
		for j=0 to UBound(aBuscadorPalabra)
			sBuscadorPalabra= " AND (notas.des_titulonota like '%" & fFiltraApostrofe(aBuscadorPalabra(j)) & _
			"%' OR notas.des_cabecera like '%" & fFiltraApostrofe(aBuscadorPalabra(j)) & _
			"%' OR notas.des_texto like '%" & fFiltraApostrofe(aBuscadorPalabra(j)) & _
			"%')"
		next
	end if%>
<%'El listado general de notas, se mostrarán las publicaciones y secciones
	i= 0
	sSql= "SELECT DISTINCT a.cod_publicacion, a.nom_publicacion" & _
	", b.cod_seccion, b.nom_seccion" & _
	" FROM publicacion a, seccion b, notas" & _
	" WHERE a.cod_publicacion=b.cod_publicacion" & _
	" AND b.cod_seccion=notas.cod_seccion" & _
	sBuscadorPalabra & _
	" ORDER BY a.nom_publicacion, b.nom_seccion"
	set oRs= Server.CreateObject("ADODB.Recordset")
	oRs.Open sSql, oConn
	if not oRs.EOF then%>
			<tr bgcolor="#FFFFFF">
				<td class="textobold" width="20%">Publicación</td>
				<td class="textobold" width="20%">Sección</td>
				<td class="textobold" align="center" width="50%">Nota</td>
				<td class="textobold" align="center" width="10%">Asignar</td>
			</tr>
<%	
		do while not oRs.EOF
			iCodPublicacionx= oRs("cod_publicacion")
			iCodPublicaciony= iCodPublicacionx%>
			<tr bgcolor="#FFFFFF">
				<td valign="top" width="20%">
					<table width="100%" cellpadding="1" cellspacing="0" border="0">
						<tr>
							<td align="center" valign="top" width="2%">
								<a href="Javascript:document.frmAsignNotaRelacionada.action='AsignNotasRelacionadas.asp?<%=sQueryString%>&CodPubR=<%=iCodPublicacionx%>&AP=<%if bAbiertoPublicacion and iCodPublicacionR=iCodPublicacionx then%>0<%else%>1<%end if%>'; Javascript:document.frmAsignNotaRelacionada.submit()"
								class="enlacepequeno"><%if bAbiertoPublicacion and iCodPublicacionR=iCodPublicacionx then%>-<%else%>+<%end if%></a>
							</td>
							<td align="left" valign="middle" class="texto" width="98%">
								<%=Trim(oRs("nom_publicacion"))%>
							</td>
						</tr>
					</table>
				</td>
				<td colspan="3"></td>
			</tr>
<%		do while not oRs.EOF and iCodPublicacionx=iCodPublicaciony
				iCodSeccionx= oRs("cod_seccion")
				iCodSecciony= iCodSeccionx%>
<%			if bAbiertoPublicacion and iCodPublicacionx=iCodPublicacionR then%>
			<tr bgcolor="#FFFFFF">
				<td></td>
				<td valign="top" width="20%">
					<table width="100%" cellpadding="1" cellspacing="0" border="0">
						<tr>
							<td align="center" valign="top" width="2%">
								<a href="Javascript:document.frmAsignNotaRelacionada.action='AsignNotasRelacionadas.asp?<%=sQueryString%>&CodPubR=<%=iCodPublicacionx%>&CodSecR=<%=iCodSeccionx%>&AP=<%=bAbiertoPublicacion%>&AS=<%if bAbiertoSeccion and iCodSeccionR=iCodSeccionx then%>0<%else%>1<%end if%>'; document.frmAsignNotaRelacionada.submit()"
								class="enlacepequeno"><%if bAbiertoSeccion and iCodSeccionR=iCodSeccionx then%>-<%else%>+<%end if%></a>
							</td>
							<td align="left" valign="middle" class="texto" width="98%">
								<%=Trim(oRs("nom_seccion"))%>
							</td>
						</tr>
					</table>
				</td>
				<td colspan="2"></td>
			</tr>
<%'Saca la relación de notas de la sección a ver
					if bAbiertoSeccion and iCodSeccionx=iCodSeccionR then
						set oRs2= Server.CreateObject("ADODB.Recordset")
						oRs2.Open "SELECT notas.cod_nota, notas.des_titulonota, b.cod_nota" & _
						" FROM notas, notasrelacionadas b" & _
						" WHERE notas.cod_seccion=" & iCodSeccionR & _
						" AND notas.cod_nota*=b.cod_notarelacionada" & _
						" AND b.cod_nota=" & iCodNota & _
						sBuscadorPalabra, oConn
						do while not oRs2.EOF
							i= i + 1%>
			<tr bgcolor="#FFFFFF">
				<td colspan="2"></td>
				<td valign="top" width="50%">
					<a href="Javascript:fAbreVentana(400, 500, 0, 'VerNota.asp?CodNota=<%=oRs2(0)%>')"
					class="enlacepequeno"><%=Trim(oRs2(1))%></a>
				</td>
				<td align="center">
					<input type="checkbox" name="chkNotaRelacionada<%=i%>" value="1" <%if not IsNull(oRs2(2)) then%>checked<%end if%>
					<%if oRs2(0)=iCodNota then%>disabled<%end if%>>
					<input type="hidden" name="hdnCodigo<%=i%>" value="<%=oRs2(0)%>">
				</td>
			</tr>
<%						oRs2.MoveNext
						loop
						oRs2.Close
						set oRs2= nothing
					end if%>
<%			end if%>
<%			oRs.MoveNext
				if not oRs.EOF then
					iCodPublicacionx= oRs("cod_publicacion")
					iCodSeccionx= oRs("cod_seccion")
				end if%>
<%		loop%>
<%	loop%>
			<tr bgcolor="#FFFFFF">
				<td colspan="4" valign="top">
					<a href="Javascript:document.frmAsignNotaRelacionada.action='AsignNotasRelacionadas.asp?<%=sQueryString%>&SeVa=1'; document.frmAsignNotaRelacionada.submit()">&lt;&lt;VOLVER</a>
					<input type="hidden" name="hdnI" value="<%=i%>">
				</td>
			</tr>
<%'
	else%>
			<tr bgcolor="#FFFFFF">
				<td class="texto" align="center" colspan="4">
					Por el momento no hay notas registradas
				</td>
			</tr>
<%end if
	oRs.Close
	set oRs= nothing%>
		</table>
		</form>
	</body>
</html>
<%oConn.Close
	set oConn= nothing%>