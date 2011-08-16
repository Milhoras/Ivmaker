<%Response.Buffer=false%>

<!--#include file="../include/ASP/Conn.asp" -->
<!--#include file="../include/ASP/fFiltraApostrofe.asp" -->
<%
icoddeinteres=request("icodDeinteres")
select case request("M")
case "N"
	StrMode="G"
	StrTitulo="Ingreso"
	StrBoton ="Ingresar Notas De Interes"
case "M"
	StrMode  ="U"						'update
	StrTitulo="Modificar"
	StrBoton ="Modificar Notas De Interes"

	set conn = server.CreateObject("adodb.Connection")
	conn.open Constr
	strsql="SELECT cod_notaDei, des_titulo, des_enlace,est_Activo " & _
		   "FROM NotasDEInteres where cod_notaDei=" & request("icodNotaDei") & " and cod_deinteres="&icoddeinteres
	set rs=conn.execute(strsql)
	if not rs.eof then
		icodNotaDei		=rs(0)
		sdesTitulo		=trim(rs(1))
		sDesEnlace		=trim(rs(2))
		fActivo			=rs(3)
		if factivo="" then factivo=0
		
	else
	strMensaje="el registro al que intenta ingresar, no existe o fue borrado desde fuera del aplicativo"
	end if
	Set rs=nothing
	conn.Close
	set conn=nothing
case "G"							'Grabar
	StrMode		="G"
	StrTitulo	="Corregir"
	StrBoton	="Corregir datos de la Nota de Interes"
	sdestitulo		=fFiltraApostrofe(request("txtdesTitulo"))
	sDEsEnlace		=fFiltraApostrofe(request("txtDEsEnlace"))
	fActivo		=request("chkActivo")
	if fActivo="" then fActivo=0
	
	if sDesTitulo="" or len(sDesTitulo)>100 then
		strMensaje="Ha ingresado el titulo de la nota en blanco o  el texto ingresado excede la longitud asignada para el campo," & _
					" recuerde  que el Titulo no deben exeder los 100 caracteres, corrija"
	else
		Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Insert NotasDEInteres (des_titulo,des_enlace, est_Activo,cod_deinteres) " & _
			   " values('"&sDesTitulo&"','"&sdesEnlace&"','"&fActivo&"',"&icodDeinteres&")"
        conn.execute(strsql)
		conn.close
		set conn=nothing
		Response.Redirect("ListNotaInteres.asp?icoddeinteres="&icoddeinteres)
	end if
case "U"
	StrMode		="U"
	StrTitulo	="Corregir"
	StrBoton	="Corregir datos de Usuarios"
	icodNotaDei	=request("hdnCodNotaDEI")
	sdestitulo		=fFiltraApostrofe(request("txtdesTitulo"))
	sDEsEnlace		=fFiltraApostrofe(request("txtDEsEnlace"))
	fActivo		=request("chkActivo")
	if fActivo="" then fActivo=0
	
	if sDesTitulo="" or len(sDesTitulo)>100 then
		strMensaje="Ha ingresado el titulo de la nota en blanco o  el texto ingresado excede la longitud asignada para el campo," & _
					" recuerde  que el Titulo no deben exeder los 100 caracteres, corrija"
	else
		Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Update  NotasDEInteres set des_titulo='"&sDesTitulo&"'," & _
			   "  est_activo='"&factivo&"'" & _
			   " , des_enlace='"&sdesenlace&"'" & _
			   "  where cod_notaDei="& icodNotaDei & _
			   " and cod_deinteres=" & icoddeinteres
		conn.execute(strsql)
		conn.close
		set conn=nothing
		Response.Redirect("ListNotaInteres.asp?icoddeinteres="&icoddeinteres)
	end if
end select%>

<HTML>
<HEAD>
<link rel="stylesheet" href="../include/css/Stilo.css" type="text/css">

<TITLE>Edición de Notas De Interes</TITLE>
</HEAD>
<body bgcolor="#FFFFFF" text="#000000"  >
<BASEFONT FACE="VERDANA" SIZE="2">

<form action="<%=request.Servervariables("url")%>" method="post">
  <TABLE cellpadding="1" cellspacing="1" border="0" width="480" align="center">
    <tr>
      <td colspan="2" class="Linea">
        <input type="Hidden" name="M" value="<%=strMode%>">
        <input type="hidden" name="hdnCodNotaDEI" value="<%=icodNotaDei%>">
		<input type="hidden" name="icoddeinteres" value="<%=icoddeinteres%>">
      </td>
    </tr>
    <tr align="center">
      <td colspan="2" class="Titulo"><%=strTitulo%> de Notas De Interes</td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td>
    </tr>
    <%if strMensaje<>"" then%>
    <tr>
      <td colspan="2" class="mensaje"><%=strMensaje%></td>
    </tr>
    <%end if%>
    <tr>
      <td class="texto">titulo de la nota </td>
      <td class="texto">
        <input type="text" name="txtDesTitulo" value="<%=sDesTitulo%>" maxlength="100">
      </td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr><tr>
      <td class="texto">Enlace de la nota </td>
      <td class="texto">
        <input type="text" name="txtdesenlace" value="<%=sDesEnlace%>" maxlength="100">
      </td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>

<tr>
      <td class="texto"> Registro activo</td>
      <td class="texto">
        <input type="checkbox" name="chkActivo" value="1" <%if factivo=1 then%>Checked<%end if%>>
      </td>
    </tr>

    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>
    <tr align="center">
      <Td colspan="2" class="Titulo">
        <input type="submit" name="accion" value="<%=strBoton%>">
        <input type="button" name="accion" value="Volver a Lista" onclick="location.href='ListNotaInteres.asp?icoddeinteres=<%=icoddeinteres%>'">
      </td>
    </tr>
  </table>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>

</BODY>
</HTML>
