function fLengthTextArea(xElement,xCant,xMessage)
{
	if (eval(xElement.value.length > xCant))
	{
		alert(xMessage);
		xElement.focus();
		return false
	 }	else
	{
		return true
	}
//Verifica una cantidad determinada para que no exceda el texto en una caja de textarea
}
