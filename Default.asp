<%session.Timeout= 60%>
<html>
<head>
<title>Sistema Ivmaker / elcomercioperu.com</title>
		<meta http-equiv="pragma" content="no-cache"/>
		<meta http-equiv="expires" content="0"/>
		<LINK REL="SHORTCUT ICON" HREF="/favicon.ico">
</head>

<%
fsalir=session("fsalir")
if fSalir="" or fsalir="SI" or request("M")="x" then
session("fsalir")="SI"%>
<!--#include file="./include/asp/conn.asp"-->
<%
if request("accion")<>"" then
	set Rs = server.CreateObject("adodb.recordset")
	strsql="select cod_usuario from usuario where des_usuario='"&request("user")&"' and des_clave='"&request("pass")&"'"
	rs.open strsql, constr
	if rs.eof then
		Mensaje="Los datos ingresados no corresponden a ningun usuario, reintente"
	else
		session("coduser")=rs(0)
		session("fsalir")="NO"
		page="default.asp"
		response.redirect(page)
	end if
end if

%>
<script>
function framebreak()
{
  if (top.location != self.location)
    top.location.href = self.location.href
}
framebreak();
</script>
<body bgcolor="#FFFFFF" >
<%select case request("T")
case "S"
mensaje="La session a caducado por favor vuelva a ingresar"
end select%>
<basefont face="verdana" size="2"> 
<form name="form1" method="post" action="<%=Request.servervariables("url")%>">

          <table width="355" border="0" cellspacing="0" cellpadding="2" align="center">
            <tr bgcolor="#333333"> 
              <td>
                <table width="350" border="0" cellspacing="2" cellpadding="4" align="center" bgcolor="#FFFFFF">
                  <tr align="center"> 
                    <td colspan="2" align=center> 
                      Validación                       de Ingreso
                    </td>
                  </tr>
                  <tr align="center"> 
                    <td align="right"><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2">usuario</font></b></td>
                    <td>  
                      <input type="text" name="user" size="15" maxlength="15">
                    </td>
                  </tr>
                  <tr align="center"> 
                    <td align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"> <b>password</b> </font></td>
                    <td> 
                      <input type="password" name="pass" size="15" maxlength="15">
                     </td>
                  </tr>
                  <tr align="center" bgcolor="#000000"> 
                    <td colspan="2"> <input type="image" name="imgIngresar" src="./Image/bot_ingresar.GIF" width="96" height="29" border="0"/>
                    <input type="hidden" name="accion" value="Ingresar"></td>
                  </tr>
<%if Trim(mensaje)<>"" then%>
					<tr align="center">
						<td colspan="2">
							<b><font color="#FF0000" 
							face="Verdana, Arial, Helvetica, sans-serif" size="2"><%=mensaje%></font></b>
						</td>
					</tr>
<%end if%>
                </table>
              </td>
            </tr>
          </table>
</form>

<%else%>
<frameset cols="184,*" rows="*"> 
  <frame src="macro/Menu.asp" name="fraMenu" marginwidth="0" marginheight="0" frameborder="NO">
  <frame src="macro/centro.asp" name="fraCentro" marginwidth="0" marginheight="0" scrolling="AUTO" frameborder="NO" bordercolor="#66CCCC">
</frameset>
<noframes>
	<body bgcolor="#FFFFFF" text="#000000">

	</body>
</noframes>

<%end if%>
</html>
