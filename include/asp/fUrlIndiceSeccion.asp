<%'Función que trae la dirección html del índice de la sección
	function fUrlIndiceSeccion(iCodigoSeccion_, oConn_)
		dim oRs_
		set oRs_= Server.CreateObject("ADODB.Recordset")
		oRs_.Open "SELECT a.des_rutavirtual" & _
			" FROM publicacion a, seccion b" & _
			" WHERE b.cod_seccion=" & iCodigoSeccion_ & _
			" AND b.cod_publicacion=a.cod_publicacion", oConn_
		if not oRs_.EOF then
			fUrlIndiceSeccion= "/" & Trim(oRs_("des_rutavirtual")) & "/" & _
				csSubDirectorioHtml & "/" & _
				fArmaNombrePaginaIndiceSeccion(iCodigoSeccion_, oConn_)
		end if
		oRs_.Close
		set oRs_= nothing
	end function
	
	'Trae el nombre de la página de índice de sección
	function fArmaNombrePaginaIndiceSeccion(iCodigoSeccion_, oConn_)
		dim oRs_, sNombrePaginaIndiceSeccion
		set oRs_= Server.CreateObject("ADODB.Recordset")
		oRs_.Open "SELECT des_alias FROM seccion" & _
		" WHERE cod_seccion=" & iCodigoSeccion_, oConn_
		if not oRs_.EOF then
			sNombrePaginaIndiceSeccion= Trim(oRs_("des_alias")) & "Index.html"
		end if
		oRs_.Close
		set oRs_= nothing
		fArmaNombrePaginaIndiceSeccion= sNombrePaginaIndiceSeccion
	end function
	
	'Función que arma el subdirectorio de fecha para el índice de la sección
	function fArmaSubDirectorioFechaIndiceSeccion()
		fArmaSubDirectorioFechaIndiceSeccion= Year(Now()) & "-" & _
			Right("00" & Month(Now()), 2) & "-" & _
			Right("00" & Day(Now()), 2)
	end function%>