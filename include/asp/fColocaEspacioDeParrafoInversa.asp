<%'Funci�n que coloca espacio de p�rrafos
	function fColocaEspacioDeParrafoInversa (sTexto_)
		fColocaEspacioDeParrafoInversa= Replace(sTexto_, "<P/>", chr(13))
	end function
%>