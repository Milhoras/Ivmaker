<%'Función que filtra los signos de mayor y menor por corchetes
	function fFiltraSignosMayorMenor(sTextof)
		dim stexto_
		stexto_= sTextof
		if Trim(stexto_)<>"" and not IsNull(stexto_) then
			stexto_= Replace(stexto_, "<", "{")
			stexto_= Replace(stexto_, ">", "}")
		end if
		fFiltraSignosMayorMenor= stexto_
	end function%>
