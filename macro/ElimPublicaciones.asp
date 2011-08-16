<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../Include/Asp/Conn.asp" -->
<%'Autorización para esta página
	if IsEmpty(Session("EstaAutorizadoPagina")) then
		pMensaje "No está autorizado para eliminar esta publicación", "ListPublicaciones.asp", "_self"
	end if%>
<%'Variables
	dim oConn%>
<%'Recoge el código de publicación
	if not IsEmpty(Request.QueryString("CodPub")) then
		set oConn= Server.CreateObject("ADODB.Connection")
		oConn.Open constr
		oConn.Execute "DELETE publicacion WHERE cod_publicacion=" & _
		Request.QueryString("CodPub")
		oConn.Close
		set oConn= nothing
	end if%>
<%Response.Redirect "ListPublicaciones.asp"%>