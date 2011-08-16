<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../include/asp/conn.asp" -->
<%'Autorización para esta página
	if IsEmpty(Session("EstaAutorizadoPagina")) then
		pMensaje "No está autorizado para ingresar notas", "../Macro/ListNotas.asp?CodPub=" & _
		Request.QueryString("CodPub") & "&CodSec=" & Request.QueryString("CodSec"), "_self"
	end if%>
<%'Verifica si código de sección exista y sea un número
	if not IsNumeric(Request.QueryString("CodSec")) or Trim(Request.QueryString("CodSec"))="" then
		pMensaje "Ingrese una sección válida", "../Macro/ListSeccionesRedactores.asp?CodPub=" & Request.QueryString("CodPub"), "_self"
	end if%>
<!-- #include file="../Include/Asp/incVerificaAutorizacionPubSec.asp" -->
<!-- #include file="../Include/Asp/fValorCampo.asp" -->
<!-- #include file="../Include/Asp/fFiltraSignosMayorMenor.asp" -->
<!-- #include file="../Include/Asp/fUrlNota.asp" -->
<!-- #include file="../Include/Asp/incConstantesNombresSubDirectorios.asp" -->
<%'Declaración de variables
	dim oRs, sSql, iCodPublicacion, iCodSeccion, i, oConn, iCodNota _
		, sTituloNota, sEstado, iNumeroPrioridad, sEstadoGenerado _
		, sEstadoPortada, sEstadoArchivo, sRelacionArchivo
	dim iTotalRegistros, iNumeroPagina, sScrollAction, iTotalPaginas _
		, iContadorFilas, iNumPagLinks, iPrimeraPagina, iUltimaPagina, iLinkPage%>
<%'Abrir la conexión
	set oConn= Server.CreateObject("ADODB.connection")
	oConn.Open constr%>
<%'Recoge el código de la publicación
	iCodPublicacion= CInt(Request.QueryString("CodPub"))%>
<%'Recoge el código de la sección
	iCodSeccion= CInt(Request.QueryString("CodSec"))%>
<%'Parámetro para visualizar las notas archivadas y no archivadas
	sEstadoArchivo= Request.QueryString("EstArch")
	if Trim(sEstadoArchivo)="" then
		sEstadoArchivo= "1"
	elseif sEstadoArchivo="0" then
		sRelacionArchivo= "Archivadas"
	end if%>
<%'Trae dominio del servidor, si la publicación reside en otro diferente al servidor de ivmaker
	dim sDominio
	sDominio= fValorCampo("a.des_dominio", "servidores a, publicacion b", _
	oConn, "b.cod_publicacion=" & iCodPublicacion & _
	" AND b.cod_servidor=a.cod_servidor AND b.des_rutaftp<>''" & _
	" AND b.des_rutaftp is not null")
	if Trim(sDominio)<>"" then sDominio= "http://" & sDominio%>
<%'El proceso de activación y actualización
	if not IsEmpty(Request.Form("hdnI")) then
		dim ixCodigo, ixNumeroPrioridad
		for i=1 to CInt(Request.Form("hdnI")) 
			ixCodigo= Request.Form("hdnCodigo" & CStr(i))
			if Request.Form("chkActivo" & CStr(i)) <> "" then
				sSql= "UPDATE notas SET est_activo='1' WHERE cod_nota=" & ixCodigo
			else
				sSql= "UPDATE notas SET est_activo='0' WHERE cod_nota=" & ixCodigo
			end if
			oConn.Execute sSql
			ixNumeroPrioridad= Request.Form("txtNumeroPrioridad" & CStr(i))
			if IsNumeric(ixNumeroPrioridad) or ixNumeroPrioridad="" then
				if ixNumeroPrioridad="" then ixNumeroPrioridad= 0
				oConn.Execute "UPDATE notas SET num_prioridad=" & _
				ixNumeroPrioridad & " WHERE cod_nota=" & ixCodigo
			end if
		next
	end if%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Listado de notas</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="../Include/Css/stilo.css" type="text/css" />
		<script language="JavaScript" src="../Include/Js/fConfirmAction.js"></script>
	</head>
	<body bgcolor="#FFFFFF" marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
		<form action="../Macro/ListNotas.asp?CodPub=<%=iCodPublicacion%>&amp;CodSec=<%=iCodSeccion%>&amp;EstArch=<%=sEstadoArchivo%>" method="post" name="frmListNota" id="frmListNota">
		<table width="600" border="0" cellspacing="1" cellpadding="3" bgcolor="#c0c0c0">
			<tr bgcolor="#FFFFFF">
				<td colspan="10" align="center" class="Titulo">Listado de Notas <%=sRelacionArchivo%> / <%=fValorCampo("nom_publicacion", "publicacion", constr, "cod_publicacion=" & iCodPublicacion)%>
				/ <%=fValorCampo("nom_seccion", "seccion", constr, "cod_seccion=" & iCodSeccion)%></td>
			</tr>
