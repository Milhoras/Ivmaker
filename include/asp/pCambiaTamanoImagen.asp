<%'Procedimiento que le cambia el tama�o a una imagen
	'sImagenNombre						nombre del archivo a reducir
	'sImagenOriginalRutaVirtual			ruta completa del archivo a reducir
	'sImagenReducidaRutaVirtual		ruta virtual donde se depositar� el archivo reducido
	'iImagenReducidaLadoHorizontal	ancho a reducir
	'Utiliza la funci�n nombre de imagen reducido
	sub pCambiaTamanoImagen(sImagenNombre, sImagenOriginalRutaVirtual, sImagenReducidaRutaVirtual, iImagenReducidaLadoHorizontal)
		dim oImagenReducida, iImagenReducidaLadoVertical, sImagenNombreReducido
		set oImagenReducida= Server.CreateObject("AspImage.Image")
		'Proceso para reducir la imagen		
		oImagenReducida.LoadImage(Server.MapPath(sImagenOriginalRutaVirtual) & "\" & sImagenNombre)
		iImagenReducidaLadoVertical = (iImagenReducidaLadoHorizontal / oImagenReducida.MaxX) * oImagenReducida.MaxY
		oImagenReducida.ResizeR iImagenReducidaLadoHorizontal, iImagenReducidaLadoVertical
		sImagenNombreReducido= fNombreImagenReducida(sImagenNombre, iImagenReducidaLadoHorizontal)
		oImagenReducida.FileName= Server.MapPath(sImagenReducidaRutaVirtual) & "\" & sImagenNombreReducido
		oImagenReducida.SaveImage
		set oImagenReducida= nothing
	end sub%>