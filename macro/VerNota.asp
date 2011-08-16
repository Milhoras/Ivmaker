<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../Include/Asp/Conn.asp" -->
<%'Declaración de variables
	dim oConn, oRs, iCodNota, sTitulo, sCuerpo, sCabecera, sNombrePublicacion _
	, sNombreSeccion, sAutor, sTextoAuxiliar%>
<%'Recoge el código de la nota, publicación y sección
	iCodNota= CInt(Request.QueryString("CodNota"))%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Ver nota</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<link rel="stylesheet" href="../Include/Css/stilo.css" type="text/css" />
		<script language="javascript" src="../Include/Js/fAbreVentana.js"></script>
	</head>
	<body bgcolor="#FFFFFF" marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
		<div align="center">
			<table width="370" border="0" cellspacing="1" cellpadding="3" bgcolor="#c0c0c0">
<%'traer los datos de la nota
	set oRs= Server.CreateObject("ADODB.Recordset")
	oRs.Open "SELECT c.nom_publicacion, b.nom_seccion, a.des_titulonota" & _
	", a.des_cabecera, a.des_texto, a.des_autor, a.des_textoauxiliar" & _
	" FROM notas a, seccion b, publicacion c" & _
	" WHERE a.cod_nota=" & iCodNota & " AND a.cod_seccion=b.cod_seccion" & _
	" AND b.cod_publicacion=c.cod_publicacion" , constr
	if not oRs.EOF then
		sNombrePublicacion= Trim(oRs("nom_publicacion"))
		sNombreSeccion= Trim(oRs("nom_seccion"))
		sTitulo= Trim(oRs("des_titulonota"))
		sCabecera= Trim(oRs("des_cabecera"))
		sCuerpo= Trim(oRs("des_texto"))
		sAutor= Trim(oRs("des_autor"))
		sTextoAuxiliar= Trim(oRs("des_textoauxiliar"))
	end if
	oRs.Close
	set oRs= nothing%>
				<tr bgcolor="#FFFFFF">
					<td colspan="2" align="center" class="Titulo">
						Ver nota
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" width="35%">
						<span class="textobold">Publicación / Sección</span>
					</td>
					<td class="texto" width="65%">
						<span class="texto"><%=sNombrePublicacion%> / <%=sNombreSeccion%></span>
					</td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td class="texto" colspan="2">
						<span class="textobold">Título</span><br>
						<span class="texto"><%=sTitulo%></span>
					</td>
				</tr>
<%if sCabecera<>"" then%>
				<tr bgcolor="#FFFFFF">
					<td class="texto" colspan="2">
						<span class="textobold">Cabecera</span><br>
						<span class="texto"><%=sCabecera%></span>
					</td>
				</tr>
<%end if%>
<%if sCuerpo<>"" then%>
				<tr bgcolor="#FFFFFF">
					<td class="texto" colspan="2">
						<span class="textobold">Cuerpo</span><br>
						<span class="texto"><%=sCuerpo%></span>
					</td>
				</tr>
<%end if%>
<%if sAutor<>"" then%>
				<tr bgcolor="#FFFFFF">
					<td class="texto" colspan="2">
						<span class="textobold">Autor</span><br>
						<span class="texto"><%=sAutor%></span>
					</td>
				</tr>
<%end if%>
<%if sTextoAuxiliar<>"" then%>
				<tr bgcolor="#FFFFFF">
					<td class="texto" colspan="2">
						<span class="textobold">Texto auxiliar</span><br>
						<span class="texto"><%=sTextoAuxiliar%></span>
					</td>
				</tr>
<%end if%>
				<tr bgcolor="#FFFFFF">
					<td class="texto" colspan="2">
						<a href="Javascript:window.close()">Cerrar ventana</a>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
