  function Toggle(e)
    {
	if (e.checked) {
	    Highlight(e);
//	    document.ListPublicaciones.toggleAll.checked = AllChecked();
	}
	else {
	    Unhighlight(e);
//	    document.ListPublicaciones.toggleAll.checked = false;
	}
    }

    function ToggleAll(e)
    {
	if (e.checked) {
	    CheckAll();
	}
	else {
	    ClearAll();
	}
    }

    function Check(e)
    {
	e.checked = true;
	Highlight(e);
    }

    function Clear(e)
    {
	e.checked = false;
	Unhighlight(e);
    }

    function CheckAll()
    {
	var ml = document.ListPublicaciones;
	var len = ml.elements.length;
	for (var i = 0; i < len; i++) {
	    var e = ml.elements[i];
	    if (e.name == "Cod") {
		Check(e);
	    }
	}
	ml.toggleAll.checked = true;
    }

    function ClearAll()
    {
	var ml = document.ListPublicaciones;
	var len = ml.elements.length;
	for (var i = 0; i < len; i++) {
	    var e = ml.elements[i];
	    if (e.name == "Cod") {
		Clear(e);
	    }
	}
	ml.toggleAll.checked = false;
    }

    function Highlight(e)
    {
	var r = null;
	if (e.parentNode && e.parentNode.parentNode) {
	    r = e.parentNode.parentNode;
	}
	else if (e.parentElement && e.parentElement.parentElement) {
	    r = e.parentElement.parentElement;
	}
	if (r) {
	    if (r.className == "PubRow") {
		r.className = "PubRows";
	    }
	    else if (r.className == "SeccRow") {
		r.className = "SeccRows";
	    }
	}
    }

    function Unhighlight(e)
    {
	var r = null;
	if (e.parentNode && e.parentNode.parentNode) {
	    r = e.parentNode.parentNode;
	}
	else if (e.parentElement && e.parentElement.parentElement) {
	    r = e.parentElement.parentElement;
	}
	if (r) {
	    if (r.className == "PubRows") {
		r.className = "PubRow";
	    }
	    else if (r.className == "SeccRows") {
		r.className = "SeccRow";
	    }
	}
    }

    function AllChecked()
    {
	ml = document.ListPublicaciones;
	len = ml.elements.length;
	for(var i = 0 ; i < len ; i++) {
	    if (ml.elements[i].name == "Cod" && !ml.elements[i].checked) {
		return false;
	    }
	}
	return true;
    }