<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../Include/Asp/Conn.asp" -->
<%'Autorizaci�n para esta p�gina
	if IsEmpty(Session("EstaAutorizadoPagina")) then
		pMensaje "No est� autorizado para eliminar esta publicaci�n", "ListPublicaciones.asp", "_self"
	end if%>
<%'Variables
	dim oConn%>
<%'Recoge el c�digo de publicaci�n
	if not IsEmpty(Request.QueryString("CodPub")) then
		set oConn= Server.CreateObject("ADODB.Connection")
		oConn.Open constr
		oConn.Execute "DELETE publicacion WHERE cod_publicacion=" & _
		Request.QueryString("CodPub")
		oConn.Close
		set oConn= nothing
	end if%>
<%Response.Redirect "ListPublicaciones.asp"%>