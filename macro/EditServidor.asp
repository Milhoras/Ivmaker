<%Response.Buffer=false%>

<!--#include file="../include/ASP/Conn.asp" -->
<!--#include file="../include/ASP/fFiltraApostrofe.asp" -->
<%
select case request("M")
case "N"
	StrMode="G"
	StrTitulo="Ingreso"
	StrBoton ="Ingresar Usuarios"
case "M"
	StrMode  ="U"						'update
	StrTitulo="Modificar"
	StrBoton ="Modificar Usuarios"

	set conn = server.CreateObject("adodb.Connection")
	conn.open Constr
	strsql="SELECT cod_servidor, nom_servidor, des_usuario,des_clave,des_IpDireccion,nom_contactoTecnico,num_telefonoContacto,des_emailContacto,est_Activo " & _
		   "FROM Servidores where cod_servidor=" & request("iCodServidor")
	set rs=conn.execute(strsql)
	if not rs.eof then

		iCodservidor=rs(0)
		sNomservidor=trim(rs(1))
		sUsuario	   =trim(rs(2))
		sClave   =trim(rs(3))
		sIpDireccion     =trim(rs(4))
		SContacto    =rs(5)
		inumTelefono  =rs(6)
		sEmailcontacto=rs(7)
		factivo=rs(8)
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
	StrBoton="Corregir datos de Usuarios"
	sNomservidor=fFiltraApostrofe(request("txtNomServidor"))
	sUsuario    =fFiltraApostrofe(request("txtusuario"))
	sClave	   =fFiltraApostrofe(request("txtClave"))
	sIpDireccion	   =fFiltraApostrofe(request("txtIpdireccion"))
	scontacto   =fFiltraApostrofe(request("txtContacto"))
	inumTelefonico	   =fFiltraApostrofe(request("txtNumTelefonico"))
	SEmailcontacto		=fFiltraApostrofe(request("txtEmailContacto"))
	fActivo    =request("chkActivo")

	if fActivo="" then fActivo=0
	if sNomservidor="" or sIpDireccion=""  or  sUsuario=""  or  sClave=""  or  scontacto="" then
		strMensaje="Ha ingresado datos  blanco o el texto ingresado excede la capacidad de la base de datos," & _
					" recuerde  que el user y el password no deben exeder los 15 caracteres, y el nombre no debe tener mas de 50 caracteres, corrija"
	else
		Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Insert servidores (nom_servidor, des_usuario,des_clave,des_ipdireccion,nom_contactoTecnico,num_telefonocontacto,des_emailContacto,est_Activo) " & _
			   " values('"&snomServidor&"','"&Susuario&"','"&sClave&"','"&sIpDireccion&"','"&scontacto&"','"&inumtelefonico&"','"&sEmailcontacto&"','"&fActivo&"')"
        conn.execute(strsql)
		conn.close
		set conn=nothing
		Response.Redirect("ListServidores.asp")
	end if
