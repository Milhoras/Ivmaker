<!--
//Este include trae las funciones para contar caracteres en un 
//campo text o textarea, y se puede manejar un checkbox
//para elegir si se activa o se desactiva jsm 050303
var bVerContadorCaracteres= true;
function fCuentaCaracteres(oForma, sdivId)
{
	if (bVerContadorCaracteres)
	{
		document.all[sdivId].innerHTML= oForma.value.length;
		document.all[sdivId].style.display= "block";
	}
	else
	{
		document.all[sdivId].innerHTML= "";
		document.all[sdivId].style.display= "none";
	}
}
function fVerContadorCaracteres()
{
	if (arguments[0].checked)
	{
		bVerContadorCaracteres= true;
	}
	else
	{
		bVerContadorCaracteres= false;
	}
	for (var i=1; i<arguments.length; i= i+2)
	{
		fCuentaCaracteres(arguments[i], arguments[i+1])
	}
}
-->