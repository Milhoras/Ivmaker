<%'Función para sacar si el usuario tiene permiso de acceder a la publicación o sección
	'Argumentos: Código usuario, Código publicación, Código sección, string de conexion
	'Devuelve un valor booleano
	function fTienePermisoPubSec(iCodigoUsuariof, iCodigoPublicacionf, iCodigoSeccionf, sConexionf)
		dim oRsf, sSqlf
		set oRsf= Server.CreateObject("ADODB.Recordset")
		sSqlf= "SELECT cod_perfil FROM usuarioperfil" & _
		" WHERE cod_usuario=" & iCodigoUsuariof & _
		" AND cod_publicacion=" & iCodigoPublicacionf
		if Trim(iCodigoSeccionf)<>"" then sSqlf= sSqlf & _
		" AND cod_seccion=" & iCodigoSeccionf
		oRsf.Open sSqlf, sConexionf
		if not oRsf.EOF then
			fTienePermisoPubSec= true
		else
			fTienePermisoPubSec= false
		end if
		oRsf.Close
		set oRsf= nothing
	end function%>
<%'Verificar que no visiten esta página sin autorización a la publicación o sección
	'Para que esta página funcione debe haberse incluído la función fTienePermisoPubSec()
	if not fTienePermisoPubSec(Session("coduser"), Request.QueryString("CodPub") _
	, Request.QueryString("CodSec"), constr) then
		pMensaje "Usted no está autorizado a accesar a esta publicación o sección", "../default.asp", "_top"
	end if%>
