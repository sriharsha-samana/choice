<%@page import="databaseActions.Actions"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
		  <!-- Included CSS Files -->
		  <!-- Combine and Compress These CSS Files -->
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/globals.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/typography.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/grid.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/ui.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/forms.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/orbit.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/reveal.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/mobile.css">
			  <link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css" type="text/css">
		  <!-- End Combine and Compress These CSS Files -->
				<link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/app.css">
				<link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/responsive-tables.css">
				<script src="/Choice/JS/ResponsiveTables/jquery.min.js"></script>
				<script src="/Choice/JS/ResponsiveTables/responsive-tables.js"></script>
				<script src="/Choice/JS/CommonJS.js"></script>

		
		<title>Create Database</title>
		
	</head>
	
	<body>
<%
	try
		{
			String strDatabase = request.getParameter("Database");	
			File appFolder = new File(application.getRealPath("/"));
			String strApplicationPath = appFolder.toURL().toString();
			strApplicationPath = strApplicationPath.substring(strApplicationPath.indexOf("file:/")+6, strApplicationPath.length());

			String strDatabaseFilePath;
			String strDatabaseName;
			String strServerName;
			String strPort;
			String strDBUsername;
			String strDBPassword;
			String[] Parameters = new String[5];
			
			if(strDatabase.equalsIgnoreCase("Access"))
				{
					strDatabaseFilePath = request.getParameter("DatabaseFilePath");
					Parameters[0] = strDatabaseFilePath;
				}
			
			if(strDatabase.equalsIgnoreCase("MySQL"))
			{
				strDatabaseName = request.getParameter("DatabaseName");
				strServerName = request.getParameter("ServerURL");
				strPort = request.getParameter("Port");
				strDBUsername = request.getParameter("DBUsername");
				strDBPassword = request.getParameter("DBPassword");
				Parameters[0] = strDatabaseName;
				Parameters[1] = strServerName;
				Parameters[2] = strPort;
				Parameters[3] = strDBUsername;
				Parameters[4] = strDBPassword;
			}
			
			Actions createDB = new Actions();

			boolean IsDataBaseCreated = createDB.createDatabase(strDatabase,strApplicationPath,Parameters);
			
			if(IsDataBaseCreated)
				{
%>
						<script type="text/javascript">
						alert("Database successfully created.");
						window.open("/Choice/AdminHome.jsp","_top");
						</script>
<%
				}
			else
				{
%>
						<script type="text/javascript">
						alert("Something went wrong!!\nPlease try again.");
						window.open("/Choice/AdminHome.jsp","_top");
						</script>
<%		
				}
		}
		catch(Exception e)
			{
				System.out.println("Exception::"+e);
%>
				<jsp:forward page="/JSP/ErrorJSP/Error.jsp"></jsp:forward>
<%
			}
%>
	
	</body>
<%
		}
}
%>
</html>