<%'Listado
	i= 0
	set oRs= Server.CreateObject("adodb.recordset")
	sSql= "SELECT cod_nota, des_titulonota, num_prioridad, est_generado" & _
	", est_portada, fec_registro, cod_plantilla, est_activo" & _
	" FROM notas WHERE cod_seccion=" & iCodSeccion & _
	" AND est_archivo='" & sEstadoArchivo & "'" & _
	" ORDER BY num_prioridad ASC"
	oRs.Open sSql, oConn, 1, 1
	if not oRs.EOF then%>
			<tr bgcolor="#FFFFFF">
				<td class="textobold" align="center" width="6%"># Prior.</td>
				<td class="textobold" width="46%">Titulo</td>
				<td class="textobold" align="center" width="6%">Gen.</td>
				<td class="textobold" align="center" width="6%">Notas<br>rel.</td>
				<td class="textobold" align="center" width="6%">Pág.</td>
				<td class="textobold" align="center" width="6%">Plant.</td>
				<td class="textobold" align="center" width="6%">Mód.</td>
				<td class="textobold" align="center" width="6%">Elim.</td>
				<td class="textobold" align="center" width="6%">Elim.<br>(en const.)</td>
				<td class="textobold" align="center" width="6%">Activo</td>
			</tr>
<%
		iTotalRegistros= oRs.RecordCount
		oRs.PageSize= 30 ' Número de registros por página 
		sScrollAction= Request.form("ScrollAction")
		if sScrollAction<>"" Then
			iNumeroPagina= cint(sScrollAction)
			if iNumeroPagina<1 Then iNumeroPagina= 1
		else
			iNumeroPagina= 1
		end if
		oRs.AbsolutePage= iNumeroPagina
		iTotalPaginas= oRs.PageCount
		iContadorFilas= oRs.PageSize
		do while not oRs.EOF and iContadorFilas>0
			iCodNota= Trim(oRs("cod_nota"))
			sTituloNota= Trim(oRs("des_titulonota"))
			iNumeroPrioridad= oRs("num_prioridad")
			sEstadoGenerado= Trim(oRs("est_generado"))
			sEstadoPortada= Trim(oRs("est_portada"))
			i= i + 1%>
			<tr bgcolor="#FFFFFF">
				<td valign="top" width="6%" align="center">
					<input type="text" name="txtNumeroPrioridad<%=i%>" value="<%=iNumeroPrioridad%>" maxlength="3" size="3" />
				</td>
				<td valign="middle" width="46%" class="texto">
					<a href="EditNotas.asp?CodPub=<%=iCodPublicacion%>&amp;CodSec=<%=iCodSeccion%>&amp;CodNota=<%=iCodNota%>&amp;EstArch=<%=sEstadoArchivo%>" class="texto"><%=fFiltraSignosMayorMenor(sTituloNota)%>
					(<%=Right("0" & Day(oRs("fec_registro")), 2)%>/<%=Right(Month(oRs("fec_registro")), 2)%>/<%=Year(oRs("fec_registro"))%>)</a>
				</td>
				<td align="center" width="8%">
					<a href="GenNota.asp?CodPub=<%=iCodPublicacion%>&amp;CodSec=<%=iCodSeccion%>&amp;CodNota=<%=iCodNota%>"><img src="../Image/html.gif" border="0" WIDTH="24" HEIGHT="25" alt="Generar página html para nota"></a>
				</td>
				<td class="textobold" align="center" width="6%">
					<a href="ListNotasRelacionadas.asp?CodPub=<%=iCodPublicacion%>&amp;CodSec=<%=iCodSeccion%>&amp;CodNota=<%=iCodNota%>"><img src="../Image/subnotas.gif" border="0" alt="Relacionar notas" WIDTH="24" HEIGHT="25"></a>
				</td>
				<td align="center" width="6%">
