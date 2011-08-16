<%Response.Buffer= true%>
<!--#include file="../include/ASP/Conn.asp"-->
<%
Dim Image 
Dim codpub,NumFotos,Tamano

function SacaRutaImage(codpub)
		strSql=" select rtrim(des_rutaFisica)  from publicacion where cod_publicacion="&codpub
		set conn=Server.CreateObject("adodb.Connection")
		conn.Open constr
		set rs=conn.execute(strsql)
		if  not rs.EOF then
			RutaRaiz=trim(rs(0))&"\Photo\"
		end if
		rs.Close
		set rs=nothing 
		conn.Close
		set conn=nothing
		SacaRutaImage=RutaRaiz
end function

sub ReduceFoto(ArchivoOriginal,Size,RutaSalida)
				RUTAGRANDE=ArchivoOriginal
				IntXSize=Size
				Set Image = Server.CreateObject("AspImage.Image")
				Image.AutoSize = false
				Image.LoadImage(RutaGrande)
				intYSize = (intXSize / Image.MaxX) * Image.MaxY
				Image.ResizeR intXSize, intYSize
				NuevoArchivo=RutaSalida
				'Response.Write(RutaSalida)
				Image.FileName = RutaSalida
				Image.SaveImage
				set Image =nothing
end sub

Sub GuardarEnTabla(cod,Foto)
	Set Conn= server.CreateObject("Adodb.Connection")
	conn.open constr
	conn.Execute("Insert Foto set cod_publicacion, des_nombrearchivo) values ("&codpub&",'"&foto&"')")
	conn.close
	set conn=nothing
end sub

Dim ListaFotos(20)
Set upl = Server.CreateObject("SoftArtisans.FileUp")
'Response.Write("Safile creado<br>")
codpub= Upl.Form("icodpublicacion")
numfotos=Upl.Form("NumFotos")
Tamano=Upl.Form("tamano")

'sacar ruta de grabación de la publicación
ruta =SacaRutaImage(codpub)
'Ruta=server.MapPath("./Photo")	
'Response.Write("ruta: "& ruta & "<br>")									'borrar para que funcione en el servidor srv_database
upl.Path = Ruta
'Response.Write("Ruta de destino: "&Upl.Path & "<br>")
contador=1
for each item in upl.form
'Response.Write("leyendo las imagenes<br>")
	if  IsObject(upl.form(item)) Then
				Nombre=upl.Form(item).UserFilename
				PosInicial= InStrRev(nombre, "\")+ 1
				NombreArchivo=replace(mid(Nombre,posinicial)," ","")
				Upl.Form(item).SaveAs Upl.Path & NombreArchivo
				ListaFotos(Contador)=upl.form(item).ServerName
				call GuardaEnTabla(codpub,NombreARchivo)
				'Response.Write(Listafotos(contador)&"<br>")
				Contador=contador +1
	end if
	
next


'For Item =0 to contador
'	Response.Write(item & " .-" & ListaFotos(Item)&"<br>")
'next


select case  trim(tamano)
case "O"
			mensaje="Archivo(s)  grabado(s) con exito"
case "D"
	ContadorT=1
	do while ContadorT<=cint(NumFotos)
			NombreFotoOriginal=lcase(trim(ListaFotos(ContadorT)))
			if right(NombreFotoOriginal,4)=".jpg" then
				ArchivoReducido=replace(NombreFotoOriginal,"\photo\","\photo\reducido\")
				call ReduceFoto(NombreFotoOriginal,150,ArchivoReducido)
				ArchivoReducido=NombreFotoOriginal		
				call ReduceFoto(NombreFotoOriginal,350,ArchivoReducido)
			end if
	ContadorT=ContadorT+1
	loop
case "CC"
	ContadorT=1
	do while ContadorT<=cint(NumFotos)
			NombreFotoOriginal=lcase(Lista(ContadorT))
			if right(NombreFotoOriginal,4)<>".gif" then
				ArchivoReducido=replace(NombreFotoOriginal,"\photo\","\photo\reducido\")
				call ReduceFoto(NombreFotoOriginal,200,NombreFotoOriginal)
			end if
	ContadorT=ContadorT+1
	loop
case "CL"
	ContadorT=1
	do while ContadorT<=cint(NumFotos)
			NombreFotoOriginal=lcase(ListaFotos(ContadorT))
			if right(NombreFotoOriginal,4)<>".gif" then
				ArchivoReducido=NombreFotoOriginal
				call ReduceFoto(NombreFotoOriginal,150,ArchivoReducido)
			end if
	ContadorT=ContadorT+1
	loop

case "T"
	ContadorT=1
	do while ContadorT<=cint(NumFotos)
			NombreFotoOriginal=Lcase(ListaFotos(ContadorT))
			ArchivoReducido=replace(NombreFotoOriginal,"\photo\","\photo\reducido\")
			RutaMini=replace(NombreFotoOriginal,"\photo\","\photo\mini\")
			if right(NombreFotoOriginal,4)<>".gif" then
				call ReduceFoto(NombreFotoOriginal,150,ArchivoReducido)
				call ReduceFoto(NombreFotoOriginal,40,RutaMini)
  				ArchivoReducido=NombreFotoOriginal
				call ReduceFoto(NombreFotoOriginal,350,ArchivoReducido)
			end if
	ContadorT=ContadorT+1
	loop
case else
	ContadorT=1
	do while ContadorT<=cint(NumFotos)
			NombreFotoOriginal=lcase(trim(ListaFotos(ContadorT)))
			if right(NombreFotoOriginal,4)=".jpg" then
				ArchivoReducido=replace(NombreFotoOriginal,"\photo\","\photo\reducido\")
				ArchivoReducido=replace(ArchivoReducido,".","_"&tamano&".")
				call ReduceFoto(NombreFotoOriginal,Tamano,ArchivoReducido)
			end if
	ContadorT=ContadorT+1
	loop
end select
Response.redirect("OpcionesFotos.asp?icodpublicacion="&codpub)
%>


