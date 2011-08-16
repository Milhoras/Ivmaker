<%'Esta función trae el texto que se va a utilizar entre los tags inicio y final	jsm 19/09/02
function fTraeEntreTags(sTexto_, sTagInicio_, sTagFinal_)
	dim iPosIni_, iPosFin_, sTextoOtro_
	sTextoOtro_= sTexto_
	iPosIni_ = Instr(1,sTextoOtro_,sTagInicio_,1)
	iPosFin_ = Instr(1,sTextoOtro_,sTagFinal_,1)
	if iPosIni_>0 and iPosFin_>0 and iPosFin_>iPosIni_ then
		sTextoOtro_ = Mid(sTextoOtro_, iPosIni_ + Len(sTagInicio_), iPosFin_ - (iPosIni_ + Len(sTagInicio_)))
	else
		sTextoOtro_= ""
	end if
	fTraeEntreTags = sTextoOtro_
end function%>