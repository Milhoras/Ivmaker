<%'Procedimiento que redirecciona a la p�gina de mensaje. 
	'Necesita los par�metros de mensaje y del url a donde se dirigir� luego de mostrar el mensaje
	sub pMensaje(sMensajeM, sUrlIrM, sTargetM)
		Response.Redirect "../Macro/Mensaje.asp?Mensaje=" & Server.URLEncode(sMensajeM) & _
		"&UrlIr=" & Server.URLEncode(sUrlIrM) & "&Target=" & sTargetM
	end sub%>