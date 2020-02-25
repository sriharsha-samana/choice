<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="databaseActions.Actions"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>

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

<%
try
	{
		String strAction = request.getParameter("action");
		String actionCompleted = "false:No Action performed!";
		Actions action = new Actions();
		
		if(strAction.equalsIgnoreCase("changeTableName"))
		{
			String strOldTableName = request.getParameter("oldTableName");
			String strNewTableName = request.getParameter("newTableName");
			actionCompleted = action.changeTableName(strOldTableName, strNewTableName);
		}
		else if(strAction.equalsIgnoreCase("deleteTable"))
		{
			String strTableName = request.getParameter("tableName");
			actionCompleted = action.deleteTable(strTableName);
		}
		else if(strAction.equalsIgnoreCase("updateTableFields"))
		{
			String strTableName = request.getParameter("tableName").trim();
			String strTableFieldNames = request.getParameter("fieldNames").trim();
			List<String> DatabaseTableFieldsList = Arrays.asList(strTableFieldNames.split(","));
			String strOldTableFieldNames = request.getParameter("oldFieldNames").trim();
			List<String> DatabaseTableOldFieldsList = Arrays.asList(strOldTableFieldNames.split(","));
			String[] DatabaseTableFields = new String[DatabaseTableFieldsList.size()];
			String[] DatabaseTableOldFields = new String[DatabaseTableFieldsList.size()];
			String strTableFieldTypes = request.getParameter("fieldTypes").trim();
			List<String> DatabaseTableFieldTypesList = Arrays.asList(strTableFieldTypes.split(","));
			String[] DatabaseTableFieldTypes = new String[DatabaseTableFieldsList.size()];
			String strTableFieldSizes = request.getParameter("fieldSizes").trim();
			List<String> DatabaseTableFieldSizesList = Arrays.asList(strTableFieldSizes.split(","));
			String[] DatabaseTableFieldSizes = new String[DatabaseTableFieldsList.size()];
			String strTableFieldNullConstraints = request.getParameter("fieldNullConstraints").trim();
			List<String> DatabaseTableFieldNullConstraintsList = Arrays.asList(strTableFieldNullConstraints.split(","));
			String[] DatabaseTableFieldConstraints = new String[DatabaseTableFieldsList.size()];
			String strTableFieldUniqueConstraints = request.getParameter("fieldUniqueConstraints").trim();
			List<String> DatabaseTableFieldUniqueConstraintsList = Arrays.asList(strTableFieldUniqueConstraints.split(","));
			String strTableFieldDefaultValues = request.getParameter("fieldDefaultValues").trim();
			List<String> DatabaseTableFieldDefaultValuesList = Arrays.asList(strTableFieldDefaultValues.split(","));
			String[] DatabaseTableFieldDefaults = new String[DatabaseTableFieldsList.size()];
			for(int i=0;i<DatabaseTableFieldsList.size();i++)
			{
				DatabaseTableFields[i] = DatabaseTableFieldsList.get(i).trim();
				DatabaseTableOldFields[i] = DatabaseTableOldFieldsList.get(i).trim();
				DatabaseTableFieldTypes[i] = DatabaseTableFieldTypesList.get(i).trim();
				DatabaseTableFieldSizes[i] = DatabaseTableFieldSizesList.get(i).trim();
				String tempConstraintsString = "Not Selected";
				if(DatabaseTableFieldNullConstraintsList.get(i).trim().equalsIgnoreCase("YES"))
				{
					tempConstraintsString = "NOT NULL";
				}
				if(DatabaseTableFieldUniqueConstraintsList.get(i).trim().equalsIgnoreCase("YES"))
				{
					if(tempConstraintsString.equalsIgnoreCase("Not Selected"))
					{
						tempConstraintsString = "UNIQUE";
					}
					else
					{
					tempConstraintsString += ",UNIQUE";
					}
				}
				DatabaseTableFieldConstraints[i] = tempConstraintsString.trim();
				DatabaseTableFieldDefaults[i] = DatabaseTableFieldDefaultValuesList.get(i).trim();
			}
			
			actionCompleted = action.updateExistingTableFields(strTableName, DatabaseTableOldFields, DatabaseTableFields, DatabaseTableFieldTypes, DatabaseTableFieldSizes, DatabaseTableFieldConstraints, DatabaseTableFieldDefaults);
		}
		else if(strAction.equalsIgnoreCase("deleteTableFields"))
		{
			String strTableName = request.getParameter("tableName").trim();
			String strTableFieldNames = request.getParameter("fieldNames").trim();
			List<String> DatabaseTableFieldsList = Arrays.asList(strTableFieldNames.split(","));
			String[] DatabaseTableFields = new String[DatabaseTableFieldsList.size()];
			
			for(int i=0;i<DatabaseTableFieldsList.size();i++)
			{
				DatabaseTableFields[i] = DatabaseTableFieldsList.get(i).trim();
			}
			
			actionCompleted = action.deleteExistingTableFields(strTableName, DatabaseTableFields);
		}
		else if(strAction.equalsIgnoreCase("addNewTableFields"))
		{
			String strTableName = request.getParameter("tableName").trim();
			String strTableFieldNames = request.getParameter("fieldNames").trim();
			List<String> DatabaseTableFieldsList = Arrays.asList(strTableFieldNames.split(","));
			String[] DatabaseTableFields = new String[DatabaseTableFieldsList.size()];
			String strTableFieldTypes = request.getParameter("fieldTypes").trim();
			List<String> DatabaseTableFieldTypesList = Arrays.asList(strTableFieldTypes.split(","));
			String[] DatabaseTableFieldTypes = new String[DatabaseTableFieldsList.size()];
			String strTableFieldSizes = request.getParameter("fieldSizes").trim();
			List<String> DatabaseTableFieldSizesList = Arrays.asList(strTableFieldSizes.split(","));
			String[] DatabaseTableFieldSizes = new String[DatabaseTableFieldsList.size()];
			String strTableFieldNullConstraints = request.getParameter("fieldNullConstraints").trim();
			List<String> DatabaseTableFieldNullConstraintsList = Arrays.asList(strTableFieldNullConstraints.split(","));
			String[] DatabaseTableFieldConstraints = new String[DatabaseTableFieldsList.size()];
			String strTableFieldUniqueConstraints = request.getParameter("fieldUniqueConstraints").trim();
			List<String> DatabaseTableFieldUniqueConstraintsList = Arrays.asList(strTableFieldUniqueConstraints.split(","));
			String strTableFieldDefaultValues = request.getParameter("fieldDefaultValues").trim();
			List<String> DatabaseTableFieldDefaultValuesList = Arrays.asList(strTableFieldDefaultValues.split(","));
			String[] DatabaseTableFieldDefaults = new String[DatabaseTableFieldsList.size()];
			for(int i=0;i<DatabaseTableFieldsList.size();i++)
			{
				DatabaseTableFields[i] = DatabaseTableFieldsList.get(i).trim();
				DatabaseTableFieldTypes[i] = DatabaseTableFieldTypesList.get(i).trim();
				DatabaseTableFieldSizes[i] = DatabaseTableFieldSizesList.get(i).trim();
				String tempConstraintsString = "Not Selected";
				if(DatabaseTableFieldNullConstraintsList.get(i).trim().equalsIgnoreCase("YES"))
				{
					tempConstraintsString = "NOT NULL";
				}
				if(DatabaseTableFieldUniqueConstraintsList.get(i).trim().equalsIgnoreCase("YES"))
				{
					if(tempConstraintsString.equalsIgnoreCase("Not Selected"))
					{
						tempConstraintsString = "UNIQUE";
					}
					else
					{
					tempConstraintsString += ",UNIQUE";
					}
				}
				DatabaseTableFieldConstraints[i] = tempConstraintsString.trim();
				DatabaseTableFieldDefaults[i] = DatabaseTableFieldDefaultValuesList.get(i).trim();
			}
			
			actionCompleted = action.addNewTableFields(strTableName, DatabaseTableFields, DatabaseTableFieldTypes, DatabaseTableFieldSizes, DatabaseTableFieldConstraints, DatabaseTableFieldDefaults);
		}
		
		List<String> messageList = new ArrayList<String>();
		if(actionCompleted != null  && actionCompleted.contains(":"))
		{
			messageList = Arrays.asList(actionCompleted.split(":"));
		}
		else
		{
			actionCompleted = "false:No Action performed!";
		}
		if(((String)messageList.get(0)).equalsIgnoreCase("true"))
			{
%>
				<script type="text/javascript">
						alert("<%=(String)messageList.get(1)%>");
						window.open("/Choice/AdminHome.jsp","_top");
				</script>
<%
			}
			else if(((String)messageList.get(0)).equalsIgnoreCase("false"))
				{
%>
				<script type="text/javascript">
						alert("Action failed!\nError: <%=(String)messageList.get(1)%>");
						window.open("/Choice/AdminHome.jsp","_top");
				</script>
<%	
				}
	}
	catch(Exception e)
		{
			System.out.println("Exception in DatabaseTableActionsProcess.jsp ::"+e);
%>
			<jsp:forward page="/JSP/ErrorJSP/Error.jsp"></jsp:forward>
<%
		}
%>
<%
		}
}
%>
</html>