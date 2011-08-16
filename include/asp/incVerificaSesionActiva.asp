<%'Verifica la caducidad de la sesión
	if IsEmpty(Session("coduser")) then 
		pMensaje "La sesión ha caducado", "../default.asp", "_top"
	end if%>