<!--#include file="../include/ASP/Conn.asp"-->
<%sub SeleccionaPlantilla(CodigoMaestro,codPlantilla,TipPlantilla)	Strsql="select cod_plantilla, nom_plantilla from plantillas" & _
			" where cod_publicacion="& Codpub & " and est_activo=1" & _
			" and Tip_plantilla='"&TipPlantilla&"'"	Set PRs= Conn.Execute(StrSQl)%>
<select name="cmbName<%=CodigoMaestro%>" size=1 class="largo">
	<option value="0">Seleccionar</option>
	<%Do While Not PRs.EOF%>
	<option value="<%=Prs(0)%>"><%=Trim(PRs(1))%></option>
	<%PRs.MoveNext
	Loop
	set PRs=nothing%>
</select><Script>
	SelectList(document.forms(0).cmbName<%=CodigoMaestro%>,<%=codPlantilla%>);</Script>
<%End Sub%>
<%CodPub=Request("CodPub")Set Conn= Server.CreateObject("Adodb.Connection")Conn.Open constr%>
<%if request("accion")<>"" then strsql="select cod_Seccion from seccion where cod_publicacion="&CodPub& " and est_Activo=1 order by nom_seccion asc"  set Graba=Conn.Execute(strsql)
 do while not graba.eof
 	codSeccion=graba(0)
	codigodePlantillaAsign=request("cmbName"&codSeccion)	sql="Update seccion set cod_plantilla="&codigodePlantillaAsign&" where cod_Seccion="&codSeccion & " and cod_publicacion="&codpub	conn.Execute(sql)
 graba.movenext
 loop
 graba.close
 set graba=nothingend if%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>ASIGNACIÓN DE PLANTILLAS A SECCIONES</title><script src="../include/Js/fSelectList.js"></script><LINK rel="stylesheet" type="text/css" href="../include/Css/Stilo.css">
</head>

<body >
<form ACTION="<%=Request.ServerVariables("URL")%>" name="frmListAsigna" method="POST"><input type="hidden" name="codpub" value="<%=codpub%>">
<table border="0" cellpadding="1"  cellspacing="1" width="550" align="center">
	<tr class="Titulo">
		<td colspan=4 align=center>Asignación de plantillas a las secciones </td>
	</tr>	<tr><td colspan="5" class="LineaSeparadora"></td></tr>    
	<tr class="CabeceraTabla">
	    <td width="10"><b>Nº</b></td>
	    <td width="33%"><b>Secciones</b></td>
	    <td width="20">&nbsp;</td>
	    <td width="34%"><b>Plantillas</b></td>
	</tr>	<tr><td colspan="5" class="LineaSeparadora"></td></tr>    
<%Wcont=1
if codpub<>""  then
sql="select cod_seccion, nom_seccion, cod_plantilla from Seccion" & _
	 " where cod_publicacion="&codpub & " and est_activo=1"  & _
	 " order by nom_seccion asc"
Set rs = conn.Execute(sql)
do while not rs.eof
codsecc=rs(0)
nombre=trim(rs(1))
codplt=rs(2)%>
    <tr class="texto">
        <td width=10><%=wcont%></td>
        <td width="33%"><%=nombre%></td>
        <td width="20%">&nbsp;</td>
        <td width="34%"><%call SeleccionaPlantilla(codsecc,codplt,"S")%></td>
    </tr>    <tr><td colspan="5" class="LineaSeparadora"></td></tr>        
<%
wcont=wcont+1
rs.movenext
loop
rs.close
set rs=nothing%>


<%else%>
	<tr><td colspan=4 class="CabeceraTabla">No ha elegido publicación Todavía </td></tr>
<%end if%>    <tr><td colspan="5" class="LineaSeparadora"></td></tr>        
    <tr class="CabeceraTabla">
        <td align="center" colspan="4">
			<input type="submit"  name="accion" value="Asignar">			<input type="button" name="IR" value="Ingresar nueva Plantilla" onclick="location.href='EditPlantillas.asp?M=N&icodpublicacion=<%=codpub%>'">
			<input type="button" name="IR" value="Lista de Plantillas" onclick="location.href='ListPlantillas.asp?icodpublicacion=<%=codpub%>'">
		</td>
    </tr>

</table>
</form>
</body>
</html>
