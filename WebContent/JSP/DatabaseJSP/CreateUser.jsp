<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.io.File"%>
<%@page import="databaseActions.Actions"%>
<%@page import="javax.sql.rowset.CachedRowSet"%>

<html>
	<head>

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

		
		<title>User Registration</title>
		
		
	</head>
	
	<body>
	
		<div id = header1 class = "header1">
			<h4 style="color:#ff6a22">User Registration</h4><br><br>
		</div>
		<div class="ActiveScreenObj" id="ActiveScreenObj" name="ActiveScreenObj">
		
			<div id = CreateUserFormDiv> 
				
				<form id="CreateUserForm" method="post" action="/Choice/JSP/DatabaseJSP/CreateUserProcess.jsp" onsubmit= "return checkUsernameAndPassword();">
						
						<table border="1">
							
							<tr>
								<td>
									Username:
								</td>
								<td>
									<input type="text" id="username" name="username" required/>
								</td>
							</tr>
							
							<tr>
								<td>
									Password
								</td>
								<td>
									<input type="password" id="password" name="password" required/>
								</td>
							</tr>
							
							<tr>
								<td>
									Select User Group
								</td>
								<td>
									<select id="UserGroup" name="UserGroup">
<%
										Actions action = new Actions();
										CachedRowSet UserGroups = action.fetchDataFromDB("usergroups", null, "Name != 'NA'");
										while(UserGroups.next())
										{
											String strName = UserGroups.getString("Name");
											String strLabel = UserGroups.getString("Value");
%>
											<option value="<%=strName%>"><%=strLabel%></option>
<%											
										}

%>
									</select>
								</td>
							</tr>
										
						</table>
					

						<br><input type="submit" id="submit" value="Create User">

					
				</form>
				
			</div>
			
		</div>			
			
	</body>
<%
		}
}
%>	
</html>