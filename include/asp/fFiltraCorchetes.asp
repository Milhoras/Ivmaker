<%'Función que filtra los los corchetes por signos de mayor y menor
	function fFiltraCorchetes(sTextof)
		dim stexto_
		stexto_= sTextof
		if Trim(stexto_)<>"" and not IsNull(stexto_) then
			stexto_= Replace(stexto_, "{", "<")
			stexto_= Replace(stexto_, "}", ">")
		end if
		fFiltraCorchetes= stexto_
	end function%>
