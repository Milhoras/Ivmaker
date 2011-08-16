<!--#include file="../include/asp/conn.asp"-->
<!--VALIDALOGIN-->
<%session.Timeout=120%>
<%icodpublicacion=request("icodPublicacion")
if request("icodpublicacion")="" then
icodpublicacion=request("codPub")
end if

%>
<html>
<head>
<title>Relacion de Plantillas</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../include/css/Stilo.css" type="text/css">
</head>
<%
if request("M")="E" then
	Set conn = server.CreateObject("adodb.Connection")
	Conn.open constr
	conn.execute("delete Plantillas where cod_Plantilla="& request("icodplantilla"))
	conn.close
	set conn=nothing
end if

if request("hdni")<>"" then
set conn= server.CreateObject("adodb.Connection")
conn.open constr
	for key = 1 to request("hdni")
		if request("chkactivo"&key)="1" then
			sql="Update Plantillas set est_activo='1' where cod_Plantilla="&request("hdncodigo"&key)
		else
			sql="Update Plantillas set est_activo='0' where cod_Plantilla="&request("hdncodigo"&key)
		end if
		conn.execute(sql)
	next
conn.close
set conn =nothing	
end if
%>
<script language="JavaScript1.2" src="../Include/Js/Tooltip.js"></script>
<script language="JavaScript1.2" src="../Include/Js/fConfirmAction.js"></script>
<script language="Javascript">
	function fActualizaOpener() {
		if (opener != null) {
			opener.location.reload();
		}
	}
</script>

<div id="tooltip" style="position:absolute;visibility:hidden;"></div>
<body bgcolor="#FFFFFF" text="#000000" onload="fActualizaOpener()">

<form action="<%=Request.ServerVariables("url")%>" method="post" name="frmListPlantillas">

<table width="450" border="0" cellspacing="1" cellpadding="1" align="center">
  <tr align="center">
    <td ColSpan="4"  class="Titulo">Lista de Plantillas creados en el sistema IvMaker</td>
  </tr>
<%  'Listado
	i= 0
	set Rs= Server.CreateObject("adodb.recordset")
	StrSQl="Select cod_Plantilla,nom_Plantilla,est_Activo from Plantillas where cod_publicacion="&icodpublicacion&" order by 2 asc"
	Rs.Open StrSQl, constr, 1, 1
	if not Rs.EOF then%>

  <tr class="CabeceraTabla">
    <td >Plantillas</td>
    <td  align="center">Modificar</td>
    <td  align="center">Activar</td>
    <td  align="center">Borrar</td>
  </tr><tr>
    <td ColSpan="4"  class="LineaSeparadora"></td>
  </tr>
 <%iTotalRegistros= Rs.RecordCount
		Rs.PageSize= 15 ' Número de registros por página 
		sScrollAction= Request.form("ScrollAction")
		if sScrollAction<>"" Then
			iNumeroPagina= cint(sScrollAction)
			if iNumeroPagina<1 Then iNumeroPagina= 1
		else
			iNumeroPagina= 1
		end if
		Rs.AbsolutePage= iNumeroPagina
		iTotalPaginas= Rs.PageCount
		iContadorFilas= Rs.PageSize
do while not Rs.EOF and iContadorFilas>0
i=i+1
  icodplantilla=rs(0)
  sNomPlantillas=rs(1)
  factivo=rs(2)
  %>
  <tr class="texto">
    <td  ><%=sNomPlantillas%> </td>
      <td align="center"><a href="EditPlantillas.asp?M=M&icodplantilla=<%=icodplantilla%>&icodpublicacion=<%=icodpublicacion%>" class="texto" onMouseover="showtip(this,event,'Modifica datos del Plantillas <%=replace(ucase(trim(sNomPlantillas)),"'","\'")%>')" onMouseout="hidetip()">Modificar</a></td>
      <td align="center">
		<input type="checkbox" name="chkactivo<%=i%>" value="1" <%if factivo="1" then%>Checked<%end if%>>
		<input type="hidden" name="hdncodigo<%=i%>" value="<%=icodplantilla%>">				
      </td>
      <td align="center"><a href="JavaScript:fConfirmAction('ListPlantillas.asp?M=E&icodplantilla=<%=icodplantilla%>&icodpublicacion=<%=icodpublicacion%>', 'Desea Eliminar el registro?')" class="texto" onMouseover="showtip(this,event,'Elimina los datos del Plantillas <%=replace(ucase(trim(sNomPlantillas)),"'","\'")%> ')" onMouseout="hidetip()" >Borrar</a></td>
  </tr>
