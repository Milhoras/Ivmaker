<%'Función que coloca el estado a no generado en la nota
sub pColocaEstadoNotaNoGenerada(iCodigoNota_, oConn_)
	oConn_.Execute "UPDATE notas SET est_generado='0'" & _
		" WHERE cod_nota=" & iCodigoNota_
end sub%>