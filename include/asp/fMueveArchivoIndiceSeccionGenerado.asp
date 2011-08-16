<%'Mueve el archivo índice de sección generado a la ruta física
' que le corresponde o la ruta ftp según sea el caso
'Devuelve un estado del proceso:	"0":no movido;
'	"1":ftp ok;	"2":ftp no ok; "2.1": no ha asignado servidor para enviar por ftp
'	"3":mover ok;	"4":mover no ok
function fMueveArchivoIndiceSeccionGenerado(iCodigoSeccion, oConn_)
	'on error resume next
	dim oRsMueve, sRutaFisica, sRutaFtp, bEstadoProceso, i, aDisco _
		, aDirectorios, sDirectorios, sUrlIndiceSeccion, oOFS _
		, sUrlPaginaHtml, sSubDirectorioFecha, iCodigoServidor
	const t_bin= 2
	set oRsMueve= Server.CreateObject("ADODB.Recordset")
	oRsMueve.Open "SELECT a.des_rutaftp, a.des_rutafisica, a.cod_servidor" & _
		" FROM publicacion a, seccion b" & _
		" WHERE b.cod_seccion=" & iCodigoSeccion & _
		" AND b.cod_publicacion=a.cod_publicacion", oConn_
	if not oRsMueve.EOF then
		'Trae el nombre de la página generada
		sUrlPaginaHtml= fArmaNombrePaginaIndiceSeccion(iCodigoSeccion, _
			oConn_)
		sSubDirectorioFecha= fArmaSubDirectorioFechaIndiceSeccion()
		sRutaFtp= Trim(oRsMueve("des_rutaftp"))
		sRutaFisica= Trim(oRsMueve("des_rutafisica"))
		iCodigoServidor= oRsMueve("cod_servidor")
	 	sUrlIndiceSeccion= fUrlIndiceSeccion(iCodigoSeccion, oConn_)
		if Trim(sRutaFtp)<>"" and not IsNull(sRutaFtp) then
			'Ruta remota
			dim sRutaRemota, sRutaLocal
		 	sRutaLocal= Server.MapPath(".." & sUrlIndiceSeccion)
		 	'Dirección remota ubicada en el subdirectorio /VIRTUAL/html/
		 	sRutaRemota= sRutaFtp & "/" & csSubDirectorioHtml & "/" & _
			 	sUrlPaginaHtml
			 'Enviar por ftp
			 if not IsNull(iCodigoServidor) then
				bEstadoProceso= fEnviaArchivoPorFtp(sRutaLocal, _
					sRutaRemota, iCodigoServidor, oConn_)
				if bEstadoProceso then 'Si envió bien a la primera entonces enviar a la segunda
					'Enviar a la otra dirección: /virtual/html/fecha/
		 			sRutaRemota= sRutaFtp & "/" & csSubDirectorioHtml & "/" & _
					 	sSubDirectorioFecha & "/" & sUrlPaginaHtml
					bEstadoProceso= bEstadoProceso= fEnviaArchivoPorFtp(sRutaLocal, _
					sRutaRemota, iCodigoServidor, oConn_)
					if bEstadoProceso then
						fMueveArchivoIndiceSeccionGenerado= "1"
						'Al ser enviado se elimina
						set oOFS= Server.CreateObject("Scripting.FileSystemObject")
						if oOFS.FileExists(sRutaLocal) then oOFS.DeleteFile(sRutaLocal)
						set oOFS= nothing
					else
						fMueveArchivoIndiceSeccionGenerado= "2"
					end if
				else
					fMueveArchivoIndiceSeccionGenerado= "2"
				end if
			else
				fMueveArchivoIndiceSeccionGenerado= "2.1"
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
				dim sRutaArchivoOrigen, sRutaArchivoDestino
				'Colocarle y verificar el subdirectorio de html
				sDirectorios= sDirectorios & csSubDirectorioHtml
				pVerificaCreaDirectorio(sDirectorios)
				'Arma la ruta del archivo local
				sRutaArchivoOrigen= Server.MapPath(".." & sUrlIndiceSeccion)
				'Arma la ruta del archivo destino, primer envío
				sRutaArchivoDestino= sDirectorios & "\" & sUrlPaginaHtml				
				'Copiar el archivo fuente como archivo copia
				set oOFS= Server.CreateObject("Scripting.FileSystemObject")
				oOFS.CopyFile sRutaArchivoOrigen, sRutaArchivoDestino
				if err.number=0 then
					'Arma la ruta del archivo destino, segundo envío
					'Colocarle y verificar el subdirectorio de la fecha a la que corresponde
					sDirectorios= sDirectorios & "\" & sSubDirectorioFecha
					pVerificaCreaDirectorio(sDirectorios)
					sRutaArchivoDestino= sDirectorios & "\" & sUrlPaginaHtml				
					oOFS.CopyFile sRutaArchivoOrigen, sRutaArchivoDestino
					if err.number=0 then
						fMueveArchivoIndiceSeccionGenerado= "3"
					else
						fMueveArchivoIndiceSeccionGenerado= "4"
					end if
				else
					fMueveArchivoIndiceSeccionGenerado= "4"
				end if
				set oOFS= nothing
			end if
		else
			fMueveArchivoIndiceSeccionGenerado= "0"
		end if
	else
		fMueveArchivoIndiceSeccionGenerado= "0"
	end if
	oRsMueve.Close
	set oRsMueve= nothing
end function%>