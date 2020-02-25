<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="databaseActions.Actions"%>
<%@page import="java.io.File"%><html>
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
		
		
		<title>Create New Table</title>
	</head>

	<body>
		<div id = Formheader class = "Formheader">
			Transaction in progress...
			</div>
		
<%
	try
		{
			
			String strDatabaseTableName = request.getParameter("DatabaseTableName");
			String[] strNames = new String[7];
			String[] strValues = new String[7];
			String[] strDatabaseTableFields = new String[7];
			
			
			String strTempValue = null;
			strNames[0]= "Name";
			strTempValue = request.getParameter("Name");
			strTempValue = strTempValue.trim();
			strValues[0]= strTempValue;
			strTempValue = request.getParameter("NameDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[0]= strTempValue;
			
			strNames[1]= "Database_Table_Name";
			strTempValue = request.getParameter("Database_Table_Name");
			strTempValue = strTempValue.trim();
			strValues[1]= strTempValue;
			strTempValue = request.getParameter("Database_Table_NameDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[1]= strTempValue;
			
			strNames[2]= "Where_Condition";
			strTempValue = request.getParameter("Where_Condition");
			strTempValue = strTempValue.trim();
			strValues[2]= strTempValue;
			strTempValue = request.getParameter("Where_ConditionDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[2]= strTempValue;
			
			strNames[3]= "Fields";
			strTempValue = request.getParameter("Fields");
			strTempValue = strTempValue.trim();
			strValues[3]= strTempValue;
			strTempValue = request.getParameter("FieldsDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[3]= strTempValue;
			
			strNames[4]= "Heading";
			strTempValue = request.getParameter("Heading");
			strTempValue = strTempValue.trim();
			strValues[4]= strTempValue;
			strTempValue = request.getParameter("HeadingDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[4]= strTempValue;
			
			strNames[5]= "Sub_Heading";
			strTempValue = request.getParameter("Sub_Heading");
			strTempValue = strTempValue.trim();
			strValues[5]= strTempValue;
			strTempValue = request.getParameter("Sub_HeadingDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[5]= strTempValue;
			
			strNames[6]= "Title";
			strTempValue = request.getParameter("Title");
			strTempValue = strTempValue.trim();
			strValues[6]= strTempValue;
			strTempValue = request.getParameter("TitleDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[6]= strTempValue;
			
			String[] Parameters = new String[10];
			Actions toAdd = new Actions();
			String IsNewEntryAdded = toAdd.AddNewEntry(strDatabaseTableName, strDatabaseTableFields, strValues);
		
			if(IsNewEntryAdded.equals("true"))
				{
%>
					<script type="text/javascript">
						alert("New Table Search Results Page created Successfully!");
						window.open("/Choice/AdminHome.jsp","_top");
					</script>
<%
				}
				else if(IsNewEntryAdded.equals("No DB"))
					{
%>
						<script type="text/javascript">
							alert("Database doesnot exist. Please create database.");
							window.open("/Choice/AdminHome.jsp","_top");
						</script>
					
<%
					}
					else if(IsNewEntryAdded.equals("Entry already exists"))
						{
%>
							<script type="text/javascript">
								alert("Table Page with same Name already exists!!");
								window.open("/Choice/AdminHome.jsp","_top");
							</script>
<%
						}
						else
							{
%>
								<script type="text/javascript">
									alert("Something went wrong! Please try again.");
									window.open("/Choice/AdminHome.jsp","_top");
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

<%
		}
}
%>
</html>