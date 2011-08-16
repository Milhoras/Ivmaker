<!--#include file="../include/asp/conn.asp"-->
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" type="text/css" href="../include/Css/Stilo.css">
<%
	Set Conn= Server.CreateObject("adodb.Connection")
	Conn.open ConStr

sub Tamanios(codpub)
	strsql="select cod_tamanio,des_tamanio from tamanioFoto where est_Activo='1' order by 2 asc"
	set Trs = conn.execute(Strsql)
	if not Trs.eof then
	Response.Write("<table cellpadding=0 cellspacing=0 border=0 width=""100%""><tr class=""Texto""><td>")
	do while not trs.eof %>
		<%=trim(trs(1))%><input type="checkbox" name="Size<%=codpub%>" value="<%=trs(0)%>" <%=MarcaTamanio(codpub,Trs(0))%>>&nbsp;
	<%trs.movenext
	loop
	Response.Write("</td></tr></table>")
	trs.close
	set trs=nothing
	else
	Response.Write("No hay tamaños ingresados en el sistema")	
	end if
end sub


sub defecto(codPub)
	strsql="select cod_tamanio,des_tamanio from TamanioFoto where est_Activo='1' order by 2 asc"
	set drs = conn.execute(strsql)
	if not drs.eof then
		Response.Write("<select name=""defecto"&codpub&""" size=""1""><option> Seleccionar</option>")
		do while not drs.eof %>
		<option value="<%=drs(0)%>"	<%=MarcaDefecto(codpub,drs(0))%>><%=trim(drs(1))%></option>
		<%drs.movenext
		loop
		drs.close
		set drs=nothing
		Response.Write("</select>")
	else
		response.write("No hay tamanos ingresados en el sistema")
	end if
end sub

sub amplia(codpub)
	strsql="select cod_tamanio,des_tamanio from TamanioFoto where est_Activo='1' order by 2 asc"
	set ars = conn.execute(strsql)
	if not ars.eof then
		Response.Write("<select name=""Amplia"&codpub&""" size=""1""><option> Seleccionar</option>")
		do while not ars.eof %>
		<option value="<%=ars(0)%>"	<%=MarcaAmplia(codpub,ars(0))%>><%=trim(ars(1))%></option>
		<%ars.movenext
		loop
		ars.close
		set ars=nothing
		Response.Write("</select>")
	else
		response.write("No hay tamanos ingresados en el sistema")
	end if
end sub

function MarcaTamanio(codpub,codtamanio)
	strsql="select cod_tamanio from tamanioFotoPublicacion where cod_publicacion ="&codpub&" and cod_tamanio="&codtamanio
	Set Mrs= Conn.execute(strsql)
	if not mrs.eof then
		MarcaTamanio="Checked"
	else
		MarcaTamanio=""
	end if
	Mrs.close
	set Mrs=nothing
end function


function MarcaDefecto(codpub, codtamanio)
	strsql="select est_defecto from TamanioFotoPublicacion where cod_publicacion="&codpub&" and cod_tamanio="&codtamanio
	
	Set Nrs=conn.execute(strsql)
	if not nrs.eof  then
		if nrs(0)="1" then	Marcadefecto="selected"
	else
		Marcadefecto=""
	end if
	nrs.close
	set nrs=nothing
end function
function MarcaAmplia(codpub, codtamanio)
	strsql="select est_ampliable from TamanioFotoPublicacion where cod_publicacion="&codpub&" and cod_tamanio="&codtamanio
	Set Zrs=conn.execute(strsql)
	if not Zrs.eof  then
		if Zrs(0)="1" then	MarcaAmplia="selected"
	else
		MarcaAmplia=""
	end if
	Zrs.close
	set Zrs=nothing
end function


if request("Accion")<>"" then
	for each item in request("codpub")
		valdefecto = request("defecto"&item)
	    valAmplia = request("amplia"&item)
		sql="delete TamanioFotoPublicacion where cod_publicacion="&item
		conn.Execute(sql)
		for each key in request("size"&item)
			sql="insert TamanioFotoPublicacion (cod_publicacion,cod_tamanio) values ("&item&","&key&")"
			if valdefecto=key then okDefecto=key
			if valamplia=key then okAmplia=key
			conn.Execute(sql)
		next
		if okdefecto<>"" then
			sql="Update TamanioFotoPublicacion set est_defecto='1' where cod_publicacion="&item & _
				" and cod_tamanio="&okdefecto		
			conn.Execute(sql)
		else
			valErrorDefecto=valErrorDefecto & item &"|"
		end if
		if okamplia<>"" then
			sql="Update TamanioFotoPublicacion set est_ampliable='1' where cod_publicacion="&item & _
				" and cod_Tamanio="&okamplia
			conn.Execute(sql)
		else
			valErrorAmplia= valErrorAmplia & item &"|"
 		end if
		okDefecto=""
		okAmplia=""
	next
end if

sub errordefecto(codpub,StrErrorDefecto)
	StrErrorDefecto = "|" &StrErrorDefecto
	if instr(1,StrErrorDefecto,codpub) >0 then
	Response.Write("<span class=""texto"" onMouseover=""showtip(this,event,'Tamaño escojido no fue asignado a publicacion ')"" onMouseout=""hidetip()"">Error!<font face=webdings size=2>2</font></span>")
	end if
end sub

sub errorAmplia(codpub,StrErrorAmplia)
	StrErrorAmplia = "|" &StrErrorAmplia
	if instr(1,StrErrorAmplia,codpub) >0 then
	Response.Write("<span class=""texto"" onMouseover=""showtip(this,event,'Tamaño escojido no fue asignado a publicacion ')"" onMouseout=""hidetip()"">Error!<font face=webdings size=2>2</font></span>")
	end if

end sub

%>
</HEAD>
<BODY>
<script language="JavaScript1.2" src="../Include/Js/Tooltip.js"></script>
<div id="tooltip" style="position:absolute;visibility:hidden;"></div>
<form action="<%=Request.ServerVariables("URL")%>" method="post"> 
<table width="95%" cellpadding="2" cellspacing="2" border="0" align="center">
	<tr class="Titulo">
		<td align="center" colspan="5">
		Lista de publicaciones
		</td>
	</tr>
	<tr><td class="LineaSeparadora" colspan="5"></td></TR>
	<tr class="CabeceraTabla">
		<td align="center" >publicaciones</td>
		<td colspan="2">Tamaños	</td>
		<td>Tamaño por defecto</td>
		<td>Tamaño enlace a Original</td>
	</tr>
	<tr><td class="LineaSeparadora" colspan="5"></td></TR>
	<%
	strsql="select cod_publicacion,nom_publicacion from publicacion order by 2 asc"
	set rs= conn.execute(strsql)
	if not rs.eof then
	do while not rs.eof %>
		<tr class="texto">
			<td><%=trim(rs(1))%><input type="hidden" name="codpub" value="<%=rs(0)%>"></td>
			<td colspan="2"><%call Tamanios(rs(0))%></td>
			<td align="left"><%call defecto(rs(0))%><font color="red"><%call errordefecto(rs(0),valerrordefecto)%></font></td>
			<td align="left"><%call amplia(rs(0))%><font color="red"><%call erroramplia(rs(0),valerrorAmplia)%></font></td>
		</tr>
		<tr><td class="LineaSeparadora" colspan="5"></td></TR>
	<%rs.movenext
	loop
	rs.close
	set rs=nothing
	else%>
	<tr class="Titulo">
		<td align="center">
			No existen publicaciones en el sistema
		</td>
	</tr>
	<%end if%>
	<tr><td class="LineaSeparadora" colspan="5"></td></TR>
	<tr>
		<td class="CabeceraTabla" colspan="5" align="center">
		<input type="submit" name="accion" value="Asignar"></td>
	</tr>
</table>
</form>
</BODY>
</HTML>