<%		if sEstadoGenerado="1" then%>
				<a href="<%=sDominio%><%=fUrlNota(iCodNota, oConn)%>" target="_blank"><img src="../Image/htmla.gif" border="0" alt="Ver página html generada"></a>
<%		end if%>	
				</td>
				<td class="textobold" align="center" width="6%">
<%		if not IsNull(oRs("cod_plantilla")) then%>
					<font face="webdings" size="2" color="black">a</font>
<%		end if%>
				</td>
				<td class="textobold" align="center" width="6%">
					<a href="javascript:fMuestraDivModulos('<%=iCodNota%>', 'block')">...</a>
				</td>
				<td valign="middle" align="center" width="6%">
					<a href="JavaScript:fConfirmAction('ElimNotas.asp?CodPub=<%=icodPublicacion%>&amp;CodSec=<%=iCodSeccion%>&amp;EstArch=<%=sEstadoArchivo%>&amp;CodNota=<%=iCodNota%>', '¿Está seguro de eliminar esta nota?')"><img src="../Image/papelera.gif" border="0" WIDTH="15" HEIGHT="16" alt="Eliminar nota"></a>
				</td>
				<td valign="middle" align="center" width="6%">
					<input type="checkbox" name="chkEliminar<%=i%>" value="1">
				</td>
				<td valign="middle" align="center" width="6%">
					<input type="checkbox" name="chkActivo<%=i%>" value="1" <%if oRs("est_activo")="1" then%>checked<%end if%>>
					<input type="hidden" name="hdnCodigo<%=i%>" value="<%=iCodNota%>">
				</td>
			</tr>
<%
			oRs.MoveNext
		loop%>
			<tr bgcolor="#FFFFFF">
				<td colspan="10" valign="middle">
					<table border="0" valign="top" cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td align="left" valign="top">
								<input type="hidden" name="ScrollAction" value="<%=sScrollAction%>" />
								<input type="hidden" name="PagIni" value="<%=(iPrimeraPagina)%>" />
<%	iNumPagLinks= 15  'Numero de Link Por página
		iNumPagLinks= iNumPagLinks - 1
		iPrimeraPagina = 1
		if Request.Form("PagIni") <> "" then iPrimeraPagina = Request.Form("PagIni")
		iUltimaPagina = iPrimeraPagina + iNumPagLinks
		'  muestra  el grupo inferior de links
		if iNumeroPagina > iNumPagLinks and iPrimeraPagina <> 1 then%>
								<a href="javascript:document.frmListNota.ScrollAction.value='<%=(iPrimeraPagina - 1)%>';document.frmListNota.PagIni.value='<%=(iPrimeraPagina-iNumPagLinks)-1%>'; document.frmListNota.submit()" class="paginacion">[<<<]</a>&nbsp;
<%	end if%>
<%	if  iTotalPaginas > 1 then
			for iLinkPage = iPrimeraPagina to iUltimaPagina
				if iLinkPage <= iTotalPaginas then
					if iLinkPage = iNumeroPagina then%>
								<span class="paginacion"><b><%=iLinkPage%></b></span>&nbsp;
<%				else%>
								<a href="javascript:document.frmListNota.ScrollAction.value='<%=iLinkPage%>'; document.frmListNota.PagIni.value='<%=(iPrimeraPagina)%>'; document.frmListNota.submit()" class="paginacion"><%=iLinkPage%></a>&nbsp;
<%				end if
				end if
			next
		end if%>
		<%'Muestra el grupo superior de links
		if iTotalPaginas>iNumPagLinks and iUltimaPagina<iTotalPaginas then%>
								<a href="javascript:document.frmListNota.ScrollAction.value='<%=iLinkPage%>';document.frmListNota.PagIni.value='<%=(iUltimaPagina+1)%>'; document.frmListNota.submit()" class="paginacion">[&gt;&gt;&gt;]</a>
