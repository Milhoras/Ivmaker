function fSalir(sMensaje, sUrl)
{
	/* Esta función muestra un mensaje y referencia a una página determinada,
		por lo general se utiliza para cuando se necesite salir en algun error por ejemplo sesiones caducadas
		jsm 22/2/00
	 */
	if (sMensaje.length > 0)
	{
		alert (sMensaje);
	}
	location.href= sUrl;		
}
