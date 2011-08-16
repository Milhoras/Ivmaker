function fSeleccionaTodas(oElemento){
	if (oElemento!=null) {
		for (var i= 0; i<oElemento.length; i++) {
			oElemento.options[i].selected= true;
		}
	}
}