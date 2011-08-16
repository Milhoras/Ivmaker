<%'Se ha separado esta parte del programa porque lo usan tanto el IngrFotoNota.asp como EditFotoNota.asp
				'Saca el nombre del archivo
				sArchivoFoto= Mid(oUpl.Form("fFoto").UserFilename, InstrRev(oUpl.Form("fFoto").UserFilename, "\") + 1)
				sArchivoFoto= LCase(sArchivoFoto)
				if InStr(1, sArchivoFoto, ".jpg")>0 or InStr(1, sArchivoFoto, ".jpeg")>0 then
					'Trae el directorio virtual de la publicación
					sDirectorioVirtualPublicacion= fValorCampo("des_rutavirtual", "publicacion", constr, "cod_publicacion=" & iCodPublicacion)
					sDirectorioVirtualPublicacion= Replace(sDirectorioVirtualPublicacion, " ", "")
					'Verifica si existe el directorio o si no crearlo
					dim oOFS
					set oOFS= server.CreateObject("Scripting.FileSystemObject")
					if not oOFS.FolderExists(Server.MapPath("../" & sDirectorioVirtualPublicacion)) then
						call CreaDirectoriosPub(iCodPublicacion)
					end if
					'Verifica si existe el subdirectorio para las fotos, o crearlo
					call pVerificaCreaDirectorio(Server.MapPath("../" & sDirectorioVirtualPublicacion & "/" & csSubDirectorioFoto))
					set oOFS= nothing
					'Subir la foto al servidor
					oUpl.SaveAs Server.MapPath("../" & sDirectorioVirtualPublicacion & "/" & csSubDirectorioFoto) & "\" & sArchivoFoto
					'Grabar la foto en la base de datos
					oConn.Execute "INSERT foto(cod_publicacion, des_nombrearchivo" & _
					", des_autor) VALUES(" & iCodPublicacion & ", '" & fFiltraApostrofe(sArchivoFoto) &  _
					"', '" & fFiltraApostrofe(sAutorFoto) & "')"
					'Recoge el código generado
					set oRs= Server.CreateObject("ADODB.Recordset")
					oRs.open "SELECT @@identity FROM foto", oConn
					if not oRs.EOF then iCodigoFoto= oRs(0)
					oRs.Close
					set oRs= nothing
					'convierte la imagen en los demás tamaños
					dim x, aFormTamanos
					i= 0
					aFormTamanos= split(oUpl.Form("chkTamanos"), ",")
					'Verifica si existe el subdirectorio para las fotos reducidas, o crearlo
					call pVerificaCreaDirectorio(server.MapPath("../" & sDirectorioVirtualPublicacion & "/" & csSubDirectorioFotoReducido))
					for i=0 to ubound(aFormTamanos)
						call pCambiaTamanoImagen(sArchivoFoto, "../" & sDirectorioVirtualPublicacion & "/" & csSubDirectorioFoto, "../" & sDirectorioVirtualPublicacion & "/" & csSubDirectorioFotoReducido, CInt(aFormTamanos(i)))
					next
				else
					bSePuedeEnviar= false
					sMensaje= "* La foto debe ser un archivo de formato jpg o jpeg"
				end if%>