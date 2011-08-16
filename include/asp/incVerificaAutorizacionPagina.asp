<%'Verificar que no visiten esta página sin autorización
	'Para que esta página funcione debe haberse incluído la página que tiene
	'la función fTienePermisoPagina()
	dim sUrlActualVAP
	sUrlActualVAP= Mid(Request.ServerVariables("URL"), _
	InStrRev(Request.ServerVariables("URL"), "/")+1, _
	len(Request.ServerVariables("URL")) - _
	InStrRev(Request.ServerVariables("URL"), "/"))
	if fTienePermisoPagina(sUrlActualVAP, Session("coduser"), constr) then
		Session("EstaAutorizadoPagina")= "true"
	else
		pMensaje "Usted no está autorizado a ingresar a esta página", "../default.asp", "_top"
	end if%>
