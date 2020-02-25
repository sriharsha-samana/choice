<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="databaseActions.Actions"%>
<%@page import="javax.sql.rowset.CachedRowSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>

<html>
	<%if (session == null || session.getAttribute("User") == null) {%><script>window.open("/Choice/Login.jsp","_top");</script><%}if(request.getHeader("X-Requested-With") != null){if(request.getHeader("X-Requested-With").equalsIgnoreCase("XMLHttpRequest")){%>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/globals.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/typography.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/grid.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/ui.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/forms.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/orbit.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/reveal.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/mobile.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/app.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/responsive-tables.css"><link rel="stylesheet" href="/Choice/CSS/Common/jquery-ui.css"><link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css"><script src="/Choice/JS/ResponsiveTables/jquery.min.js"></script><script src="/Choice/JS/ResponsiveTables/responsive-tables.js"></script><script src="/Choice/JS/CommonJS.js"></script><script src="/Choice/JS/jquery-ui.js"></script>
		<script src="/Choice/JS/CommonJS.js"></script>
		<script src="/Choice/JS/jquery.js"></script>
		<script src="/Choice/JS/HomePage/colpick.js"></script>
		<link rel="stylesheet" href="/Choice/CSS/HomePage/colpick.css">
		
<%
		Actions action = new Actions();
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
			
			$('#picker').colpick({
				layout:'hex',
				onChange:function(hsb,hex,rgb,el,bySetColor) {
					document.getElementById("BackgroundColor").value = "#"+hex;
				}
			});
			
			</script>
		
		<title>Set Preferences</title>
	</head>

	<body>
		<div id = Formheader class = "Formheader">
			<br><h4 style="color:#ff6a22">Set Preferences</h4><br><br>
		</div>

		<div id="Set_PreferencesDiv" class="Set_PreferencesDiv">

			<form id="Set_PreferencesForm" name="Set_PreferencesForm" method="POST" action="/Choice/JSP/DatabaseJSP/SetClientPreferencesProcess.jsp">


				<input type="hidden" id="DatabaseTableName" name="DatabaseTableName" value="clientpreferences" />

				<table id="Set_PreferencesTable" name="Set_PreferencesTable" border="1" bgcolor="#e5e5e5">

					

					<tr>

						<td>

							Select Background Color

						</td>

						<td>

							<input type="text" id="BackgroundColor" name="BackgroundColor" value="" required readonly/>
							<input type="button" id="picker" value="Show Color Picker"/>
						</td>

								<input type="hidden" id="BackgroundColorDatabaseTableFieldName" name="BackgroundColorDatabaseTableFieldName" value="Value" />

						</tr>

					<tr>

						<td>

							Select Home Page

						</td>

						<td>

							<select id="HomePage" name="HomePage" required>
								<option value="Nothing">- Nothing -</option>
<%				
							String strUser = (String)session.getAttribute("User");
							String strUserGroup = null;
							CachedRowSet UsersSet = action.fetchDataFromDB("userstable", null, "Username = '"+strUser+"'");
							if(UsersSet.next())
							{
								strUserGroup = UsersSet.getString("UserGroup");
							}
							
							String strWhere = "Name != 'NA'";
							String eachName = null;
							String eachLabel = null;
							CachedRowSet resultSetAvailableTopNavigator = action.fetchDataFromDB("clienttopnavigator", null, strWhere);
							CachedRowSet resultSetAvailableSideNavigator= action.fetchDataFromDB("clientsidenavigator", null, strWhere);

								while(resultSetAvailableTopNavigator.next())
								{
									
									eachName = resultSetAvailableTopNavigator.getString("LINK");
									eachLabel = resultSetAvailableTopNavigator.getString("Label");
									String strAccessGroups = resultSetAvailableTopNavigator.getString("AccessGroups");
									List<String> AccessGroupsList = Arrays.asList(strAccessGroups.split(","));
									if(AccessGroupsList.contains(strUserGroup))
									{

%>							
								<option value="<%=eachName%>"><%=eachLabel%></option>
<%
									}
								}
								
								while(resultSetAvailableSideNavigator.next())
								{
									eachName = resultSetAvailableSideNavigator.getString("LINK");
									eachLabel = resultSetAvailableSideNavigator.getString("Label");
									String strAccessGroups = resultSetAvailableSideNavigator.getString("AccessGroups");
									List<String> AccessGroupsList = Arrays.asList(strAccessGroups.split(","));
									if(AccessGroupsList.contains(strUserGroup))
									{

%>							
									<option value="<%=eachName%>"><%=eachLabel%></option>
<%
									}
								}

%>

							</select>

						</td>

									<input type="hidden" id="HomePageDatabaseTableFieldName" name="HomePageDatabaseTableFieldName" value="Value" />

						</tr>

					

				</table><br><br>

				<table id="Set_PreferencesSubmitTable" name="Set_PreferencesSubmitTable">

					<input type="submit" id="Set_PreferencesSubmit" name="Set_PreferencesSubmit" value="Set Preferences"/>

				</table>

			</form>

		</div>

	</body>


<%}}%>


</html>