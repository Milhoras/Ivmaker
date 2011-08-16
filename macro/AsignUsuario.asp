<!--#include file="../include/ASP/Conn.asp" -->

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<!--enlace a Style Sheet para funcionameinto de la lista de checkbox-->
<LINK rel="stylesheet" type="text/css" href="../include/Css/CheckBoxList.css">
<LINK rel="stylesheet" type="text/css" href="../include/Css/Stilo.css">
<SCRIPT LANGUAGE=Javascript src="../include/Js/fToggleCheckBox.js"></script>
</HEAD>
<BODY bgcolor="#FFFFFF">
<%
iCodUsuario=request("icodusuario")
iNumColsPan="2"
set Conn= server.CreateObject("adodb.Connection")
    conn.Open constr
    'saca nombre de usuario
    set Urs=conn.Execute("select nom_usuario from usuario where cod_usuario="& request("icodusuario"))
    sNomUsuario=urs(0)
    UrS.close
   set Urs=nothing
   
   if request("accion")<>"" then
		icodusuario=request("icodusuario")	
		imaxContador=request("hdnMaxcontador")
		
		 for key= 1 to imaxcontador
			if request("cod"&key)<>"" then
			iCodActivo=request("Cod"&key)
				SqlLock="select cod_perfil from usuarioperfil where cod_usuario="&icodusuario&" and cod_publicacion="&iCodActivo
				set rsLock= conn.Execute(SQLLock)
				if  rslock.eof then
					sql="Insert usuarioperfil (cod_publicacion,cod_usuario) values ("&iCodActivo&","&icodusuario&")"
					conn.Execute(sql)
					SQlSecc="select cod_seccion from seccion where cod_publicacion="& iCodActivo
					set Rs=conn.Execute(SQlSecc)
					do while not Rs.eof
						GrabaSECC="insert usuarioperfil (cod_publicacion,cod_usuario,cod_Seccion) values ("&iCodActivo&","&icodusuario&","&rs(0)&")"
						conn.Execute(GrabaSEcc)
					Rs.Movenext
					loop
					Rs.close
					set rs=nothing
					sqlDefaultFunc="select cod_funcion from funciones f, temafuncion TF where f.est_defecto='1' and f.cod_tema=tf.cod_tema and tf.tip_tema='P'"
					set rs= conn.Execute(sqlDefaultFunc)
					do while not rs.eof
					icodfuncion=rs(0)
					conn.execute("insert perfilfuncion (cod_funcion,cod_usuario,cod_publicacion) values("&icodfuncion&","&icodusuario&","&icodActivo&")")
					rs.movenext
					loop
					rs.close
					set rs=nothing
				end if
				if cint(session("coduser"))=cint(icodusuario) then
				%>
				<script>
					parent.frames[0].location.reload();
				</script>
				<%
				end if
			else
				iCodDesactivado	=request("hdnCodigo"&key)
				if icoddesactivado<>"" then
				sql="delete usuarioperfil where cod_usuario="&icodusuario& " and cod_publicacion="&icodDesactivado
				Conn.execute(sql)
				
				sqlFunciones="delete perfilfuncion where cod_usuario="&icodusuario & " and cod_publicacion="&iCodDesactivado &" and cod_funcion in (select f.cod_funcion from funciones f,temafuncion tf where tf.tip_tema='P'and f.cod_tema=tf.cod_Tema)"
				conn.Execute(sqlfunciones)
				end if
				
			end if
		 next
   end if
   
function fMarcaCheckBox(CodPub)    
   ' Devuelve el valor "checked" si la publicacion ya asignada al usuario en la tabla  usuarioPerfil
   Strsq="select cod_perfil from usuarioperfil where cod_usuario="& icodusuario & "and cod_publicacion="& CodPub & " and  cod_Seccion is null"
   set IngresadosRS=Conn.Execute(strsq)
   if  IngresadosRs.eof then
   fMarcaCheckBox=""
   ELSE
	fMarcaCheckBox="Checked"
   END IF
