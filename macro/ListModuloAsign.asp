<!--#include file="../include/asp/conn.asp"-->
<%
set conn=Server.CreateObject("adodb.Connection")
conn.Open constr
codpub=request("codpub")
function nombrePub(cod)
	nsql="select nom_publicacion from publicacion where cod_publicacion="& cod
	set rs=conn.Execute(nsql)
	if not rs.eof then
		NombrePub=trim(rs(0))
	else
		NombrePub=""
	end if
	rs.close
	set rs=nothing
end function

function SacaEnlace(enlace,COD)
	sacaenlace=replace(enlace,"[CODPUB]",COD)

end function

%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD><LINK rel="stylesheet" type="text/css" href="../include/Css/Stilo.css">
<BODY>

<table cellpadding="2"  cellspacing="2" width="95%" border="0">
<tr class="Titulo">
<td colspan="2" align="center"> Lista de Modulos activados para la publicacion <%=NombrePub(codpub)%></td>
</tr>
<tr><td colspan="2" class="LineaSeparadora"></td></tr>

<tr class="CabeceraTabla">
<td>Modulos</td>
<td>Enlaces de acceso</td>
</tr>
<tr><td colspan="2" class="LineaSeparadora"></td></tr>

<%
strsql="select a.nom_modulo, a.des_comando1 from modulo a , publicacionmodulo b " & _
		" where a.cod_modulo=b.cod_modulo and b.cod_publicacion="&codpub
Set rs= conn.execute(strsql)
if not rs.eof then
do while not rs.eof
%>
<tr class="texto">
<td><%=rs(0)%></td>
<td align="left"><font face="webdings">8</font> <a href="../modulos/<%=SacaEnlace(trim(rs(1)),codpub)%>">Ingresar al modulo <%=rs(0)%></a></td>
</tr>
<tr><td colspan="2" class="LineaSeparadora"></td></tr>

<%
rs.movenext
loop
rs.close
set rs=nothing%>
<%end if%>
<tr><td colspan="2" class="LineaSeparadora"></td></tr>

</table>

</BODY>
</HTML>
