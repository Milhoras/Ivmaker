<%'funci�n que se encarga de crear un archivo html en del resultdo de una p�gina asp
	sub pCreaPaginaHtmlDesdePaginaAsp(sPaginaEntrada, sRutaVirtualArchivoSalida)
		
		dim oAspHttp, sResultado, oOFS, oArchivoSalida
		
		'Saca el c�digo html del resultado de la llamada a la p�gina asp
		set oAspHttp= Server.CreateObject("AspHttp.Conn")
		oAspHttp.Url= sPaginaEntrada
		oAspHttp.RequestMethod= "GET"
		oAspHttp.UserAgent= "Mozilla/2.0 (compatible; MSIE 3.0B; Windows NT)"
		sResultado= oAspHttp.GetURL
		set oAspHttp= nothing

		'Guarda el resultado en una p�gina html
		set oOFS= Server.CreateObject("Scripting.FileSystemObject")
		Set oArchivoSalida = oOFS.CreateTextFile(Server.MapPath(sRutaVirtualArchivoSalida), true, false)
		oArchivoSalida.Write sResultado
		set oArchivoSalida= nothing
		set oOFS= nothing
	
	end sub%>