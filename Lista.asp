<%
Constr="Provider=SQLOLEDB;Initial Catalog=ivmaker;Data Source=agurojiv;User ID=sa;Password="
Set Conn= server.createObject("adodb.Connection")
Conn.open constr
%>

			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td align="center"><font size="3" face="arial"><strong>Relaci&oacute;n de Bases </strong></font></td>
				</tr>
				<tr>
					<td>&nbsp;<input type="hidden" name="DataBase" value=""></td>
				</tr>
<%	wselect = "sp_helpdb"
		set bases = server.CreateObject("ADODB.Recordset")
		bases.Open wselect, constr
		i = 0
		do while not bases.EOF
			i = i + 1%>
				<tr>
					<td><font size="2" face="arial"><%=i%>.<%=bases.Fields.Item(0).Value%></font></td>
				</tr>
<%		bases.MoveNext
		loop
		bases.Close
		set bases = nothing%>
			</table>


<%	if trim(strDataBase)= "" then
			MaxCols = 4%>
<%		Set Tablas = Server.CreateObject("ADODB.Recordset")
			Set Tablas = conn.OpenSchema(20)%>
<%		if not Tablas.eof then%>
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td align="center" colspan="<%=MaxCols%>"><font size="3" face="arial"><strong>Relaci&oacute;n de tablas de "<%=strDataBase%>"</strong></font></td>
				</tr>
				<tr><td colspan="<%=MaxCols%>">&nbsp;</td></tr>
<%			k = 0
				do while not Tablas.eof
					if Tablas("TABLE_TYPE") = "TABLE" then
						k = k + 1
						c = c +1
						if c = 1 then Response.Write("<tr>")%>
					<td>
						<input type="checkbox" name="Tabla" value="<%=Tablas("TABLE_NAME")%>" <%if Tablas("TABLE_NAME") = Tabla then Response.Write " checked"%>>
						<font size="2" face="arial"><%=Tablas("TABLE_NAME")%></font>
					</td>
<%					if c = MaxCols then
							c = 0
							Response.Write("</tr>")
						end if%>
<%				end if
					Tablas.Movenext
				loop
				if c > 0 then Response.Write("<td colspan=" & MaxCols - c & ">&nbsp;</td></tr>")%>
			<tr>
				<td align="center" colspan="<%=MaxCols%>"><br>
<%			if k > 0 then%>
					<table width="80%" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td align="center"><input type="checkbox" name="Todas" value="1" onclick="CheckTodas()"><font size="2" face="Arial">&nbsp;Chequear todas</font>
							</td>
							<td align="center"><input type="checkbox" name="Delete" value="1" onclick="DeleteTablas()"><font size="2" face="Arial">&nbsp;Borrar datos que existan en la base destino</font>
							</td>
							<td align="center"><input type="Submit" name="Procesar" value="Grabar Tablas"
							onclick="document.FormCargaBd.DataBase.value='<%=strDataBase%>'">
							</td>
						</tr>
					</table>
<%			else%>
				<font size="2" face="Arial">No hay tablas en <%=strDataBase%></font>
<%			end if%>
<%		end if
			Tablas.Close
			set Tablas = nothing%>
				</td>
			</tr>
		</table>
<%	end if%>

campos

	<%


	strFields = "*"
	strTable="notas"
	set xConn = Server.CreateObject("ADODB.Connection")
xConn.Open constr

' Build Query
		strsql = "SELECT " & strFields & " FROM " & strTable


set xrs = Server.CreateObject("ADODB.Recordset")
xrs.Open strsql, xConn

intFieldCount = xrs.Fields.Count
Dim aFields()
ReDim aFields(intFieldCount,4)

' Get field info
	ReDim arrFieldNames(intFieldCount)
	For x = 1 to intFieldCount
		aFields(x, 1) = xrs.Fields(x-1).Name
		aFields(x, 2) = xrs.Fields(x-1).Type
		aFields(x, 3) = xrs.Fields(x-1).DefinedSize
		aFields(x, 4) = 0 ' For running totals (per dbTotalFields)
		arrFieldNames(x-1) = xrs.Fields(x-1).Name
	Next

' Are totals required
If Trim(strTotalFields) = "" Then strTotalFields = String(intFieldCount,"0")

xrs.Close
Set xrs = Nothing
response.write("<table>")
do while contador <= intFieldCount
	response.write("<tr><td>Nombre: "&aFields(contador,1)&"</td><td>")
	response.write("Tipo: "&aFields(contador,2)&"</td><td>")
	response.write("Tamaño: "&aFields(contador,3)&"</td><td>")
	response.write(aFields(contador,4)&"</td><td></tr>")
	contador=contador+1
loop
response.write("</table>")
	%>


