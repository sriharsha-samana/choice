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

		
		<title>Search Database</title>
		
		<script type="text/javascript">
			
		function setCheckboxValues()
		{
			var tableName =  document.getElementById("tableName").value;
			var fieldName =  document.getElementsByName("fieldName");
			var fieldNameCondition =  document.getElementsByName("fieldNameCondition");
			var fieldNameValue = "";
			var fieldNameConditionValue = "";
			for(i=0;i<fieldName.length;i++)
				{
					if(fieldName[i].checked)
						{
							fieldNameValue += fieldName[i].value.trim() + ",";
							fieldNameConditionValue += fieldNameCondition[i].value.trim() + ",";
						}
				}
			fieldNameValue = fieldNameValue.substring(0,fieldNameValue.length-1);
			fieldNameConditionValue = fieldNameConditionValue.substring(0,fieldNameConditionValue.length-1);
			var ActiveScreenURL = "/Choice/JSP/DatabaseJSP/DynamicFormActionsProcess.jsp?tableName="+tableName+"&fieldName="+fieldNameValue+"&fieldCondition="+fieldNameConditionValue;
			loadAdminActiveScreen(ActiveScreenURL);
		}
		
		function updateTableFields()
		{
			var target = document.getElementById("tableName");
			if(target.value == "select" || target.value == "No DB")
				{
					if(target.value == "select")
						{
							document.getElementById('selectFields').innerHTML = '';
						}
						else
							{
								document.getElementById('selectFields').innerHTML = '<h2>Database doesnot exist.</h2>';
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
						    	setCheckboxes(ajaxRequest.responseText);
						    }
						  }
						 
					
					var url = "/Choice/JSP/DatabaseJSP/listFields.jsp?tableName=" + target.value;
					ajaxRequest.open("GET", url, true);
					ajaxRequest.send();
				}
		}
		
		
		function setCheckboxes(responseText)
		{
			document.getElementById('selectFields').innerHTML = '';
			var TableName = document.getElementById("tableName").value;
			var length = responseText.length;
			length = length-9;
			responseText = responseText.substring(1,length);
			var list = responseText.split(",");
			var HTML1 = "<table border=1>";
			for(i=0;i<list.length;i++)
				{	
					var primaryKey = TableName + "_UID";
					var temp = list[i]+"";
					if(temp.trim().toUpperCase() != primaryKey.trim().toUpperCase())
						{
							HTML1 += "<tr><td><input type='checkbox' id='fieldName' name='fieldName' value='"+list[i]+"' checked></td><td align=center>"+list[i]+"</td>";
							HTML1 += "<td><input type='text' id='fieldNameCondition' name='fieldNameCondition' value='*'></td></tr>";
						}
				}
			
			document.getElementById("selectFields").innerHTML = HTML1;
		}
		
		</script>
		
	</head>
<%
		Actions action = new Actions();	
		String strTable = null;
%>
	<body>
	
		<div id = header1 class = "header1">
			<h4 style="color:#ff6a22">Edit Forms & Tables</h4><br><br>
		</div>

		<div class="ActiveScreenObj" id="ActiveScreenObj" name="ActiveScreenObj">
		
			<div id = CreateUserFormDiv> 
				
				<form id="SearchDatabaseForm">
						
						<table border="1">
							
							<tr>
							
								<td>
									Table Name:
								</td>
								<td>
									<select style="min-width:120px; height:30px" name="tableName" id="tableName" required onchange="updateTableFields();">
									<option selected>select</option>
									<option value="formmaster">Forms</option>
									<option value="formfield">Form Fields</option>
									<option value="tablemaster">Tables</option>

									</select>
								</td>
								
							</tr>
							
							<tr>
							
								<td>
									Select Fields:
								</td>
								
								<td>
									<div id="selectFields" name="selectFields">
									
									</div>
									
								</td>
									
							</tr>
							
										
						</table>
					
						<br><input type="button" id="button" value="Search" onclick="setCheckboxValues();"/>

					
				</form>
				
			</div>
			
		</div>			
			
	</body>
<%
		}
}
%>	
</html>