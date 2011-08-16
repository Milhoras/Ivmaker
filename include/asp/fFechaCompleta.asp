<%'Función que devuelve la fecha completa en formato Lunes, 1 de Enero de 2001
	function fFechaCompleta(dtFecha_)
		dim sMeses_, sMes_, sDias_, sDia_
		sMeses_= "Enero    Febrero  Marzo    Abril    Mayo     Junio    Julio    Agosto   SetiembreOctubre  NoviembreDiciembre"
		sMes_= Trim(Mid(sMeses_,((9 * (CInt(Month(dtFecha_)) - 1)) + 1),9))
		sDias_="Domingo  Lunes    Martes   MiércolesJueves   Viernes  Sábado   "
		sDia_= Trim(Mid(sDias_,((9 * (Weekday(dtFecha_)-1)) + 1),9))

		fFechaCompleta= sDia_ & ", " & Day(dtFecha_) & " de " & sMes_ & _
		" de " & Year(dtFecha_)
	end function%>