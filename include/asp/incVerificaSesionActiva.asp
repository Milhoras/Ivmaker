<%'Verifica la caducidad de la sesi�n
	if IsEmpty(Session("coduser")) then 
		pMensaje "La sesi�n ha caducado", "../default.asp", "_top"
	end if%>