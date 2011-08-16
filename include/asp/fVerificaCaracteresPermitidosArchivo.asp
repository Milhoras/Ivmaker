<%'Función que verifica el ingreso de caracteres no permitidos para un nombre de archivo
	function fVerificaCaracteresPermitidosArchivo(sTexto)
		dim sChar, sTextoMayor, bReturn, i
		sTextoMayor= UCase(sTexto)
		bReturn= true
		for i=1 to len(sTextoMayor)
			sChar= Mid(sTextoMayor, i, 1)
			if  Asc(sChar)<48 or (Asc(sChar)>57 and Asc(sChar)<64) or Asc(sChar)>90 then
				bReturn= false
				exit for
			end if
		next
		fVerificaCaracteresPermitidosArchivo= bReturn
	end function%>
