<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
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
			
			function updateTableFields()
			{
				var target = document.getElementById("Database_Table_Name");
				if(target.value != "select" && target.value != "No DB")
					{
					var ajaxRequest;
					
					try{
						// Opera 8.0+, Firefox, Safari
						ajaxRequest = new XMLHttpRequest();
						}catch (e){
						// Internet Explorer Browsers
						try{
							ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
							}catch (e) {
							try{
								 ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
								 }catch (e){
								  // Something went wrong
								  alert("Your browser broke!");
								  return false;
								}
							}
						}
				
						ajaxRequest.onreadystatechange=function()
							{
								if (ajaxRequest.readyState==4 && ajaxRequest.status==200)
									{	
										setFieldValueOptions(ajaxRequest.responseText,target.value);
									}
							}
								 
							var url = "/Choice/JSP/DatabaseJSP/listFields.jsp?tableName=" + target.value;
							ajaxRequest.open("GET", url, true);
							ajaxRequest.send();
					}
					else
						{
							if(target.value == "select")
								{
									document.getElementById("updateFields").innerHTML = "";
								}
								else
									{
										document.getElementById("updateFields").innerHTML = "<br><h2>Database doesnot exist.</h2>";
									}
						}
			}
			function setFieldValueOptions(responseText,TableName)
			{
				var length = responseText.length;
				length = length-9;
				responseText = responseText.substring(1,length);
				var list = responseText.split(",");
				var HTML="";
	
				for(j=0;j<list.length;j++)
					{	
						var PrimaryKeyField = TableName+"_UID";
						var autoNumber = TableName + "_AutoNumberPrefix";
	
						if(PrimaryKeyField.toUpperCase() != list[j].toUpperCase().trim() && autoNumber.toUpperCase() != list[j].toUpperCase().trim())
							{
								HTML += "<tr><td><input type=\"checkbox\" id=\"FieldsCheckbox\" name=\"FieldsCheckbox\" value=\""+list[j]+"\" onclick=\"setCheckboxValues(name);\"/></td><td>"+list[j]+"</td></tr>";
							}
					}
				document.getElementById("updateFields").innerHTML = HTML;
			}
			</script>
		
		<title>Create New Table Results Page</title>
	</head>

	<body>
		<div id = Formheader class = "Formheader">
			<h4 style="color:#ff6a22">Create New Table Results Page</h4><br><br>
		</div>

		<div id="Create_New_TableDiv" class="Create_New_TableDiv">

			<form id="Create_New_TableForm" name="Create_New_TableForm" method="POST" action="/Choice/JSP/DatabaseJSP/CreateDynamicTableProcess.jsp" onsubmit="showProgress();">

				

				<input type="hidden" id="DatabaseTableName" name="DatabaseTableName" value="tablemaster" />

				<table id="Create_New_TableTable" name="Create_New_TableTable" border="1" bgcolor="#e5e5e5">

					

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

							Database Table Name

						</td>

						<td>

							&nbsp<select id="Database_Table_Name" name="Database_Table_Name" required onchange="updateTableFields();">
							<option selected>select</option> 
<%
							Actions action = new Actions();	
							String strTable = null;
							List TablesList = new ArrayList<String>();
							TablesList = action.listTables();
							List ExcludedTablesList = new ArrayList<String>();
							ExcludedTablesList = action.getExcludedTablesList();
							for(int i=0;i<TablesList.size();i++)
								{
									String strTableName = ((String)TablesList.get(i)).trim();
									if(!ExcludedTablesList.contains(strTableName))
										{
%>
									<option><%=TablesList.get(i) %></option>
<%												
								
										}
								}
%>								

							</select>

						</td>

									<input type="hidden" id="Database_Table_NameDatabaseTableFieldName" name="Database_Table_NameDatabaseTableFieldName" value="TableName" />

						</tr>

					<tr>

						<td>

							Where Condition

						</td>

						<td>

							&nbsp<input type="text" id="Where_Condition" name="Where_Condition" value="NA" required />

						</td>

									<input type="hidden" id="Where_ConditionDatabaseTableFieldName" name="Where_ConditionDatabaseTableFieldName" value="WhereCondition" />

						</tr>

					<tr>

						<td>

							Select Fields

						</td>

						<td>

							<table border="1" id="updateFields" class="updateFields">
							</table>

								<input type="hidden" id="Fields" name="Fields" value="Not selected" />


						</td>

									<input type="hidden" id="FieldsDatabaseTableFieldName" name="FieldsDatabaseTableFieldName" value="Fields" />

						</tr>

					<tr>

						<td>

							Heading

						</td>

						<td>

							&nbsp<input type="text" id="Heading" name="Heading" value="" required />

						</td>

									<input type="hidden" id="HeadingDatabaseTableFieldName" name="HeadingDatabaseTableFieldName" value="Heading" />

						</tr>

					<tr>

						<td>

							Sub Heading

						</td>

						<td>

							&nbsp<input type="text" id="Sub_Heading" name="Sub_Heading" value="NA" required />

						</td>

									<input type="hidden" id="Sub_HeadingDatabaseTableFieldName" name="Sub_HeadingDatabaseTableFieldName" value="SubHeading" />

						</tr>

					<tr>

						<td>

							Title

						</td>

						<td>

							&nbsp<input type="text" id="Title" name="Title" value="NA" required />

						</td>

									<input type="hidden" id="TitleDatabaseTableFieldName" name="TitleDatabaseTableFieldName" value="Title" />

						</tr>

					

				</table>


					<br><input type="submit" id="Create_New_TableSubmit" name="Create_New_TableSubmit" value="Add" />



			</form>

		</div>

	</body>

<%
		}
}
%>
</html>