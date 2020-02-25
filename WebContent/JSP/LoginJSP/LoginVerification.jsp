<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="login.UserVerification"%>
<%@page import="java.io.File"%>

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
				String IsValidUser  = null;
				String strForwardURL = null;
				UserVerification verifyUser = new UserVerification();
				if(strUserName.equalsIgnoreCase("Administrator"))
					{
						IsValidUser = verifyUser.verifyAdministrator(strUserName, strPassword);
						strForwardURL = "/Choice/AdminHome.jsp";
					}
					else
						{
							IsValidUser= verifyUser.verifyUser(strUserName, strPassword);
							strForwardURL = "/Choice/Home.jsp";
						}
				if(IsValidUser.equals("No DB"))
					{
%>
						<script type="text/javascript">
						alert("Database not installed. Kindly contact Administrator!");
						window.open("/Choice/Login.jsp","_top");
						</script>
<%		
					}
			
			if(IsValidUser.equals("true"))
				{
					session.setAttribute("User", strUserName);	
					response.sendRedirect(strForwardURL);				
				}
			else if(IsValidUser.equals("false"))
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
					System.out.println("Exception in LoginVerfication.jsp::"+e);
%>
					<jsp:forward page="/JSP/ErrorJSP/Error.jsp"></jsp:forward>
<%
				}
%>
	</body>
	
</html>