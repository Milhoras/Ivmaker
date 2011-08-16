<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<html>
	<head>
		<title>Sistema Ivmaker / elcomercioperu.com / Página de mensajes</title>
		<meta name="GENERATOR" Content="Microsoft Visual Studio 6.0"/>
	</head>
	<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0">
		<table width="450" cellpadding="2" cellspacing="1" bgcolor="#c0c0c0" height="200">
			<tr bgcolor="#FFFFFF">
				<td valign="middle" align="center" class="mensaje" height="170">
					<%=Request.QueryString("Mensaje")%>
				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td valign="middle" align="center" height="30">
					<form action="<%=Request.QueryString("UrlIr")%>" method="post"
						name="frmContinuar" id="frmContinuar" target="<%=Request.QueryString("Target")%>">
						<input type="submit" value="Continuar" name="UrlIr">
					</form>
				</td>
			</tr>
		</table>
		<script language="javascript">
			/*for (var i = 0; i < 2000000; i++) {
			}
			document.frmContinuar.submit();*/
		</script>
	</body>
</html>
