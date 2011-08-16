<%
Sub GetListing_run()
Response.Write("Entre<br>")
   Dim Ftp
   ' Very important to handle errors!
   On Error Resume Next
   ' use Set so we get IntelliSense
   Set Ftp = Server.CreateObject("Dart.Ftp.1")
   ' reduce Timeout to 20 seconds from 30 second default
   Ftp.Timeout = 20000
   ' make the login request
   Ftp.Login Host, User, Pass
   Response.Write("envio la orden de conexion<br>")
   ' get a listing
   If Err = 0 Then
      ' request a full recursive listing
      Ftp.List "-lr"     
      Response.Write("solicita listado<br>")     
      if Err = 0 Then
         ' show ALL the listing to the user
         ListResult = Ftp.Listing.Text
         ' prefill File edit box with first .txt file found
         Dim Entry
         For Each Entry In Ftp.Listing
            if InStr (Entry.Name, "txt") Then
               Firsttxt = Entry.Name
               Exit For
            End If
         Next
      Else
         ' report error and clear it
         ListResult = "Ftp.List failed: " & Err.Description
         Err.Clear
      End If
   Else
      ' report error and clear it
      ListResult = "Ftp.Login failed: " & Err.Description
      Err.Clear
   End If
   Response.Write(ListResult & "<br>")
End Sub

if Session("Host") = "" then
	Dim Host
	Dim User
	Dim Pass
	Dim ListResult
	Dim Firsttxt
	Host = Request.Form("txtHost")
	User = Request.Form("txtUser")
	Pass = Request.Form("txtPass")
	Session("Host") = Host
	Session("User") = User
	Session("Pass") = Pass
	GetListing_run()
end if
%>