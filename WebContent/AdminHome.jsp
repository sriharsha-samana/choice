<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.net.InetAddress"%>
<%@page import="java.net.UnknownHostException"%>
<html>
<%	
		InetAddress ip = InetAddress.getLocalHost();
		String URL="http://"+ip.getHostAddress()+":"+request.getServerPort()+"/Choice/JSP/HomePageJSP/AdministratorWelcomePage.jsp";	
		session.setAttribute("preURL", URL);
		//URL="http://382c47cc.ngrok.com/Choice/JSP/HomePageJSP/AdministratorWelcomePage.jsp";	
		
%>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css" type="text/css">
		<script src="/Choice/JS/jquery.js"></script>

		<title>Choice</title>
		<script>
			$(document).ready(function()
			{
				var href = "<%=URL%>";
				$('#mainFrame').load(href);
			});
		</script>
	</head>
	
	<body>	
		<div id=mainFrame class="mainFrame">
		</div>
	</body>
	
</html>