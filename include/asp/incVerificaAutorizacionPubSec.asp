<%'Funci�n para sacar si el usuario tiene permiso de acceder a la publicaci�n o secci�n
	'Argumentos: C�digo usuario, C�digo publicaci�n, C�digo secci�n, string de conexion
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
<%'Verificar que no visiten esta p�gina sin autorizaci�n a la publicaci�n o secci�n
	'Para que esta p�gina funcione debe haberse inclu�do la funci�n fTienePermisoPubSec()
	if not fTienePermisoPubSec(Session("coduser"), Request.QueryString("CodPub") _
	, Request.QueryString("CodSec"), constr) then
		pMensaje "Usted no est� autorizado a accesar a esta publicaci�n o secci�n", "../default.asp", "_top"
	end if%>
