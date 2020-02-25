<%@page import="databaseActions.Actions"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.io.File"%>
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
		<link rel="stylesheet" href="/Choice/CSS/Common/jquerycss.css" type="text/css">
		<link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css" type="text/css">
		<script src="/Choice/JS/jquerymobile.js"></script>
		<script src="/Choice/JS/CommonJS.js"></script>
		<script src="/Choice/JS/jquery.js"></script>

		
		<title>Create Database</title>

		
	</head>
	
	<body>
<%
	try
		{
			String strDatabaseTableName = (String)session.getAttribute("tableName");
			String[][] resultArrayWithKeys = (String[][])session.getAttribute("resultArrayWithKeys");
			String[][] resultArray = (String[][])session.getAttribute("resultArray");
			int rows = Integer.parseInt(resultArray[0][0]); 
			int columns = Integer.parseInt(resultArray[0][1]);
			int rowsWithKeys = Integer.parseInt(resultArrayWithKeys[0][0]); 
			int columnsWithKeys = Integer.parseInt(resultArrayWithKeys[0][1]);
			String[] primaryKeys = new String[rowsWithKeys];
			
			for(int i=2;i<rowsWithKeys+2;i++)
				{
					for(int k=2;k<columnsWithKeys+2;k++)
						{
							if(resultArrayWithKeys[1][k].equalsIgnoreCase(strDatabaseTableName+"_UID"))
								{
									primaryKeys[i-2] = resultArrayWithKeys[i][k];
								}
						}
				}
			
			String[] DatabaseTableFields = new String[columns];
			for(int z=2;z<columns+2;z++)
				{
					DatabaseTableFields[z-2] = resultArray[1][z];
				}
			
			String[][] Values = new String[rows][columns];

			for(int i=0;i<rows;i++)
				{
					for(int k=2;k<columns+2;k++)
						{
							Values[i][k-2] = request.getParameter("EachEditableField"+(i+2)+"_"+k);
						}
				}

			Actions updateEntry = new Actions();
			
			String AreAllEntriesUpdated = "true";
			
			for(int a=0;a<primaryKeys.length;a++)
				{
					String[] eachRowValues = new String[columns];
					for(int b=0;b<columns;b++)
						{
							eachRowValues[b] = Values[a][b];
						}
					
					String isChecked = request.getParameter("EditableFieldsCheckbox"+(a+2)+"Text");
					if(isChecked.equals("true"))
						{
							String IsEntryUpdated = updateEntry.UpdateExistingEntry(strDatabaseTableName, primaryKeys[a], DatabaseTableFields, eachRowValues);	
					
							if(!IsEntryUpdated.equals("true"))
								{
									AreAllEntriesUpdated = IsEntryUpdated;
								}
						}
				}
			
			String strSuccessMessage = "Entries updated successfully!";
			if(strDatabaseTableName.equalsIgnoreCase("formmaster"))
			{
				strSuccessMessage = "Form fields updated successfully!";
			}
			else if(strDatabaseTableName.equalsIgnoreCase("tablemaster"))
			{
				strSuccessMessage = "Table fields updated successfully!";
			}
			
			if(AreAllEntriesUpdated.equals("true"))
			{
%>
				<script type="text/javascript">
					alert("<%=strSuccessMessage%>");
					window.open("/Choice/AdminHome.jsp","_top");
				</script>
<%
			}
			else if(AreAllEntriesUpdated.equals("No DB"))
				{
%>
					<script type="text/javascript">
						alert("Database doesnot exist. Please create database!");
						window.open("/Choice/AdminHome.jsp","_top");
					</script>
				
<%
				}
				else if(AreAllEntriesUpdated.contains("Duplicate"))
					{
%>
						<script type="text/javascript">
							alert("<%=AreAllEntriesUpdated%>");
							window.open("/Choice/AdminHome.jsp","_top");
						</script>
<%
					}
					else if(AreAllEntriesUpdated.contains("Invalid"))
						{
%>
							<script type="text/javascript">
								alert("<%=AreAllEntriesUpdated%>");
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
				System.out.println("Exception in UpdateExistingEntry.jsp ::"+e);
%>
				<jsp:forward page="/JSP/ErrorJSP/Error.jsp"></jsp:forward>
<%		
			}
%>

</body>

<%
%>
</html>