function fValidateTextBlank(xElement,xMessage)
{
	sLiteral = new String(xElement.value);	
	sNewLiteral = new String(fTrim(sLiteral));
	xElement.value = sNewLiteral.toString();
	if (sNewLiteral.length == 0)
	{
		alert(xMessage)
		xElement.focus();
		return false
	}
	else
	{
		return true
	}
}
