<%'Función que se encarga de la generación en archivo físico de una nota
' devuelve un valor: 0:Sin errores;	1:No hay plantilla asignada;	2:La plantilla física no existe 
function fGeneraNota(iCodigoNota, iCodigoSeccion, iCodigoPublicacion, oConn_)
	'Declaración de vvariables para el pGeneraNota
	dim sRetornoLinea, sTitularNota_, i, sArchivoPlantilla, iCodPlantilla _
	, oRsGeneraNota, sEstadoGeneraNota
	'Constantes
	sRetornoLinea= Chr(13) &  Chr(10)
	'Traer el titular de la nota
	sTitularNota_= fValorCampo("des_titulonota", "notas", oConn_, _
		"cod_nota=" & iCodigoNota)
	'Verifica que tenga plantilla asignada
	iCodPlantilla= fValorCampo("cod_plantilla", "notas", oConn_, _
		"cod_nota=" & iCodigoNota)
	if iCodPlantilla=0 or Trim(iCodPlantilla)="" or IsNull(iCodPlantilla) then
		sEstadoGeneraNota= "1"
	else
		sArchivoPlantilla= fValorCampo("des_archivoplantilla", "plantillas", oConn_, "cod_plantilla=" & iCodPlantilla)
		'Verificai si está la plantilla física
		dim oOFS, oArchivoPlantilla, sRutaVirtual, sTextoPagina _
			, sRutaFisicaArchivoPlantilla, oArchivoHtml, sUrlNota_ _
			, dtFechaRegistroNota
		sRutaVirtual= fValorCampo("des_rutavirtual", "publicacion", oConn_, _
			"cod_publicacion=" & iCodigoPublicacion)
		'Arma la ruta física completa del archivo de plantilla
		sRutaFisicaArchivoPlantilla= Server.MapPath("../" & sRutaVirtual & _
			"/" & csSubDirectorioPlantilla & "/" & sArchivoPlantilla)
		set oOFS= Server.CreateObject("Scripting.FileSystemObject")
		'Verifica si existe fisicamente el archivo de la plantilla
		if not oOFS.FileExists(sRutaFisicaArchivoPlantilla) then
			sEstadoGeneraNota= "2"
		else
			sEstadoGeneraNota= "0"
			sUrlNota_= fUrlNota(iCodigoNota, oConn_)
			set oArchivoPlantilla= oOFS.OpenTextFile(Server.MapPath("../" & _
			sRutaVirtual & "/" & csSubDirectorioPlantilla & "/" & sArchivoPlantilla), 1, 1)
			sTextoPagina= oArchivoPlantilla.readAll
			set oArchivoPlantilla= nothing
			'Trae la fecha de registro de la nota para ver a qué subdirectorio pertenece
			dtFechaRegistroNota= fValorCampo("fec_registro", "notas", oConn_, "cod_nota=" & iCodigoNota)
			'Verifica si existe el subdirectorio de html
			call pVerificaCreaDirectorio(Server.MapPath("../" & sRutaVirtual & "/" & _
			csSubDirectorioHtml))
			'Verifica si existe el subdirectorio de la fecha a la que corresponde la nota
			call pVerificaCreaDirectorio(Server.MapPath("../" & sRutaVirtual & "/" & _
			csSubDirectorioHtml & "/" & CStr(Year(dtFechaRegistroNota)) & _
			"-" & Right("0" & CStr(Month(dtFechaRegistroNota)),2) & _
			"-" & Right("0" & CStr(Day(dtFechaRegistroNota)),2)))
