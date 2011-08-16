<%'Función para sacar el valor de un campo de alguna tabla
	'Argumentos: nombre del campo, nombre de la tabla, 
	'string de conexion u objeto de conexion, el string para el where
	function fValorCampo(sNombreCampoVC, sNombreTablaVC, sConexionVC, sLiteralWhere)
		dim oRsVC, sSqlVC
		
		sSqlVC= "SELECT " & sNombreCampoVC & " FROM " & sNombreTablaVC
		if sLiteralWhere<>"" then sSqlVC= sSqlVC & " WHERE " & sLiteralWhere
		
		set oRsVC= Server.CreateObject("ADODB.Recordset")
		oRsVC.Open sSqlVC, sConexionVC
		if not oRsVC.EOF then
			fValorCampo= oRsVC(0)
			if TypeName(fValorCampo)="String" then fValorCampo= Trim(fValorCampo)
		else
			fValorCampo= ""
		end if
		oRsVC.Close
		set oRsVC= nothing
	end function%>