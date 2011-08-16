<!--#include file="../include/asp/conn.asp"-->
<html>
<head>
<title>Asignar auspicios a publicaci&oacute;n</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../include/Css/Stilo.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<form name="frmAsignaauspicios" method="post" action="<%=request.servervariables("URL")%>">
  <table width="85%" border="0" cellspacing="2" cellpadding="0" align="center">
    <tr> 
      <td colspan="2" class="Titulo" align="center"> 
        Asignar auspicios a las auspicios
      </td>
    </tr>
<%
Set Rs= Server.CreateObject("adodb.Recordset")
strsql="select cod_auspicio,nom_auspicio from auspicio "& _
		" order by 2"
Rs.Open strsql, Constr
 if not Rs.eof then
 %>
     <tr> 
      <td colspan="2" class="texto" align="center"> 
        Seleccionar auspicio que sera asignado a las portadas de las publicaciones
      </td>
    </tr>
    <tr> 
      <td class="CabeceraTabla">Auspicio</td>
      <td class="CabeceraTabla">Asignar a publicaciones</td>
    </tr>
<%do while not rs.EOF 
icodauspicio=rs(0)
snomauspicio=trim(rs(1))
%>    
    <tr> 
      <td class="texto" align="left"><%=snomauspicio%></td>
      <td class="texto" align="center"><a href="AuspicioListaPub.asp?icodauspicio=<%=icodauspicio%>">ir a</a></td>
    </tr>
    <tr> 
      <td colspan="2" class="LineaSeparadora"> </td>
    </tr>
<%rs.MoveNext
loop%>    
    
    <tr> 
      <td colspan="2"> 
        
      </td>
    </tr>
<%else%>
    <tr> 
      <td class="texto" colspan="2"> No existen auspicios creadas</td>
    </tr>
    <tr> 
      <td colspan="2" class="LineaSeparadora"> </td>
    </tr>
    
<%end if
rs.Close
set rs=nothing
%>
  </table>
</form>
<p>&nbsp;</p>
</body>
</html>
