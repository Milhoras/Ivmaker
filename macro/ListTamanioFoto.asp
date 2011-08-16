<!--#include file="../include/asp/conn.asp"-->
<!--VALIDALOGIN-->
<html>
<head>
<title>Relacion de Temaes</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../include/css/Stilo.css" type="text/css">
</head>
<%

	Set conn = server.CreateObject("adodb.Connection")
	Conn.open constr

if request("M")="E" then
	conn.Execute("delete TamanioFotoPublicacion where cod_tamanio="&request("icodtamanio"))
	conn.execute("delete TAmanioFoto where cod_Tamanio="& request("icodTamanio"))
	
end if

if request("Accion")<>"" and request("MaxContador")>0 then
	For Key = 1 to request("MaxContador")
		fActivo=request("chkActivo"& key)	
		icodtamanio=request("hdnCodigoTamanio"& key)
		if factivo<>"" then
			sql="update TamanioFoto set est_Activo='1' where cod_tamanio="& iCodTamanio
		else
			sql="Update TamanioFoto Set Est_activo='0' where cod_tamanio="& icodTamanio		
		end if
		conn.execute(sql)
	next
end if%>
<%
	StrSQl="Select cod_Tamanio,des_tamanio,est_Activo from tamanioFoto order by 2 asc"
Set Rs= Conn.Execute(StrSQl)%>
<script language="JavaScript1.2" src="../Include/Js/Tooltip.js"></script>
<script language="JavaScript1.2" src="../Include/Js/fConfirmAction.js"></script>

<div id="tooltip" style="position:absolute;visibility:hidden;"></div>
<body bgcolor="#FFFFFF" text="#000000">
<form action="<%=Request.ServerVariables("URl")%>" method="post">
<table width="450" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr align="center">
    <td colspan="4" class="Titulo">Lista de Tamaños de Fotos en el sistema </td>
  </tr>
  <tr>
    <td class="Titulo">Ancho</td>
    <td class="Titulo" align="center">Modificar</td>
    <td class="Titulo" align="center">Activar</td>
    <td class="Titulo" align="center">Borrar</td>
  </tr><tr>
    <td colspan="4" class="LineaSeparadora"></td>
  </tr>
  <%iContador=0
  do while not rs.eof
  iCodTamanio=rs(0)
  sDesTamanio=rs(1)
  factivo=rs(2)
  iContador=iContador+1
  %>
  <tr>
    <td colspan="4" class="LineaSeparadora"></td>
  </tr>
  <tr class="texto">
    <td ><%=sDesTamanio%> </td>
      <td align="center"><a href="EditTamanioFoto.asp?M=M&iCodTamanio=<%=iCodTamanio%>" class="texto" onMouseover="showtip(this,event,'Modifica datos del Tema <%=replace(ucase(trim(sDesTamanio)),"'","\'")%>')" onMouseout="hidetip()">Modificar</a></td>
      <td align="center">
		<input type="checkbox" name="chkActivo<%=iContador%>" value="1" <%if factivo=1 then%>checked<%end if%>>
		<input type="hidden" name="hdnCodigoTamanio<%=iContador%>" value="<%=iCodTamanio%>">
		</td>
      <td align="center"><a href="JavaScript:fConfirmAction('ListTamanioFoto.asp?M=E&iCodTamanio=<%=iCodTamanio%>', 'Desea Eliminar el registro?')" class="texto" onMouseover="showtip(this,event,'Elimina los datos del Tema <%=ucase(trim(sDesTamanio))%> ')" onMouseout="hidetip()" >Borrar</a></td>
  </tr>

  <%rs.movenext
  loop
  rs.close
  set rs=nothing
  conn.Close
  set conn =nothing
  %>
  <tr>
    <td colspan="4" class="LineaSeparadora">
    <input type="hidden" name="MaxContador" value="<%=iContador%>">
    </td>
  </tr><tr>
    <td colspan="4" class="LineaSeparadora"></td>
  </tr>
  
  <tr>
    <td  class="texto">
		<input type="button" name="Crea" value="Crear Nuevo" onclick='location.href="EditTamanioFoto.asp?M=N"'></td>
    <td></td><td></td>
    <td><%IF cint(iContador)>0 then%>
		<input type="submit" name="Accion" value="Activar/DesActivar">
		<%end if%>
	</td>
    
  </tr>
</table>
</form>

</body>


</html>