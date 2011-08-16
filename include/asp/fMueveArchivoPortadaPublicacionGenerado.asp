<%'Mueve el archivo generado a la ruta física que le corresponde 
' o la ruta ftp según sea el caso
'Devuelve un estado del proceso:	"0":no movido;		"1":ftp ok;	"2":ftp no ok;	"2.1": servidor para ftp no ha sido asignado; 
'	"3":mover ok;	"4":mover no ok
function fMueveArchivoPortadaPublicacionGenerado(iCodigoPublicacion, oConn_, _
	sRutaArchivoHtml)
	on error resume next
	dim oRsMueve, sRutaFisica, sRutaFtp, bEstadoProceso _
		, aDirectorios, sDirectorios, i, aDisco, oOFS _
		, sPaginaPrincipalHtml, iCodigoServidor
		
	set oRsMueve= Server.CreateObject("ADODB.Recordset")
	oRsMueve.Open "SELECT des_rutaftp, des_rutafisica" & _
		", cod_servidor, nom_paginaprincipal" & _
		" FROM publicacion" & _
		" WHERE cod_publicacion=" & iCodigoPublicacion, oConn_
	if not oRsMueve.EOF then
		'La ruta ftp o ruta física según fuera el caso
		sRutaFtp= Trim(oRsMueve("des_rutaftp"))
		sRutaFisica= Trim(oRsMueve("des_rutafisica"))
	 	iCodigoServidor= oRsMueve("cod_servidor")
	 	sPaginaPrincipalHtml= Trim(oRsMueve("nom_paginaprincipal"))
		if Trim(sRutaFtp)<>"" and not IsNull(sRutaFtp) then
			'Ruta remota
			dim sRutaRemota, sRutaLocal
		 	sRutaRemota= sRutaFtp & "/" & csSubDirectorioHtml & "/" & _
			 	sPaginaPrincipalHtml
		 	sRutaLocal= Server.MapPath(sRutaArchivoHtml)
		 	'Si no trae código de servidor no irá al ftp
			if not IsNull(iCodigoServidor) then
				bEstadoProceso= fEnviaArchivoPorFtp(sRutaLocal, _
					sRutaRemota, iCodigoServidor, oConn_)
				if bEstadoProceso then
					fMueveArchivoPortadaPublicacionGenerado= "1"
					'Al ser enviado se elimina
					set oOFS= Server.CreateObject("Scripting.FileSystemObject")
					if oOFS.FileExists(sRutaLocal) then oOFS.DeleteFile(sRutaLocal)
					set oOFS= nothing
				else
					fMueveArchivoPortadaPublicacionGenerado= "2"
				end if
			else
				fMueveArchivoPortadaPublicacionGenerado= "2.1"
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
				'Arma la ruta del archivo fuente
				sRutaArchivoFuente= Server.MapPath(sRutaArchivoHtml)
				'Arma la ruta del archivo copia
				sRutaArchivoCopia= sDirectorios & "\" & sPaginaPrincipalHtml
				'Mover el archivo
				set oOFS= Server.CreateObject("Scripting.FileSystemObject")
				if oOFS.FileExists(sRutaArchivoCopia) then oOFS.DeleteFile(sRutaArchivoCopia)
				oOFS.MoveFile sRutaArchivoFuente, sRutaArchivoCopia
				set oOFS= nothing
				if err.number=0 then
					fMueveArchivoPortadaPublicacionGenerado= "3"
				else
					fMueveArchivoPortadaPublicacionGenerado= "4"
				end if
			end if
		else
			fMueveArchivoPortadaPublicacionGenerado= "0"
		end if
	else
		fMueveArchivoPortadaPublicacionGenerado= "0"
	end if
	oRsMueve.Close
	set oRsMueve= nothing
end function%>