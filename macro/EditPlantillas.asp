<%Response.Buffer=false%>

<!--#include file="../include/ASP/Conn.asp" -->
<!--#include file="../include/ASP/fFiltraApostrofe.asp" -->
<%icodpublicacion=request("icodpublicacion")
select case request("M")
case "N"
	StrMode="G"
	StrTitulo="Ingreso"
	StrBoton ="Ingresar Plantillas"
case "M"
	StrMode  ="U"						'update
	StrTitulo="Modificar"
	StrBoton ="Modificar Plantillas"

	set conn = server.CreateObject("adodb.Connection")
	conn.open Constr
	strsql="SELECT cod_plantilla, nom_plantilla, des_archivoplantilla,tip_plantilla,cod_publicacion, est_Activo " & _
		   "FROM Plantillas where cod_plantilla=" & request("icodPlantilla")
	set rs=conn.execute(strsql)
	if not rs.eof then
	
		icodPlantilla=rs(0)
		sNomPlantilla=trim(rs(1))
		sDesArchivo	=TRim(rs(2))
		ftipPlantilla  =trim(rs(3))
		icodpublicacion=trim(rs(4))
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
	StrBoton="Corregir datos de Plantillas"
	sNomPlantilla=fFiltraApostrofe(request("txtNomPlantilla"))
	sDesArchivo		   =fFiltraApostrofe(request("txtDesArchivo"))
	ftipPlantilla	   =request("cmbTipPlantilla")
	icodPublicacion	   =request("icodpublicacion")
	fActivo    =request("chkActivo")
	if fActivo="" then fActivo=0
	if sNomPlantilla="" or len(sNomPlantilla)>50   then
		strMensaje="Ha ingresado datos  blanco o el texto ingresado excede la capacidad de la base de datos" 
	else
		Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Insert Plantillas (nom_plantilla, des_archivoplantilla,tip_plantilla,cod_publicacion,est_Activo) " & _
			   " values('"&sNomPlantilla&"','"&sdesArchivo&"','"&ftipPlantilla&"',"&icodpublicacion&",'"&fActivo&"')"
        conn.execute(strsql)
		conn.close
		set conn=nothing
		Response.Redirect("ListPlantillas.asp?icodpublicacion="&icodpublicacion)
	end if
case "U"
	StrMode="U"
	StrTitulo="Corregir"
	StrBoton="Corregir datos de Plantillas"
	icodPlantilla=request("hdnCodPlantillas")
	sNomPlantilla=fFiltraApostrofe(request("txtNomPlantilla"))
	sDesArchivo		   =fFiltraApostrofe(request("txtDesArchivo"))
	ftipPlantilla	   =request("cmbTipPlantilla")
	icodPublicacion	   =request("icodpublicacion")
	fActivo    =request("chkActivo")
	if fActivo="" then fActivo=0
	if sNomPlantilla="" or len(sNomPlantilla)>50   then
		strMensaje="Ha ingresado datos  blanco o el texto ingresado excede la capacidad de la base de datos" 
	else
		Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Update  Plantillas set nom_plantilla='"&sNomPlantilla&"' , des_archivoplantilla='"&sdesArchivo&"'," & _
			   " tip_plantilla='"&ftipPlantilla&"', cod_publicacion="&icodpublicacion&", est_activo='"&factivo&"'" & _
			   "  where cod_plantilla="& icodPlantilla
		conn.execute(strsql)
		conn.close
		set conn=nothing
			Response.Redirect("ListPlantillas.asp?icodpublicacion="&icodpublicacion)
	end if
end select%>
<HTML>
<HEAD>
<link rel="stylesheet" href="../include/css/Stilo.css" type="text/css">
<script language="JavaScript1.2" src="../Include/Js/fSelectList.js"></script>


<TITLE>Edición de Plantillas</TITLE>
</HEAD>
<body bgcolor="#FFFFFF" text="#000000"  >
<BASEFONT FACE="VERDANA" SIZE="2">

<form action="<%=request.Servervariables("url")%>" method="post">
  <TABLE cellpadding="1" cellspacing="1" border="0" width="480" align="center">
    <tr>
      <td colspan="2" class="Linea">
        <input type="Hidden" name="M" value="<%=strMode%>">
        <input type="hidden" name="hdnCodPlantillas" value="<%=icodPlantilla%>">
		<input type="hidden" name="icodpublicacion" value="<%=icodpublicacion%>">
      </td>
    </tr>
    <tr align="center">
      <td colspan="2" class="Titulo"><%=strTitulo%> de Plantillas</td>
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
      <td class="texto">Nombre del Plantillas</td>
      <td class="texto">
        <input type="text" name="txtNomPlantilla" value="<%=sNomPlantilla%>">
      </td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>

    <tr>
      <td class="texto">Tipo de Plantilla </td>
      <td class="texto">
      <Select name="cmbTipPlantilla" size="1">
      <option value="N">plantilla de Nota</option>
      <option value="S">Plantilla de seccion</option>
      <option value="P">Plantilla de Portada</option>
      <option value="">Seleccionar</option>
      
      </select> 
      <script>
SelectList(document.forms(0).cmbTipPlantilla,'<%=ftipPlantilla%>');
</script> 
      </td>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>

    </tr>
	 <tr>
      <td class="texto">Nombre fisico de la plantilla</td>
      <td class="texto">
        <input type="text" name="txtDesArchivo" value="<%=sDesArchivo%>"> recuerde que deben tener la terminacion (.plt)
      </td>
    </tr>

    <tr>
      <td colspan="5" class="LineaSeparadora"></td>
    </tr>
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
        <input type="button" name="accion" value="Volver a Lista" onclick="location.href='ListPlantillas.asp?icodpublicacion=<%=icodpublicacion %>'">
        <input type="button" name="accion" value="Ir a asignacion de plantillas" onclick="location.href='AsignPlantillasSecc.asp?codpub=<%=icodpublicacion %>'">
      </td>
    </tr>
  </table>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>

</BODY>
</HTML>
