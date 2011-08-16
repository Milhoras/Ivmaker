<%'Procedimiento que redirecciona a la página de mensaje. 
	'Necesita los parámetros de mensaje y del url a donde se dirigirá luego de mostrar el mensaje
	sub pMensaje(sMensajeM, sUrlIrM, sTargetM)
		Response.Redirect "../Macro/Mensaje.asp?Mensaje=" & Server.URLEncode(sMensajeM) & _
		"&UrlIr=" & Server.URLEncode(sUrlIrM) & "&Target=" & sTargetM
	end sub%>