<%'Función para sacar si el usuario tiene permiso de ejecutar alguna página
	'Argumentos: nombre de la página(sin variables del método get), código del usuario, string de conexion
	'Devuelve un valor booleano
	function fTienePermisoPagina(sNombrePaginaf, iCodigoUsuariof, sConexionf)
		dim oRsf, sSqlf
		set oRsf= Server.CreateObject("ADODB.Recordset")
		sSqlf= "SELECT a.cod_funcion FROM funciones a, perfilfuncion b" & _
		" WHERE a.des_comando like '" & sNombrePaginaf & _
		"%' AND a.est_activo='1' AND a.cod_funcion=b.cod_funcion" & _
		" AND b.cod_usuario=" & iCodigoUsuariof
		oRsf.Open sSqlf, sConexionf
		if not oRsf.EOF then
			fTienePermisoPagina= true
		else
			fTienePermisoPagina= false
		end if
		oRsf.Close
		set oRsf= nothing
	end function%>