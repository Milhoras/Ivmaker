<%Response.Buffer=true%>

<!--#include file="../include/ASP/Conn.asp" -->
<!--#include file="../include/ASP/fFiltraApostrofe.asp" -->
<%
select case request("M")
case "N"
	StrMode="G"
	StrTitulo="Ingreso"
	StrBoton ="Ingresar Modulos"
case "M"
	StrMode  ="U"						'update
	StrTitulo="Modificar"
	StrBoton ="Modificar Modulos"

	set conn = server.CreateObject("adodb.Connection")
	conn.open Constr
	strsql="SELECT cod_Modulo, nom_Modulo, des_modulo,des_comando1, des_comando2,est_Activo" & _
		   " FROM Modulo where cod_Modulo=" & request("icodModulo")
	set rs=conn.execute(strsql)
	if not rs.eof then
		iCodModulo =rs(0)
		sModulo    =trim(rs(1))
		sdesmodulo =trim(rs(2))
		scomando   =trim(rs(3))
		scomando2  =trim(rs(4))
		fActivo    =rs(5)
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
	StrBoton="Corregir datos de la Modulo"
	sModulo		   =fFiltraApostrofe(request("txtModulo"))
	sdesModulo	   =ffiltraApostrofe(request("txtDesModulo"))
	sComando	   =fFiltraApostrofe(request("txtComando"))
	sComando2	   =fFiltraApostrofe(request("txtComando2"))
	fActivo        =request("chkActivo")
	
	if fActivo="" then fActivo=0
	
	if sModulo="" or len(sModulo)>50 or len(Scomando)>100  or  Scomando=""   then
		strMensaje="Ha ingresado datos  blanco o el texto ingresado excede la capacidad de la base de datos," & _
					" recuerde  que el Nombre de la Modulo no deben exeder los 50 caracteres, y el Comando no  debe tener mas de 100 caracteres, corrija"
	else
		Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Insert Modulo (nom_Modulo, des_modulo,des_comando1,des_comando2,est_Activo) " & _
			   " values('"&sModulo&"','"&sdesmodulo&"','"&scomando&"','"&scomando2&"','"&fActivo&"')"
        conn.execute(strsql)
		conn.close
		set conn=nothing
		Response.Redirect("ListModulos.asp")
	end if
case "U"
	StrMode="U"
	StrTitulo="Corregir"
	StrBoton="Corregir datos de Usuarios"
	iCodModulo     =request("hdnCodModulo")
	sModulo		   =fFiltraApostrofe(request("txtModulo"))
	sdesModulo	   =ffiltraApostrofe(request("txtDesModulo"))
	sComando	   =fFiltraApostrofe(request("txtComando"))
	sComando2	   =fFiltraApostrofe(request("txtComando2"))
	fActivo        =request("chkActivo")
	if factivo ="" then factivo=0
	if sModulo="" or len(sModulo)>50 or len(Scomando)>100  or  Scomando=""   then
		strMensaje="Ha ingresado datos  blanco o el texto ingresado excede la capacidad de la base de datos," & _
					" recuerde  que el Nombre de la Modulo no deben exeder los 50 caracteres, y el Comando no  debe tener mas de 100 caracteres, corrija"
	else
		Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Update  Modulo set nom_Modulo='"&sModulo&"' ,des_modulo='"&sdesmodulo&"' ,des_comando1='"&scomando&"'," & _
			   " des_comando2='"&scomando2&"',est_activo='"&factivo&"'" & _
			   "  where cod_Modulo="& icodModulo
		conn.execute(strsql)
		conn.close
		set conn=nothing
		Response.Redirect("ListModulos.asp")
	end if
end select%>

<HTML>
<HEAD>
<link rel="stylesheet" href="../include/css/Stilo.css" type="text/css">
<script language="JavaScript1.2" src="../Include/Js/fSelectList.js"></script>

<TITLE>Edición de Usuarios</TITLE>
</HEAD>
<body bgcolor="#FFFFFF" text="#000000"  >
<BASEFONT FACE="VERDANA" SIZE="2">

<form action="<%=request.Servervariables("url")%>" method="post">
  <TABLE cellpadding="1" cellspacing="1" border="0" width="480" align="center">
    <tr>
      <td colspan="2" class="Linea">
        <input type="Hidden" name="M" value="<%=strMode%>">
        <input type="hidden" name="hdnCodModulo" value="<%=iCodModulo%>">
      </td>
    </tr>
    <tr align="center">
      <td colspan="2" class="Titulo"><%=strTitulo%> de Modulos</td>
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
      <td class="texto">Nombre del Modulo </td>
      <td class="texto">
        <input type="text" name="txtModulo" value="<%=sModulo%>">
      </td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>

    <tr>
      <td class="texto">Descripcion del Modulo </td>
      <td class="texto">
        <textarea name="txtDesModulo" rows="2" cols="35" ><%=sdesModulo%></textarea>
      </td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>

    <tr>
      <td class="texto">Comando para enlace en el menu del perfil de usuario </td>
      <td class="texto">
              <textarea name="txtComando" rows="2" cols="35" ><%=sComando%></textarea>
      </td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>
<tr>
    <tr>
      <td class="texto">comando para enlace con nota de publicacion </td>
      <td class="texto">
              <textarea name="txtComando2" rows="2" cols="35" ><%=sComando2%></textarea>
      </td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>
<tr>
      <td class="texto"> Registro activo</td>
      <td class="texto">
        <input type="checkbox" name="chkActivo" value="1" <%if factivo="1" then%>Checked<%end if%>>
      </td>
    </tr>

    <tr><td colspan="5" class="LineaSeparadora"></td></tr>
    <tr align="center">
      <Td colspan="2" class="Titulo">
        <input type="submit" name="accion" value="<%=strBoton%>">
        <input type="button" name="accion" value="Volver a Lista" onclick="location.href='ListModulos.asp'">
      </td>
    </tr>
  </table>
</form>


</BODY>
</HTML>
