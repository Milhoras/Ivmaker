<%'Funci�n que coloca espacio de p�rrafos
	function fColocaEspacioDeParrafo (sTexto_)
		fColocaEspacioDeParrafo= Replace(sTexto_, chr(13), "<P/>")
	end function
%>