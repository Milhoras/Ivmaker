function SelectList(xElement, xValue)
{
	for (var i = 0; i < xElement.length; i++)
	{
		if (xElement.options[i].value == xValue)
		{
			xElement.selectedIndex = i;
			break;
		}
	}	
}