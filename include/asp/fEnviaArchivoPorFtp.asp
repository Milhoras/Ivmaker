<%'Función que envía un archivo vía ftp
	function fEnviaArchivoPorFtp(sRutaLocal_, sRutaRemota_, iCodigoServidor_, oConn_)
		dim oFtp, oRsFtp, bOk
		const t_bin= 2
		
		set oRsFtp= Server.CreateObject("ADODB.Recordset")		
		oRsFtp.Open "SELECT des_ipdireccion, des_usuario, des_clave" & _
			" FROM servidores WHERE cod_servidor=" & iCodigoServidor_, oConn_
		if not oRsFtp.EOF then
			set oFtp= Server.CreateObject("AspInet.FTP")
			bOk= oFtp.FTPPutFile(Trim(oRsFtp("des_ipdireccion")), _
				Trim(oRsFtp("des_usuario")), Trim(oRsFtp("des_clave")), _
				sRutaRemota_, sRutaLocal_, t_bin)
			set oFtp= nothing
		else
			bOk= false
		end if
		oRsFtp.Close
		set oRsFtp= nothing
		fEnviaArchivoPorFtp= bOk
	end function
%>
