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
		
		<title>Table Actions</title>
		
		<script type="text/javascript">
			
		function submitColumns()
		{
			var tableName =  document.getElementById("tableName").value;
			var ColumnNames =  document.getElementById("ColumnNames").value;
			var ActiveScreenURL = "/Choice/JSP/DatabaseJSP/DatabaseTableActionsProcess.jsp?tableName="+tableName+"&columnNames="+ColumnNames;
			loadAdminActiveScreen(ActiveScreenURL);
		}
		
		
		function updateTableFields()
		{
			var target = document.getElementById("tableName");
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
						    	setCheckboxes(ajaxRequest.responseText);
						    }
						  }
						 
					var url = "/Choice/JSP/DatabaseJSP/getTableDetails.jsp?tableName=" + target.value;
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
		
		
		function setCheckboxes(responseText)
		{
			var TableName = document.getElementById("tableName").value;
			var list = responseText.split(";");
			var NameList = [];
			var TypeList = [];
			var SizeList = [];
			var NullConstraintList = [];
			var UniqueConstraintList = [];
			var DefaultValueList = [];
			
			for(var j=0;j<list.length;j++)
				{
					var checkString = list[j];
					if(checkString.indexOf("Name") > -1)
						{
							var tempList = checkString.split(":");
							var tempString = tempList[1];
							tempString = tempString.substring(1,tempString.length-1);
							NameList = tempString.split(",");
						}
						else if(checkString.indexOf("DataType") > -1)
							{
								var tempList = checkString.split(":");
								var tempString = tempList[1];
								tempString = tempString.substring(1,tempString.length-1);
								TypeList = tempString.split(",");
							}
						else if(checkString.indexOf("Size") > -1)
						{
							var tempList = checkString.split(":");
							var tempString = tempList[1];
							tempString = tempString.substring(1,tempString.length-1);
							SizeList = tempString.split(",");
						}
						else if(checkString.indexOf("NullConstraint") > -1)
						{
							var tempList = checkString.split(":");
							var tempString = tempList[1];
							tempString = tempString.substring(1,tempString.length-1);
							NullConstraintList = tempString.split(",");
						}
						else if(checkString.indexOf("UniqueConstraint") > -1)
						{
							var tempList = checkString.split(":");
							var tempString = tempList[1];
							tempString = tempString.substring(1,tempString.length-1);
							UniqueConstraintList = tempString.split(",");
						}
						else if(checkString.indexOf("DefaultValue") > -1)
						{
							var tempList = checkString.split(":");
							var tempString = tempList[1];
							tempString = tempString.substring(1,tempString.length-1);
							DefaultValueList = tempString.split(",");
						}
				}

			var HTML = "<br><br><table border=\"1\"><tr><td><input id=\"TableNameCheckbox\" type=\"checkbox\" onclick=\"updateTableName();\"/></td><td id=\"TableNameData\" style=\"min-width:100px\">"+TableName+"</td>";
			HTML += "</tr></table><input type=\"button\" value=\"Update Table Name\" onclick=\"changeTableName();\" />";
			HTML += "</table>";
			HTML += "<br><br><br>";
			HTML += "<table id=\"TableFieldDataTable\" border=\"1\"><th>Select</th><th>Name</th><th>Type</th><th>Size</th><th>Null Constraint</th><th>Unique Constraint</th><th>Default Value</th>";
			var primaryKey = TableName + "_UID";
			var autoNumberPrefix = TableName + "_AutoNumberPrefix";
			var actualcount = 0;
			document.getElementById("numberOfFields").value = NameList.length;
			for(var i=0;i<NameList.length;i++)
				{	
					var temp = NameList[i]+"";
					if(temp.trim().toUpperCase() != primaryKey.trim().toUpperCase() && temp.trim().toUpperCase() != autoNumberPrefix.trim().toUpperCase())
						{
							HTML += "<tr>";
							HTML += "<td><input type=\"checkbox\" id=\"TableFieldDataCheckbox"+ actualcount +"\" onclick=\"updateTableFieldData("+ actualcount +");\" /></td>";
							HTML += "<td id=\"TableFieldName"+actualcount+"\">" + NameList[i].trim() + "</td>";
							HTML += "<td id=\"TableFieldType"+actualcount+"\">" + TypeList[i].trim() + "</td>";
							HTML += "<td id=\"TableFieldSize"+actualcount+"\">" + SizeList[i].trim() + "</td>";
							HTML += "<td id=\"TableFieldNullConstraint"+actualcount+"\">" + NullConstraintList[i].trim() + "</td>";
							HTML += "<td id=\"TableFieldUniqueConstraint"+actualcount+"\">" + UniqueConstraintList[i].trim() + "</td>";
							HTML += "<td id=\"TableFieldDefaultValue"+actualcount+"\">" + DefaultValueList[i].trim() + "</td>";
							
							HTML += "<input type=\"hidden\" id=\"TableFieldNameHidden"+actualcount+"\" value=\""+NameList[i].trim()+"\"/>";
							HTML += "<input type=\"hidden\" id=\"TableFieldTypeHidden"+actualcount+"\" value=\""+TypeList[i].trim()+"\"/>";
							HTML += "<input type=\"hidden\" id=\"TableFieldSizeHidden"+actualcount+"\" value=\""+SizeList[i].trim()+"\"/>";
							HTML += "<input type=\"hidden\" id=\"TableFieldNullConstraintHidden"+actualcount+"\" value=\""+NullConstraintList[i].trim()+"\"/>";
							HTML += "<input type=\"hidden\" id=\"TableFieldUniqueConstraintHidden"+actualcount+"\" value=\""+UniqueConstraintList[i].trim()+"\"/>";
							HTML += "<input type=\"hidden\" id=\"TableFieldDefaultValueHidden"+actualcount+"\" value=\""+DefaultValueList[i].trim()+"\"/>";
							
							HTML += "</tr>";
							actualcount++;
						}
				}
			HTML += "<tr><td>Number of new fields<br><input type=\"number\" id=\"NewFieldsCount\" name=\"NewFieldsCount\" value=\"0\" min=\"0\" onchange=\"updateNewTableFields();\"/></td></tr>";
			HTML += "</table><br>";
			HTML += "<input type=\"button\" value=\"Update fields\" onclick=\"updateTableFieldsData();\" />";
			HTML += "&nbsp<input type=\"button\" value=\"Delete fields\" onclick=\"DeleteTableFields();\" />";
			HTML += "&nbsp<input type=\"button\" value=\"Add new fields\" onclick=\"AddNewTableFields();\" />";
			
			HTML += "<br><br><br>";
			HTML += "<input type=\"button\" value=\"Delete Table\" onclick=\"DeleteTable();\" />";
			
			document.getElementById("updateFields").innerHTML = HTML;
			document.getElementById("hiddenInnerHTMLField").value = document.getElementById("TableFieldDataTable").innerHTML;
		}
		
		function updateTableName()
		{
			var TableName = document.getElementById("tableName").value;
			if(document.getElementById("TableNameCheckbox").checked)
				{
					document.getElementById("TableNameData").innerHTML = "<input type=\"text\" name=\"TableNameUpdate\" id=\"TableNameUpdate\" value=\""+TableName+"\"/>";
				}
				else
					{
						document.getElementById("TableNameData").innerHTML = TableName;
					}
		}
		
		function updateTableFieldData(i)
		{
			var FieldName = document.getElementById("TableFieldNameHidden"+i).value;
			var FieldType = document.getElementById("TableFieldTypeHidden"+i).value;
			var FieldSize = document.getElementById("TableFieldSizeHidden"+i).value;
			var FieldNullConstraint = document.getElementById("TableFieldNullConstraintHidden"+i).value;
			var FieldUniqueConstraint = document.getElementById("TableFieldUniqueConstraintHidden"+i).value;
			var FieldDefaultValue = document.getElementById("TableFieldDefaultValueHidden"+i).value;
			var fieldTypes = ["CHARACTER","VARCHAR","BINARY","BOOLEAN","INTEGER","FLOAT","REAL","DATE","TIME","TIMESTAMP"];
			var setSelectedValue = "";
			if(document.getElementById("TableFieldDataCheckbox"+i).checked)
				{
					document.getElementById("TableFieldName"+i).innerHTML = "<input type=\"text\" name=\"TableFieldNameUpdate"+i+"\" id=\"TableFieldNameUpdate"+i+"\" value=\""+FieldName+"\" required />";
					setSelectedValue = "<select name=\"TableFieldTypeUpdate"+i+"\" id=\"TableFieldTypeUpdate"+i+"\" onchange=\"updateSize(id,'TableFieldSizeUpdate"+i+"');\" required>";
					for(var j=0;j<fieldTypes.length;j++)
						{
							if(FieldType.toUpperCase() == fieldTypes[j].toUpperCase())
								{
									setSelectedValue += "<option value=\""+fieldTypes[j]+"\" selected>"+fieldTypes[j]+"</option>";
								}
								else
									{
										setSelectedValue += "<option value=\""+fieldTypes[j]+"\">"+fieldTypes[j]+"</option>";
									}
						}
					setSelectedValue += "</select>";
					document.getElementById("TableFieldType"+i).innerHTML = setSelectedValue;
					document.getElementById("TableFieldSize"+i).innerHTML = "<input type=\"text\" name=\"TableFieldSizeUpdate"+i+"\" id=\"TableFieldSizeUpdate"+i+"\" value=\""+FieldSize+"\" onchange=\"checkForNumber(value);\" required/>";
					setSelectedValue = "<select name=\"TableFieldNullConstraintUpdate"+i+"\" id=\"TableFieldNullConstraintUpdate"+i+"\" required>";
					
					if(FieldNullConstraint == "YES")
						{
							setSelectedValue += "<option value=\"YES\" selected>YES</option><option value=\"NO\">NO</option></select>";
						}
					else
						{
							setSelectedValue += "<option value=\"YES\">YES</option><option value=\"NO\" selected>NO</option></select>";
						}
					document.getElementById("TableFieldNullConstraint"+i).innerHTML = setSelectedValue;
					
					setSelectedValue = "<select name=\"TableFieldUniqueConstraintUpdate"+i+"\" id=\"TableFieldUniqueConstraintUpdate"+i+"\" required>";
					
					if(FieldUniqueConstraint == "YES")
						{
							setSelectedValue += "<option value=\"YES\" selected>YES</option><option value=\"NO\">NO</option></select>";
						}
					else
						{
							setSelectedValue += "<option value=\"YES\">YES</option><option value=\"NO\" selected>NO</option></select>";
						}
					document.getElementById("TableFieldUniqueConstraint"+i).innerHTML = setSelectedValue;
					document.getElementById("TableFieldDefaultValue"+i).innerHTML = "<input type=\"text\" name=\"TableFieldDefaultValueUpdate"+i+"\" id=\"TableFieldDefaultValueUpdate"+i+"\" value=\""+FieldDefaultValue+"\" required/>";
				}
				else
					{
						document.getElementById("TableFieldName"+i).innerHTML = FieldName;
						document.getElementById("TableFieldType"+i).innerHTML = FieldType;
						document.getElementById("TableFieldSize"+i).innerHTML = FieldSize;
						document.getElementById("TableFieldNullConstraint"+i).innerHTML = FieldNullConstraint;
						document.getElementById("TableFieldUniqueConstraint"+i).innerHTML = FieldUniqueConstraint;
						document.getElementById("TableFieldDefaultValue"+i).innerHTML = FieldDefaultValue;
					}
		}
		
		function updateNewTableFields()
		{
			var count = document.getElementById("NewFieldsCount").value;
			document.getElementById("numberOfNewFields").value = count;
			var existingInnerHTML = document.getElementById("hiddenInnerHTMLField").value;
			var fieldTypes = ["CHARACTER","VARCHAR","BINARY","BOOLEAN","INTEGER","FLOAT","REAL","DATE","TIME","TIMESTAMP"];
			
			for(var i=0;i<count;i++)
				{
					existingInnerHTML += "<tr>";
					existingInnerHTML += "<td><input type=\"checkbox\" id=\"NewTableFieldCheckbox"+i+"\"/>";
					existingInnerHTML += "</td>";
					existingInnerHTML += "<td><input type=\"text\" id=\"NewTableFieldName"+i+"\" name=\"NewTableFieldName"+i+"\" required/>";
					existingInnerHTML += "</td>";
					existingInnerHTML += "<td><select id=\"NewTableFieldType"+i+"\" name=\"NewTableFieldType"+i+"\" onchange=\"updateSize(id,'NewTableFieldSize"+i+"');\" required>";
					for(var j=0;j<fieldTypes.length;j++)
						{
							existingInnerHTML += "<option value=\""+fieldTypes[j]+"\">"+fieldTypes[j]+"</option>";
						}
					existingInnerHTML += "</select>";
					existingInnerHTML += "</td>";
					existingInnerHTML += "<td><input type=\"text\" id=\"NewTableFieldSize"+i+"\" name =\"NewTableFieldSize"+i+"\" onchange=\"checkForNumber(value);\" required/>";
					existingInnerHTML += "</td>";
					existingInnerHTML += "<td><select id=\"NewTableFieldNullConstraint"+i+"\" name=\"NewTableFieldNullConstraint"+i+"\" required><option value=\"YES\">YES</option><option value=\"NO\">NO</option></select>";
					existingInnerHTML += "</td>";
					existingInnerHTML += "<td><select id=\"NewTableFieldUniqueConstraint"+i+"\" name=\"NewTableFieldUniqueConstraint"+i+"\" required><option value=\"YES\">YES</option><option value=\"NO\">NO</option></select>";
					existingInnerHTML += "</td>";
					existingInnerHTML += "<td><input type=\"text\" id=\"NewTableFieldDefaultValue"+i+"\" name=\"NewTableFieldDefaultValue"+i+"\" value=\"NA\" required/>";
					existingInnerHTML += "</td>";
					existingInnerHTML += "</tr>";
				}
			document.getElementById("TableFieldDataTable").innerHTML = existingInnerHTML;
			document.getElementById("NewFieldsCount").value = count;
		}
		
		function updateSize(id,sizeId)
			{
				var selectedType = document.getElementById(id).value;
				if(selectedType == "CHARACTER" || selectedType == "VARCHAR" || selectedType == "BINARY")
					{
						document.getElementById(sizeId).value = "";
						document.getElementById(sizeId).readOnly = false;
					}
					else
						{
							document.getElementById(sizeId).value = "0";
							document.getElementById(sizeId).readOnly = true;
						}
			}
		
		function changeTableName()
		{
			if(document.getElementById("TableNameCheckbox").checked)
				{
					var oldTableName = document.getElementById("tableName").value;
					var newTableName = document.getElementById("TableNameUpdate").value;
					loadAdminActiveScreen("/Choice/JSP/DatabaseJSP/DatabaseTableActionsProcess.jsp?action=changeTableName&oldTableName="+oldTableName+"&newTableName="+newTableName,"_self");
				}
			else
				{
					alert("Check and edit Table Name to udpate!");
				}
		}
		function DeleteTable()
		{
			var check = confirm('Do you want to delete Table?');
			if(check)
				{
					var TableName = document.getElementById("tableName").value;
					loadAdminActiveScreen("/Choice/JSP/DatabaseJSP/DatabaseTableActionsProcess.jsp?action=deleteTable&tableName="+TableName,"_self");
				}
				else
					{
						return;				
					}
		}
		function updateTableFieldsData()
		{
			var NoOfFields = document.getElementById("numberOfFields").value;
			NoOfFields = NoOfFields-2;
			var checked = false;
			var count = 0;
			var TableName = document.getElementById("tableName").value;
			var FieldName = [];
			var FieldOldName = [];
			var FieldType = [];
			var FieldSize = [];
			var FieldNullConstraint = [];
			var FieldUniqueConstraint = [];
			var FieldDefaultValue = [];
			for(var i=0;i<NoOfFields;i++)
				{
					if(document.getElementById("TableFieldDataCheckbox"+i).checked)
						{
							checked = true;
							FieldName[count] = document.getElementById("TableFieldNameUpdate"+i).value;
							FieldOldName[count] = document.getElementById("TableFieldNameHidden"+i).value;
							FieldType[count] = document.getElementById("TableFieldTypeUpdate"+i).value;
							FieldSize[count] = document.getElementById("TableFieldSizeUpdate"+i).value;
							FieldNullConstraint[count] = document.getElementById("TableFieldNullConstraintUpdate"+i).value;
							FieldUniqueConstraint[count] = document.getElementById("TableFieldUniqueConstraintUpdate"+i).value;
							FieldDefaultValue[count] = document.getElementById("TableFieldDefaultValueUpdate"+i).value;
							count++;
						}
				}
			if(checked)
				{
					var allInputFields = document.getElementsByTagName("input");
					for(var i=0;i<allInputFields.length;i++)
						{
							var tagName = allInputFields[i].id;
							if(tagName.match(/TableField/g))
								{
									var checkValue = allInputFields[i].value;
									if(checkValue == null || checkValue == '' || checkValue.trim() == '')
										{
											alert("Please enter all fields!");
											return false;
										}
								}
						}
					
					loadAdminActiveScreen("/Choice/JSP/DatabaseJSP/DatabaseTableActionsProcess.jsp?action=updateTableFields&tableName="+TableName+"&fieldNames="+FieldName+"&fieldTypes="+FieldType+"&fieldSizes="+FieldSize+"&fieldNullConstraints="+FieldNullConstraint+"&fieldUniqueConstraints="+FieldUniqueConstraint+"&fieldDefaultValues="+FieldDefaultValue+"&oldFieldNames="+FieldOldName,"_self");
				}
				else
					{
						alert("Select atleast one Field to update!");
					}
		}
		function DeleteTableFields()
		{
			var NoOfFields = document.getElementById("numberOfFields").value;
			NoOfFields = NoOfFields-2;
			var count = 0;
			var checked = false;
			var TableName = document.getElementById("tableName").value;
			var FieldName = [];
			for(var i=0;i<NoOfFields;i++)
				{
					if(document.getElementById("TableFieldDataCheckbox"+i).checked)
						{
							checked = true;
							FieldName[count] = document.getElementById("TableFieldNameUpdate"+i).value;
							count++;	
						}
				}
			if(checked)
				{
					loadAdminActiveScreen("/Choice/JSP/DatabaseJSP/DatabaseTableActionsProcess.jsp?action=deleteTableFields&tableName="+TableName+"&fieldNames="+FieldName,"_self");
				}
				else
					{
						alert("Select atleast one Field to delete!");
					}
		}
		function AddNewTableFields()
		{
			var NoOfNewFields = document.getElementById("numberOfNewFields").value;
			var checked = false;
			var count = 0;
			var TableName = document.getElementById("tableName").value;
			var FieldName = [];
			var FieldType = [];
			var FieldSize = [];
			var FieldNullConstraint = [];
			var FieldUniqueConstraint = [];
			var FieldDefaultValue = [];
			for(var i=0;i<NoOfNewFields;i++)
				{
					if(document.getElementById("NewTableFieldCheckbox"+i).checked)
						{
							checked = true;
							FieldName[count] = document.getElementById("NewTableFieldName"+i).value;
							FieldType[count] = document.getElementById("NewTableFieldType"+i).value;
							FieldSize[count] = document.getElementById("NewTableFieldSize"+i).value;
							FieldNullConstraint[count] = document.getElementById("NewTableFieldNullConstraint"+i).value;
							FieldUniqueConstraint[count] = document.getElementById("NewTableFieldUniqueConstraint"+i).value;
							FieldDefaultValue[count] = document.getElementById("NewTableFieldDefaultValue"+i).value;
							count++;
						}
				}
			if(checked)
				{
					var allInputFields = document.getElementsByTagName("input");
					for(var i=0;i<allInputFields.length;i++)
					{
						var tagName = allInputFields[i].id;
						if(tagName.match(/NewTableField/g))
							{
								var checkValue = allInputFields[i].value;
								if(checkValue == null || checkValue == '' || checkValue.trim() == '')
									{
										alert("Please enter all fields!");
										return false;
									}
							}
					}
					loadAdminActiveScreen("/Choice/JSP/DatabaseJSP/DatabaseTableActionsProcess.jsp?action=addNewTableFields&tableName="+TableName+"&fieldNames="+FieldName+"&fieldTypes="+FieldType+"&fieldSizes="+FieldSize+"&fieldNullConstraints="+FieldNullConstraint+"&fieldUniqueConstraints="+FieldUniqueConstraint+"&fieldDefaultValues="+FieldDefaultValue,"_self");
				}
				else
					{
						alert("Select atleast one new field to add!");
					}
		}

		</script>
		
	</head>
