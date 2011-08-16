<%'Función que arma el subdirectorio para la fecha
	function fArmaSubDirectorioFecha(iCodigoNota_, oConn_)
		dim oRs_
		set oRs_= Server.CreateObject("ADODB.Recordset")
		oRs_.Open "SELECT fec_registro FROM notas" & _
		" WHERE cod_nota=" & iCodigoNota_ , oConn_
		if not oRs_.EOF then
			fArmaSubDirectorioFecha= Year(oRs_("fec_registro")) & "-" & _
			Right("00" & Month(oRs_("fec_registro")), 2) & "-" & _
			Right("00" & Day(oRs_("fec_registro")), 2)
		end if
		oRs_.Close
		set oRs_= nothing
	end function
	
	'Función que arma el nombre de la página
	function fTraeNombrePagina(iCodigoNota_, oConn_)
		dim oRs_, oRs1_
		set oRs1_= server.CreateObject("ADODB.Recordset")
		oRs1_.Open "SELECT des_nombrepagina FROM notas" & _
			" WHERE cod_nota=" & iCodigoNota_ & _
			" AND des_nombrepagina is not null" & _
			" AND LTRIM(RTRIM(des_nombrepagina))<>''", oConn_
		if not oRs1_.EOF then
			fTraeNombrePagina= Trim(oRs1_("des_nombrepagina"))
		else
			set oRs_= Server.CreateObject("ADODB.Recordset")
			oRs_.Open "SELECT b.des_alias FROM notas a" & _
				", seccion b WHERE a.cod_nota=" & iCodigoNota_ & _
				" AND a.cod_seccion=b.cod_seccion" , oConn_
			if not oRs_.EOF then
				fTraeNombrePagina= Trim(oRs_("des_alias")) & _
					Right("000000" & iCodigoNota_, 7) & ".html"
			end if
			oRs_.Close
			set oRs_= nothing
		end if
		oRs1_.Close
		set oRs1_= nothing
	end function
	
	'Función que trae la dirección html de la nota
	function fUrlNota(iCodigoNota_, oConn_)
		dim oRs_, sSubDirectorioFecha_
		set oRs_= server.CreateObject("ADODB.Recordset")
		oRs_.Open "SELECT a.des_rutavirtual" & _
			" FROM publicacion a, seccion b, notas c" & _
			" WHERE c.cod_nota=" & iCodigoNota_ & _
			" AND c.cod_seccion=b.cod_seccion" & _
			" AND b.cod_publicacion=a.cod_publicacion", oConn_
		if not oRs_.EOF then
			fUrlNota= "/" & Trim(oRs_("des_rutavirtual")) & "/" & _
				csSubDirectorioHtml & "/" & _
				fArmaSubDirectorioFecha(iCodigoNota_, oConn_) & _
				"/" & fTraeNombrePagina(iCodigoNota_, oConn_)
		else
			fUrlNota= ""
		end if
		oRs_.Close
		set oRs_= nothing
	end function%>