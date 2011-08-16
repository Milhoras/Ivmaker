function fCheckedIndexRadio(elementoRadio) {
	var intValue = "";
	for (var i = 0; i < elementoRadio.length; i++) {
		if (elementoRadio[i].checked) {
			intValue = elementoRadio[i].value;
			break
		}
	}
	return intValue;
}