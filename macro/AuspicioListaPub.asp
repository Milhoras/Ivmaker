<!--#include file="../include/asp/conn.asp"-->
<%
icodauspicio=request("icodauspicio")
function NombreAuspicio(cod)
	set rs1= server.CreateObject("adodb.Recordset")
	sql="select nom_auspicio from auspicio where cod_auspicio="& cod
	rs1.open sql, constr
	NombreAuspicio=trim(rs1(0))
	rs1.close
	set rs1=nothing
end function
 if request("accion")<>"" then
 set conn= server.CreateObject("adodb.Connection")
 conn.open constr
	for key= 1 to request("maxcontador")
		if request("icodpublicacion"& key)<>"" then
			sql="update publicacion set cod_auspicio="&icodauspicio & _
			    " where cod_publicacion=" & request("hdncodigo"& key)
		'Response.Write(sql & "<br>")
		conn.execute(sql)
		end if		
		if request("liberar"&key)<>"" then
			sql="Update publicacion set cod_auspicio=null where cod_publicacion="&request("hdncodigo"&key)
			'Response.Write(sql & "<br>")
			conn.execute(sql)
		end if
	next
conn.Close
set conn=nothing
  end if


%>
<html>
<head>
<title>Lista de Publicaciones a auspiciar</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../include/Css/Stilo.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<form name="form1" method="post" action="<%=Request.ServerVariables("url")%>">
<input type="hidden" name="icodauspicio" value="<%=icodauspicio%>">
  <table width="85%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td colspan="4" class="Titulo" align="center"> 
        Lista de publicaciones a la que se le va asignar el asupicio:
         "<i><%=NombreAuspicio(icodauspicio)%></i>"
      </td>
    </tr>
<%set Rs= SErver.CreateObject("adodb.Recordset")
strsql="select cod_publicacion, nom_publicacion,cod_auspicio from publicacion order by 2"
rs.open strsql,constr
if not rs.EOF then
%>
    <tr> 
      <td class="CabeceraTabla">Publicacion</td>
      <td class="CabeceraTabla"> Auspiciado por</td>
      <td class="CabeceraTabla"> Asignar</td>
      <td class="CabeceraTabla"> Liberar</td>
    </tr>
    <tr> 
      <td class="LineaSeparadora" colspan="4"></td>
    </tr>
    <%do while not rs.eof
    i=i+1
    icodpublicacion=rs(0)
    snompublicacion=rs(1)
    icodasignado=rs(2)
    %>
    <tr> 
      <td class="texto" align="left"><%=snompublicacion%></td>
      <td class="texto" align="center">
      <%if icodasignado<>"" then
      Response.Write(NombreAuspicio(icodasignado))
      else
      Response.Write("Libre")
      end if%></td>
      <td class="texto" align="center"> 
        <input type="checkbox" name="icodpublicacion<%=i%>" value="<%=icodpublicacion%>">
        <input type="hidden" name="hdncodigo<%=i%>" value="<%=icodpublicacion%>"> 
      </td>
      <td align="center">
          <input type="checkbox" name="liberar<%=i%>" value="<%=icodpublicacion%>">
      </td>
    </tr>
    <tr> 
      <td class="LineaSeparadora" colspan="4"></td>
    </tr>
    <%rs.MoveNext
    loop%>
    <tr> 
      <td colspan="4" class="CabeceraTabla" align="center"> 
		  <input type="hidden" name="maxcontador" value="<%=i%>">
          <input type="submit" name="accion" value="Asignar">
		  <input type="button" name="Volver" value="volver" onclick="location.href='AsignaAuspicioPub.asp'">
      </td>
    </tr>
    <%else%>
    
    
    <%end if
    rs.Close
    set rs=nothing%>
  </table>
</form>
</body>
</html>
