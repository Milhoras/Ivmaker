<%
Sub GetFile_run()
   Dim Ftp
   ' Very important to handle errors!
   On Error Resume Next
   ' use Set so we get IntelliSense
   Set Ftp = Server.CreateObject("Dart.Ftp.1")
   ' reduce Timeout to 10 seconds from 30 second default
   Ftp.Timeout = 10000
   ' make the login request
   Ftp.Login Session("Host"), Session("User"), Session("Pass"), "", 21
   if Err = 0 then
      Dim Result
      ' initialize Result to a string
      Result = ""
      ' get the file
      Ftp.Retrieve File, Result, 0     
      if Err = 0 then
         ' show ALL the listing to the user
          GetResult = Result
      else
         ' report error and clear it
         GetResult = "Ftp.Retrieve failed: " & Err.Description
         Err.Clear
      end if
   else
      ' report error and clear it
      GetResult = "Ftp.Login failed: " & Err.Description
      Err.Clear
   end if
End Sub

if Request.Form("hdget") <> "" then
	Dim File
	Dim GetResult
	File = Request.Form("txtFile")
	GetFile_run()
end if
%>

