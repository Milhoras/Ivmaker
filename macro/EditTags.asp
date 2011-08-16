<%Response.Buffer=false%>

<!--#include file="../include/ASP/Conn.asp" -->
<!--#include file="../include/ASP/fFiltraApostrofe.asp" -->
<%
select case request("M")
case "N"
	StrMode="G"
	StrTitulo="Ingreso"
	StrBoton ="Ingresar Tags"
case "M"
	StrMode  ="U"						'update
	StrTitulo="Modificar"
	StrBoton ="Modificar Tags"

	set conn = server.CreateObject("adodb.Connection")
	conn.open Constr
	strsql="SELECT cod_Tag,nom_tag, des_Tag, des_basedatos,des_tabla,des_campo,des_formato,est_activo, tip_tag" & _
		   " FROM TagIvmaker where cod_Tag=" & request("icodTag")
	set rs=conn.execute(strsql)
	if not rs.eof then
		iCodTag			=rs(0)
		sNomTag			=trim(rs(1))
		sDesTAg			=trim(rs(2))
		sDesBaseDatos	=trim(rs(3))
		sDesTabla		=rs(4)
		sDesCampo		=rs(5)
		sDesCadena		=sDesBaseDatos & "|"&sDesTabla & "|" &sDesCampo  
		sDesFormato		=rs(6)
		factivo			=rs(7)
		fTiptag			=rs(8)
		if factivo="" then factivo=0
		if fTipTAg="" then fTipTag="N"		
	else
	strMensaje="el registro al que intenta ingresar, no existe o fue borrado desde fuera del aplicativo"
	end if
	Set rs=nothing
	conn.Close
	set conn=nothing
case "G"							'Grabar
	StrMode="G"
	StrTitulo="Corregir"
	StrBoton="Corregir datos de la Tag"
	sNomTag			=fFiltraApostrofe(request("txtNomTag"))
	sDesTag			=fFiltraApostrofe(request("txtDesTag"))
	sDesCadena		=fFiltraApostrofe(request("Cadena"))
	Datos			=Split(sDesCadena,"|")
	sDesBaseDatos   =Datos(1)
	sDesTabla		=Datos(2)
	sDesCampo	    =Datos(3)
	sDesFormato		=fFiltraApostrofe(request("txtFormato"))
	fActivo			=request("chkActivo")
	fTipTag			=request("RadTipo")
	
	if fActivo="" then fActivo=0
	
	if sNomTag="" or len(sNomTag)>50 then
		strMensaje="Ha ingresado datos  blanco o el texto ingresado excede la capacidad de la base de datos," & _
					" recuerde  que el Nombre de la Tag no deben exeder los 50 caracteres, y el Comando no  debe tener mas de 100 caracteres, corrija"
	else
		Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Insert TagIvmaker (nom_tag,des_Tag, des_basedatos,des_Tabla,des_campo,des_formato,est_Activo,tip_tag) " & _
			   " values('"&sNomTag&"','"&sdesTag&"','"&sDesBAseDatos&"','"&sdesTabla&"',"&sdesCampo&",'"&sdesFormato&"','"&factivo&"','"&ftiptag&"')"
        conn.execute(strsql)
		conn.close
		set conn=nothing
		Response.Redirect("ListTags.asp")
	end if
