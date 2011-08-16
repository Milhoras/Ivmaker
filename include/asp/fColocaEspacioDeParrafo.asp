<%'Función que coloca espacio de párrafos
	function fColocaEspacioDeParrafo (sTexto_)
		fColocaEspacioDeParrafo= Replace(sTexto_, chr(13), "<P/>")
	end function
%>