<%Response.Buffer=false%>
<!--#include file="../include/ASP/Conn.asp" -->
<!--#include file="../include/asp/fvalidaLogin.asp"-->
<html>
<head>
<title>Menu de opciones</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" type="text/css" href="../include/Css/Stilo.css">
<%  icodusuario=session("coduser")
call fvalidaLogin(icodusuario)
function SacaNombreUsuario(codigo)
set UsrRS=Server.CreateObject("Adodb.Recordset")
	strsql="select nom_usuario from usuario where cod_usuario="& codigo
UsrRs.Open strsql, constr
	SacaNombreUsuario = UsrRs(0)
UsrRs.Close
set UsrRs =nothing
end function

function fMarcaPublicacion(CodElegido,CodPub)
	if codelegido="" then
	codelegido=0
	end if
	if cint(codelegido)=cint(codpub) then
		fMarcaPublicacion="SelectedItem"
	else
		fMarcaPublicacion="texto"
	end if
End function

function fMuestraTema(TmpNomTema,NomTema)
	if trim(temptema)<>trim(NomTema)then
		fMuestraTema=" <tr ><td class=""LineaSeparadora""></td></tr>" & _
				 "<tr class=""CabeceraTabla"">" & chr(13)& chr(10) & _
				 "<td align=""Left"">" & trim(NomTEma) & "</td>" & chr(13)& chr(10) & _
				 "</tr>"  & chr(13)& chr(10) & _
				 " <tr><td  class=""LineaSeparadora""></td></tr>"
	else
		fMuestraTema=""
	end if
end function

'Este Recordset Permitira listar todas las publicaciones a las que esta asignado un usuario
  Set PubRs= server.CreateObject("Adodb.recordset")
  strsql="select cod_publicacion, nom_publicacion from publicacion where cod_publicacion in " & _
		" (select cod_publicacion from usuarioperfil where cod_usuario="&iCodUsuario&" and cod_seccion is null)" & _
		" order by 2 asc" 
  PubRs.open strsql,constr%>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td align="center" class="CabeceraTabla"><b>Ivmaker<br>
      (<%=SacaNombreUsuario(icodusuario)%>)</td>
  </tr>
 
  <tr><td class="LineaSeparadora"></td></tr>
  
<%if not PubRs.EOf then		' Utiliza el REcorset PubRs abierto anteriormente%>

  <tr class="CabeceraTabla"><td>Publicaciones asignadas</td></tr>
  <tr><td class="LineaSeparadora"></td></tr>
   <%do while not PubRs.eof %>
		<tr class="<%=fMarcaPublicacion(request("icodPublicacion"),PubRs(0))%> "><td><font face="Webdings" size="1" color="#5A0C73">4</font>
		<a href="Menu.asp?icodpublicacion=<%=Pubrs(0)%>" onclick="parent.frames[1].location.href='Listseccionesredactores.asp?codpub=<%=PubRs(0)%>'"><%=PubRs(1)%></a></td></tr>
		<%PubRs.movenext
	loop
	pubrs.MoveFirst
' carga el primer codigo para mostrar el menu de la primera publicacion
	icodpublicacion=pubrs(0)
	
end if

	' esta condicion permite cargar el codigo de publicacion si fue cambiado desde el menu
	if request("icodPublicacion")<>"" then 
		icodpublicacion=request("icodpublicacion") 
	end if
