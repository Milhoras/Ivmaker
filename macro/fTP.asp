<HTML>
<HEAD>
<!-- #include file="enviarvideo.asp"-->
<!-- #include file="enviarvideo2.asp"-->
<TITLE>Dart Communications FTP Demo for ActiveX</TITLE>
<style type="text/css">
	BODY { FONT-SIZE: 70%; FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif }
	TD { FONT-SIZE: 70% }
</style>

<%if request("submit1")<>"" then
	GetListing_run
end if
if request("dos")<>"" then
	GetFile_run
end if
%>
</HEAD>
<BODY topmargin="40" leftmargin="40">
<p><b>FTP Demo (ActiveX)</b></p>

Use FTP to get file listings and download/upload files. Potential applications:
<ul>
<li>View remote files through a browser interface 
<li>Dynamically download files for script processing by the server 
<li>Dynamically generate files and upload them to any FTP 
  server</li>          
</ul>
<form name="form1" action="ftp.asp" method="post">
Host:<input name="txtHost" >&nbsp;&nbsp;&nbsp;User:<input name="txtUser" >&nbsp;&nbsp;&nbsp;Password:<input type="password" name="txtPass"><br><br>
<input type="submit" value="Get Listing" id=submit1 name=submit1>&nbsp;&nbsp;&nbsp;<input type="button" value="View Script" onClick="location.replace('FtpList.inc');" id=button1 name=button1><br><br>
</form>
<form name="form2" action="ftp.asp" method="post">

	File:<input name='txtFile' >

&nbsp;&nbsp;&nbsp;<input type="submit" value="Get File" name="dos">&nbsp;&nbsp;&nbsp;<input type="button" value="View Script" onClick="location.replace('FtpGet.inc');" id=button2 name=button2><br><br><TEXTAREA name=taresult rows=15 cols=75></TEXTAREA>
	
<input type="hidden" name="hdget" value="true">
</form>
</BODY>
</html>
