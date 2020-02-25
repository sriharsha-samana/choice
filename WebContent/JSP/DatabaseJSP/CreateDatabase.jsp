<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
				<script src="/Choice/JS/CommonJS.js"></script>
		
		<title>Create Database</title>
		
	</head>

	<body onload="makeReadOnly();">
	
		<div id = header1 class = "header1">
			<h4 style="color:#ff6a22">Database Creation</h4><br><br>
		</div>
	
		<div class="ActiveScreenObj" id="ActiveScreenObj" name="ActiveScreenObj">	
			
			<div id = CreateDBFormDiv> 
					
					<form id="CreateDatabaseForm" method="post" action="/Choice/JSP/DatabaseJSP/CreateDatabaseProcess.jsp" onsubmit="showProgress();">

						<table border="1">
							
							<tr>
								<td>
									Database:
								</td>
								<td>
									<select id="Database" name="Database" onChange = "makeReadOnly();" required readonly>
										<!-- <option>Access</option> -->
										<option selected>MySQL</option>
									</select>
								</td>
							</tr>
												
							<tr>
								<td>
									Database Name:
								</td>
								<td>
									<input type="text" id="DatabaseName" name="DatabaseName" onblur = "checkInput(value);" required />
								</td>
							</tr>
							
							<tr>
								<td>
									Server URL:
								</td>
								<td>
									<input type="text" id="ServerURL" name="ServerURL" onblur = "checkInput(value);" required />
								</td>
						</tr>
						
						<tr>
							<td>
								Port:
							</td>
							<td>
								<input type="text" id="Port" name="Port" onblur = "checkInput(value);" required />
							</td>				
						</tr>
						
						<tr>
							<td>
								Database Connection Username:
							</td>
							<td>
								<input type="text" id="DBUsername" name="DBUsername" onblur = "checkInput(value);" required />
							</td>				
						</tr>
						
						<tr>
							<td>
								Database Connection Password:
							</td>
							<td>
								<input type="text" id="DBPassword" name="DBPassword" onblur = "checkInput(value);" required />
							</td>				
						</tr>
					
					</table>
					

						<br><input type="submit" id="submit" value="Create Database">

					
				</form>
				
			</div>
				
		</div>
				
	</body>
<%
		}
}
%>
</html>