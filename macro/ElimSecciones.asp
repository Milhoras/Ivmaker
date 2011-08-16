<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../Include/Asp/Conn.asp" -->
<%'Verifica que código de publicación exista o sea número
	if not IsNumeric(Request.QueryString("CodPub")) or Trim(Request.QueryString("CodPub"))="" then
		pMensaje "Ingrese una publicación válida", "../Macro/ListPublicaciones.asp", "_self"
	end if%>
<%'autorización para esta página
	if IsEmpty(Session("EstaAutorizadoPagina")) then
		pMensaje "No está autorizado para eliminar esta sección", "ListSecciones.asp?CodPub=" & Request.QueryString("CodPub"), "_self"
	end if%>
<%'Variables
	dim oConn%>
<%'Recoge el código de publicación
	if not IsEmpty(Request.QueryString("CodSec")) then
		set oConn= Server.CreateObject("ADODB.Connection")
		oConn.Open constr
		oConn.Execute "DELETE seccion WHERE cod_seccion=" & _
		Request.QueryString("CodSec")
		oConn.Close
		set oConn= nothing
	end if%>
<%Response.Redirect "ListSecciones.asp?CodPub=" & Request.QueryString("CodPub")%>