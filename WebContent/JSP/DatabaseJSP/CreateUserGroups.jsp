<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<%if (session == null || session.getAttribute("User") == null) {%><script>window.open("/Choice/Login.jsp","_top");</script><%}if(request.getHeader("X-Requested-With") != null){if(request.getHeader("X-Requested-With").equalsIgnoreCase("XMLHttpRequest")){%>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/globals.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/typography.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/grid.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/ui.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/forms.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/orbit.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/reveal.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/mobile.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/app.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/responsive-tables.css"><link rel="stylesheet" href="/Choice/CSS/Common/jquery-ui.css"><link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css"><script src="/Choice/JS/ResponsiveTables/jquery.min.js"></script><script src="/Choice/JS/ResponsiveTables/responsive-tables.js"></script><script src="/Choice/JS/CommonJS.js"></script><script src="/Choice/JS/jquery-ui.js"></script>
		<script src="/Choice/JS/CommonJS.js"></script>
		<script src="/Choice/JS/jquery.js"></script>
		
		
<%
		
		%>
		<script type="text/javascript">
			
			function setCheckboxValues(name)
				{
					var hiddenTagName = name.substring(0,(name.length-8));
					var checkboxFieldNames =  document.getElementsByName(name);
					var fieldNameValue = "";
					for(i=0;i<checkboxFieldNames.length;i++)
					
						{
							if(checkboxFieldNames[i].checked)
								{
									fieldNameValue += checkboxFieldNames[i].value.trim() + ",";
								}
						}
				
					fieldNameValue = fieldNameValue.substring(0,fieldNameValue.length-1);
					document.getElementById(hiddenTagName).value = fieldNameValue;
				}
			</script>
		
		<title>User Groups</title>
	</head>

	<body>
		<div id = Formheader class = "Formheader">
			<h4 style="color:#ff6a22">User Groups</h4><br><br>
		</div>

		<div id="User_GroupsDiv" class="User_GroupsDiv">

			<form id="User_GroupsForm" name="User_GroupsForm" method="POST" action="/Choice/JSP/DatabaseJSP/CreateUserGroupsProcess.jsp">

				

				<input type="hidden" id="DatabaseTableName" name="DatabaseTableName" value="usergroups" />

				<table id="User_GroupsTable" name="User_GroupsTable" border="1" bgcolor="#e5e5e5">

					

					<tr>

						<td>

							Name

						</td>

						<td>

							&nbsp<input type="text" id="Name" name="Name" value="" required />

						</td>

									<input type="hidden" id="NameDatabaseTableFieldName" name="NameDatabaseTableFieldName" value="Name" />

						</tr>

					<tr>

						<td>

							Label

						</td>

						<td>

							&nbsp<input type="text" id="Value" name="Value" value="" required />

						</td>

									<input type="hidden" id="ValueDatabaseTableFieldName" name="ValueDatabaseTableFieldName" value="Value" />

						</tr>

					

				</table>

				<table id="User_GroupsSubmitTable" name="User_GroupsSubmitTable">

					<input type="submit" id="User_GroupsSubmit" name="User_GroupsSubmit" value="Create" />

				</table>

			</form>

		</div>

	</body>


<%}}%>


</html>