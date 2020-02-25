<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="databaseActions.Actions"%>
<%@page import="java.io.File"%>
<%@page import="javax.sql.rowset.CachedRowSet"%>
<%@ page import="com.oreilly.servlet.*" %> 
<html>
<%
if (session == null || session.getAttribute("User") == null || !session.getAttribute("User").equals("Administrator")) {
%>
		<script>
			window.open("/Choice/Login.jsp","_top");
		</script>
<%
}

%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<!--<link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css" type="text/css">-->
		<script src="/Choice/JS/CommonJS.js"></script>
		<script src="/Choice/JS/jquery.js"></script>
		
		
		<title>Set Logo</title>
	</head>

	<body>
		<div id = Formheader class = "Formheader">
			Transaction in progress...
		</div>
<%
	try
		{

			File appFolder = new File(application.getRealPath("/"));
			String strApplicationPath = appFolder.toURL().toString();
			strApplicationPath = strApplicationPath.substring(strApplicationPath.indexOf("file:/")+6, strApplicationPath.length());
			strApplicationPath += "/Images/Icons";
			MultipartRequest m = new MultipartRequest(request, strApplicationPath);
			
			String strDatabaseTableName = m.getParameter("DatabaseTableName");
			String[] strNames = new String[3];
			String[] strValues = new String[3];
			String[] strDatabaseTableFields = new String[3];
			
			
			String strTempValue = null;
			strNames[0]= "Name";
			strTempValue = m.getParameter("Name");
			strTempValue = strTempValue.trim();
			strValues[0]= strTempValue;
			strTempValue = m.getParameter("NameDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[0]= strTempValue;
			
			strNames[1]= "Value";
			strTempValue = m.getOriginalFileName("Value");
			strTempValue = strTempValue.trim();
			strValues[1]= strTempValue;
			strTempValue = m.getParameter("ValueDatabaseTableFieldName");
			strTempValue = strTempValue.trim();
			strDatabaseTableFields[1]= strTempValue;
			
			strNames[2]= "User";
			strValues[2]= (String)session.getAttribute("User");
			strDatabaseTableFields[2]= "User";
			
			String[] Parameters = new String[10];
			String IsNewEntryAdded = "fasle";
			
			Actions action = new Actions();
			CachedRowSet checkExistingLogo = action.fetchDataFromDB(strDatabaseTableName, null, "Name = 'Logo'");
			if(checkExistingLogo.next())
			{
				String strPrimaryKey = checkExistingLogo.getString(strDatabaseTableName+"_UID");
				IsNewEntryAdded = action.UpdateExistingEntry(strDatabaseTableName, strPrimaryKey, strDatabaseTableFields, strValues);
			}
			else
			{
				IsNewEntryAdded = action.AddNewEntry(strDatabaseTableName, strDatabaseTableFields, strValues);
			}
			
			
			if(IsNewEntryAdded.equals("true"))
				{
%>
					<script type="text/javascript">
						alert("Cleint Logo updated Successfully!");
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
								alert("Entry already exists!!");
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

%>
</html>