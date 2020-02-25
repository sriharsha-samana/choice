<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="databaseActions.Actions"%>
<%@page import="java.io.File"%>

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

		
		<title>Create User</title>
		

	
	</head>

	<body>
<%
	try
		{
			String strTableName = request.getParameter("TableName");
			String strNoOfFields = request.getParameter("NoOfFields");	
			String strAutoNumberPrefix = request.getParameter("AutoNumberPrefix");
			int NoOfFields = Integer.valueOf(strNoOfFields);
			String Fields[] = new String[NoOfFields];
			String FieldTypes[] = new String[NoOfFields];
			String FieldSizes[] = new String[NoOfFields];
			String FieldDefaultValues[] = new String[NoOfFields];
			String Constraints[] = new String[NoOfFields];

			for(int i=0;i<NoOfFields;i++)
			{
				String strEachType = request.getParameter("Type"+i);
				FieldTypes[i] = strEachType.trim();
				String strEachName = request.getParameter("Name"+i);
				Fields[i] = strEachName.trim();
				String strEachSize = request.getParameter("Size"+i);
				FieldSizes[i] = strEachSize.trim();
				String strEachDefaultValue = request.getParameter("DefaultValue"+i);
				FieldDefaultValues[i] = strEachDefaultValue.trim();
				String strEachContraintsValue = request.getParameter("Constraints"+i);
				Constraints[i] = strEachContraintsValue.trim();
			}
			String[] Parameters = new String[10];

			Actions action = new Actions();
			String IsTableCreated = action.AddNewTable(strTableName, Fields, FieldTypes, FieldSizes, Constraints, FieldDefaultValues, strAutoNumberPrefix);

			if(IsTableCreated.equals("true"))
			{
%>
				<script type="text/javascript">
					alert("New table added successfully!");
					window.open("/Choice/AdminHome.jsp","_top");
				</script>
<%
			}
			else if(IsTableCreated.equals("No DB"))
				{
%>
					<script type="text/javascript">
						alert("Database doesnot exist. Please create database!");
						window.open("/Choice/AdminHome.jsp","_top");
					</script>
				
<%
				}
				else if(IsTableCreated.contains("already exists"))
					{
%>
						<script type="text/javascript">
							alert("Table with same name already exists!");
							window.open("/Choice/JSP/DatabaseJSP/AdminHome.jsp","_top");
						</script>
<%
					}
					else if(IsTableCreated.contains("Invalid default value"))
					{
%>
						<script type="text/javascript">
							alert("<%=IsTableCreated%>");
							window.open("/Choice/JSP/DatabaseJSP/AdminHome.jsp","_top");
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
				System.out.println("Exception in CreateNewTableProcess.jsp ::"+e);
%>
				<jsp:forward page="/JSP/ErrorJSP/Error.jsp"></jsp:forward>
<%		
			}
%>

	</body>

<%
		}
}
%>
</html>