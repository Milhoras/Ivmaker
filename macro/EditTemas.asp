<%Response.Buffer=false%>

<!--#include file="../include/ASP/Conn.asp" -->
<!--#include file="../include/ASP/fFiltraApostrofe.asp" -->
<%
select case request("M")
case "N"
	StrMode="G"
	StrTitulo="Ingreso"
	StrBoton ="Ingresar Temas"
case "M"
	StrMode  ="U"						'update
	StrTitulo="Modificar"
	StrBoton ="Modificar Temas"

	set conn = server.CreateObject("adodb.Connection")
	conn.open Constr
	strsql="SELECT cod_Tema, nom_tema, est_Activo,tip_tema " & _
		   "FROM TemaFuncion where cod_Tema=" & request("iCodTema")
	set rs=conn.execute(strsql)
	if not rs.eof then
		iCodTema=rs(0)
		sTema   =trim(rs(1))
		fActivo  =rs(2)
		ftipotema=rs(3)
		if factivo="" then factivo=0
		
	else
	strMensaje="el registro al que intenta ingresar, no existe o fue borrado desde fuera del aplicativo"
	end if
	Set rs=nothing
	conn.Close
	set conn=nothing
case "G"							'Grabar
	StrMode="G"
	StrTitulo="Corregir"
	StrBoton="Corregir datos de la funcion"
	sTema	=fFiltraApostrofe(request("txtTema"))
	fActivo =request("chkActivo")
	if fActivo="" then fActivo=0
	fTipoTema=request("chkTipoTema")
	if fTipoTema="" then fTipoTema="P"
	
	if sTema="" or len(sTema)>50 then
		strMensaje="Ha ingresado el nombre del Tema en blanco o  el texto ingresado excede la longitud asignada para el campo," & _
					" recuerde  que el Nombre del Tema no deben exeder los 30 caracteres, corrija"
	else
		Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Insert TemaFuncion (nom_tema, est_Activo,tip_Tema) " & _
			   " values('"&sTema&"','"&fActivo&"','"&fTipoTema&"')"
        conn.execute(strsql)
		conn.close
		set conn=nothing
		Response.Redirect("ListTemas.asp")
	end if
case "U"
	StrMode="U"
	StrTitulo="Corregir"
	StrBoton="Corregir datos de Usuarios"
	iCodTema=request("hdnCodTema")
	sTema	   =fFiltraApostrofe(request("txtTema"))
	fActivo	   =request("chkActivo")
	if factivo ="" then factivo=0
	fTipoTema=request("chkTipoTema")
	if fTipoTema="" then fTipoTema="P"
	
	if sTema="" or len(sTema)>50 then
		strMensaje="Ha ingresado el nombre del Tema en blanco o  el texto ingresado excede la longitud asignada para el campo," & _
					" recuerde  que el Nombre del Tema no deben exeder los 30 caracteres, corrija"
	else
		Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Update  TemaFuncion set nom_tema='"&sTema&"'," & _
			   "  est_activo='"&factivo&"'" & _
			   " , tip_tema='"&fTipotema&"'" & _
			   "  where cod_Tema="& iCodTema
		conn.execute(strsql)
		conn.close
		set conn=nothing
		Response.Redirect("ListTemas.asp")
	end if
end select%>

<HTML>
<HEAD>
<link rel="stylesheet" href="../include/css/Stilo.css" type="text/css">

<TITLE>Edición de Temas</TITLE>
</HEAD>
<body bgcolor="#FFFFFF" text="#000000"  >
<BASEFONT FACE="VERDANA" SIZE="2">

<form action="<%=request.Servervariables("url")%>" method="post">
  <TABLE cellpadding="1" cellspacing="1" border="0" width="480" align="center">
    <tr>
      <td colspan="2" class="Linea">
        <input type="Hidden" name="M" value="<%=strMode%>">
        <input type="hidden" name="hdnCodTema" value="<%=iCodTema%>">
      </td>
    </tr>
    <tr align="center">
      <td colspan="2" class="Titulo"><%=strTitulo%> de Temas</td>
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
      <td class="texto">Nombre del Tema </td>
      <td class="texto">
        <input type="text" name="txtTema" value="<%=sTema%>" maxlength="20">
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
<tr>
      <td class="texto">Es funcion de administracion de sistema?</td>
      <td class="texto">
        <input type="checkbox" name="chkTipoTema" value="G" <%if fTipotema="G" then%>Checked<%end if%>>
      </td>
    </tr>

    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>
    <tr align="center">
      <Td colspan="2" class="Titulo">
        <input type="submit" name="accion" value="<%=strBoton%>">
        <input type="button" name="accion" value="Volver a Lista" onclick="location.href='ListTemas.asp'">
      </td>
    </tr>
  </table>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>

</BODY>
</HTML>
