<%option explicit%>
<%Response.Buffer= true
	Response.CacheControl= "private"
	Response.Expires= 0%>
<!-- #include file="../Include/Asp/pMensaje.asp" -->
<!-- #include file="../Include/Asp/incVerificaSesionActiva.asp" -->
<!-- #include file="../Include/Asp/Conn.asp" -->
<%'Autorización para la página
	if IsEmpty(Session("EstaAutorizadoPagina")) then
		pMensaje "No está autorizado eliminar notas relacionadas externas", "../Macro/ListNotas.asp?CodPub=" & _
		Request.QueryString("CodPub") & "&CodSec=" & Request.QueryString("CodSec") & _
		"&CodNota=" & Request.QueryString("CodNota"), "_self"
	end if%>
<%'Verifica que código sección exista o sea un número
	if not IsNumeric(Request.QueryString("CodSec")) or Trim(Request.QueryString("CodSec"))="" then
		pMensaje "Ingrese una sección válida", "../Macro/ListSeccionesRedactores.asp?" & Request.QueryString("CodPub"), "_self"
	end if%>
<%'Verifica que código nota exista o sea un número
	if not IsNumeric(Request.QueryString("CodNota")) or Trim(Request.QueryString("CodNota"))="" then
		pMensaje "Ingrese una nota válida", "../Macro/ListNotas.asp?CodPub=" & _
		Request.QueryString("CodPub") & "&CodSec=" & Request.QueryString("CodSec"), "_self"
	end if%>
<!-- #include file="../Include/Asp/incVerificaAutorizacionPubSec.asp" -->
<%'Declaración de variables
	dim oConn, sSql, iCodRelacional%>
<%'El proceso
	if not IsEmpty(Request.QueryString("CodRelacional")) then
		'Abre la conexión
		set oConn= Server.CreateObject("ADODB.Connection")
		oConn.Open constr
		sSql= "DELETE notasrelacionadas WHERE cod_relacionnota=" & _
		Request.QueryString("CodRelacional")
		oConn.Execute(sSql)
		oConn.Close
		set oConn= nothing
		Response.Redirect("ListNotasRelacionadas.asp?CodPub=" & _
		Request.QueryString("CodPub") & "&CodSec=" & _
		Request.QueryString("CodSec") & "&CodNota=" & _
		Request.QueryString("CodNota"))
	end if%>
