<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<script src="../Js/fSelectList.js"></script>
<LINK rel="stylesheet" type="text/css" href="../Css/Stilo.css">
<script LANGUAGE="JavaScript">
lck=0;
function r(hval) {
                opener.document.frmTagsEdit.Cadena.value=hval;
}         
</script>
</HEAD>
<BODY>
<form name="frmBaseDatos" action="<%=Request.ServerVariables("Url")%>" method="post">
<table width="60%"  cellpadding="1" cellspacing="1">
<%
sBaseDatos=request("sBaseDatos")
Constr="Provider=SQLOLEDB;Initial Catalog="&sBaseDatos&";Data Source=agurojiv;User ID=sa;Password="
Set Conn= server.createObject("adodb.Connection")
Conn.open constr%>
	 <tr>
      <td class="texto">Base de datos</td>
      <td class="texto"> 
<%wselect = "sp_helpdb"
set bases = conn.execute(wselect)%>
<select name="bases" size="1" onChange="window.open(this.options[this.selectedIndex].value,'_self')">
<option value="selectBdTablaCampo.asp?sBaseDatos=">--SELECCIONAR--</OPTION>
<%do while not bases.EOF%>
	<option value="selectBdTablaCampo.asp?sBaseDatos=<%=trim(bases.Fields.Item(0).Value)%>"><%=bases.Fields.Item(0).Value%></option>
<%bases.MoveNext
loop
bases.Close
set bases = nothing%>
</select>
 <script>
 <%if request("sBaseDatos")="" then%>
SelectList(document.forms(0).bases,'selectBdTablaCampo.asp?sBaseDatos=Ivmaker');
<%else%>
SelectList(document.forms(0).bases,'selectBdTablaCampo.asp?sBaseDatos=<%=sBaseDatos%>');
<%end if%>
</script>

      </td>
    </tr>
    <tr>
      <td colspan="5" class="LineaSeparadora"></td></tr>
<tr>
      <td class="texto">
Tablas de la base de datos      
      </td>
      <td class="texto">
      <%if request("sBaseDatos")<>"" then%>
<%	Set Tablas = Server.CreateObject("ADODB.Recordset")
Set Tablas = conn.OpenSchema(20)%>
<select name="tablas" size="1" onChange="window.open(this.options[this.selectedIndex].value,'_self')">
<option value="SelectBdTablaCampo.asp?sBaseDatos=<%=sBaseDatos%>&strTable=">--Selecccionar Tabla--</option>
<%do while not Tablas.eof
if Tablas("TABLE_TYPE") = "TABLE" then%>
<option value="SelectBdTablaCampo.asp?sBaseDatos=<%=sBaseDatos%>&strTable=<%=trim(Tablas("TABLE_NAME"))%>"><%=Tablas("TABLE_NAME")%></option>
<%end if%>
<%Tablas.Movenext
loop%>
</select>
 <script>
SelectList(document.forms(0).tablas,'SelectBdTablaCampo.asp?sBaseDatos=<%=sBaseDatos%>&strTable=<%=request("strTable")%>');
</script>
<%end if%>
      </td>
    </tr>

    <tr><td colspan="5" class="LineaSeparadora"></td></tr>
<tr>
      <td class="texto">Campos de la tabla</td>
      <td class="texto">
<%strFields = "*"
if request("strTable")<>"" then
strTable=request("strTable")

strsql = "SELECT " & strFields & " FROM " & strTable
set Campos=  Conn.execute(strsql)%>
<select name="campos" size="5"  onChange="window.open(this.options[this.selectedIndex].value,'_self')">
<%intFieldCount = Campos.Fields.Count
	For x = 1 to intFieldCount%>
		<option value="SelectBdTablaCampo.asp?sBaseDatos=<%=sBaseDatos%>&strTable=<%=request("strTable")%>&StrCampo=<%=trim(Campos.Fields(x-1).Name)%>"><%=Campos.Fields(x-1).Name%></option>
	<%Next%>
</select>
<%Campos.close		
set Campos=nothing%>
 <script>
SelectList(document.forms(0).campos,'SelectBdTablaCampo.asp?sBaseDatos=<%=sBaseDatos%>&strTable=<%=request("strTable")%>&StrCampo=<%=request("strCampo")%>');
</script>
<%end if%>
      </td>
    </tr>
   <tr><td colspan="5" class="LineaSeparadora"></td></tr>	
   <tr><td colspan="5"><a HREF="javascript:window.close()"
        onMouseOver="r('<%=sBaseDatos%>|<%=strTable%>|<%=request("strCampo")%>'); return true">Seleccionar </a></td></tr>
   </table>
</form>
</BODY>
</HTML>
