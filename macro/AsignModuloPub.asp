<!--#include file="../include/asp/conn.asp"-->
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<LINK rel="stylesheet" type="text/css" href="../include/Css/Stilo.css">
<%Set Conn= Server.CreateObject("Adodb.Connection")
conn.Open constr

sub PintaModulos()
	strsql="select nom_modulo from modulo where est_Activo=1 order by 1 asc"
	set Mrs=Conn.Execute(strsql)%>
	<table cellpadding=2 cellspacing=2 border=0 WIDTH="100%"><tr class="CabeceraTabla">
	<%do while not mrs.eof%>
	<td align="center"><%=trim(Mrs(0))%></td>
	<%mrs.movenext
	loop
	%>
	</tr></table>
	<%mrs.close
	set mrs=nothing
end sub

sub PintacheckModulos(codpub)
	strsql="select cod_modulo from modulo where est_Activo=1 order by nom_modulo asc"
	set Mrs=Conn.Execute(strsql)%>
	<table cellpadding=2 cellspacing=2 border=0 WIDTH="100%"><tr class="Texto">
	<%do while not mrs.eof%>
		<td ALIGN="CENTER"><input type="checkbox" name="Mod<%=Codpub%>" value="<%=Mrs(0)%>" <%=PintaSelected(codpub,mrs(0))%>></td>
	<%mrs.movenext
	loop
	%>
	</tr></table>
	<%mrs.close
	set mrs=nothing
end sub

function PintaSelected(intcodpub,intcodMod)
	sql="select cod_modulo from publicacionmodulo where cod_publicacion="& intCodPub & _
		" and cod_modulo=" & intCodMod
	set rs=conn.Execute(sql)
	if not rs.eof then
		PintaSelected="checked"
	else
		PintaSelected=""
	end if
	rs.close
	set rs=nothing
end function


if request("accion")<>"" then
sql="delete PublicacionModulo "
conn.Execute(sql)
	for each Pub in request("codPub")
		for each item in request("mod"&Pub)
			sql="Insert PublicacionModulo (cod_publicacion,cod_Modulo)" & _
				" values("&pub&","&item&")"
			conn.Execute(sql)
		next
	next
	

end if


%>
<BODY>
<form action="" method="post">
<table cellpadding="2" cellspacing="2" border="0" width="95%" align="center">
<tr>
<td colspan="2" class="Titulo" align="center"> Asignacion de Módulos a las Publicaciones</td>
</tr>
<tr class="CabeceraTabla">
<td align="center" rowspan="2">Lista de publicaciones</td>
<td align="center">Modulos disponibles</td>
</tr>
<tr  class="CabeceraTabla"><td align="center"><%call PintaModulos()%></td></tr>
<tr class="LineaSeparadora" ><td colspan="2"></td></tr>

<%
strsql="select cod_publicacion , nom_publicacion from publicacion where est_activo='1' order by 2 asc"
Set Prs= conn.execute(StrSql)
if not PRs.eof then
do while not Prs.eof%>
<tr class="texto">
<td width="30%"> <%=trim(Prs(1))%><input type="hidden" name="codpub" value="<%=Prs(0)%>"></td>
<td align="center" width="70%"><%call PintaCheckModulos(Prs(0))%> </td>
</tr>
<tr class="LineaSeparadora" ><td colspan="2"></td></tr>
<%Prs.movenext
loop
Prs.close
set Prs=nothing

else%>
<tr colspan="2"> No existen Publicaciones creadas</tr>
<%end if%>
<tr class="CabeceraTabla">
<td colspan="2" align="center"><input type="submit" name="accion" value="Asignar"></td>
</tr>
</table>
</form>
<%conn.Close
set conn=nothing%>
</BODY>
</HTML>
