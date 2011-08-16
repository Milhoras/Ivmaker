<%Response.Buffer=false%>

<!--#include file="../include/ASP/Conn.asp" -->
<!--#include file="../include/ASP/fFiltraApostrofe.asp" -->
<%
select case request("M")
case "N"
	StrMode="G"
	StrTitulo="Ingreso"
	StrBoton ="Ingresar Funciones"
case "M"
	StrMode  ="U"						'update
	StrTitulo="Modificar"
	StrBoton ="Modificar Funciones"

	set conn = server.CreateObject("adodb.Connection")
	conn.open Constr
	strsql="SELECT cod_funcion, des_funcion, des_comando,tip_comando, est_Activo,cod_tema ,est_defecto" & _
		   " FROM Funciones where cod_funcion=" & request("icodfuncion")
	set rs=conn.execute(strsql)
	if not rs.eof then
		iCodfuncion=rs(0)
		sfuncion=trim(rs(1))
		sComando=trim(rs(2))
		sTipoComando=trim(rs(3))
		fActivo    =rs(4)
		icodTema   =rs(5)
		fdefecto	=rs(6)
		if factivo="" then factivo=0
		if fdefecto="" then fdefecto=0
		
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
	sfuncion=fFiltraApostrofe(request("txtfuncion"))
	sComando	   =fFiltraApostrofe(request("txtComando"))
	stipoComando   =request("rdTipoComando")
	fActivo    =request("chkActivo")
	icodTema   =request("cmbTema")
	fdefecto	=request("chkDefecto")
	
	if fActivo="" then fActivo=0
	if fdefecto="" then fdefecto=0
	
	if sfuncion="" or len(sfuncion)>50 or len(Scomando)>100  or  Scomando=""   then
		strMensaje="Ha ingresado datos  blanco o el texto ingresado excede la capacidad de la base de datos," & _
					" recuerde  que el Nombre de la funcion no deben exeder los 50 caracteres, y el Comando no  debe tener mas de 100 caracteres, corrija"
	else
		Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Insert Funciones (des_funcion, des_comando,tip_comando,est_Activo,cod_tema,est_defecto) " & _
			   " values('"&sfuncion&"','"&scomando&"','"&stipoComando&"','"&fActivo&"',"&icodTema&",'"&fdefecto&"')"
        conn.execute(strsql)
		conn.close
		set conn=nothing
		Response.Redirect("ListFunciones.asp")
	end if
case "U"
	StrMode="U"
	StrTitulo="Corregir"
	StrBoton="Corregir datos de Usuarios"
	iCodFuncion=request("hdnCodFuncion")
	sfuncion	   =fFiltraApostrofe(request("txtfuncion"))
	sComando	   =fFiltraApostrofe(request("txtComando"))
	stipoComando   =request("RdTipoComando")
	fActivo		   =request("chkActivo")
	icodTema		=request("cmbTema")
	fdefecto		=request("chkdefecto")
	if factivo ="" then factivo=0
	if fdefecto="" then fdefecto=0
	if sfuncion="" or len(sfuncion)>50 or len(Scomando)>100  or  Scomando=""   then
		strMensaje="Ha ingresado datos  blanco o el texto ingresado excede la capacidad de la base de datos," & _
					" recuerde  que el Nombre de la funcion no deben exeder los 50 caracteres, y el Comando no  debe tener mas de 100 caracteres, corrija"
	else
		Set conn = server.CreateObject("adodb.Connection")
		Conn.open Constr
		strsql="Update  funciones set des_funcion='"&sfuncion&"' , des_comando='"&scomando&"'," & _
			   " tip_comando='"&sTipoComando&"',  est_activo='"&factivo&"'" & _
			   ", cod_tema= "&icodTema & ", est_defecto='"&fdefecto&"' " & _
			   "  where cod_funcion="& icodfuncion
		conn.execute(strsql)
		conn.close
		set conn=nothing
		Response.Redirect("ListFunciones.asp")
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
        <input type="hidden" name="hdnCodFuncion" value="<%=iCodFuncion%>">
      </td>
    </tr>
    <tr align="center">
      <td colspan="2" class="Titulo"><%=strTitulo%> de Funciones</td>
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
      <td class="texto">Nombre de la Funcion </td>
      <td class="texto">
        <input type="text" name="txtfuncion" value="<%=sFuncion%>">
      </td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>

    <tr>
      <td class="texto">Comando </td>
      <td class="texto">
        <input type="text" name="txtComando" value="<%=sComando%>" maxlength="100" size="40">
      </td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>


	 <tr>
      <td class="texto">Tipo Comando</td>
      <td class="texto"> 
        Se muestra en el menu <input type="radio"  name="RdTipoComando" value="L" <%if StipoComando="L" then%>Checked <%end if%>><br>
        No se muestra en el Menu <input type="radio"  name="RdTipoComando" value="F"<%if StipoComando="F" then%>Checked <%end if%> >        
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
      <td class="texto"> funcion por defecto</td>
      <td class="texto">
        <input type="checkbox" name="chkdefecto" value="1" <%if fdefecto=1 then%>Checked<%end if%>>
      </td>
    </tr>

    <tr><td colspan="5" class="LineaSeparadora"></td></tr>
	<tr>
      <td class="texto">Funcion del Tipo</td>
      <td class="texto">
      <%Set Trs= Server.CreateObject("Adodb.Recordset")
      StrSql="select cod_tema,nom_tema from TemaFuncion order by 2 asc"
      trs.Open strsql, constr
      if Trs.EOF then
      Response.Write("No hay temas que agrupen las funciones, crear primero los temas")
      else%>
        <select name="cmbTema" size="1">
        <option value="0">Seleccionar</option>
        <%do while not trs.eof%>
        <Option value="<%=trs(0)%>"><%=Trs(1)%></option>
		<%trs.Movenext
		loop%>
        </select>
        <script>
SelectList(document.forms(0).cmbTema,<%=icodtema%>);
</script>
      <%end if
      trs.Close
      set trs=nothing
      %>      
      
      
      </td>
    </tr>

    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>
    <tr align="center">
      <Td colspan="2" class="Titulo">
        <input type="submit" name="accion" value="<%=strBoton%>">
        <input type="button" name="accion" value="Volver a Lista" onclick="location.href='ListFunciones.asp'">
      </td>
    </tr>
  </table>
</form>
<p>&nbsp;</p>
<p>&nbsp;</p>

</BODY>
</HTML>
