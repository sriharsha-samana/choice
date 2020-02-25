<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Loading</title>
</head>
<body>
<%
	String strURL = request.getParameter("href");
%>
Please wait...
<img src="/Choice/Images/Icons/loadingBig.gif">
<jsp:forward page="<%=strURL%>"></jsp:forward>
</body>
<%
		}
}
%>
</html>