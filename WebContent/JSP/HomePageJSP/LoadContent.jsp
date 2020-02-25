<%@page import="files.FileActions"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	
	<head>
<%
if (session == null || session.getAttribute("User") == null) {
%>
		<script>
			window.open("/Choice/Login.jsp","_top");
		</script>
<%
}
if(request.getHeader("X-Requested-With") != null)
{
		
	if(request.getHeader("X-Requested-With").equalsIgnoreCase("XMLHttpRequest"))
		{
%>	
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css" type="text/css">
		<script src="/Choice/JS/CommonJS.js"></script>
		<script src="/Choice/JS/jquery.js"></script>
		
		<title>Welcome Page</title>	
		
	</head>

	
	<body>
		<div class="ActiveScreenObj" id="ActiveScreenObj" name="ActiveScreenObj">
			<div class="AboutUs" id="AboutUs" name="AboutUs">
				<div class="sub-heading" id="sub-heading" name="sub-heading"><%=request.getParameter("header")%></div>
<%

					String strContent=null;	
					String[] Parameters = new String[2];
					Parameters[0] = application.getRealPath("/Properties");
					Parameters[1] = request.getParameter("content")+".txt";
		
					FileActions readFile = new FileActions();	
					strContent = readFile.readTextFile(Parameters);
					if(strContent.equals("Error"))
						{
							strContent = "Error fetching data";
						}
%>
				<p><%=strContent%></p>
				
			</div>
			
		</div>

	</body>
<%
		}
}
%>
</html>