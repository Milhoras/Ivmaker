<%'Mueve el archivo generado a la ruta física que le corresponde 
' o la ruta ftp según sea el caso
'Devuelve un estado del proceso:	"0":no movido;		"1":ftp ok;	"2":ftp no ok;	"2.1": servidor para ftp no ha sido asignado; 
'	"3":mover ok;	"4":mover no ok
function fMueveArchivoGenerado(iCodigoNota, oConn_)
	on error resume next
	dim oRsMueve, sRutaFisica, sRutaFtp, bEstadoProceso _
		, aDirectorios, sDirectorios, i, aDisco, sUrlNota_, oOFS _
		, sUrlPaginaHtml, sSubDirectorioFecha, iCodigoServidor
		
	set oRsMueve= Server.CreateObject("ADODB.Recordset")
	oRsMueve.Open "SELECT a.des_rutaftp, a.des_rutafisica, a.cod_servidor" & _
		" FROM publicacion a, seccion b, notas c" & _
		" WHERE c.cod_nota=" & iCodigoNota & _
		" AND c.cod_seccion=b.cod_seccion" & _
		" AND b.cod_publicacion=a.cod_publicacion", oConn_
	if not oRsMueve.EOF then
		'Trae el nombre de la página generada
		sUrlPaginaHtml= fTraeNombrePagina(iCodigoNota, oConn_)
		sSubDirectorioFecha= fArmaSubDirectorioFecha(iCodigoNota, oConn_)
		'La ruta ftp o ruta física según fuera el caso
		sRutaFtp= Trim(oRsMueve("des_rutaftp"))
		sRutaFisica= Trim(oRsMueve("des_rutafisica"))
	 	iCodigoServidor= oRsMueve("cod_servidor")
	 	sUrlNota_= fUrlNota(iCodigoNota, oConn_)
		if Trim(sRutaFtp)<>"" and not IsNull(sRutaFtp) then
			'Ruta remota
			dim sRutaRemota, sRutaLocal
		 	sRutaRemota= sRutaFtp & "/" & csSubDirectorioHtml & "/" & _
			 	sSubDirectorioFecha & "/" & sUrlPaginaHtml
		 	sRutaLocal= Server.MapPath(".." & sUrlNota_)
		 	'Si no trae código de servidor no irá al ftp
			if not IsNull(iCodigoServidor) then
				bEstadoProceso= fEnviaArchivoPorFtp(sRutaLocal, _
					sRutaRemota, iCodigoServidor, oConn_)
				if bEstadoProceso then
					fMueveArchivoGenerado= "1"
					'Al ser enviado se elimina
					set oOFS= Server.CreateObject("Scripting.FileSystemObject")
					if oOFS.FileExists(sRutaLocal) then oOFS.DeleteFile(sRutaLocal)
					set oOFS= nothing
				else
					fMueveArchivoGenerado= "2"
				end if
			else
				fMueveArchivoGenerado= "2.1"
			end if
		elseif Trim(sRutaFisica)<>"" and not IsNull(sRutaFisica) then
			'Verificar si existe el directorio físico
			aDisco= split(sRutaFisica, ":")
			if UBound(aDisco)>=0 then
				sDirectorios= aDisco(0) & ":\"
				if UBound(aDisco)>0 then
					aDirectorios= Split(aDisco(1), "\")
					for i=0 to UBound(aDirectorios)
						sDirectorios= sDirectorios & aDirectorios(i) & "\"
						pVerificaCreaDirectorio(sDirectorios)
					next
				end if
				'Proceso para mover el archivo generado
				dim sRutaArchivoFuente, sRutaArchivoCopia
				'Colocarle y verificar el subdirectorio de html
				sDirectorios= sDirectorios & csSubDirectorioHtml
				pVerificaCreaDirectorio(sDirectorios)
				'Colocarle y verificar el subdirectorio de la fecha a la que corresponde
				sDirectorios= sDirectorios & "\" & sSubDirectorioFecha
				pVerificaCreaDirectorio(sDirectorios)
				'Arma la ruta del archivo local
				sRutaArchivoFuente= Server.MapPath(".." & sUrlNota_)
				sRutaArchivoCopia= sDirectorios & "\" & sUrlPaginaHtml
				'Arma la ruta del archivo remoto
				'Mover el archivo
				set oOFS= Server.CreateObject("Scripting.FileSystemObject")
				if oOFS.FileExists(sRutaArchivoCopia) then oOFS.DeleteFile(sRutaArchivoCopia)
				oOFS.MoveFile sRutaArchivoFuente, sRutaArchivoCopia
				set oOFS= nothing
				if err.number=0 then
					fMueveArchivoGenerado= "3"
				else
					fMueveArchivoGenerado= "4"
				end if
			end if
		else
			fMueveArchivoGenerado= "0"
		end if
	else
		fMueveArchivoGenerado= "0"
	end if
	oRsMueve.Close
	set oRsMueve= nothing
end function%>