case "U"
	StrMode="U"
	StrTitulo="Corregir"
	StrBoton="Corregir datos de Usuarios"
	iCodServidor=request("icodservidor")
	sNomservidor=fFiltraApostrofe(request("txtNomServidor"))
	sUsuario    =fFiltraApostrofe(request("txtusuario"))
	sClave	   =fFiltraApostrofe(request("txtClave"))
	sIpDireccion	   =fFiltraApostrofe(request("txtIpdireccion"))
	scontacto   =fFiltraApostrofe(request("txtContacto"))
	inumTelefonico	   =fFiltraApostrofe(request("txtNumTelefonico"))
	SEmailcontacto		=fFiltraApostrofe(request("txtEmailContacto"))
	fActivo    =request("chkActivo")
	if factivo ="" then factivo=0
	if sNomservidor="" or sIpDireccion=""  or  sUsuario=""  or  sClave=""  or  scontacto="" then
		strMensaje="Ha ingresado datos en blanco o el texto ingresado excede la longitud asignada al campo," & _
					" recuerde  que el user y el password no deben exeder los 15 caracteres, y el nombre no debe tener mas de 50 caracteres, corrija"
	else
		Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Update  servidores set nom_servidor='"&snomservidor&"'," & _
			   " des_usuario='"&susuario&"', des_clave='"&sclave&"', des_ipdireccion='"&sipdireccion&"'" & _
			   " , nom_contactoTecnico='"&scontacto&"',num_telefonocontacto='"&inumtelefonicoo&"'" & _
			   " , des_EmailContacto='"&SEmailcontacto&"', est_activo='"&factivo&"'" & _
			   "  where cod_servidor="& icodservidor
		conn.execute(strsql)
		conn.close
		set conn=nothing
		Response.Redirect("ListServidores.asp")
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
        <input type="hidden" name="icodservidor" value="<%=iCodservidor%>">
      </td>
    </tr>
    <tr align="center">
      <td colspan="2" class="Titulo"><%=strTitulo%> de Servidores</td>
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
      <td class="texto">Nombre del Servidor</td>
      <td class="texto">
        <input type="text" name="txtNomservidor" value="<%=sNomServidor%>" size="35" maxlength="20">
      </td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>

    <tr>
      <td class="texto">Usuario de accso al servidor </td>
      <td class="texto">
        <input type="text" name="txtusuario" value="<%=susuario%>" size="35" maxlength="20">
      </td>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>

    </tr>
	 <tr>
      <td class="texto">Clave de acceso al servidor</td>
      <td class="texto">
        <input type="text" name="txtclave" value="<%=sClave%>" size="35" maxlength="20">
      </td>
    </tr>

    <tr>
      <td colspan="5" class="LineaSeparadora"></td>
    </tr><tr>
      <td class="texto">Direccion Ip del servidor</td>
      <td class="texto">
        <input type="text" name="txtIpDireccion" value="<%=sipDireccion%>" size="35" maxlength="20">
      </td>
    </tr>

    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>
<tr>
      <td class="texto">Nombre del contacto Tecnico</td>
      <td class="texto">
        <input type="text" name="txtContacto" value="<%=scontacto%>" size="35" maxlength="20">
      </td>
    </tr>

    <tr><td colspan="5" class="LineaSeparadora"></td></tr>
<tr>
      <td class="texto">Numero de teléfono del Contacto</td>
      <td class="texto">
        <input type="text" name="txtnumtelefonico" value="<%=inumTelefono%>" size="35" maxlength="20">
      </td>
    </tr>

    <tr><td colspan="5" class="LineaSeparadora"></td></tr>
<tr>
      <td class="texto">Email del contacto Tecnico</td>
      <td class="texto">
        <input type="text" name="txtEmailContacto" value="<%=semailContacto%>" size="35" maxlength="20">
      </td>
    </tr>

    <tr><td colspan="5" class="LineaSeparadora"></td></tr>
<tr>
      <td class="texto">Activo</td>
      <td class="texto">
        <input type="checkbox" name="chkActivo" value="1" <%if factivo=1 then%>checked<%end if%>>
      </td>
    </tr>

    <tr><td colspan="5" class="LineaSeparadora"></td></tr>
<%if ferror=1 then%>
    <tr>
      <td class="texto"><font color="red" >Nota</font> </td>
   <td class="texto">
     <font color="red" >Los campos marcados con (*) indican que el campo debe ser ingresado obligatoriamente</font>
      </td>
    </tr>
    <tr><td colspan="5" class="LineaSeparadora"></td></tr>
<%end if%>


    <tr align="center">
      <Td colspan="2" class="Titulo">
        <input type="submit" name="accion" value="<%=strBoton%>">
        <input type="button" name="accion" value="Volver a Lista" onclick="location.href='Listservidores.asp'">
      </td>
    </tr>
  </table>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>

</BODY>
</HTML>