<%
		Actions action = new Actions();	
		String strTable = null;
%>
	<body>
	
		<div id = header1 class = "header1">
			<h4 style="color:#ff6a22">Table Actions</h4><br><br>
		</div>

		<div class="ActiveScreenObj" id="ActiveScreenObj" name="ActiveScreenObj">
		
				
				<form id="SearchDatabaseForm">
											
									<h6>Select Table Name </h6><br>
									<select style="width:150px;height:30px" name="tableName" id="tableName" required onchange="updateTableFields();">
									<option selected>select</option>
<% 										
										List ExcludedTablesList = new ArrayList<String>();
										ExcludedTablesList = action.getExcludedTablesList();

										List TablesList = new ArrayList<String>();
										TablesList = action.listTables();
										for(int i=0;i<TablesList.size();i++)
											{
												
											String strEachTable = ((String)TablesList.get(i)).trim();
											if(!ExcludedTablesList.contains(strEachTable))
												{
%>
													<option><%=strEachTable %></option>
<%												
												}
											}
%>									
									</select>
						
						<div id="updateFields" class="updateFields">
								
						</div>
						
						<input type="hidden" id="hiddenInnerHTMLField" name="hiddenInnerHTMLField" />
						<input type="hidden" id="numberOfFields" name="numberOfFields" />		
						<input type="hidden" id="numberOfNewFields" name="numberOfFields" />
					
				</form>
			
		</div>			
			
	</body>
<%
		}
}
%>	
</html>