<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="login.UserVerification"%>

<html>

	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css" type="text/css">
		<script src="/Choice/JS/CommonJS.js"></script>
		<script src="/Choice/JS/jquery.js"></script>
	
		<title>LoginVerification</title>	
		
	</head>
	
	<body>
<%
	try
		{	
			String strUserName = request.getParameter("username");
			String strPassword = request.getParameter("password");
			UserVerification verifyUser = new UserVerification();
				
			boolean IsValidUser;
			
			if(strUserName.equals("Administrator") && strPassword.equals("123qwe!@#"))
				{
					IsValidUser = true;
				}
			else
				{
					IsValidUser = false;
				}
				
			
			if(IsValidUser)
				{
					session.setAttribute("User", strUserName);
					response.sendRedirect("/Choice/AdminHome.jsp");
				}
			else
				{
%>
					<script type="text/javascript">
					alert("Wrong Details!!");
					window.open("/Choice/Login.jsp","_top");
					</script>
<%		
				}
		}
		catch(Exception e)
			{
				System.out.println("Exception in AdministratorLoginVerification.jsp ::"+e);
%>
				<jsp:forward page="/JSP/ErrorJSP/Error.jsp"></jsp:forward>
<%
			}
%>
	</body>
	
</html>