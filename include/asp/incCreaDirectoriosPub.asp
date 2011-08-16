<%' esta SubRutina crea Los directorios de una publicacion en el servidor  de generacion
' Se estan creando los subdirectorios en base al nombre de la publicacion por lo que  se debera
' tener cuidado al modificar este item					IAR130303
SUB CreaDirectoriosPub(CodPub)
	Dim CreaDirectorios, RutaPorCrear, RutaRaiz, sRutaVirtual _
		,Conn,Rs,Item, strSql, FS
	Set Conn = server.CreateObject("Adodb.Connection")
	Conn.open Constr
		strsql="select des_rutavirtual from publicacion where cod_publicacion="& CodPub
	Set Rs= Conn.execute(strsql)
		sRutaVirtual=replace(trim(Rs(0))," ","")
	Set Rs=nothing
	Conn.close
	set Conn =nothing
	RutaRaiz=Server.MapPath("/" & sRutaVirtualIVMaker & "/")
	dim RutasPorCrear(12)
		RutasPorCrear(1)=RutaRaiz & "\" & sRutaVirtual
		RutasPorCrear(2)=RutaRaiz & "\" & sRutaVirtual & "\Html\"
		RutasPorCrear(3)=RutaRaiz & "\" & sRutaVirtual & "\Photo\"
		RutasPorCrear(4)=RutaRaiz & "\" & sRutaVirtual & "\Photo\Reducido\"
		RutasPorCrear(5)=RutaRaiz & "\" & sRutaVirtual & "\Photo\Mini\"
		RutasPorCrear(6)=RutaRaiz & "\" & sRutaVirtual & "\Image\"
		RutasPorCrear(7)=RutaRaiz & "\" & sRutaVirtual & "\Include\"
		RutasPorCrear(8)=RutaRaiz & "\" & sRutaVirtual & "\Include\css\"
		RutasPorCrear(9)=RutaRaiz & "\" & sRutaVirtual & "\Include\asp\"
		RutasPorCrear(10)=RutaRaiz & "\" & sRutaVirtual & "\Include\js\"
		RutasPorCrear(11)=RutaRaiz & "\" & sRutaVirtual & "\Macro\"
		RutasPorCrear(12)=RutaRaiz & "\" & sRutaVirtual & "\Template\"

	SET FS = Server.CreateObject("Scripting.FileSystemObject")
	for Item = 1 to 12
		if not FS.FolderExists(RutasPorCrear(item)) then FS.CreateFolder(RutasPorCrear(item))
	next
	set FS=nothing
End SUB %>