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
<%
		Actions action = new Actions();	
		String strTable = null;
		List TablesList = new ArrayList<String>();
		TablesList = action.listTables();
		String isSearchForm = request.getParameter("isSearchForm");
		session.setAttribute("isSearchForm", isSearchForm);
		String isWriteJSP = request.getParameter("isWriteJSP");
%>
		
		<title>Create Search Form</title>
		
		<script type="text/javascript">

		function createFields()
			{
				var NoOfFields = parseInt(document.getElementById("NoOfFields").value);
				var NoOfColumns = parseInt(document.getElementById("NoOfColumns").value);
				var HTML = "<table border=1>";
				HTML += "<th>Name</th><th>Label</th><th>Field Name</th>";
				for(var i=0;i<NoOfFields;i++)
					{
						HTML += "<tr><td id=\"DynamicFieldTableTDIDName"+i+"\">";
						HTML += "<input type=\"text\" id=\"Name"+i+"\" name=\"Name"+i+"\" required /></td><td id=\"DynamicFieldTableTDIDLabel"+i+"\">";
						HTML += "<input type=\"text\" id=\"Label"+i+"\" name=\"Label"+i+"\" required /></td>";
						HTML += "<td id=\"DynamicFieldTableTDIDDataBaseField"+i+"\">";
						HTML += "<select id=\"DatabaseField"+i+"\" name=\"DatabaseField"+i+"\" required><option>select</option>";
						HTML += "</select>";
						HTML += "</td></tr>";
					}
				HTML += "</table>";
				document.getElementById("dynamicFieldTableDataElement").innerHTML = HTML;
			}
		
		
		function verifyInput()
			{
				var NoOfFields = parseInt(document.getElementById("NoOfFields").value);
				if(NoOfFields <= 0)
					{
						window.alert("Number of Fields value should be greater than zero!");
						return false;
					}
				
				if(document.getElementById("DatabaseTableName").value == "select")
					{
						window.alert("Please select Database Table Name!");
						return false;
					}
				
				var checkDatabaseFiledsEntered = true;
				
				for(i=0;i<NoOfFields;i++)
					{
						var DatabaseField = document.getElementById("DatabaseField"+i).value;
						if(DatabaseField == "select")
							{
								checkDatabaseFiledsEntered = false;
							}
					}
				
				if(!checkDatabaseFiledsEntered)
					{
						alert("Please select Database Fields!");
						return false;
					}
				
				var returnValue = checkMaxNumber();
				
				if(returnValue)
					{
						var count = parseInt(document.getElementById("NoOfFields").value);
						
						for(j=0;j<count;j++)
							{
								var tempValue = document.getElementById("DatabaseField"+j).value;
								var repeat = 0;
								for(k=0;k<count;k++)
									{
										if(tempValue == document.getElementById("DatabaseField"+k).value)
											{
												repeat++;
											}
									}
								if(repeat > 1)
									{
										alert("Same Database Field value cannot be assigned to more than one Form Field!");
										return false;
									}
							}
					}
				
				return returnValue;
			}
		
		function updateTableFields()
			{
				var target = document.getElementById("DatabaseTableName");
				var count = parseInt(document.getElementById("NoOfFields").value);

				if(target.value == "select")
					{
						for(i=0;i<count;i++)
							{
								document.getElementById("DatabaseField"+i).innerHTML = '<option>select</option>';
								document.getElementById("NoOfFields").value = "1";
								createFields();
							}
					}
					else
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
												setFiledValueOptions(ajaxRequest.responseText,target.value);
											}
									}
										 
									var url = "/Choice/JSP/DatabaseJSP/listFields.jsp?tableName=" + target.value;
									ajaxRequest.open("GET", url, true);
									ajaxRequest.send();
						}
			}
		
		function setFiledValueOptions(responseText,TableName)
			{
				var count = parseInt(document.getElementById("NoOfFields").value); 
				
				for(i=0;i<count;i++)
					{
						document.getElementById("DatabaseField"+i).innerHTML = '<option>select</option>';
					}

				var length = responseText.length;
				length = length-9;
				responseText = responseText.substring(1,length);
				var list = responseText.split(",");
				var HTML="";
				document.getElementById("MaxNumberOfFieldsAllowed").value = list.length-2;
				for(j=0;j<list.length;j++)
					{	
						var PrimaryKeyField = TableName+"_UID";
						var autoNumber = TableName + "_AutoNumberPrefix";
						
						if(PrimaryKeyField.toUpperCase() != list[j].toUpperCase().trim() && autoNumber.toUpperCase() != list[j].toUpperCase().trim())
							{
								HTML += "<option value=\""+list[j]+"\">"+list[j]+"</option>";
							}
					}
				
				checkMaxNumber();
				createFields();
				
				for(k=0;k<count;k++)
				{
					document.getElementById("DatabaseField"+k).innerHTML = HTML;
				}
			}
		
		function checkMaxNumber()
			{
				var MaxNumber = parseInt(document.getElementById("MaxNumberOfFieldsAllowed").value);
				var ActualNumber = parseInt(document.getElementById("NoOfFields").value);
				
				if(ActualNumber > MaxNumber)
					{
						window.alert("Maximum number of fields allowed = "+MaxNumber);
						document.getElementById("NoOfFields").value = MaxNumber;
						return false;
					}
				
				return true;
			}
		
		function checkMinRows(id)
			{
				var TotalFields = parseInt(document.getElementById("NoOfFields").value);
				var Columns = parseInt(document.getElementById("NoOfColumns").value);
				var MaxRows = TotalFields;
				var MinRows = parseInt(TotalFields / Columns);
				if(TotalFields % Columns != 0)
					{
						MinRows += 1;
					}
				if(Columns < 1)
					{
						alert("Minimum number of columns required = 1");
						document.getElementById("NoOfColumns").value = "1";
					}
				if(Columns > TotalFields)
					{
						alert("Maximum number of columns allowed = "+TotalFields);
						document.getElementById("NoOfColumns").value = TotalFields;
					}
				if(id == "NoOfRows")
					{
						var Rows = parseInt(document.getElementById("NoOfRows").value);
						if(Rows<MinRows)
							{
								alert("Minimum number of rows required = "+MinRows);
								document.getElementById("NoOfRows").value = MinRows;
							}
						if(Rows>MaxRows)
						{
							alert("Maximum number of rows allowed = "+MaxRows);
							document.getElementById("NoOfRows").value = MaxRows;
						}
					}
					else
						{
							document.getElementById("NoOfRows").value = MinRows;	
						}
			}
		
		
		</script>
		
	</head>
	
	<body>
	
		<div id = header class = "header">
