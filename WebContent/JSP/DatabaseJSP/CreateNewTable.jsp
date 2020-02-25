<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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

		<title>Create New Table</title>
		
		<script type="text/javascript">
		
		
		function createFields()
			{
				var NoOfFields = document.getElementById("NoOfFields").value;
				var fieldTypes = ["VARCHAR","CHARACTER","BINARY","BOOLEAN","INTEGER","FLOAT","REAL","DATE","TIME","TIMESTAMP"];
				var HTML = "<table border=1>";
				HTML += "<th>Type</th><th>Name</th><th>Size</th><th>Constraints</th><th>Default Value</th>";
				for(var i=0;i<NoOfFields;i++)
					{
						HTML += "<tr><td id=\"DynamicFieldTableTDIDType"+i+"\"><select id='Type"+i+"' name='Type"+i+"' onchange=\"updateOptions("+i+");\" required>";
						for(var j=0;j<fieldTypes.length;j++)
							{
								HTML += "<option value=\""+fieldTypes[j]+"\">"+fieldTypes[j]+"</option>";
							}
						HTML += "</select></td><td id=\"DynamicFieldTableTDIDName"+i+"\">";
						HTML += "<input type=\"text\" id=\"Name"+i+"\" name=\"Name"+i+"\" required /></td><td id=\"DynamicFieldTableTDIDSize"+i+"\">";
						HTML += "<input type=\"text\" id=\"Size"+i+"\" name=\"Size"+i+"\" value=\"\" onchange=\"checkForNumber(value);\" required/></td><td id=\"DynamicFieldTableTDIDConstraints"+i+"\">";
						HTML += "<input type=\"checkbox\" id=\"Constraints"+i+"Checkbox\" name=\"Constraints"+i+"Checkbox\" value=\"NOT NULL\" onclick=\"setCheckboxValues(name);\" />NOT NULL";
						HTML += "<input type=\"checkbox\" id=\"Constraints"+i+"Checkbox\" name=\"Constraints"+i+"Checkbox\" value=\"UNIQUE\" onclick=\"setCheckboxValues(name);\" />UNIQUE";
						HTML += "<input type=\"hidden\" id=\"Constraints"+i+"\" name=\"Constraints"+i+"\" value=\"Not selected\" />";
						HTML += "</td><td id=\"DynamicFieldTableTDIDDefaultValue"+i+"\">";
						HTML += "<input type=\"text\" id=\"DefaultValue"+i+"\" name=\"DefaultValue"+i+"\" value=\"NA\" required />";
					}
				HTML += "</table>";
				document.getElementById("dynamicFieldTableDataElement").innerHTML = HTML;
			}
		
		function updateOptions(count)
			{
				var selectedType = document.getElementById("Type"+count).value;
				if(selectedType == "CHARACTER" || selectedType == "VARCHAR" || selectedType == "BINARY")
					{
	
						document.getElementById("Size"+count).readOnly = false;
						document.getElementById("Size"+count).value = "";
					}
					else
						{
							document.getElementById("Size"+count).value = "0";
							document.getElementById("Size"+count).readOnly = true;
						}
			}
		
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
	</head>

	<body>
		<div id = Formheader class = "Formheader">
			<h4 style="color:#ff6a22">Create New Table</h4><br><br>
		</div>

		<div id="Create_New_TableDiv" class="Create_New_TableDiv">

			<form id="Create_New_TableForm" name="Create_New_TableForm" method="POST" action="/Choice/JSP/DatabaseJSP/CreateNewTableProcess.jsp" onsubmit="showProgress();">

				<table id="Create_New_TableTable" name="Create_New_TableTable" border="1" bgcolor="#e5e5e5">

					

					<tr>

						<td>

							Table Name

						</td>

						<td>

							&nbsp<input type="text" id="TableName" name="TableName" value="" required/>

						</td>

					</tr>
					
					<tr>

						<td>

							Auto-Number Prefix

						</td>

						<td>

							&nbsp<input type="text" id="AutoNumberPrefix" name="AutoNumberPrefix" value="NA" required/>

						</td>

					</tr>
					
					
					<tr>

						<td>

							Number of fields: 

						</td>

						<td>

							<input type="number" id="NoOfFields" name="NoOfFields" value="1"  min="1" onchange="checkForNumber(value); createFields();" required/>

						</td>

					</tr>
					
					<tr>
						<td>
							Enter Required details: 
						</td>

						<td id="dynamicFieldTableDataElement">

						</td>
								
						<script>
								createFields();
						</script>
							
					</tr>


				</table>


				<input type="submit" id="Create_New_TableSubmit" name="Create_New_TableSubmit" value="Create Table"/>


			</form>

		</div>

	</body>
<%
		}
}
%>

</html>