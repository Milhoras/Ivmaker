function fMueveOpcionSelectASelect(elementoDesde, elementoHacia){
//Mueve elemento seleccionado desde un Select "elementoDesde" a otro select "elementoHacia" jsm 15.08.01

	if (elementoDesde.selectedIndex>-1) {
		var Indice= elementoHacia.length;
		var optionX= new Option(elementoDesde.options[elementoDesde.selectedIndex].text, elementoDesde.options[elementoDesde.selectedIndex].value);
		eval("elementoHacia.options[Indice]= optionX");
		elementoDesde.options[elementoDesde.selectedIndex]= null;
	}
}