'******************************************
			'Empieza el reemplazo
			'Declara variables
			dim sCabecera, sCuerpo, sAutor, sNombreSeccion, sTextoAyuda _
				, sTextoBloque, sRutaFotoReducida, sRutaFotoOriginal _
				, sTextoBloque2, oImage, iAnchoFoto, iAltoFoto	
		
			'Trae los datos de la nota y de la seccion
			set oRsGeneraNota= Server.CreateObject("ADODB.Recordset")
			oRsGeneraNota.Open "SELECT a.des_cabecera, a.des_texto, a.des_autor" & _
			", b.nom_seccion FROM notas a, seccion b" & _
			" WHERE a.cod_seccion=b.cod_seccion AND a.cod_nota=" & _
			iCodigoNota , oConn_
			if not oRsGeneraNota.EOF then
				sCabecera= fFiltraCorchetes(fColocaEspacioDeParrafo(Trim(oRsGeneraNota("des_cabecera"))))
				sCuerpo= fFiltraCorchetes(fColocaEspacioDeParrafo(Trim(oRsGeneraNota("des_texto"))))
				sAutor= Trim(oRsGeneraNota("des_autor"))
				sNombreSeccion= Trim(oRsGeneraNota("nom_seccion"))
			end if
			oRsGeneraNota.Close
			set oRsGeneraNota= nothing
			sTextoPagina= Replace(sTextoPagina, "<!TITULAR>", sTitularNota_)
			sTextoPagina= Replace(sTextoPagina, "<!CABECERA>", sCabecera)
			sTextoPagina= Replace(sTextoPagina, "<!CUERPO>", sCuerpo)
			sTextoPagina= Replace(sTextoPagina, "<!AUTOR>", sAutor)
			sTextoPagina= Replace(sTextoPagina, "<!SECCION>", sNombreSeccion)
			sTextoPagina= Replace(sTextoPagina, "<!FECHAHOY>", fFechaCompleta(Now()))
