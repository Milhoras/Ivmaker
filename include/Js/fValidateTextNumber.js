// Retorna false si un campo no es número, true si lo es.
// jsm 14/02/01
function fValidateTextNumber(objElement, strMessage){
	var bool= true
	if (isNaN(objElement.value)) {
		alert(strMessage);
		objElement.focus();
		bool= false
	}
	return bool
}
