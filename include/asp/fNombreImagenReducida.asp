<%'Trae el nombre de la imagen reducida
'Necesita como par�metros el nombre del archivo original y el ancho del tama�o a reducir
'Luego se forma un nombre como: NombreArchivoOriginal_TamanoAReducir.Extension
function fNombreImagenReducida(sNombreImagenOriginal_, iAnchoImagenReducida_)
	fNombreImagenReducida= Replace(sNombreImagenOriginal_, _
	".", "_" & iAnchoImagenReducida_ & ".")
end function%>