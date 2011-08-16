function fValidateCheckBox(xElement,xMessage)
{
// si envian xmessage="" then no sale el alert
// de lo contrario se muestra el alert, se usa segun lo desee
	var vOk = false;
	if (xElement.checked) {
		return true}
	else {
		for (var i = 0; i < xElement.length; i++)
		{	
			if (xElement[i].checked) {
				vOk = true;
				break }
		}
		if (vOk) {
			return true}
		else {
			if (xMessage != "") {
				alert(xMessage)}
			return false
		}
	}
}