<tr>
    <td ColSpan="4"  class="LineaSeparadora"></td>
  </tr>
  <%
 iContadorFilas= iContadorFilas - 1
 rs.movenext
  loop
  rs.close
  set rs=nothing%>
   
   <tr>
    <td ColSpan="4"  class="LineaSeparadora"></td>
  </tr><tr bgcolor="#FFFFFF">
      <td ColSpan="4" valign="middle">
		<table border="0" valign="top" cellpadding="0" cellspacing="0" width="100%">
		<tr>
					<td align="left" valign="top">
						<input type="hidden" name="ScrollAction" value="<%=sScrollAction%>" />
						<input type="hidden" name="PagIni" value="<%=(iPrimeraPagina)%>" />
						<input type="hidden" name="icodpublicacion" value="<%=icodpublicacion%>" />
<%iNumPagLinks= 15  'Numero de Link Por página
iNumPagLinks= iNumPagLinks - 1
iPrimeraPagina = 1
if Request.Form("PagIni") <> "" then iPrimeraPagina = Request.Form("PagIni")
iUltimaPagina = iPrimeraPagina + iNumPagLinks
'  muestra  el grupo inferior de links
if iNumeroPagina > iNumPagLinks and iPrimeraPagina <> 1 then%>
			<a href="javascript:document.frmListPlantillas.ScrollAction.value='<%=(iPrimeraPagina - 1)%>';document.frmListPlantillas.PagIni.value='<%=(iPrimeraPagina-iNumPagLinks)-1%>'; document.frmListPlantillas.submit()" class="paginacion">[<<<]</a>&nbsp;
<%	end if%>
<%	if  iTotalPaginas > 1 then
	for iLinkPage = iPrimeraPagina to iUltimaPagina
	 if iLinkPage <= iTotalPaginas then
	 	if iLinkPage = iNumeroPagina then%>
			<span class="paginacion"><b><%=iLinkPage%></b></span>&nbsp;
<%		else%>
			<a href="javascript:document.frmListPlantillas.ScrollAction.value='<%=iLinkPage%>'; document.frmListPlantillas.PagIni.value='<%=(iPrimeraPagina)%>'; document.frmListPlantillas.submit()" class="paginacion"><%=iLinkPage%></a>&nbsp;
<%		end if
	 end if
	next
end if%>
<%'Muestra el grupo superior de links
if iTotalPaginas>iNumPagLinks and iUltimaPagina<iTotalPaginas then%>
			<a href="javascript:document.frmListPlantillas.ScrollAction.value='<%=iLinkPage%>';document.frmListPlantillas.PagIni.value='<%=(iUltimaPagina+1)%>'; document.frmListPlantillas.submit()" class="paginacion">[&gt;&gt;&gt;]</a>
<%	end if%>
					</td>
					<td align="right" valign="top">
						<span class="paginacion">Total páginas <%=iTotalPaginas%></span>
					</td>
				</tr>
			</table>
		</td>
	</tr>
<%else%>
			<tr bgcolor="#FFFFFF">
				<td valign="middle" align="center" class="texto" ColSpan="4">
					Por el momento no existen plantillas registradas
				</td>
			</tr>
<%end if
'	Rs.Close
'	set Rs= nothing%>
<tr><td ColSpan="4"  class="LineaSeparadora"></td></tr>
			<tr bgcolor="#FFFFFF">
				<td valign="top" colspan="<%if i>0 then%>2<%else%>4<%end if%>">
					<a href="EditPlantillas.asp?M=N&icodpublicacion=<%=icodpublicacion%>" class="texto">Nueva Plantilla</a>
				</td>
<%if i>0 then%>
				<td valign="top" ColSpan="2"  align="right">
					<input type="hidden" name="hdnI" value="<%=i%>" />
					<a href="Javascript:document.frmListPlantillas.submit()" class="texto">Activar/Desactivar</a>
				</td>
<%end if%>
			</tr>
			<tr>
    <td ColSpan="4"  class="LineaSeparadora"></td>
  </tr>
			<tr>
				<td valign="top" colspan="4" align="left">
					<a href="AsignplantillasSecc.asp?codpub=<%=icodpublicacion%>" class="texto">Asignar Plantilla-Seccion</a>
				</td>

			</tr>
			
			</table>

</body>


</html>