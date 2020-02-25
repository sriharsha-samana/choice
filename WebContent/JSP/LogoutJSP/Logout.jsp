<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css" type="text/css">
		<script src="/Choice/JS/CommonJS.js"></script>
		<script src="/Choice/JS/jquery.js"></script>

		<title>Log out</title>

	</head>
	
	<body>
<%
		session.removeAttribute("User");
		response.setHeader("Cache-control","no-store");
		response.setHeader("Pragma","no-cache");
		response.setDateHeader("Expire",0);
		session.invalidate();
%>
		<script type="text/javascript">
			window.open("/Choice/Login.jsp","_top");
		</script>
	
	</body>
	
</html>