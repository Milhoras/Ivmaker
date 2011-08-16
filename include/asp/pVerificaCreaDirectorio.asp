<%' Sub rutina verifica que exista el directorio de lo contrario lo crea jsm/260303
sub  pVerificaCreaDirectorio(sDirectorio_)
	dim oOFS_
	set oOFS_= Server.CreateObject("Scripting.FileSystemObject")
	if not oOFS_.FolderExists(sDirectorio_) then
		oOFS_.CreateFolder(sDirectorio_)
	end if
	set oOFS_=nothing
end sub%>