function fValidateSelectBlank(xElementSelect,xFirstIndex,xMessage)
{
	if (xElementSelect.selectedIndex == xFirstIndex)
	{
		alert(xMessage);
		xElementSelect.focus();
		return false
	}
	else
	{
		return true
	}
}
