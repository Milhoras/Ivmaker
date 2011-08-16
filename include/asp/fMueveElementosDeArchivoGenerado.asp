<%'Mueve las fotos de un archivo ya generado a la ruta que le corresponde
'Devuelve un mensaje con los datos de los elementos enviados
function fMueveElementosDeArchivoGenerado(iCodigoNota, oConn_)
	'on error resume next
	dim oRsMueve, sRutaFisica, sRutaFtp, oFtp, bEstadoProceso _
		, aDirectorios, sDirectorios, i, aDisco, sUrlNota_ _
		, sUrlPaginaHtml, sSubDirectorioFecha, oOFS, sDirectorioCopiaFoto _
		, sDirectorioCopiaFotoReducido, sRutaVirtualPublicacion _
		, sNombreArchivo, iFotosEnviadas, iFotosNoEnviadas, oRs_ _
		, xsNombreArchivo, oRsElementos, iCodigoServidor
'*********************************************
	'Ver si tiene fotos para enviar
	set oRsElementos= Server.CreateObject("ADODB.Recordset")
	oRsElementos.Open "SELECT cod_foto FROM fotonota" & _
		" WHERE cod_nota=" & iCodigoNota, oConn_


	if not oRsElementos.EOF then
		'La ruta virtual de la publicación
		sRutaVirtualPublicacion= fValorCampo("a.des_rutavirtual", _
			"publicacion a, seccion b, notas c", oConn_, _
			"c.cod_nota=" & iCodigoNota & " AND c.cod_seccion=b.cod_seccion" & _
			" AND b.cod_publicacion=a.cod_publicacion")
		set oRsMueve= Server.CreateObject("ADODB.Recordset")
		oRsMueve.Open "SELECT a.des_rutaftp, a.des_rutafisica, a.cod_servidor" & _
			" FROM publicacion a, seccion b, notas c, servidores d" & _
			" WHERE c.cod_nota=" & iCodigoNota & _
			" AND c.cod_seccion=b.cod_seccion" & _
			" AND b.cod_publicacion=a.cod_publicacion", oConn_
		if not oRsMueve.EOF then
			'Trae el nombre de la página generada
			sRutaFtp= Trim(oRsMueve("des_rutaftp"))
			sRutaFisica= Trim(oRsMueve("des_rutafisica"))
			iCodigoServidor= oRsMueve("cod_servidor")
			if Trim(sRutaFtp)<>"" and not IsNull(sRutaFtp) then
				'Ruta remota
				dim sRutaRemota, sRutaLocal
				iFotosEnviadas= 0
				iFotosNoEnviadas= 0
				set oRs_= Server.CreateObject("ADODB.Recordset")
				oRs_.Open "SELECT b.des_nombrearchivo, d.des_tamanio" & _
					" FROM fotonota a, foto b, tamaniofotopublicacion c, tamaniofoto d" & _
					" WHERE a.cod_nota=" & iCodigoNota & " AND a.cod_foto=b.cod_foto" & _
					" AND b.cod_publicacion=c.cod_publicacion" & _
					" AND c.cod_tamanio=d.cod_tamanio", oConn_
				do while not oRs_.EOF
					sNombreArchivo= Trim(oRs_("des_nombrearchivo"))
					xsNombreArchivo= sNombreArchivo
					'Arma la ruta local
			 		sRutaLocal= Server.MapPath("../" & _
						sRutaVirtualPublicacion & "/" & csSubDirectorioFoto & _
						"/" & sNombreArchivo)
					'Arma la ruta remota
			 		sRutaRemota= sRutaFtp & "/" & csSubDirectorioFoto & "/" & _
			 			sNombreArchivo
					'Mover el archivo
					bEstadoProceso= fEnviaArchivoPorFtp(sRutaLocal, _
						sRutaRemota, iCodigoServidor, oConn_)
					if bEstadoProceso then
						iFotosEnviadas= iFotosEnviadas + 1
					else
						iFotosNoEnviadas= iFotosNoEnviadas + 1
					end if
					do while not oRs_.EOF and _
						xsNombreArchivo=sNombreArchivo
						'Arma la ruta del archivo local
						sRutaLocal= Server.MapPath("../" & _
							sRutaVirtualPublicacion & "/" & csSubDirectorioFotoReducido & _
							"/" & fNombreImagenReducida(sNombreArchivo, _
							Trim(oRs_("des_tamanio"))))
						'Arma la ruta del archivo remoto
						sRutaRemota= sRutaFtp & "/" & csSubDirectorioFotoReducido & _
							"/" & fNombreImagenReducida(sNombreArchivo, _
							Trim(oRs_("des_tamanio")))
						'Mover el archivo
						bEstadoProceso= fEnviaArchivoPorFtp(sRutaLocal, _
							sRutaRemota, iCodigoServidor, oConn_)
						if bEstadoProceso then
							iFotosEnviadas= iFotosEnviadas + 1
						else
							iFotosNoEnviadas= iFotosNoEnviadas + 1
						end if
						ors_.MoveNext
						if not oRs_.EOF then _
							sNombreArchivo= Trim(oRs_("des_nombrearchivo"))
					loop
				loop
				oRs_.Close
				set oRs_= nothing
				fMueveElementosDeArchivoGenerado= CStr(iFotosEnviadas) & _
					" fotos enviadas<br>" & CStr(iFotosNoEnviadas) & " fotos no enviadas"
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
					'Proceso para mover las fotos del archivo generado
					dim sRutaArchivoFuente, sRutaArchivoCopia
					'Colocarle y verificar el subdirectorio de foto
					sDirectorioCopiaFoto= sDirectorios & csSubDirectorioFoto
					pVerificaCreaDirectorio(sDirectorioCopiaFoto)
					'Colocarle y verificar el subdirectorio de foto/reducido
					sDirectorioCopiaFotoReducido= sDirectorios & _
						replace(csSubDirectorioFotoReducido, "/", "\")
					pVerificaCreaDirectorio(sDirectorioCopiaFotoReducido)
					'Trae las fotos de la base de datos
					iFotosEnviadas= 0
					iFotosNoEnviadas= 0
					set oRs_= Server.CreateObject("ADODB.Recordset")
					oRs_.Open "SELECT b.des_nombrearchivo, d.des_tamanio" & _
						" FROM fotonota a, foto b, tamaniofotopublicacion c, tamaniofoto d" & _
						" WHERE a.cod_nota=" & iCodigoNota & " AND a.cod_foto=b.cod_foto" & _
						" AND b.cod_publicacion=c.cod_publicacion" & _
						" AND c.cod_tamanio=d.cod_tamanio", oConn_
					set oOFS= Server.CreateObject("Scripting.FileSystemObject")
					do while not oRs_.EOF
						sNombreArchivo= Trim(oRs_("des_nombrearchivo"))
						xsNombreArchivo= sNombreArchivo
						'Arma la ruta del archivo local
						sRutaArchivoFuente= Server.MapPath("../" & _
							sRutaVirtualPublicacion & "/" & csSubDirectorioFoto & _
							"/" & sNombreArchivo)
						'Arma la ruta del archivo copia
						sRutaArchivoCopia= sDirectorioCopiaFoto & "\" & sNombreArchivo
						'Mover el archivo
						if oOFS.FileExists(sRutaArchivoFuente) then _
							oOFS.CopyFile sRutaArchivoFuente, sRutaArchivoCopia
						if err.number=0 then
							iFotosEnviadas= iFotosEnviadas + 1
						else
							iFotosNoEnviadas= iFotosNoEnviadas + 1
						end if
						do while not oRs_.EOF and _
							xsNombreArchivo=sNombreArchivo
							'Arma la ruta del archivo local
							sRutaArchivoFuente= Server.MapPath("../" & _
								sRutaVirtualPublicacion & "/" & csSubDirectorioFotoReducido & _
								"/" & fNombreImagenReducida(sNombreArchivo, _
								Trim(oRs_("des_tamanio"))))
							'Arma la ruta del archivo copia
							sRutaArchivoCopia= sDirectorioCopiaFotoReducido & "\" & _
								fNombreImagenReducida(sNombreArchivo, _
								Trim(oRs_("des_tamanio")))
							'Mover el archivo
							if oOFS.FileExists(sRutaArchivoFuente) then _
								oOFS.CopyFile sRutaArchivoFuente, sRutaArchivoCopia
							if err.number=0 then
								iFotosEnviadas= iFotosEnviadas + 1
							else
								iFotosNoEnviadas= iFotosNoEnviadas + 1
							end if
							oRs_.MoveNext
							if not oRs_.EOF then _
								sNombreArchivo= Trim(oRs_("des_nombrearchivo"))
						loop
					loop
					oRs_.Close
					set oRs_= nothing
					set oOFS= nothing
					fMueveElementosDeArchivoGenerado= CStr(iFotosEnviadas) & _
						" fotos enviadas<br>" & CStr(iFotosNoEnviadas) & " fotos no enviadas"
				end if
			else
				fMueveElementosDeArchivoGenerado= "*No especifica ruta para enviar elementos"
			end if
		else
			fMueveElementosDeArchivoGenerado= "*No especifica ruta para enviar elementos"
		end if
		oRsMueve.Close
		set oRsMueve= nothing
	else
		fMueveElementosDeArchivoGenerado= "No tiene fotos"
	end if
	oRsElementos.Close
	set oRsElementos= nothing
'*****************************************
end function%>