function fAbreVentana(xwidth,xheight,xstatus,xurl) {
	var argumentos= "toolbar=no,scrollbars=yes,resizable=no,height=" + xheight + ",width=" + xwidth + ",status=" + xstatus;
	var remote=window.open(xurl,'NewWindow',argumentos);
	if (remote != null) {
		if (remote.opener == null)
		{ remote.opener = self;}
	}
 }
function AbreNoBlanco(xw,xh,xs,xUrl,xElemento) {
	if (xElemento != " " && xElemento !="")
		{ AbreVentana(xw,xh,xs,xUrl + xElemento)}
}