' Este Recordset
  Set AdmRs=Server.CreateObject("adodb.Recordset")
  Strsql="SELECT Funciones.des_funcion, Funciones.des_comando, " & _
			" TemaFuncion.nom_tema " & _
			" FROM Funciones, temafuncion, PerfilFuncion " & _
			" WHERE Funciones.cod_funcion = PerfilFuncion.cod_funcion AND  " & _
			" Funciones.cod_tema = TemaFuncion.cod_tema AND  " & _
			" Funciones.est_activo=1 and " & _
			" (PerfilFuncion.cod_usuario = "&icodusuario&") AND  " & _
			" (PerfilFuncion.cod_publicacion is null) and  " & _
			" TemaFuncion.est_activo=1 and" & _
			" (TemaFuncion.tip_tema='G')" & _
			" order by funciones.cod_tema" 
			
  AdmRs.Open StrSQl, Constr
  if Not AdmRs.EOF then%>
  <tr><td class="LineaSeparadora"></td></tr>
  <tr class="CabeceraTabla"><td><b>Funciones administrativas</b></td></tr>

	<%do while not AdmRs.eof
	vSOpcion=trim(AdmRs(0))
	vsLink=replace(trim(AdmRs(1)),"[CODPUB]",icodPublicacion)
	VsLink=replace(vsLink,"[CODUSER]",iCodUsuario)
	vsNomTema=AdmRs(2)
	Response.Write(fMuestraTema(TempTema,vsNomTema))  ' esta funcion pintara las celdas del Tema de funcion
		tempTema=vsnomtema%>
		<tr> 
		<td><font face="Webdings" size="1">4</font><b><a href="<%=vsLink%>" target="fraCentro"><%=vsopcion%></a></b></td>
		</tr>
	<%AdmRs.MoveNext
	loop
	
	end if
	AdmRs.Close
	set AdmRs=nothing
if not Pubrs.EOF then	
	Set Rs= server.CreateObject("Adodb.Recordset")
		' este Query verifica las funciones asignadas y las muestra
	  Strsql="SELECT Funciones.des_funcion, Funciones.des_comando, " & _
			" TemaFuncion.nom_tema " & _
			" FROM Funciones, temafuncion, PerfilFuncion " & _
			" WHERE Funciones.cod_funcion = PerfilFuncion.cod_funcion AND  " & _
			" Funciones.cod_tema = TemaFuncion.cod_tema AND  " & _
			" (PerfilFuncion.cod_usuario = "&icodusuario&") AND  " & _
			" (PerfilFuncion.cod_publicacion = "&icodpublicacion&") " & _
			" and (not PerfilFuncion.cod_publicacion is null)" & _
			" and (Temafuncion.tip_tema='P')" & _
			" and (Funciones.Tip_comando='L')" & _
			" and (Funciones.Est_activo='1')" & _
			" order by funciones.cod_tema" 
			'Response.Write(strsql &"<br>")
	Rs.Open strsql, constr
	if Not Rs.EOF then%>
<tr><td class="LineaSeparadora"></td></tr>
    <tr class="CabeceraTabla"><td><b>Opciones de usuario</b></td></tr>
 	<%tempTema="xxx"  
	do while not Rs.EOF 
		vSOpcion=trim(rs(0))
		vsLink=replace(trim(rs(1)),"[CODPUB]",icodPublicacion)
		VsLink=replace(vsLink,"[CODUSER]",iCodUsuario)
		vsNomTema=rs(2)
		Response.Write(fMuestraTema(TempTema,vsNomTema))  ' esta funcion pintara las celdas del Tema de funcion
		tempTema=vsnomtema%>
		<tr> 
		<td><font face="Webdings" size="1">4</font><a href="<%=vsLink%>" target="fraCentro"><%=vsopcion%></a></td>
		</tr>
		<%
		rs.MoveNext
	loop
	Rs.Close
	set Rs =nothing
		end if	' verifica que tenga funciones asignadas
end if
PubRs.Close
set Pubrs=nothing ' verifica la existencia de publicaicones asignadas al usuario  %>
  <tr> <td>&nbsp;</td> </tr>
  <tr><td class="LineaSeparadora"></td></tr>
  <tr> 
    <td class="CabeceraTabla"><a href="../Default.asp?M=x"><img src="../image/salir.gif" border="0" vspace="1" hspace="1" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>Salir</b></font></a></td>
  </tr>
  <tr><td class="LineaSeparadora"> </td></tr>
</table>
</body>
</html>
