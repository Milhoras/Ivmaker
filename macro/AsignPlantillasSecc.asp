<!--#include file="../include/ASP/Conn.asp"-->
<%sub SeleccionaPlantilla(CodigoMaestro,codPlantilla,TipPlantilla)
			" where cod_publicacion="& Codpub & " and est_activo=1" & _
			" and Tip_plantilla='"&TipPlantilla&"'"
<select name="cmbName<%=CodigoMaestro%>" size=1 class="largo">
	<option value="0">Seleccionar</option>
	<%Do While Not PRs.EOF%>
	<option value="<%=Prs(0)%>"><%=Trim(PRs(1))%></option>
	<%PRs.MoveNext
	Loop
	set PRs=nothing%>
</select>
	SelectList(document.forms(0).cmbName<%=CodigoMaestro%>,<%=codPlantilla%>);
<%End Sub%>


 do while not graba.eof
 	codSeccion=graba(0)
	codigodePlantillaAsign=request("cmbName"&codSeccion)
 graba.movenext
 loop
 graba.close
 set graba=nothing
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>ASIGNACI�N DE PLANTILLAS A SECCIONES</title>
</head>

<body >
<form ACTION="<%=Request.ServerVariables("URL")%>" name="frmListAsigna" method="POST">
<table border="0" cellpadding="1"  cellspacing="1" width="550" align="center">
	<tr class="Titulo">
		<td colspan=4 align=center>Asignaci�n de plantillas a las secciones </td>
	</tr>
	<tr class="CabeceraTabla">
	    <td width="10"><b>N�</b></td>
	    <td width="33%"><b>Secciones</b></td>
	    <td width="20">&nbsp;</td>
	    <td width="34%"><b>Plantillas</b></td>
	</tr>
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
    </tr>
<%
wcont=wcont+1
rs.movenext
loop
rs.close
set rs=nothing%>


<%else%>
	<tr><td colspan=4 class="CabeceraTabla">No ha elegido publicaci�n Todav�a </td></tr>
<%end if%>
    <tr class="CabeceraTabla">
        <td align="center" colspan="4">
			<input type="submit"  name="accion" value="Asignar">
			<input type="button" name="IR" value="Lista de Plantillas" onclick="location.href='ListPlantillas.asp?icodpublicacion=<%=codpub%>'">
		</td>
    </tr>

</table>
</form>
</body>
</html>