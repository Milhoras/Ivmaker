<%Response.Buffer=false%>

<!--#include file="../include/ASP/Conn.asp" -->
<!--#include file="../include/ASP/fFiltraApostrofe.asp" -->
<%
	icodpub=request("codpub")
select case request("M")
case "N"
	StrMode="G"
	StrTitulo="Ingreso"
	StrBoton ="Ingresar Grupo de notas de Interes"

case "M"
	StrMode  ="U"						'update
	StrTitulo="Modificar"
	StrBoton ="Modificar Grupos de notas de Interes"

	set conn = server.CreateObject("adodb.Connection")
	conn.open Constr
	strsql="SELECT cod_deInteres, cod_Seccion, nom_deinteres, num_notaMax, nom_plantilla, des_rutaSalida, est_generado, est_Activo" & _
		   " FROM DeInteres where cod_deInteres=" & request("icodDeInteres")
	set rs=conn.execute(strsql)
	if not rs.eof then
		icodDeInteres=rs(0)
		icodSEccion=RS(1)
		sNomDeInteres=trim(rs(2))
		iNumMax=trim(rs(3))
		sDesNomPlantilla=trim(rs(4))
		sDesRutaSalida=trim(rs(5))
		fGenrado	=rs(6)
		fActivo    =rs(7)
		if factivo="" then factivo=0
		if fgenerado="" then fgenerado=0
		
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
	iCodSeccion=request("txtcodseccion")
	sNomDeInteres=fFiltraApostrofe(request("txtnomDeInteres"))
	inumMax	   =fFiltraApostrofe(request("txtNumMax"))
	sNomPlantilla=fFiltraApostrofe(request("txtNomPlantilla"))
	SDEsRutaSalida=fFiltraApostrofe(request("txtDesRutaSalida"))
	fActivo    =request("chkActivo")
	fgenerado	=request("chkGenerado")
	if fActivo="" then fActivo=0
	if fgenerado="" then fgenerado=0
	
	if SnomDeinteres="" or len(SnomDeinteres)>150   then
		strMensaje="Ha ingresado datos  blanco o el texto ingresado excede la capacidad de la base de datos" 
					
	else
		Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Insert DeInteres (cod_seccion,Nom_deinteres, num_notaMax,des_nomplantilla, des_rutaSalida,est_Activo,Est_generado) " & _
			   " values("&icodseccion&",'"&SnomDeinteres&"',"&inumMax&",'"&sdesnomplantilla&"','"&sDesRutaSalida&"','"&fActivo&"','"&fgenerado&"')"
        conn.execute(strsql)
		conn.close
		set conn=nothing
		Response.Redirect("ListNotasInteresSecc.asp")
	end if
case "U"
	StrMode="U"
	StrTitulo="Corregir"
	StrBoton="Corregir datos de Usuarios"
	icodDeInteres=request("hdnCodDeInteres")
	iCodSeccion=request("txtCodSeccion")
	SnomDeinteres=fFiltraApostrofe(request("txtnomDeInteres"))
	inumMax	   =fFiltraApostrofe(request("txtNumMax"))
	sNomPlantilla=fFiltraApostrofe(request("txtNomPlantilla"))
	SDEsRutaSalida=fFiltraApostrofe(request("txtDesRutaSalida"))
	fActivo    =request("chkActivo")
	fgenerado	=request("chkGenerado")
	if fActivo="" then fActivo=0
	if fgenerado="" then fgenerado=0
	if SnomDeinteres="" or len(SnomDeinteres)>150   then
		strMensaje="Ha ingresado datos  blanco o el texto ingresado excede la capacidad de la base de datos" 
	else
			Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Update  DeInteres set cod_Seccion="&icodseccion&", nom_deInteres='"&SnomDeinteres&"' , num_notaMAx="&inummax&"," & _
			   " nom_plantilla='"&sNomPlantilla&"', des_rutaSalida='"&sdesRutasalida&"', est_activo='"&factivo&"'" & _
			   ", est_generado= '"&fgenerado & "' " & _
			   "  where cod_deInteres="& icodDeInteres
		conn.execute(strsql)
		conn.close
		set conn=nothing
		Response.Redirect("ListNotasInteresSecc.asp")
	end if
end select%>

<HTML>
<HEAD>
<link rel="stylesheet" href="../include/css/Stilo.css" type="text/css">
<script language="JavaScript1.2" src="../include/Js/fAbreVentana.js"></script>

<TITLE>Edición de Usuarios</TITLE>

</HEAD>
<body bgcolor="#FFFFFF" text="#000000"  >
<BASEFONT FACE="VERDANA" SIZE="2">

<form action="<%=request.Servervariables("url")%>" method="post" name="frmDeInteres">
  <TABLE cellpadding="1" cellspacing="1" border="0" width="480" align="center">
    <tr>
      <td colspan="2" class="Linea">
        <input type="Hidden" name="M" value="<%=strMode%>">
        <input type="hidden" name="hdnCodDeInteres" value="<%=icodDeInteres%>">
      </td>
    </tr>
    <tr align="center">
      <td colspan="2" class="Titulo"><%=strTitulo%> de DeInteres</td>
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
      <td class="texto">codigo de seccion </td>
      <td class="texto">
        <input type="text" name="txtCodSeccion" value="<%=icodseccion%>" readOnly class="corto">
        <br><a href="#" onclick="window.open('SeleccionaSeccionLibre.asp?codSecc=<%=icodseccion%>&codpub=<%=icodpub%>','NewWindow',width=100,height=100);">Selecccionar</a> 
      </td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>

    <tr>
      <td class="texto">Nombre de Interes </td>
      <td class="texto">
        <input type="text" name="txtnomDeInteres" value="<%=SnomDeinteres%>" >
      </td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>


	 <tr>
      <td class="texto">Numero de Maximo de notas</td>
      <td class="texto"> 
	<input type="text" name="txtNumMax" value="<%=iNumMax%>" class="corto">
      </td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>
<tr>
      <td class="texto">Nombre de La plantilla</td>
      <td class="texto">
        <input type="text" name="txtNomPlantilla" value="<%=sDesNomPlantilla%>" >
      </td>
    </tr>

    <tr><td colspan="5" class="LineaSeparadora"></td></tr>
<tr>
      <td class="texto">Ruta de generacion por defecto</td>
      <td class="texto">
        <input type="text" name="txtDesRutaSalida" value="<%=sDEsRutaSAlida%>" >
      </td>
    </tr>

    <tr><td colspan="5" class="LineaSeparadora"></td></tr>
	<tr>
      <td class="texto">Include ya generado</td>
      <td class="texto">
<input type="checkbox" name="chkGenerado" value="1" <%if fgenerado="1" then%>Checked<%end if%>>      
      </td>
    </tr>

    <tr><td colspan="5" class="LineaSeparadora"></td></tr>
	<tr>
      <td class="texto">Grupo activo</td>
      <td class="texto">
<input type="checkbox" name="chkactivo" value="1" <%if factivo="1" then%>Checked<%end if%>>      
      </td>
    </tr>


    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>
    <tr align="center">
      <Td colspan="2" class="Titulo">
        <input type="submit" name="accion" value="<%=strBoton%>">
        <input type="button" name="accion" value="Volver a Lista" onclick="location.href='ListNotasInteresSecc.asp'">
      </td>
    </tr>
  </table>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>

</BODY>
</HTML>
