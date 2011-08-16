function fModificaItemSelect(oElemento, sElemento, sPagina, iWidth, iHeight){
	if (oElemento.selectedIndex!=-1){
			fAbreVentana(iWidth, iHeight, 0, sPagina + '&Elemento=' + sElemento + '&Item=' + oElemento.options[oElemento.selectedIndex].value + '&Indice=' + oElemento.selectedIndex)
	}else{
		alert("Debe elegir el item a modificar");
	}
}