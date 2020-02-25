<%@page import="databaseActions.Actions"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.io.File"%>
<%@page import="javax.sql.rowset.CachedRowSet"%>
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

%>	
	<head>
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
		
		<title>Create Database</title>
		
	</head>
	
	<body>
<%
	try
		{
			String strDatabaseTableName = (String)session.getAttribute("tableName");
			String[][] resultArrayWithKeys = (String[][])session.getAttribute("resultArrayWithKeys");
			int rows = Integer.parseInt(resultArrayWithKeys[0][0]); 
			int columns = Integer.parseInt(resultArrayWithKeys[0][1]);
			String[] primaryKeys = new String[rows];
			
			for(int i=2;i<rows+2;i++)
				{
					for(int k=2;k<columns+2;k++)
						{
							if(resultArrayWithKeys[1][k].equalsIgnoreCase(strDatabaseTableName+"_UID"))
								{
									primaryKeys[i-2] = resultArrayWithKeys[i][k];
								}
						}
				}

			Actions deleteEntry = new Actions();
			
			String AreAllEntriesDeleted = "true";
			
			for(int a=0;a<primaryKeys.length;a++)
				{
					String isChecked = request.getParameter("EditableFieldsCheckbox"+(a+2)+"Text");
					String formName = null;
					if(strDatabaseTableName.equalsIgnoreCase("formmaster"))
					{
						CachedRowSet results = deleteEntry.fetchDataFromDB(strDatabaseTableName, null, "formmaster_UID = '"+primaryKeys[a]+"'");
						if(results.next())
						{
							formName = results.getString("Name");
						}
					}
					
					if(isChecked.equals("true"))
						{
							String IsEntryDeleted = deleteEntry.DeleteExistingEntry(strDatabaseTableName, primaryKeys[a]);	
							
							if(formName != null)
							{
								CachedRowSet results = deleteEntry.fetchDataFromDB("formfield", null, "formName = '"+formName+"'");
								while(results.next())
								{	
									String strPrimaryKey = results.getString("formfield_UID");
									IsEntryDeleted = deleteEntry.DeleteExistingEntry("formfield", strPrimaryKey);	
								}
								
							}
					
							if(!IsEntryDeleted.equals("true"))
								{
									AreAllEntriesDeleted = "false";
								}
							
						}
				}
			
			String strSuccessMessage = "Entries deleted successfully!";
			if(strDatabaseTableName.equalsIgnoreCase("formmaster"))
			{
				strSuccessMessage = "Form fields deleted successfully!";
			}
			else if(strDatabaseTableName.equalsIgnoreCase("tablemaster"))
			{
				strSuccessMessage = "Table fields deleted successfully!";
			}
			
			if(AreAllEntriesDeleted.equals("true"))
			{
%>
				<script type="text/javascript">
					alert("<%=strSuccessMessage%>");
					window.open("/Choice/AdminHome.jsp","_top");
				</script>
<%
			}
			else if(AreAllEntriesDeleted.equals("No DB"))
				{
%>
					<script type="text/javascript">
						alert("Database doesnot exist. Please create database!");
						window.open("/Choice/AdminHome.jsp","_top");
					</script>
				
<%
				}
				else if(AreAllEntriesDeleted.contains("already exists"))
					{
%>
						<script type="text/javascript">
							alert("Entry with same details already exists!");
							window.open("/Choice/AdminHome.jsp","_top");
						</script>
<%
					}
					else if(AreAllEntriesDeleted.contains("Invalid"))
						{
%>
							<script type="text/javascript">
								alert("<%=AreAllEntriesDeleted%>");
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
				System.out.println("Exception in DeleteExistingEntry.jsp ::"+e);
%>
				<jsp:forward page="/JSP/ErrorJSP/Error.jsp"></jsp:forward>
<%		
			}
%>

</body>

<%

%>
</html>