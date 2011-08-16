<%'Función que filtra el texto para que el comando sql pueda entender al apóstrofe. IAR 12/02/03
	function fFiltraApostrofe(sTexto)
		sTexto=replace(sTexto,"'","''")
		fFiltraApostrofe=sTexto
	end function%>
