<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="databaseActions.Actions"%>
<%@page import="java.io.File"%><html>
	<%if (session == null || session.getAttribute("User") == null) {%><script>window.open("/Choice/Login.jsp","_top");</script><%}if(request.getHeader("X-Requested-With") != null){if(request.getHeader("X-Requested-With").equalsIgnoreCase("XMLHttpRequest")){%>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/globals.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/typography.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/grid.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/ui.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/forms.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/orbit.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/reveal.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/mobile.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/app.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/responsive-tables.css"><link rel="stylesheet" href="/Choice/CSS/Common/jquery-ui.css"><link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css"><script src="/Choice/JS/ResponsiveTables/jquery.min.js"></script><script src="/Choice/JS/ResponsiveTables/responsive-tables.js"></script><script src="/Choice/JS/CommonJS.js"></script><script src="/Choice/JS/jquery-ui.js"></script>
		<script src="/Choice/JS/ResponsiveTables/jquery.min.js"></script>
		<script src="/Choice/JS/CommonJS.js"></script>
		<script src="/Choice/JS/jquery.js"></script>
		
<%
		%>
		<script type="text/javascript">
			
			</script>
		
		<title>Reminder details</title>
	</head>

	<body>
		<div id = Formheader class = "Formheader">
			Transaction in progress...
		</div>
<%
	try
		{
			
			String strDatabaseTableName = request.getParameter("DatabaseTableName");
			String[] strNames = new String[5];
			String[] strValues = new String[5];
			String[] strDatabaseTableFields = new String[5];
			
			
			String strTempValue = null;
			strNames[0]= "Name";
			strTempValue = request.getParameter("Name");
			strTempValue = strTempValue.trim();
			strValues[0]= strTempValue;
			strTempValue = request.getParameter("NameDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[0]= strTempValue;
			
			strNames[1]= "RemindPerson";
			strTempValue = request.getParameter("RemindPerson");
			strTempValue = strTempValue.trim();
			strValues[1]= strTempValue;
			strTempValue = request.getParameter("RemindPersonDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[1]= strTempValue;
			
			strNames[2]= "ReminderDate";
			strTempValue = request.getParameter("ReminderDate");
			strTempValue = strTempValue.trim();
			strValues[2]= strTempValue;
			strTempValue = request.getParameter("ReminderDateDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[2]= strTempValue;
			
			strNames[3]= "Message";
			strTempValue = request.getParameter("Message");
			strTempValue = strTempValue.trim();
			strValues[3]= strTempValue;
			strTempValue = request.getParameter("MessageDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[3]= strTempValue;
			
			strNames[4]= "User";
			strValues[4]= (String)session.getAttribute("User");
			strDatabaseTableFields[4]= "User";
			
			
			Actions toAdd = new Actions();
			String IsNewEntryAdded = toAdd.AddNewEntry(strDatabaseTableName, strDatabaseTableFields, strValues);
			
			if(IsNewEntryAdded.equals("true"))
				{
%>
					<script type="text/javascript">
						alert("Reminder set Successfully!");
						window.open("/Choice/Home.jsp","_top");
					</script>
<%
				}
				else if(IsNewEntryAdded.equals("No DB"))
					{
%>
						<script type="text/javascript">
							alert("Database doesnot exist. Please create database.");
							window.open("/Choice/Home.jsp","_top");
						</script>
					
<%
					}
					else if(IsNewEntryAdded.equals("Entry already exists"))
						{
%>
							<script type="text/javascript">
								alert("Entry already exists!!");
								window.open("/Choice/Home.jsp","_top");
							</script>
<%
						}
						else
							{
%>
								<script type="text/javascript">
									alert("Something went wrong! Please try again.");
									window.open("/Choice/Home.jsp","_top");
								</script>
<%
						}
						
		}
		catch(Exception e)
			{
				System.out.println("Exception::"+e);
%>
				<jsp:forward page="../ErrorJSP/Error.jsp"></jsp:forward>
<%
			}
%>

	</body>


<%}}%>


</html>