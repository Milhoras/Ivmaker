<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../Include/Asp/Conn.asp" -->
<%'Verifica que c�digo de publicaci�n exista o sea n�mero
	if not IsNumeric(Request.QueryString("CodPub")) or Trim(Request.QueryString("CodPub"))="" then
		pMensaje "Ingrese una publicaci�n v�lida", "../Macro/ListPublicaciones.asp", "_self"
	end if%>
<%'autorizaci�n para esta p�gina
	if IsEmpty(Session("EstaAutorizadoPagina")) then
		pMensaje "No est� autorizado para eliminar esta secci�n", "ListSecciones.asp?CodPub=" & Request.QueryString("CodPub"), "_self"
	end if%>
<%'Variables
	dim oConn%>
<%'Recoge el c�digo de publicaci�n
	if not IsEmpty(Request.QueryString("CodSec")) then
		set oConn= Server.CreateObject("ADODB.Connection")
		oConn.Open constr
		oConn.Execute "DELETE seccion WHERE cod_seccion=" & _
		Request.QueryString("CodSec")
		oConn.Close
		set oConn= nothing
	end if%>
<%Response.Redirect "ListSecciones.asp?CodPub=" & Request.QueryString("CodPub")%>