<%'Esta función esquiva o hace blanco a los tags que no se van a utilizar jsm 21/02/01
function fEsquivaTags(sTexto_, sTagInicio_, sTagFinal_)
	dim iPosIni_, iPosFin_, sTexto2_
	sTexto2_= sTexto_
	iPosIni_= Instr(1,sTexto2_,sTagInicio_,1)
	if iPosIni_>0 then
		iPosFin_= Instr(1,sTexto2_,sTagFinal_,1)
		if iPosFin_>0 then
			sTexto2_= Mid(sTexto2_,1,iPosIni_ - 1) & Mid(sTexto2_,iPosFin_ + len(sTagFinal_),(Len(sTexto2_) -(iPosFin_ + len(sTagFinal_) - 1)))
		end if
	end if
	fEsquivaTags= sTexto2_
end function
'************************************%>