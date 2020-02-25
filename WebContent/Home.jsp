<%@page import="java.net.InetAddress"%>
<%@page import="java.net.UnknownHostException"%>
<html>
<%
		InetAddress ip = InetAddress.getLocalHost();
		String URL="http://"+ip.getHostAddress()+":"+request.getServerPort()+"/Choice/JSP/HomePageJSP/WelcomePage.jsp";
		session.setAttribute("preURL", URL);
		//String URL="http://382c47cc.ngrok.com/Choice/JSP/HomePageJSP/WelcomePage.jsp";
%>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css" type="text/css">
		<script src="/Choice/JS/jquery.js"></script>

		<title>Welcome</title>
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