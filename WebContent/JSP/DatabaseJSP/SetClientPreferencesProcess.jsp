<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="databaseActions.Actions"%>
<%@page import="javax.sql.rowset.CachedRowSet"%>
<%@page import="java.io.File"%><html>
	<%if (session == null || session.getAttribute("User") == null) {%><script>window.open("/Choice/Login.jsp","_top");</script><%}if(request.getHeader("X-Requested-With") != null){if(request.getHeader("X-Requested-With").equalsIgnoreCase("XMLHttpRequest")){%>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/globals.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/typography.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/grid.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/ui.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/forms.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/orbit.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/reveal.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/mobile.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/app.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/responsive-tables.css"><link rel="stylesheet" href="/Choice/CSS/Common/jquery-ui.css"><link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css"><script src="/Choice/JS/ResponsiveTables/jquery.min.js"></script><script src="/Choice/JS/ResponsiveTables/responsive-tables.js"></script><script src="/Choice/JS/CommonJS.js"></script><script src="/Choice/JS/jquery-ui.js"></script>
		<script src="/Choice/JS/CommonJS.js"></script>
		<script src="/Choice/JS/jquery.js"></script>
		
<%
		%>
		<script type="text/javascript">
			
			</script>
		
		<title>Set Preferences</title>
	</head>

	<body>
		<div id = Formheader class = "Formheader">
			Transaction in progress...
		</div>
<%
	try
		{
			Actions action = new Actions();
			String strDatabaseTableName = request.getParameter("DatabaseTableName");
			String[] strNames = new String[3];
			String[] strValues = new String[3];
			String[] strDatabaseTableFields = new String[3];
			
			
			String strTempValue = null;
			strNames[0]= "BackgroundColor";
			strTempValue = request.getParameter("BackgroundColor");
			strTempValue = strTempValue.trim();
			strValues[0]= strTempValue;
			strTempValue = request.getParameter("BackgroundColorDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[0]= strTempValue;
			
			strValues[1]= "BackgroundColor";
			strDatabaseTableFields[1]= "Name";
			
			strValues[2]= (String)session.getAttribute("User");
			strDatabaseTableFields[2]= "User";
			
			String IsNewEntryAdded = "";
			
			CachedRowSet checkExistingBGColor = action.fetchDataFromDB(strDatabaseTableName, null, "Name = 'BackgroundColor' AND User = '"+(String)session.getAttribute("User")+"'");
			if(checkExistingBGColor.next())
			{
				String strPrimaryKey = checkExistingBGColor.getString(strDatabaseTableName+"_UID");
				IsNewEntryAdded = action.UpdateExistingEntry(strDatabaseTableName, strPrimaryKey, strDatabaseTableFields, strValues);
			}
			else
			{
				IsNewEntryAdded = action.AddNewEntry(strDatabaseTableName, strDatabaseTableFields, strValues);
			}
			
			strNames[0]= "HomePage";
			strTempValue = request.getParameter("HomePage");
			strTempValue = strTempValue.trim();
			strValues[0]= strTempValue;
			strTempValue = request.getParameter("HomePageDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[0]= strTempValue;
			
			strValues[1]= "HomePage";
			strDatabaseTableFields[1]= "Name";

			
			CachedRowSet checkExistingHomePage = action.fetchDataFromDB(strDatabaseTableName, null, "Name = 'HomePage' AND User = '"+(String)session.getAttribute("User")+"'");
			if(checkExistingHomePage.next())
			{
				String strPrimaryKey = checkExistingHomePage.getString(strDatabaseTableName+"_UID");
				if(!strValues[0].equalsIgnoreCase("Nothing"))
				{
					IsNewEntryAdded = action.UpdateExistingEntry(strDatabaseTableName, strPrimaryKey, strDatabaseTableFields, strValues);
				}
				else
				{
					IsNewEntryAdded = action.DeleteExistingEntry(strDatabaseTableName, strPrimaryKey);
				}
			}
			else
			{
				if(!strValues[0].equalsIgnoreCase("Nothing"))
				{
					IsNewEntryAdded = action.AddNewEntry(strDatabaseTableName, strDatabaseTableFields, strValues);
				}
			}
			
			
			if(IsNewEntryAdded.equals("true"))
				{
%>
					<script type="text/javascript">
						alert("Preferences set successfully!");
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