'******************************************
			'Reemplazar la foto
			sTextoBloque= fTraeEntreTags(sTextoPagina, "<!FOTO>", "<!/FOTO>")
			if Trim(sTextoBloque)<>"" then
				set oRsGeneraNota= Server.CreateObject("ADODB.Recordset")
				oRsGeneraNota.Open "SELECT a.des_nombrearchivo, a.cod_foto" & _
					", d.des_tamanio, a.des_autor, b.des_sumillafoto" & _
					", b.num_prioridad" & _
					" FROM foto a, fotonota b, tamaniofotopublicacion c, tamaniofoto d" & _
					" WHERE b.cod_nota=" & iCodigoNota & " AND b.cod_foto=a.cod_foto" & _
					" AND a.cod_publicacion=c.cod_publicacion" & _
					" AND c.est_defecto='1' AND c.cod_tamanio=d.cod_tamanio" & _
					" ORDER BY b.num_prioridad", oConn_
				if not oRsGeneraNota.EOF then
					i= 0
					'Reemplaza el script para la foto
					sTextoAyuda= "<script language=""javascript"" src=""/Include/Js/incFuncionesFotoNota.js""></script>" & sRetornoLinea & _
					"<script language=""javascript"">" & sRetornoLinea & _
					"	var aFoto= new Array();" & sRetornoLinea
					do while not oRsGeneraNota.EOF
						i= i + 1
						'Ruta de la foto original
						sRutaFotoOriginal= "/" & sRutaVirtual & "/" & _
							csSubDirectorioFoto & "/" & Trim(oRsGeneraNota("des_nombrearchivo"))
						'Ruta de la foto reducida
						sRutaFotoReducida= "/" & sRutaVirtual & "/" & _
							csSubDirectorioFotoReducido & "/" & _
							fNombreImagenReducida(Trim(oRsGeneraNota("des_nombrearchivo")), _
							Trim(oRsGeneraNota("des_tamanio")))
						'Trae el ancho y alto de la foto
						set oImage= Server.CreateObject("AspImage.Image")
						oImage.AutoSize= false
						oImage.LoadImage(Server.MapPath(".." & sRutaFotoOriginal))
						iAnchoFoto= oImage.MaxX
						iAltoFoto= oImage.MaxY
						set oImage= nothing
						'Arma el script para el arreglo de fotos
						sTextoAyuda= sTextoAyuda & "	aFoto[" & i & "]= new Array(6);" & sRetornoLinea & _
						"	aFoto[" & i & "][1]=""" & sRutaFotoOriginal & """;" & sRetornoLinea & _
						"	aFoto[" & i & "][2]=""" & sRutaFotoReducida & """;" & sRetornoLinea & _
						"	aFoto[" & i & "][3]=""<b>" & Trim(oRsGeneraNota("des_autor")) & "</b>"";" & sRetornoLinea & _
						"	aFoto[" & i & "][4]=""" & Trim(oRsGeneraNota("des_sumillafoto")) & """;" & sRetornoLinea & _
						"	aFoto[" & i & "][5]=" & iAnchoFoto & ";" & sRetornoLinea & _
						"	aFoto[" & i & "][6]=" & iAltoFoto & ";" & sRetornoLinea
						oRsGeneraNota.movenext
					loop
					'Sacar el color de fondo de la foto original desde la plantilla
					dim sColorFondoFotoOriginal
					sColorFondoFotoOriginal= fTraeEntreTags(sTextoBloque, "<!!COLORFONDOFOTOORIGINAL>", "<!!/COLORFONDOFOTOORIGINAL>")
					sTextoBloque= fEsquivaTags(sTextoBloque, "<!!COLORFONDOFOTOORIGINAL>", "<!!/COLORFONDOFOTOORIGINAL>")
					'Reemplaza el script de fotos
					sTextoAyuda= sTextoAyuda & "	var iIndiceMaximo=" & i & ";" & sRetornoLinea & _
					"	var iIndiceFoto= 0;" & sRetornoLinea & _
					"	var sColorFondoFotoOriginal= '" & sColorFondoFotoOriginal & "'" & sRetornoLinea & _
					"	fFoto();" & sRetornoLinea & _
					"</script>" & sRetornoLinea
					sTextoBloque2= ""
					'Verifica si existen más fotos
					if i>1 then
						sTextoBloque2= fTraeEntreTags(sTextoBloque, "<!MASFOTOS>", "<!/MASFOTOS>")
						sTextoBloque2= Replace(sTextoBloque2, "<!URLMASFOTOS>", "Javascript: fFoto();")
						sTextoBloque= fReemplazarEntreTags(sTextoBloque, sTextoBloque2, "<!MASFOTOS>", "<!/MASFOTOS>")
					else
						sTextoBloque= fEsquivaTags(sTextoBloque, "<!MASFOTOS>", "<!/MASFOTOS>")
					end if
					'Reesmplaza el script de fotos
					sTextoBloque= Replace(sTextoBloque, "<!SCRIPTFOTO>", sTextoAyuda)
					'Reemplaza el url de la foto
					sTextoBloque= Replace(sTextoBloque, "<!URLFOTO>", "")
					'Reemplaza el url de la foto original
					sTextoBloque= Replace(sTextoBloque, "<!URLFOTOORIGINAL>", "Javascript: fAbreVentanaFoto()")
					
					sTextoAyuda= sTextoBloque
					sTextoPagina= fReemplazarEntreTags(sTextoPagina, sTextoAyuda, "<!FOTO>", "<!/FOTO>")
				else
					sTextoPagina= fEsquivaTags(sTextoPagina, "<!FOTO>", "<!/FOTO>")
				end if
				oRsGeneraNota.Close
				set oRsGeneraNota= nothing
			end if
'******************************************
			'Reeemplaza la foto de manera directa al original
			sTextoBloque= fTraeEntreTags(sTextoPagina, "<!FOTODIRECTAORIGINAL>", "<!/FOTODIRECTAORIGINAL>")
			if Trim(sTextoBloque)<>"" then
				sRutaFotoOriginal= ""
				set oRsGeneraNota= Server.CreateObject("ADODB.Recordset")						
				oRsGeneraNota.Open "SELECT a.des_nombrearchivo" & _
					", a.des_autor, b.des_sumillafoto" & _
					" FROM foto a, fotonota b" & _
					" WHERE b.cod_nota=" & iCodigoNota & _
					" AND b.cod_foto=a.cod_foto" & _
					" ORDER BY b.num_prioridad", oConn_
				if not oRsGeneraNota.EOF then
					'Ruta de la foto original
					sRutaFotoOriginal= "/" & sRutaVirtual & "/" & _
						csSubDirectorioFoto & "/" & _
						Trim(oRsGeneraNota("des_nombrearchivo"))
					'Reemplaza la ruta de la foto original
					sTextoBloque= Replace(sTextoBloque, _
						"<!URLFOTODIRECTAORIGINAL>", sRutaFotoOriginal)
					'Reemplaza el bloque en la página
					sTextoPagina= fReemplazarEntreTags(sTextoPagina, _
						sTextoBloque, "<!FOTODIRECTAORIGINAL>", _
						"<!/FOTODIRECTAORIGINAL>")					
				else
					sTextoPagina= fEsquivaTags(sTextoPagina, _
						"<!FOTODIRECTAORIGINAL>", "<!/FOTODIRECTAORIGINAL>")
				end if				
				oRsGeneraNota.Close
				set oRsGeneraNota= nothing
			end if
'******************************************
			'Reemplaza el video
			dim iCodigoVideo
			sTextoBloque= ""
			sTextoAyuda= ""
			sTextobloque= fTraeEntreTags(sTextoPagina, "<!VIDEO>", "<!/VIDEO>")
			iCodigoVideo= fValorCampo("cod_video", "videonota", oConn_, _
				"cod_nota=" & iCodigoNota)
			if iCodigoVideo<>"" then
				sTextoAyuda= "http://www.elcomercioperu.com.pe/Video/VideoNota.asp?codVideo=" & _
					iCodigoVideo & "|b"
				sTextoBloque= Replace(sTextoBloque, "<!URLVIDEOLOW>", sTextoAyuda)
				sTextoAyuda= "http://www.elcomercioperu.com.pe/Video/VideoNota.asp?codVideo=" & _
					iCodigoVideo & "|a"
				sTextoBloque= Replace(sTextoBloque, "<!URLVIDEOHIGH>", sTextoAyuda)
				'Reemplazar
				sTextoPagina= fReemplazarEntreTags(sTextoPagina, sTextoBloque, "<!VIDEO>", "<!/VIDEO>")					
			else
				'Esquivar
				sTextoPagina= fEsquivaTags(sTextoPagina, "<!VIDEO>", "<!/VIDEO>")			
			end if
'******************************************
			'Reemplaza las notas relacionadas
			sTextoAyuda= ""
			sTextoBloque= ""
			sTextoBloque2= ""
			sTextoBloque= fTraeEntreTags(sTextoPagina, "<!NOTAS_RELACIONADAS>", "<!/NOTAS_RELACIONADAS>")
			if Trim(sTextoBloque)<>"" then
				dim sUrlNotaRelacionada, sTitularNota_Relacionada, iColumnasNotasRelacionadas
				sTextoBloque2= fTraeEntreTags(sTextoBloque, "<!NOTARELACIONADA>", "<!/NOTARELACIONADA>")
				set oRsGeneraNota= Server.CreateObject("ADODB.Recordset")
				oRsGeneraNota.Open "SELECT a.cod_notarelacionada" & _
					", a.des_titulo, a.des_enlace, b.des_titulonota" & _
					" FROM notasrelacionadas a, notas b" & _
					" WHERE a.cod_nota=" & iCodigoNota & _
					" AND a.cod_notarelacionada*=b.cod_nota" & _
					" AND b.est_archivo='1'" & _
					" ORDER BY a.num_prioridad", oConn_
				if not oRsGeneraNota.EOF then
					iColumnasNotasRelacionadas= fTraeEntreTags(sTextoBloque, "<!!COLUMNASNOTASRELACIONADAS>", "<!!/COLUMNASNOTASRELACIONADAS>")
					if Trim(iColumnasNotasRelacionadas)="" and _
					not IsNumeric(iColumnasNotasRelacionadas) then
						iColumnasNotasRelacionadas= 1
					else
						iColumnasNotasRelacionadas= CInt(iColumnasNotasRelacionadas)
					end if
					i= 0
					do while not oRsGeneraNota.EOF
						i= i + 1
						if IsNull(oRsGeneraNota("des_enlace")) then
							sUrlNotaRelacionada= fUrlNota(oRsGeneraNota("cod_notarelacionada"), oConn_)
							sTitularNota_Relacionada= Trim(oRsGeneraNota("des_titulonota"))
						else
							sUrlNotaRelacionada= oRsGeneraNota("des_enlace")
							sTitularNota_Relacionada= Trim(oRsGeneraNota("des_titulo"))
						end if
						if i=1 then
							sTextoAyuda= sTextoAyuda & "<tr>" & sRetornoLinea
						end if
						sTextoAyuda= sTextoAyuda & _
						Replace(Replace(sTextoBloque2, "<!URLNOTARELACIONADA>", sUrlNotaRelacionada), "<!TITULARNOTARELACIONADA>", sTitularNota_Relacionada)
						if i=iColumnasNotasRelacionadas then
							sTextoAyuda= sTextoAyuda & "</tr>" & sRetornoLinea
							i= 0
						end if
						oRsGeneraNota.movenext
					loop
					if i>0 then
						sTextoAyuda= sTextoAyuda & "<td colspan=""" & _
						iColumnasNotasRelacionadas - i & """></td>" & _
						sRetornoLinea & "</tr>" & sRetornoLinea
					end if
					'Esquiva el bloque de columnas de las notas relacionadas
					sTextoBloque= fEsquivaTags(sTextoBloque, "<!!COLUMNASNOTASRELACIONADAS>", "<!!/COLUMNASNOTASRELACIONADAS>")
					'Reemplaza las notas relacionadas
					sTextoBloque= fReemplazarEntreTags(sTextoBloque, sTextoAyuda, "<!NOTARELACIONADA>", "<!/NOTARELACIONADA>")
					'Reemplaza el bloque de titulares
					sTextoPagina= fReemplazarEntreTags(sTextoPagina, sTextoBloque, "<!NOTAS_RELACIONADAS>", "<!/NOTAS_RELACIONADAS>")					
				else
					sTextoPagina= fEsquivaTags(sTextoPagina, "<!NOTAS_RELACIONADAS>", "<!/NOTAS_RELACIONADAS>")
				end if
				oRsGeneraNota.Close
				set oRsGeneraNota= nothing
			end if			
'******************************************
			'Reemplaza los titulares
			sTextoAyuda= ""
			sTextoBloque= ""
			sTextoBloque2= ""
			sTextoBloque= fTraeEntreTags(sTextoPagina, "<!TITULARES_SECCION>", "<!/TITULARES_SECCION>")
			if Trim(sTextoBloque)<>"" then
				sTextoBloque2= fTraeEntreTags(sTextoBloque, "<!TITULARES>", "<!/TITULARES>")
				set oRsGeneraNota= Server.CreateObject("ADODB.Recordset")
				oRsGeneraNota.Open "SELECT cod_nota, des_titulonota" & _
					" FROM notas" & _
					" WHERE cod_seccion=" & iCodigoSeccion & _
					" AND est_activo='1' AND cod_nota<>" & iCodigoNota & _
					" AND des_titulonota<>'.' and des_titulonota is not null" & _
					" AND est_archivo='1'" & _
					" ORDER BY num_prioridad", oConn_
				if not oRsGeneraNota.EOF then
					do while not oRsGeneraNota.EOF
						sTextoAyuda= sTextoAyuda & _
						Replace(Replace(sTextoBloque2, "<!URLOTRANOTA>", fUrlNota(oRsGeneraNota("cod_nota"), oConn_)), "<!TITULAROTRANOTA>", Trim(oRsGeneraNota("des_titulonota")))
						oRsGeneraNota.movenext
					loop
					'Reemplaza la lista de titulares
					sTextoBloque= fReemplazarEntreTags(sTextoBloque, sTextoAyuda, "<!TITULARES>", "<!/TITULARES>")
					'Reemplaza el bloque de titulares
					sTextoPagina= fReemplazarEntreTags(sTextoPagina, sTextoBloque, "<!TITULARES_SECCION>", "<!/TITULARES_SECCION>")
				else
					'Quita el bloque entero
					sTextoPagina= fEsquivaTags(sTextoPagina, "<!TITULARES_SECCION>", "<!/TITULARES_SECCION>")				
				end if
				oRsGeneraNota.Close
				set oRsGeneraNota= nothing
			end if
'******************************************
			'Grabar en un archivo html
			set oArchivoHtml= oOFS.CreateTextFile(Server.MapPath(".." & sUrlNota_), true, false)
			oArchivoHtml.Write sTextoPagina
			oArchivoHtml.Close
			set oArchivoHtml = nothing
'******************************************
			'Cambia en bd el estado a generado
			oConn_.Execute("UPDATE notas SET est_generado='1' WHERE cod_nota=" & iCodigoNota)
'******************************************
			'Graba el nombre de la página, si es que no la tiene
			dim sNombrePagina
			sNombrePagina= fValorCampo("des_nombrepagina", "notas", _
				oConn_, "cod_nota=" & iCodigoNota)
			if Trim(sNombrePagina)="" or IsNull(sNombrePagina) then
				sNombrePagina= fTraeNombrePagina(iCodigoNota, oConn_)
				oConn_.Execute("UPDATE notas" & _
					" SET des_nombrepagina='" & sNombrePagina & _
					"' WHERE cod_nota=" & iCodigoNota)
			end if
		end if
'******************************************
		'Cierra el objeto del scripting file
		set oOFS= nothing
	end if
	fGeneraNota= sEstadoGeneraNota
end function%>