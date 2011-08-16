function CheckAllBox(xForm, xElementCheckAll)
{
	for (var i=0 ; i<xForm.elements.length ; i++)
    	{
		if (xForm.elements[i] != xElementCheckAll.name)
		{
			xForm.elements[i].checked = xElementCheckAll.checked
		}
	}
}
