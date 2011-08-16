<%' esta funcion devuelve el enlace para el acceso a alas notas de interes de las 
	' secciones de una publicacion determinada			IAR-120303
dim fSacaCodDeInteres,iCodSecc,strSQl,Rs,StrSalida
function fSacaCodDeInteres(codSecc)
	iCodSecc=request("codSecc")
	Set Rs = Server.CreateObject("Adodb.RecordSet")
	strSQl="Select cod_deinteres from deinteres where cod_seccion="& iCodSecc
	Rs.Open strSQl,Constr
	if not Rs.EOF then
		StrSalida="<td><a href=""ListNotaInteres.asp?icodDeInteres="&rs(0)&""">Notas de Interes</a>"
	else
		StrSalida=""
	end if
	Rs.Close
	set Rs=nothing
fSacaCodDeInteres=StrSalida
end function

%>