<%	end if%>
							</td>
							<td align="right" valign="top">
								<span class="paginacion">Total páginas <%=iTotalPaginas%></span>
							</td>
						</tr>
					</table>
				</td>
			</tr>
<%else%>
			<tr bgcolor="#FFFFFF">
				<td valign="middle" align="center" class="texto" colspan="10">
					Por el momento no existen notas para esta sección
				</td>
			</tr>
<%end if
	oRs.Close
	set oRs= nothing%>
			<tr bgcolor="#FFFFFF">
				<td valign="top" colspan="10">
					<table width="100%" cellpadding="1" cellspacing="1" border="0">
						<tr>
							<td valign="top">
								<div><a href="../Macro/IngrNotas.asp?CodPub=<%=iCodPublicacion%>&amp;CodSec=<%=iCodSeccion%>&amp;EstArch=<%=sEstadoArchivo%>" class="texto">Nueva nota</a></div>
							</td>
<%if i>0 then%>
							<td valign="top" align="center">
								<div><a href="GenSeccion.asp?CodPub=<%=iCodPublicacion%>&amp;CodSec=<%=iCodSeccion%>&amp;EstArch=<%=sEstadoArchivo%>&amp;UrlRetorno=<%=Server.URLEncode("ListNotas.asp")%>" class="texto">Generar sección completa</a></div>
							</td>
							<td valign="top" align="center">
								<div><a href="GenIndiceSeccion.asp?CodPub=<%=iCodPublicacion%>&amp;CodSec=<%=iCodSeccion%>&amp;EstArch=<%=sEstadoArchivo%>&amp;UrlRetorno=<%=Server.URLEncode("ListNotas.asp")%>" class="texto">Generar índice de sección</a></div>
							</td>
							<td valign="top" align="right">
								<div><input type="hidden" name="hdnI" value="<%=i%>" />
								<a href="Javascript:document.frmListNota.submit()" class="texto">Actualizar</a></div>
							</td>
<%end if%>
						</tr>
					</table>
				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td valign="middle" colspan="10" class="texto">
					<a href="../Macro/ListSeccionesRedactores.asp?CodPub=<%=iCodPublicacion%>" class="texto">&lt;&lt;Volver</a>
				</td>
			</tr>
		</table>
		</form>
	</body>
</html>
<%oConn.Close
	set oConn= nothing%>
<div name="divModulos" id="divModulos" style="position:absolute; display:none; top:70; left:300"></div>
<script language="javascript">
	function fMuestraDivModulos(iCodigoNota, sDisplay) {
		if (sDisplay=="none") {
			document.all["divModulos"].style.display= "none";
		} else {
			var sdivHtml= '<table width="200" cellpadding="1" cellspacing="1" border="0" bgcolor="#c0c0c0" height="250">';
			sdivHtml+='	<tr bgcolor="#FFFFFF">';
			sdivHtml+='		<td valign="middle" width="100%" height="20">';
			sdivHtml+='			<table width="100%" cellpadding="0" cellspacing="0" border="0">';
			sdivHtml+='				<tr>';
			sdivHtml+='					<td valign="middle" class="textobold" align="center" width="90%">';
			sdivHtml+='						MÓDULOS';
			sdivHtml+='					</td>';
			sdivHtml+='					<td valign="middle" align="center" width="10%">';
			sdivHtml+='						<a href="javascript:fMuestraDivModulos(\'0\', \'none\')"><img src="../Image/x1.gif" border="0"></a>';
			sdivHtml+='					</td>';
			sdivHtml+='				</tr>';
			sdivHtml+='			</table>';
			sdivHtml+='		</td>';
			sdivHtml+='	</tr>';
			sdivHtml+='	<tr bgcolor="#FFFFFF" height="230">';
			sdivHtml+='		<td valign="top" width="100%">';
			sdivHtml+='			<iframe src="ListModulosPublicacion.asp?CodPub=<%=iCodPublicacion%>&CodSec=<%=iCodSeccion%>&CodNota=' + iCodigoNota + '" frameborder="0" width="100%" height="100%"></iframe>';
			sdivHtml+='		</td>';
			sdivHtml+='	</tr>';
			sdivHtml+='</table>';
			document.all["divModulos"].innerHTML= sdivHtml;
			document.all["divModulos"].style.display= "block";
		}
	}
</script>