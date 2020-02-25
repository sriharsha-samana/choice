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
			String strNoOfNewEntries = request.getParameter("NoOfNewEntries");
			int NoOfNewEntries = Integer.parseInt(strNoOfNewEntries);
			String strDatabaseTableName = (String)session.getAttribute("tableName");
			String[][] resultArray = (String[][])session.getAttribute("resultArray");
			int rows = Integer.parseInt(resultArray[0][0]); 
			int columns = Integer.parseInt(resultArray[0][1]);
			
			String[] DatabaseTableFields = new String[columns];
			for(int z=2;z<columns+2;z++)
				{
					DatabaseTableFields[z-2] = resultArray[1][z];
				}
			
			String[][] Values = new String[NoOfNewEntries][columns];
			String[] checked = new String[NoOfNewEntries];

			for(int i=0;i<NoOfNewEntries;i++)
				{
					checked[i] = request.getParameter("EachNewEntryFieldCheckbox"+(i+2)+"Text");
					for(int k=2;k<columns+2;k++)
						{
							Values[i][k-2] = request.getParameter("EachNewEntryField"+(i+2)+"_"+k);
						}
				}

			
			Actions addNewEntry = new Actions();
			String AreAllNewEntriesAdded = "true";
			
			for(int a=0;a<NoOfNewEntries;a++)
				{
					String[] eachRowValues = new String[columns];
					for(int b=0;b<columns;b++)
						{
							eachRowValues[b] = Values[a][b];
						}
					String IsNewEntryAdded = "true";
					if(checked[a].equals("true"))
					{
						IsNewEntryAdded = addNewEntry.AddNewEntry(strDatabaseTableName, DatabaseTableFields, eachRowValues);
					}
					
					if(!IsNewEntryAdded.equals("true"))
						{
							AreAllNewEntriesAdded = IsNewEntryAdded;
							break;
						}
					
				}
			
			if(AreAllNewEntriesAdded.equals("true"))
			{
%>
				<script type="text/javascript">
					alert("New Entry added successfully!");
					window.open("/Choice/AdminHome.jsp","_top");
				</script>
<%
			}
			else if(AreAllNewEntriesAdded.equals("No DB"))
				{
%>
					<script type="text/javascript">
						alert("Database doesnot exist. Please create database!");
						window.open("/Choice/AdminHome.jsp","_top");
					</script>
				
<%
				}
				else if(AreAllNewEntriesAdded.contains("Duplicate"))
					{
%>
						<script type="text/javascript">
							alert("<%=AreAllNewEntriesAdded%>");
							window.open("/Choice/AdminHome.jsp","_top");
						</script>
<%
					}
					else if(AreAllNewEntriesAdded.contains("Invalid"))
						{
%>
							<script type="text/javascript">
								alert("<%=AreAllNewEntriesAdded%>");
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
				System.out.println("Exception in AddNewEntry.jsp ::"+e);
%>
				<jsp:forward page="/JSP/ErrorJSP/Error.jsp"></jsp:forward>
<%		
			}
%>

</body>
<%

%>

</html>