end function   
function fverificaPrevio()    
   ' Devuelve 1 si el el usuario tiene publicaiocnes asignadas al entrar a esta pagina
   Strsq="select cod_perfil from usuarioperfil where cod_usuario="& icodusuario 
   set IngresadosRS=Conn.Execute(strsq)
   if  IngresadosRs.eof then
   fverificaPrevio=0
   ELSE
	fverificaPrevio=1
   END IF
end function 
x=fverificaPrevio 
 
if cint(x)=1 then
 fmuestra=1
 inumColspan="4"
 else
 inumColspan="2"
 end if
%>
<form name=ListPublicaciones method="post" action="<%=Request.ServerVariables("Url")%>">
  <table width="60%"  cellpadding=2 cellspacing=1 border=0 align="center">
    <tr align="center"  class=Titulo> 
      <td colspan="<%=iNumColSpan%>">Asignacion de  publicaciones al usuario <b><%=snomUsuario%></b>
			<input type="hidden" name="icodUsuario" value="<%=icodusuario%>"></td>
    </tr>
    <%strsql="select cod_publicacion,nom_publicacion from PUBLICACION order by 2"
    set Rs=Conn.Execute(strsql) %>
    <tr  class=CabeceraTabla> 
      <td>Publicacion</td>
      <td>Asignar Publicacion</td>
      <%if fMuestra=1 then%>
		<td>Restringir Secciones</td>
		<td>Restringir Permisos</td>
	  <%end if%>
    </tr>
    <tr class="LineaSeparadora"><td colspan="<%=iNumColSpan%>"></td></tr>
    <%if  rs.eof then%>
    <tr  class=PubRow><TD colspan="<%=iNumColSpan%>">No existen datos</td></tr>
    <%else
    Contador=1
    do while not rs.eof
    iCodPublicacion=rs(0)
    sNomPublicacion=trim(rs(1))
    %>
	<tr><td colspan="<%=iNumColSpan%>"> </td> </tr>
    <tr class=<%if fMarcaCheckBox(icodpublicacion)="Checked" then%>PubRows<%else%>PubRow<%end if%>> 
      <td width="60%"><%=sNomPublicacion%></td>
      <td align="center"> 
        <input type="checkbox" name="Cod<%=Contador%>" value="<%=iCodPublicacion%>" onclick="Toggle(this)" <%=fMarcaCheckBox(icodPublicacion)%>>
        <input type="hidden" name="hdnCodigo<%=contador%>" value="<%=iCodPublicacion%>">
      </td>
      <%if fMuestra=1 and fMarcaCheckBox(icodPublicacion)="Checked" then%>
      <td align="center"><font size="1"><a href="AsignSecc.asp?icodUsuario=<%=icodUsuario%>&icodPublicacion=<%=icodPublicacion%>">Restringir Secciones</a></font></td>
      <td align="center"><font size="1"><a href="AsignFunccion.asp?icodUsuario=<%=icodUsuario%>&icodPublicacion=<%=icodPublicacion%>">Restringir Permisos</font></td>
      <%end if%>
    </tr>
	<tr class="LineaSeparadora"><td colspan="<%=iNumColSpan%>"></td></tr>
     <%
     contador=contador+1
     rs.movenext
    loop
    %>
    <tr align="center"> 
      <td colspan="<%=iNumColSpan%>"> 
      <input type="hidden" name="hdnMaxContador" value="<%=Contador%>">
        <input type="submit" name="accion" value="Asignar">
		<input type="button" name="volver" value="Volver" onclick='location.href="ListUsuarios.asp"'>
      </td>
    </tr>
    <%end if			' fin del if que verifica que el RS tenga datos
    rs.close
    set rs=nothing
    conn.Close
    set conn =nothing
    %>
    <tr><td colspan="<%=iNumColSpan%>" class="PubRow">
    <font size="1">
     Nota: al seleccionar una publicacion por defecto se seleccionaran todas sus secciones y todos sus permisos, 
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     si desea restringir siga los enlaces especificos
     </font></td></tr>
    </table>
</form>

</BODY>
</HTML>
