<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="databaseActions.Actions"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.sql.rowset.CachedRowSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>

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
	</head>
	<body>	
<%
		Actions action = new Actions();	
		String DBTableName = "usergroups";
		String strPrimaryKey = null;
		String strSelectedFields = request.getParameter("selectedFields");
		List<String> SelectedFields = Arrays.asList(strSelectedFields.split(","));
		String actionDone = "false:Action Failed!";
		try
		{
				for(int i=0;i<SelectedFields.size();i++)
				{
					String eachSelectedField = SelectedFields.get(i);
					String strWhere = "Name = '"+eachSelectedField+"'";
					CachedRowSet resultSetSideNavigator = action.fetchDataFromDB(DBTableName, null, strWhere);
					if(resultSetSideNavigator.next())
					{
						strPrimaryKey = resultSetSideNavigator.getString(DBTableName+"_UID");
					}
					if(strPrimaryKey != null)
					{
						actionDone = action.DeleteExistingEntry(DBTableName, strPrimaryKey);
						
						CachedRowSet existingUsersInGroup = action.fetchDataFromDB("userstable", null, "UserGroup = '"+eachSelectedField+"'");
						while(existingUsersInGroup.next())
						{
							strPrimaryKey = existingUsersInGroup.getString("userstable_UID");
							actionDone = action.DeleteExistingEntry("userstable", strPrimaryKey);
						}
						
					}
				}
				
				if(actionDone.contains("true"))
					{
%>
						<script>
							window.alert("User Groups deleted Successsfully!");
							window.open("/Choice/AdminHome.jsp","_top");
						</script>
<%						
					}
					else
						{
%>
						<script>
							window.alert("Something went wrong. Please try again!");
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