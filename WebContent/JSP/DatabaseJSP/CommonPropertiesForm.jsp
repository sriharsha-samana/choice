<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="databaseActions.Actions"%>

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
				<script src="/Choice/JS/HomePage/colpick.js"></script>
				<link rel="stylesheet" href="/Choice/CSS/HomePage/colpick.css">

		
		<title>Properties</title>	
			
	</head>
	
	<body>
	
		<div id = header class = "header">
			<br><h4 style="color:#ff6a22">Properties : </h4><br>
		</div>
		
		<div class="ActiveScreenObj" id="ActiveScreenObj" name="ActiveScreenObj">
		
			<div id = PropertiesTableDiv> 
						
						<table border="1">
<%
	try
		{
							String strDatabaseTableName = request.getParameter("table");
							String strPrimaryKey = request.getParameter("pk");
							Actions searchDatabase = new Actions();
							ArrayList<String> selectList = new ArrayList<String>();
							ArrayList<String> selectListCondition = new ArrayList<String>();
							String[][] resultArray = searchDatabase.searchDatabase(strDatabaseTableName, selectList, selectListCondition, strPrimaryKey);
							
							if(resultArray[0][0] == "No DB")
							{
%>
								<tr>
									<td>Database not installed.</td>
								</tr>
<%
							}
							else if(resultArray[0][0] == "No Data Found")
								{
%>
									<tr>
										<td>No Data Found.</td>
									</tr>
<%				
								}
								else if(resultArray[0][0] == "Exception")
								{
%>
									<tr>
										<td>Wrong input details.</td>
									</tr>
<%
								}
								else
									{
										int columns = Integer.parseInt(resultArray[0][1]);
										String[] Labels = new String[columns];
										String[] Values = new String[columns];
										for(int z=2;z<columns+2;z++)
											{
												Labels[z-2] = resultArray[1][z];
												Values[z-2] = resultArray[2][z];
											}
										
										for(int a=0;a<Labels.length;a++)
											{
												if(!Labels[a].equalsIgnoreCase(strDatabaseTableName+"_UID"))
													{
%>
												<tr>
<%
													Labels[a] = Labels[a].replace("_", " ");
%>
													<td><%=Labels[a] %></td>
													<td><%=Values[a] %></td>
												</tr>
<%
													}
											}
									
									}
		}
		catch(Exception e)
		{
			System.out.println("Exception in CommonPropertiesForm.jsp::"+e);
%>
			<jsp:forward page="/JSP/ErrorJSP/Error.jsp"></jsp:forward>
<%
		}
%>											
						</table>
						
			</div>			
			
	</body>
<%
		}
}
%>	
</html>