case "U"
	StrMode="U"
	StrTitulo="Corregir"
	StrBoton="Corregir datos de Usuarios"
	iCodTag=request("hdnCodTag")
	sNomTag			=fFiltraApostrofe(request("txtNomTag"))
	sDesTag			=fFiltraApostrofe(request("txtDesTag"))
	sDesCadena		=fFiltraApostrofe(request("Cadena"))
	Datos			=Split(sDesCadena,"|")
	sDesBaseDatos   =Datos(1)
	sDesTabla		=Datos(2)
	sDesCampo	    =Datos(3)
	sDesBaseDatos   =fFiltraApostrofe(request("txtDesBaseDatos"))
	sDesTabla		=ffiltraApostrofe(request("txtTabla"))
	sDesCampo	    =ffiltraApostrofe(request("txtCampo"))
	sDesFormato		=fFiltraApostrofe(request("txtFormato"))
	fActivo			=request("chkActivo")
	fTipTag			=request("RadTipo")

	if factivo="" then factivo=0
	if sNomTag="" or len(sNomTag)>50 then
		strMensaje="Ha ingresado datos  blanco o el texto ingresado excede la capacidad de la base de datos," & _
					" recuerde  que el Nombre de la Tag no deben exeder los 50 caracteres, y el Comando no  debe tener mas de 100 caracteres, corrija"
	else
		Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Update  TagIvmaker set nom_Tag='"&snomtag&"', des_Tag='"&sdesTag&"' , des_basedatos='"&sdesbasedatos&"'," & _
			   " des_tabla='"&sdestabla&"',  des_Campo='"&sdesCampo&"'" & _
			   ", des_formato= '"&sdesFormato & "', est_activo='"&factivo&"', tip_Tag='"&ftiptag&"'" & _
			   "  where cod_Tag="& icodTag
		conn.execute(strsql)
		conn.close
		set conn=nothing
		Response.Redirect("ListTags.asp")
	end if
end select%>

<html>
<head>
<link rel="stylesheet" href="../include/css/Stilo.css" type="text/css">
<script language="JavaScript1.2" src="../Include/Js/fSelectList.js"></script>
<script language="JavaScript1.2" src="../include/Js/fAbreVentana.js"></script>
<title>Edición de Usuarios</title>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<basefont FACE="VERDANA" SIZE="2">

<form action="<%=request.Servervariables("url")%>" method="post" name="frmTagsEdit">
  <table cellpadding="1" cellspacing="1" border="0" width="480" align="center">
    <tr>
      <td colspan="2" class="Linea">
        <input type="Hidden" name="M" value="<%=strMode%>">
        <input type="hidden" name="hdnCodTag" value="<%=iCodTag%>">
      </td>
    </tr>
    <tr align="center">
      <td colspan="2" class="Titulo"><%=strTitulo%> de Tags</td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td>
    </tr>
    <%if strMensaje<>"" then%>
    <tr>
      <td colspan="2" class="mensaje"><%=strMensaje%></td>
    </tr>
    <%end if%>
    
<tr><td class="texto">Datos de Conexion al dato</td><td colspan="3">
	<input class="largo" type="text" name="Cadena" value width="50" READONLY>
</td><td><a href="#" onclick="AbreVentana(200,200,0,'SelectBDTAblaCampo.asp?sBaseDatos=Ivmaker');"> seleccionar base de datos, tablas o campo</a></td></tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>

    <tr>
      <td class="texto">Nombre de la Tag </td>
      <td class="texto">
        <input type="text" name="txtTag" value="<%=sTag%>">
      </td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>

    <tr>
      <td class="texto">Descripcion del tag </td>
      <td class="texto">
        <textarea cols="35" rows="2" name="txtDesTag"><%=sDesTag%></textarea>
      </td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>
	<tr>
      <td class="texto">Descripcion del formato </td>
      <td class="texto">
<textarea name="txtDesFormato" cols="45" rows="5"><%=sDesFormato%></textarea>      
      
      </td>
    </tr>

    <tr><td colspan="5" class="LineaSeparadora"></td></tr>
	<tr>
      <td class="texto">Tag Activo </td>
      <td class="texto">
	<input type="checkbox" name="chkactivo" value="1" <%if factivo=1 then%>checked<%end if%>>
      </td>
    </tr>

    <tr><td colspan="5" class="LineaSeparadora"></td></tr>
	<tr>
      <td class="texto">Tipo de Tag </td>
      <td class="texto">
Normal:<input type="radio" name="RadTipo" value="N" <%if fTiptag="N" then%> selected<%end if%>><br>
Inicio Detalle:<input type="radio" name="RadTipo" value="I" <%if fTiptag="I" then%>Selected<%end if%>><br>
Fin Detalle:<input type="radio" name="RadTipo" value="F" <%if fTiptag="F" then%>Selected<%end if%>>
      
      </td>
    </tr>

    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>
    <tr align="center">
      <td colspan="2" class="Titulo">
        <input type="submit" name="accion" value="<%=strBoton%>">
        <input type="button" name="accion" value="Volver a Lista" onclick="location.href='ListTags.asp'">
      </td>
    </tr>
  </table>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>

</body>
</html>
