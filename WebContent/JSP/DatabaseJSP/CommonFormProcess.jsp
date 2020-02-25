<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="databaseActions.Actions"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.sql.rowset.CachedRowSet"%>
<%@page import="java.util.ArrayList"%>

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
	try
	{
		String strFormName = request.getParameter("formName");
		Actions action = new Actions();	
		String strWhere = null;
		String strDBTableName = null;
		String strNoOfFields = null;
		String strSuccessMessage = null;
		
		if(strFormName != null)
			{
				strWhere = "Name = '"+strFormName+"'";
			}
		
		CachedRowSet resultSetFormMaster = action.fetchDataFromDB("formmaster", null, strWhere);
	
			if(resultSetFormMaster.next())
				{
					strDBTableName = resultSetFormMaster.getString("TableName");
					strNoOfFields = resultSetFormMaster.getString("NumberOfFields");
					strSuccessMessage = resultSetFormMaster.getString("SuccessMessage");
					if(strSuccessMessage == null || strSuccessMessage.equalsIgnoreCase("") || strSuccessMessage.equalsIgnoreCase("NA") || strSuccessMessage.equalsIgnoreCase("null"))
					{
						strSuccessMessage = "New Entry added succesfully";
					}
				}
			else
				{
					strFormName = null;
				}
		
			if(strFormName != null)
			{
				String IsNewEntryAdded = null;
				String eachFieldName = null;
				String eachFieldValue = null;
				String eachDataBaseTableField = null;
				int NoOfFields = 0;
				try
				{
					NoOfFields = Integer.parseInt(strNoOfFields);
				}
				catch(Exception ex)
				{
					NoOfFields = 0;
				}
				String[] strDatabaseTableFields = new String[NoOfFields];
				String[] strValues = new String[NoOfFields];
				
				strWhere = "FormName = '"+strFormName+"'";
				CachedRowSet resultSetFormField = action.fetchDataFromDB("formfield", null, strWhere);
				int i = 0;
				while(resultSetFormField.next())
				{
					eachDataBaseTableField = resultSetFormField.getString("DBTableField");
					eachFieldName = resultSetFormField.getString("FieldName");
					eachFieldName = eachFieldName.replace(" ", "_");
					eachFieldValue = request.getParameter(eachFieldName);
					strDatabaseTableFields[i] = eachDataBaseTableField;
					strValues[i] = eachFieldValue;
					i++;
				}
				
				IsNewEntryAdded = action.AddNewEntry(strDBTableName, strDatabaseTableFields, strValues);
			
				if(IsNewEntryAdded.equals("true"))
				{
%>
					<script type="text/javascript">
						alert("<%=strSuccessMessage%>!");
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
				System.out.println("Exception in CommonFormProcess.jsp::"+e);
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