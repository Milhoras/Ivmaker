function fEliminaItemSelect(oElemento){
	if (oElemento.selectedIndex!=-1){
		if (confirm("Est� seguro de eliminar a " + oElemento.options[oElemento.selectedIndex].text + " de la lista")){
			oElemento.options[oElemento.selectedIndex]= null;
		}
	}else{
		alert("Debe elegir el item a eliminar");
	}
}
