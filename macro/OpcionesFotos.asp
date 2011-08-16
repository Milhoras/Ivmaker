<!--#include file="../include/asp/Conn.asp"-->
<%icodpublicacion=request("iCodPublicacion")%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" type="text/css" href="../include/Css/Stilo.css">
</HEAD>
<BODY>
<%if request("Mode")="" then%>
<form action="<%=Request.ServerVariables("URL")%>" method="post" name="frmCargaFotos" id="frmCargaFotos">
  <table width="480" border="0" align="center" cellpadding="2" cellspacing="0">
    <tr align="center" class="CabeceraTabla"> 
      <td colspan="2">Configurar carga de fotos para el Ivmaker 
        <input name="Mode" type="hidden" id="Mode" value="E">
        <input type="hidden" name="icodpublicacion" value="<%=icodpublicacion%>">
        </td>
    </tr>
    <tr><td  colspan="2" Class="LineaSeparadora"> </td></tr>
    <tr class="texto"> 
      <td>Numero de 
        fotos a cargar:</td>
      <td> 
        <input name="NumFotos" type="text" id="NumFotos" size="3" maxlength="2">
        </td>
    </tr>
    <tr><td  colspan="2" Class="LineaSeparadora"> </td></tr>
<tr class="texto"> 
      <td colspan="2">Tama&ntilde;o 
        de las fotos a cargar:&nbsp; 
      </td>
</tr>
<tr><td  colspan="2" Class="LineaSeparadora"></td></tr>
    <tr class="texto"> 
    <td></td>
      <td> 
        <input type="radio" name="tamano" value="O">
        Tama&ntilde;o 
        Original (sube las fotos del mismo tamaño actual)</td>
    </tr>
    <tr><td  colspan="2" Class="LineaSeparadora"> </td></tr>
    
<%Set  RS= Server.CreateObject("Adodb.recordset")
strsql="select  des_tamanio from tamaniofoto order by des_tamanio asc"
rs.open strsql, constr
if not rs.EOF then
do while not rs.EOF
numValue=trim(rs(0))
%>  
    <tr class="texto"> 
    <td></td>
      <td> 
        <input name="tamano" type="radio" value="<%=numValue%>" checked>
        Dos tama&ntilde;os 
        original y , <%=numValue%> pixels)</td>
    </tr>
    <tr><td  colspan="2" Class="LineaSeparadora"> </td></tr>
<%rs.MoveNext
loop
rs.Close
set rs=nothing%>
<%end if%>    
    
    <tr align="center" Class="CabeceraTabla"> 
      <td colspan="2"> 
        <input name="accion" type="submit" id="accion"  value="Proceder a la carga">
      </td>
    </tr>
    <tr><td  colspan="2" Class="LineaSeparadora"> </td></tr>
<tr class="texto"><TD colspan="2" align="center" bgcolor="#eef3fb"> Las imagenes en formato ".GIF", solo pordar ser cargadas la servidor en tamaño original<br>
los archivos de este formato no podran ser reducidos mediante esta herrramienta.</TD></tr>
 
  </table>
</form>


<%else
numfotos=request("numfotos")
tamano=request("tamano")

%>
<form ACTION="CargaFotos.asp" ENCTYPE="MULTIPART/FORM-DATA" METHOD="POST" id=form1 name=form1>
  
  <table WIDTH="480" border="0" cellpadding="1" cellspacing="0" align="center">
    <tr class="CabeceraTabla"> 
      <td colspan="2" ALIGN="center" VALIGN="TOP">
          <%if cint(numfotos)>1 then
	strboton="SUBIR FOTOS"%>
          seleccionar los archivos y presione "Subir fotos" 
          <%else
	strboton="SUBIR FOTO"%>
          Seleccione el archivo y presione "Subir foto" 
          <%end if%>
          </strong></p></td>
<tr><td class="texto" colspan="3" align="center">          
       posteriormente las imagenes 
           estaran disponibles en la edici&oacute;n de la nota</td>
    </tr>
    <%
contador=1
do while cint(contador)<=cint(numfotos)
%>
    <tr> 
      <td class="texto" width="30%"><%=contador%><sup>a </sup>Foto </td>
      <td ALIGN="LEFT">
        <input TYPE="FILE" NAME="FILE<%=contador%>">
        </td>
    </tr>
    <tr><td  colspan="2" Class="LineaSeparadora"> </td></tr>

    <%contador=contador+1
loop%>
    <tr> 
      <td colspan="2" ALIGN="center" >
<input type="hidden" name="icodpublicacion" value="<%=icodpublicacion%>">
<input type="hidden" name="tamano" value="<%=tamano%>">
<input type="hidden" name="numfotos" value="<%=numfotos%>">
<input TYPE="SUBMIT" NAME="SUB1" VALUE="<%=strboton%>">
        </td>
    </tr>
  </table>
</form>

<%end if %>

</BODY>
</HTML>

