<%
'-------------------------------------------------------------------------------*
' Esta funcion debe recibir el valor de las session("coduser")           * 
'   si la session no existe redirecciona a la pagina de Login con parametro M=F *
' ese parametro en la pagina de Login mostrara el mensaje de Session vencida    *
' Autor Ivan Aguilar Rojas                            05/Febrero/2003           *
'-------------------------------------------------------------------------------*
Sub fvalidaLogin(iCodUserLogged)
 if iCodUserLogged="" then
	Response.redirect("../default.asp?M=F&T=S")
 end if
end Sub

%>