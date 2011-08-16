<%'Función que reemplaza una porción de texto dentro de dos tags
	function fReemplazarEntreTags(sTextoAReemplazar_, sTextoParaReemplazar_, sTagInicio_, sTagFinal_)
		dim sTextoDondeReemplazar_, iPosi_, iPosf_
		iPosi_= InStr(1, sTextoAReemplazar_, sTagInicio_)
		iPosf_= InStr(1, sTextoAReemplazar_, sTagFinal_)
		if iPosi_>0 and iPosf_>iPosi_ then
			sTextoDondeReemplazar_= Mid(sTextoAReemplazar_, 1, iPosi_-1) & sTextoParaReemplazar_ & _
			Mid(sTextoAReemplazar_, iPosf_ + Len(sTagFinal_), Len(sTextoAReemplazar_) - iPosf_)
		else
			sTextoDondeReemplazar_= sTextoAReemplazar_
		end if
		fReemplazarEntreTags= sTextoDondeReemplazar_
	end function%>