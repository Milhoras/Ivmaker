<%'Verificar que no visiten esta p�gina sin autorizaci�n
	'Para que esta p�gina funcione debe haberse inclu�do la p�gina que tiene
	'la funci�n fTienePermisoPagina()
	dim sUrlActualVAP
	sUrlActualVAP= Mid(Request.ServerVariables("URL"), _
	InStrRev(Request.ServerVariables("URL"), "/")+1, _
	len(Request.ServerVariables("URL")) - _
	InStrRev(Request.ServerVariables("URL"), "/"))
	if fTienePermisoPagina(sUrlActualVAP, Session("coduser"), constr) then
		Session("EstaAutorizadoPagina")= "true"
	else
		pMensaje "Usted no est� autorizado a ingresar a esta p�gina", "../default.asp", "_top"
	end if%>
