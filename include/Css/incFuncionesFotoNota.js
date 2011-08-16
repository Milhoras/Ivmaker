/*en este archivo se adjuntarán todos los scripts que necesiten las fotos para
las páginas de notas*/
/*Indices:	1. foto original;	2. foto reducida;	3. autor de la foto
	4. Detalle;	5. ancho de la foto original;	6. alto de la foto original*/

function fFoto() {
	if (iIndiceFoto==iIndiceMaximo) {
		iIndiceFoto= 0;
	}
	iIndiceFoto++;
	document.imgFoto.src= aFoto[iIndiceFoto][2];
	document.all["divLeyenda"].innerText= aFoto[iIndiceFoto][4] + " (" + aFoto[iIndiceFoto][3] + ")";
}
//Función que abre la ventana para mostrar la foto en su tamaño original
function fAbreVentanaFoto() {
	var xwidth= aFoto[iIndiceFoto][5] + 5;
	var xheight= aFoto[iIndiceFoto][6] + 5;
	var argumentos= "toolbar=0, scrollbars=0, resizable=0, status=0, height=" + xheight + ", width=" + xwidth;
	var remote=window.open("","NewWindowPhoto",argumentos);
	if (remote != null) {
		if (remote.opener == null)
		{ remote.opener = self;}
		remote.document.writeln('<html>');
		remote.document.writeln('	<head>');
		remote.document.writeln('		<title>' + aFoto[iIndiceFoto][1] + '</title>');
		remote.document.writeln('	</head>');
		remote.document.writeln('	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">');
		remote.document.writeln('		<table width="100%" cellpadding="2" cellspacing="0" border="0" bgcolor="' + sColorFondoFotoOriginal + '">');
		remote.document.writeln('			<tr>');
		remote.document.writeln('				<td align="center">');
		remote.document.writeln('					<img src="' + aFoto[iIndiceFoto][1] + '" border="0">');
		remote.document.writeln('				</td>');
		remote.document.writeln('			</tr>');
		remote.document.writeln('		</table>');
		remote.document.writeln('	</body>');
		remote.document.writeln('</html>');
	}
 }