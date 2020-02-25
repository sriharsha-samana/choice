<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="databaseActions.Actions"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.sql.rowset.CachedRowSet"%>
<html>
<%
if (session == null || session.getAttribute("User") == null || !session.getAttribute("User").equals("Administrator")) {
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
			  <link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css" type="text/css">
		  <!-- End Combine and Compress These CSS Files -->
				<link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/app.css">
				<link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/responsive-tables.css">
				<script src="/Choice/JS/ResponsiveTables/jquery.min.js"></script>
				<script src="/Choice/JS/ResponsiveTables/responsive-tables.js"></script>
		
<%
		Actions action = new Actions();	
		int count = 0;
		try
		{
		CachedRowSet resultSetCheckAvailableCommands = action.fetchDataFromDB("clientsidenavigator", null, "Name != 'NA'");
		if(resultSetCheckAvailableCommands.last())
		{
			count = resultSetCheckAvailableCommands.getRow();
		}
		
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
			
			function setHyperlink(value)
				{
					if(document.getElementById("HyperlinkInnerHTML").value ==  "")
						{
							document.getElementById("HyperlinkInnerHTML").value = document.getElementById("HyperlinkTag").innerHTML;
						}

					if(value == "true")
						{
							document.getElementById("HyperlinkTag").innerHTML = "<input type=\"hidden\" id=\"HyperLink\" name=\"Hyperlink\" value=\"#\" />";
							document.getElementById("IsMenuHidden").value = "true";
						}
					else if(value == "false")
						{
							document.getElementById("HyperlinkTag").innerHTML = document.getElementById("HyperlinkInnerHTML").value;
							document.getElementById("IsMenuHidden").value = "false";
						}
				}
			
			$(document).ready(function(){
				var checkCount = <%=count > 50%>;
				if(checkCount == true)
					{
						$('#Add_Side_Navigator_linksTable').html("<br><br><h6>Maximum number of Commands already added!</h6>");
					}
			});
			
			</script>
		
		<title>Side Navigator links</title>
	</head>

	<body>
		<div id = Formheader class = "Formheader">
			<h4 style="color:#ff6a22">Add Side Navigator Commands/Menus</h4><br><br>
		</div>

		<div id="Add_Side_Navigator_linksDiv" class="Add_Side_Navigator_linksDiv">

			<form id="Add_Side_Navigator_linksForm" name="Add_Side_Navigator_linksForm" method="POST" action="/Choice/JSP/DatabaseJSP/AddSideNavigatorCommandsProcess.jsp" enctype="multipart/form-data" onsubmit="showProgress();">

				

				<input type="hidden" id="DatabaseTableName" name="DatabaseTableName" value="clientsidenavigator" />

				<table id="Add_Side_Navigator_linksTable" name="Add_Side_Navigator_linksTable" border="1" bgcolor="#e5e5e5">

					

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

							&nbsp<input type="text" id="Label" name="Label" value="" required />

						</td>

									<input type="hidden" id="LabelDatabaseTableFieldName" name="LabelDatabaseTableFieldName" value="Label" />

						</tr>

					<tr>

						<td>

							Icon

						</td>

						<td>

							&nbsp<input type="file" id="Icon" name="Icon" value="" required />

						</td>

									<input type="hidden" id="IconDatabaseTableFieldName" name="IconDatabaseTableFieldName" value="ICON" />

						</tr>
						
					<tr>

						<td>

							Command/Menu?

						</td>

						<td>

								<input type="radio" id="IsMenu" name="IsMenu" value="false" onclick="setHyperlink(value);">Command
								<input type="radio" id="IsMenu" name="IsMenu" value="true" onclick="setHyperlink(value);">Menu
								<input type="hidden" id="IsMenuHidden" name="IsMenuHidden" value="false">
						</td>

									<input type="hidden" id="IsMenuDatabaseTableFieldName" name="IsMenuDatabaseTableFieldName" value="IsMenu" />

					</tr>

					<tr>

						<td>

							Hyperlink

						</td>

						<td id="HyperlinkTag">

							<select id="Hyperlink" name="Hyperlink" required>
							<option value="#">Self</option>
<%
							String strWhere = "Name != 'NA'";
							CachedRowSet resultSetAvailableDynamicForms = action.fetchDataFromDB("formmaster", null, strWhere);
							CachedRowSet resultSetAvailableDynamicTables = action.fetchDataFromDB("tablemaster", null, strWhere);
							
							while(resultSetAvailableDynamicForms.next())
							{
								String strEachFormName = resultSetAvailableDynamicForms.getString("Name");

%>							
								<option value="<%=strEachFormName%>"><%=strEachFormName%> - Form</option>
<%
							}
							
							while(resultSetAvailableDynamicTables.next())
							{
								String strEachTableName = resultSetAvailableDynamicTables.getString("Name");

%>							
								<option value="<%=strEachTableName%>"><%=strEachTableName%> - Table</option>
<%
							}
%>
							</select>
								
						</td>
									<input type="hidden" id="HyperlinkInnerHTML" name="HyperlinkInnerHTML" value="" />
									
									<input type="hidden" id="HyperlinkDatabaseTableFieldName" name="HyperlinkDatabaseTableFieldName" value="LINK" />

						</tr>
						
					<tr>

						<td>

							Access Groups

						</td>

						<td>
							<input type="hidden" id="AccessGroups" name="AccessGroups" value=""/>
							
<%
							strWhere = "Name != 'NA'";
							CachedRowSet resultSetAvailableAccessGroups = action.fetchDataFromDB("usergroups", null, strWhere);

								while(resultSetAvailableAccessGroups.next())
								{
									
								String strEachGroupName = resultSetAvailableAccessGroups.getString("Name");
								String strEachGroupLabel = resultSetAvailableAccessGroups.getString("Value");

%>							
								<input type="checkbox" id="AccessGroupsCheckBox" name="AccessGroupsCheckBox" value="<%=strEachGroupName%>" onclick="setCheckboxValues(name);"/><%=strEachGroupLabel%><br>
<%
								}
%>
							</select>

						</td>

									<input type="hidden" id="AccessGroupsDatabaseTableFieldName" name="AccessGroupsDatabaseTableFieldName" value="AccessGroups" />

					</tr>

					

				</table><br>



					<input type="submit" id="Add_Side_Navigator_linksSubmit" name="Add_Side_Navigator_linksSubmit" value="Add Commands" />



			</form>

		</div>
<%
		}
		catch(Exception e)
		{
			System.out.println("Exception in AddSideNavigatorLinks.jsp::"+e);
%>
				<jsp:forward page="/JSP/ErrorJSP/Error.jsp"></jsp:forward>
<%
		}
%>
	</body>

<%

%>
</html>