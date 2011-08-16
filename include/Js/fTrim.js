//Hace trim derecho e izquierdo a un string
function fTrim(xLiteral)
{
	var NewLiteral = "";
	var OldChar = " ";
	for (var i=0; i < xLiteral.length; i++)
	{
		if (xLiteral.charAt(i) != " " || OldChar != " ")
		{
			NewLiteral += xLiteral.charAt(i) 
		}
		OldChar = xLiteral.charAt(i)
	}
	return NewLiteral
}
