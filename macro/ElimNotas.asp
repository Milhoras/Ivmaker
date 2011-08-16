<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../Include/Asp/Conn.asp" -->
<%'Autorizaci�n para esta p�gina
	if IsEmpty(Session("EstaAutorizadoPagina")) then
		pMensaje "No est� autorizado para eliminar notas", "../Macro/ListNotas.asp?CodPub=" & _
		Request.QueryString("CodPub") & "&CodSec=" & Request.QueryString("CodSec") & _
		"&EstArch=" & Request.QueryString("EstArch"), "_self"
	end if%>
<%'Verifica que el c�digo secci�n exista y sea un n�mero
	if not IsNumeric(Request.QueryString("CodSec")) or Trim(Request.QueryString("CodSec"))="" then
		pMensaje "Ingrese una secci�n v�lida", "../Macro/ListSeccionesRedactores.asp?" & Request.QueryString("CodPub"), "_self"
	end if%>
<!-- #include file="../Include/Asp/incVerificaAutorizacionPubSec.asp" -->
<%'Declaraci�n de variables
	dim oConn%>
<%'Eliminar una nota
	if IsNumeric(Request.QueryString("CodNota")) and Trim(Request.QueryString("CodNota"))<>"" then
		set oConn= Server.CreateObject("ADODB.Connection")
		oConn.Open constr
		oConn.Execute("DELETE notas WHERE cod_nota=" & Request.QueryString("CodNota"))
		oConn.Close
		set oConn= nothing		
	end if%>
<%'Volver
	Response.Redirect "ListNotas.asp?CodPub=" & Request.QueryString("CodPub") & _
	"&CodSec=" & Request.QueryString("CodSec") & "&EstArch=" & _
	Request.QueryString("EstArch")%>