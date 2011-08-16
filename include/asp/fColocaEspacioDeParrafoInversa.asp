<%'Función que coloca espacio de párrafos
	function fColocaEspacioDeParrafoInversa (sTexto_)
		fColocaEspacioDeParrafoInversa= Replace(sTexto_, "<P/>", chr(13))
	end function
%>