<%
			String strHeader = "Create Dynamic Search Form";
			if(isWriteJSP.equals("true"))
			{
				strHeader = "Write Search Form JSP";
			}
%>
			<h4 style="color:#ff6a22"><%=strHeader%></h4><br><br>

		</div>
		<div class="ActiveScreenObj" id="ActiveScreenObj" name="ActiveScreenObj">
		
			<div id = CreateDynamicFormDiv> 
				
				<form id="CreateDynamicForm" method="post" action="/Choice/JSP/DatabaseJSP/CreateDynamicSearchFormProcess.jsp" onsubmit="return verifyInput(); showProgress();">
					
					<input type="hidden" autocomplete="off">
					<input type="hidden" name="isWriteJSP" id="isWriteJSP" value="<%=isWriteJSP%>" />
						
						<table border="1">
						
							<input type="hidden" id="MaxNumberOfFieldsAllowed" name="MaxNumberOfFieldsAllowed" value="1" required/>
							
							<tr>
								<td>
									Select Database Table:
								</td>
								<td>
									<select id="DatabaseTableName" name="DatabaseTableName" onchange="updateTableFields();" required>
										<option>select</option>
<%
										List ExcludedTablesList = new ArrayList<String>();
										ExcludedTablesList = action.getExcludedTablesList();
										for(int i=0;i<TablesList.size();i++)
											{
												String strEachTable = ((String)TablesList.get(i)).trim();
												if(!ExcludedTablesList.contains(strEachTable))
												{
%>
												<option><%=strEachTable%></option>
<%												
												}
											}
%>
								</td>
							</tr>

							<tr>
								<td>
									Number of 
								</td>
								<td>
									Fields: <input type="number" id="NoOfFields" name="NoOfFields" value="1"  min="1" onchange="checkForNumber(value); checkMaxNumber(); createFields(); updateTableFields(); checkMinRows('NoOfColumns');" required />
									Columns: <input type="number" id="NoOfColumns" name="NoOfColumns" value="1"  min="1" onchange="checkForNumber(value); checkMinRows(id); createFields(); updateTableFields();" required />
									<input type="hidden" id="NoOfRows" name="NoOfRows" value="1" onchange="checkForNumber(value); checkMinRows(id); createFields(); updateTableFields();" required />
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
								updateTableFields();
								checkMinRows("NoOfColumns");
							</script>
							
							</tr>
							
							<tr>
								<td>
									Submit Button Label:
								</td>
								<td>
									<input type="text" id="SubmitLabel" name="SubmitLabel" value="" required/>
								</td> 
							</tr>
							
							<tr>
								<td>
									Form Title:
								</td>
								<td>
									<input type="text" id="FormTitle" name="FormTitle" value="" required/>
								</td> 
							</tr>
							
							<tr>
								<td>
									Form Heading:
								</td>
								<td>
									<input type="text" id="FormHeading" name="FormHeading" value="" required/>
								</td> 
							</tr>

							<tr>
								<td>
									Form Sub Heading:
								</td>
								<td>
									<input type="text" id="FormSubHeading" name="FormSubHeading" value="NA" required/>
								</td> 
							</tr>
										
						</table>
					

							 <br><input type="submit" id="submit" value="Create Form">

					
				</form>
				
			</div>
			
		</div>			
			
	</body>
<%
		}
}
%>	
</html>