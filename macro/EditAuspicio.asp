<%Response.Buffer=false%>

<!--#include file="../include/ASP/Conn.asp" -->
<!--#include file="../include/ASP/fFiltraApostrofe.asp" -->
<%
select case request("M")
case "N"
	StrMode="G"
	StrTitulo="Ingreso"
	StrBoton ="Ingresar auspicios"
case "M"
	StrMode  ="U"						'update
	StrTitulo="Modificar"
	StrBoton ="Modificar auspicios"

	set conn = server.CreateObject("adodb.Connection")
	conn.open Constr
	strsql="SELECT cod_auspicio, nom_auspicio, des_auspicio,des_auspiciotexto,des_auspiciofoto, des_urlauspicio, est_Activo " & _
		   "FROM auspicio where cod_auspicio=" & request("iCodauspicio")
	set rs=conn.execute(strsql)
	if not rs.eof then
	
		iCodauspicio=rs(0)
		sNomauspicio=trim(rs(1))
		sDesauspicio=(rs(2))
		sDesAuspicioTexto   =trim(rs(3))
		sdesAuspicioFoto     =trim(rs(4))
		sDesUrlAuspicio    =trim(rs(5))
		factivo=rs(6)
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
	StrBoton="Corregir datos de auspicios"
	sNomauspicio		=fFiltraApostrofe(request("txtNomauspicio"))
	sDesauspicio	    =fFiltraApostrofe(request("txtdesAuspicio"))
	sDesauspicioTExto   =fFiltraApostrofe(request("txtDesAuspicioTexto"))
	sDesAuspicioFoto	=fFiltraApostrofe(request("txtDesAuspicioFoto"))
	sDesURLAuspicio		=fFiltraApostrofe(request("TxtDesUrlAuspicio"))
	fActivo			    =request("chkActivo")
	if fActivo="" then fActivo=0
	if sNomauspicio="" or len(sNomauspicio)>50  or  sDesauspicio=""  or sDesauspicioTExto="" or  sDesAuspicioFoto=""  or  sDesURLAuspicio="" then
		strMensaje="Ha ingresado datos en  blanco en la base de datos." 
					
	else
		Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Insert auspicio (Nom_auspicio, des_auspicio,des_auspiciotexto,des_auspicioFoto,des_urlauspicio,est_Activo) " & _
			   " values('"&sNomauspicio&"','"&sDesauspicio&"','"&sDesAuspicioTexto&"','"&sDesAuspicioFoto&"','"&sDesUrlAuspicio&"','"&fActivo&"')"
        conn.execute(strsql)
		conn.close
		set conn=nothing
		Response.Redirect("ListAuspicio.asp")

	end if
case "U"
	StrMode="U"
	StrTitulo="Corregir"
	StrBoton="Corregir datos de auspicios"
	iCodauspicio=request("hdnCodauspicio")
	sNomauspicio		=fFiltraApostrofe(request("txtNomauspicio"))
	sDesauspicio	    =fFiltraApostrofe(request("txtdesAuspicio"))
	sDesauspicioTExto   =fFiltraApostrofe(request("txtDesAuspicioTexto"))
	sDesAuspicioFoto	=fFiltraApostrofe(request("txtDesAuspicioFoto"))
	sDesURLAuspicio		=fFiltraApostrofe(request("TxtDesUrlAuspicio"))
	fActivo			    =request("chkActivo")
	if factivo ="" then factivo=0
	if sNomauspicio="" or len(sNomauspicio)>50  or  sDesauspicio=""  or sDesauspicioTExto="" or  sDesAuspicioFoto=""  or  sDesURLAuspicio="" then
		strMensaje="Ha ingresado datos en  blanco en la base de datos." 
	else
		Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Update  auspicio set Nom_auspicio='"&snomauspicio&"' , des_auspicio='"&sdesauspicio&"'," & _
			   " des_auspiciotexto='"&sdesauspiciotexto&"', des_auspiciofoto='"&sdesauspiciofoto&"',des_urlauspicio='"&sDesUrlAuspicio&"', est_activo='"&factivo&"'" & _
			   "  where cod_auspicio="& icodauspicio
		conn.execute(strsql)
		conn.close
		set conn=nothing
			Response.Redirect("ListAuspicio.asp")
	end if
end select%>
<HTML>
<HEAD>
<link rel="stylesheet" href="../include/css/Stilo.css" type="text/css">
<script language="JavaScript1.2" src="../Include/Js/fSelectList.js"></script>


<TITLE>Edición de auspicios</TITLE>
</HEAD>
<body bgcolor="#FFFFFF" text="#000000"  >
<BASEFONT FACE="VERDANA" SIZE="2">

<form action="<%=request.Servervariables("url")%>" method="post">
  <TABLE cellpadding="1" cellspacing="1" border="0" width="480" align="center">
    <tr>
      <td colspan="2" class="Linea">
        <input type="Hidden" name="M" value="<%=strMode%>">
        <input type="hidden" name="hdnCodauspicio" value="<%=iCodauspicio%>">
      </td>
    </tr>
    <tr align="center">
      <td colspan="2" class="Titulo"><%=strTitulo%> de auspicios</td>
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
      <td class="texto">Nombre del auspicio</td>
      <td class="texto">
        <input type="text" name="txtNomauspicio" value="<%=sNomauspicio%>" maxlength="50">
      </td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>

    <tr>
      <td class="texto">Datos del auspicio </td>
      <td class="texto">
        <textarea name="txtdesAuspicio" cols="35" rows="3" maxlength="150"><%=sdesauspicio%></textarea>
      </td>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>

    </tr>
	 <tr>
      <td class="texto">Texto de descripcion del auspicio </td>
      <td class="texto">
        <textarea name="txtdesAuspicioTexto" cols="35" rows="3"  maxlength="100"><%=sDesAuspicioTexto%></textarea>
      </td>
    </tr>

    <tr>
      <td colspan="5" class="LineaSeparadora"></td>
    </tr><tr>
      <td class="texto">Nombre de la foto o imagen del auspicio</td>
      <td class="texto">
         <input type="text" name="txtDesAuspicioFoto"  value="<%=sDesAuspicioFoto%>"  maxlength="50" >
         
      </td>
    </tr>

    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr><tr>
      <td class="texto">Url del auspiciador</td>
      <td class="texto">
         <input type="text" name="txtdesUrlAuspicio"  value="<%=sDesUrlAuspicio%>"  maxlength="100" >
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
        <input type="button" name="accion" value="Volver a Lista" onclick="location.href='ListAuspicio.asp'">
      </td>
    </tr>
  </table>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>

</BODY>
</HTML>
