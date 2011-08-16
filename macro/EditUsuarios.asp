<%Response.Buffer=false%>

<!--#include file="../include/ASP/Conn.asp" -->
<!--#include file="../include/ASP/fFiltraApostrofe.asp" -->
<%
sub SacaLen()
	Set Trs= server.CreateObject("adodb.recordset")
	strsql="SELECT  top 1  nom_usuario,des_Email,des_usuario,des_clave  " & _
		   "FROM  usuario"
	Trs.Open strsql, constr
		lensNomusuario=Trs.fields(0).DefinedSize
		lensDesEmail=Trs.fields(1).DefinedSize
		lensDesUsuario=Trs.fields(2).DefinedSize
		lensDesClave=Trs.fields(3).DefinedSize
	Trs.Close
	set Trs=nothing
End sub


' variables de uso solo para el manejo de los redactores
  fVolver=request("Back")
  icodpublicacion=request("icodpublicacion")
  ' variables listredactores
select case request("M")
case "N"
	StrMode="G"
	StrTitulo="Ingreso"
	StrBoton ="Ingresar Usuarios"
		call SacaLen()	
case "M"
	StrMode  ="U"						'update
	StrTitulo="Modificar"
	StrBoton ="Modificar Usuarios"

	set conn = server.CreateObject("adodb.Connection")
	conn.open Constr
	strsql="SELECT cod_usuario, nom_usuario, des_email,des_usuario,des_clave, est_Activo,Tip_nivel " & _
		   "FROM Usuario where cod_usuario=" & request("iCodUsuario")
	set rs=conn.execute(strsql)
	if not rs.eof then
	
		iCodUsuario=rs(0)
		sNomUsuario=trim(rs(1))
		sEmail	   =trim(rs(2))
		sUsuario   =trim(rs(3))
		sClave     =trim(rs(4))
		fActivo    =rs(5)
		fNivel	   =rs(6)
		if factivo="" then factivo=0
		call SacaLen()	
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
	sNomUsuario=fFiltraApostrofe(request("txtNomUsuario"))
	sEmail	   =fFiltraApostrofe(request("txtEmail"))
	sUsuario   =fFiltraApostrofe(request("txtUsuario"))
	sClave	   =fFiltraApostrofe(request("txtClave"))
	fActivo    =request("chkActivo")
	fNivel	   =request("chkNivel")
	if fnivel="" then fnivel="U"
	if fActivo="" then fActivo=0
	call SacaLen()	
	if sNomUsuario=""   or  sUsuario=""  or  sClave=""  or  sEmail="" then
		strMensaje="Ha ingresado datos  blanco o el texto ingresado excede la capacidad de la base de datos," & _
					" recuerde  que el user y el password no deben exeder los 15 caracteres, y el nombre no debe tener mas de 50 caracteres, corrija"
	else
		Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Insert Usuario (Nom_usuario, des_email,des_usuario,des_clave,est_Activo,tip_Nivel) " & _
			   " values('"&sNomUsuario&"','"&sEmail&"','"&sUsuario&"','"&sClave&"','"&fActivo&"','"&fnivel&"')"
        conn.execute(strsql)
		conn.close
		set conn=nothing
		Response.Redirect("ListUsuarios.asp")
	end if
case "U"
	StrMode="U"
	StrTitulo="Corregir"
	StrBoton="Corregir datos de Usuarios"
	iCodUsuario=request("hdnCodUsuario")
	sNomUsuario=fFiltraApostrofe(request("txtNomUsuario"))
	sEmail	   =fFiltraApostrofe(request("txtEmail"))
	sUsuario   =fFiltraApostrofe(request("txtUsuario"))
	sClave	   =fFiltraApostrofe(request("txtClave"))
	fActivo    =request("chkActivo")
	ferror	   =request("hdnfError")
	fNivel	   =request("chkNivel")
	if fnivel="" then fnivel="U"
	if factivo ="" then factivo=0
	call SacaLen()	
	if sNomUsuario=""   or  sUsuario=""  or  sClave=""  or  sEmail=""    then
		strMensaje="Ha ingresado datos en blanco o el texto ingresado excede la longitud asignada al campo," & _
					" recuerde  que el user y el password no deben exeder los 15 caracteres, y el nombre no debe tener mas de 50 caracteres, corrija"
	else
		Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Update  Usuario set Nom_Usuario='"&snomUsuario&"' , des_email='"&sEmail&"'," & _
			   " des_usuario='"&susuario&"', des_clave='"&sclave&"', est_activo='"&factivo&"', tip_nivel='"&fnivel&"'" & _
			   "  where cod_usuario="& icodUsuario
		conn.execute(strsql)
		conn.close
		set conn=nothing
			Response.Redirect("ListUsuarios.asp")
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
        <input type="hidden" name="hdnCodUsuario" value="<%=iCodUsuario%>">
      </td>
    </tr>
    <tr align="center">
      <td colspan="2" class="Titulo"><%=strTitulo%> de Usuarios</td>
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
      <td class="texto">Nombre del Usuario</td>
      <td class="texto">
        <input type="text" name="txtNomUsuario" value="<%=sNomUsuario%>" maxlength="<%=lensNomUsuario%>">
      </td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>

    <tr>
      <td class="texto">E-Mail </td>
      <td class="texto">
        <input type="text" name="txtEmail" value="<%=sEmail%>" maxlength="<%=LensDesEmail%>">
      </td>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>

    </tr>
	 <tr>
      <td class="texto">Usuario</td>
      <td class="texto">
        <input type="text" name="txtusuario" value="<%=sUsuario%>" maxlength="<%=LensDesUsuario%>">
      </td>
    </tr>

    <tr>
      <td colspan="5" class="LineaSeparadora"></td>
    </tr><tr>
      <td class="texto">Clave de acceso</td>
      <td class="texto">
        <input type="text" name="txtClave" value="<%=sClave%>" maxlength="<%=lensDesClave%>">
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

    <tr><td colspan="5" class="LineaSeparadora"></td></tr>
<tr>
      <td class="texto">Usuario Administrador</td>
      <td class="texto">
        <input type="checkbox" name="chkNivel" value="S" <%if fnivel="S" then%>Checked<%end if%>>
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
        <input type="button" name="accion" value="Volver a Lista" onclick="location.href='ListUsuarios.asp'">
      </td>
    </tr>
  </table>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>

</BODY>
</HTML>
