<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="databaseActions.Actions"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Arrays"%>

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
		try
		{
			String strTableName = request.getParameter("tableName");	
			String strFieldName = request.getParameter("fieldName");
			ArrayList<String> selectList = new ArrayList<String>();
			List<String> tempList = Arrays.asList(strFieldName.split(","));
			for(int i=0;i<tempList.size();i++)
			{
				String strTemp = (String)tempList.get(i);
				if(strTemp != null)
				{
					strTemp = strTemp.trim();
					selectList.add(strTemp);
				}
			}
			
			String strFieldCondition = request.getParameter("fieldCondition");
			ArrayList<String> selectListCondition = new ArrayList<String>();
			List<String> tempConditionList = Arrays.asList(strFieldCondition.split(","));
			for(int j=0;j<tempConditionList.size();j++)
			{
				String strTemp = (String)tempConditionList.get(j);
				if(strTemp != null)
				{
					strTemp = strTemp.trim();
					selectListCondition.add(strTemp);
				}
			}
			
			String strPrimaryKey = "NA";
			Actions action = new Actions();			

			String[][] resultArray = action.searchDatabase(strTableName, selectList, selectListCondition, strPrimaryKey);
			selectList.add(strTableName+"_UID");
			String[][] resultArrayWithKeys = action.searchDatabase(strTableName, selectList, selectListCondition, strPrimaryKey);
			session.setAttribute("tableName", strTableName);
			session.setAttribute("resultArray", resultArray);
			session.setAttribute("resultArrayWithKeys", resultArrayWithKeys);
			
			List ExcludedTablesList = new ArrayList<String>();
			ExcludedTablesList = action.getExcludedTablesList();
			List TablesList = new ArrayList<String>();
			TablesList = action.listTables();
			List RequiredTablesList = new ArrayList<String>();
			for(int i=0;i<TablesList.size();i++)
				{
					String strEachTable = ((String)TablesList.get(i)).trim();
					if(!ExcludedTablesList.contains(strEachTable))
					{
						RequiredTablesList.add(strEachTable);
					}
				}
%>
		
		<title>Search Results</title>
		
		<script type="text/javascript">
		
		
		function allowEdit(i,rows,columns)
			{

				if(document.getElementById("EditableFieldsCheckbox"+i).checked)
					{
						var selectFields = ["IsSearchForm","FieldType"];
						var nonEditableFields = ["Name","FieldValidations","NumberOfFields","NumberOfRows","NumberOfColumns","TableName","FormName","FieldName","FieldValidations","DBTableField","Fields"];
						var numberFields = [];
						var checkBoxFields = [];
						
						for(z=2;z<columns+2;z++)
							{
							
									var options = [];
									var eachFieldType = document.getElementById("tableHeading"+z).innerHTML;
									
									if(selectFields.indexOf(eachFieldType) > -1)
										{
											if(eachFieldType == "IsSearchForm")
												{
													options = ["true","false"];
												}
											
											if(eachFieldType == "TableName")
											{
												var strOptions = "<%=RequiredTablesList%>";
												strOptions = strOptions.substring(1,strOptions.length-1);
												options = strOptions.split(",");
											}
											
											if(eachFieldType == "FieldType")
											{
												options = ["text","password","select","radio","checkbox","number","textarea","date","email","range","url"];
											}
											
											eachFieldType = "selectField";
										}
									else if(nonEditableFields.indexOf(eachFieldType) > -1)
										{
											eachFieldType = "nonEditableField";
										}
									else if(numberFields.indexOf(eachFieldType) > -1)
									{
										eachFieldType = "numberField";
									}
									else if(checkBoxFields.indexOf(eachFieldType) > -1)
									{
										eachFieldType = "checkboxField";
									}
									
									var value = document.getElementById("EditableFieldsHidden"+i+"_"+z).value;
									
									if(eachFieldType == "selectField")
									{
										var html = "<select id=\"EachEditableField"+i+"_"+z+"\" name=\"EachEditableField"+i+"_"+z+"\">";
										for(var j=0;j<options.length;j++)
											{
												if(options[j] == value)
													{
														html += "<option value=\""+options[j]+"\" selected>"+options[j]+"</option>";
													}
												else
													{
														html += "<option value=\""+options[j]+"\">"+options[j]+"</option>";
													}
											}
										html += "</select>";
										
										document.getElementById("EditableFields"+i+"_"+z).innerHTML = html;
									}
									else if(eachFieldType == "numberField")
									{
										document.getElementById("EditableFields"+i+"_"+z).innerHTML = "<input type=\"number\" id=\"EachEditableField"+i+"_"+z+"\" name=\"EachEditableField"+i+"_"+z+"\" value=\""+value+"\">";
									}
									else if(eachFieldType == "nonEditableField")
									{
										document.getElementById("EditableFields"+i+"_"+z).innerHTML = value + "<input type=\"hidden\" id=\"EachEditableField"+i+"_"+z+"\" name=\"EachEditableField"+i+"_"+z+"\" value=\""+value+"\">";
									}
									else
										{
											document.getElementById("EditableFields"+i+"_"+z).innerHTML = "<input type=\"text\" id=\"EachEditableField"+i+"_"+z+"\" name=\"EachEditableField"+i+"_"+z+"\" value=\""+value+"\">";
										}
							}
						
						document.getElementById("EditableFieldsCheckbox"+i+"Text").value = "true";
					}
					else
						{
							for(z=2;z<columns+2;z++)
								{
										var value = document.getElementById("EditableFieldsHidden"+i+"_"+z).value;
										document.getElementById("EditableFields"+i+"_"+z).innerHTML = value;
								}
							
							document.getElementById("EditableFieldsCheckbox"+i+"Text").value = "false";
						}
				
			}
		
		function AddNewFields(rows,columns)
			{
				var HTML = document.getElementById("NewFieldHidden").value;

				var FieldCount = document.getElementById("NoOfNewEntries").value;
				
				for(i=0;i<FieldCount;i++)
					{
						HTML += "<tr><td><input type=\"checkbox\" id=\"EachNewEntryFieldCheckbox"+(i+2)+"\" name=\"EachNewEntryFieldCheckbox"+(i+2)+"\" onclick=\"updateCheckboxValue(id);\" /></td>";
						HTML += "<input type=\"hidden\" id=\"EachNewEntryFieldCheckbox"+(i+2)+"Text\" name=\"EachNewEntryFieldCheckbox"+(i+2)+"Text\" value=\"false\" />";
						for(z=2;z<columns+2;z++)
							{
								var rowCount = i+2;
								HTML += "<td><input type=\"text\" id=\"EachNewEntryField"+rowCount+"_"+z+"\" name=\"EachNewEntryField"+rowCount+"_"+z+"\" value=\"\" required/></td>";
							}
						HTML += "</tr>";
					}
				 
				document.getElementById("NewField").innerHTML = HTML;
				document.getElementById("NoOfNewEntries").value = FieldCount;
			}
		
		function storeInnerHTML()
			{
				document.getElementById("NewFieldHidden").value = document.getElementById("NewField").innerHTML;
			}
		
		function AddNewEntry()
			{
				var NoOfNewEntries = document.getElementById("NoOfNewEntries").value;
				var checkedAtleastOne = "false";
				
				for(i=0;i<NoOfNewEntries;i++)
					{
						var checked = document.getElementById("EachNewEntryFieldCheckbox"+(i+2)+"Text").value;
						if(checked == "true")
							{
								checkedAtleastOne = "true";
							}
					}
				
				if(checkedAtleastOne != "true")
					{
						alert("Please select atleast one Entry to be added !!");
						return false;
					}
				document.getElementById("DatabaseActionsForm").action = "/Choice/JSP/DatabaseJSP/AddNewEntry.jsp";
				document.DatabaseActionsForm.submit();
			}
		
		function DeleteExistingEntry(rows)
			{
				var checkedAtleastOne = "false";
				for(i=0;i<rows;i++)
					{
						var checked = document.getElementById("EditableFieldsCheckbox"+(i+2)+"Text").value;
						if(checked == "true")
							{
								checkedAtleastOne = "true";
							}
					}
				
				if(checkedAtleastOne != "true")
					{
						alert("Please select atleast one Entry to be deleted !!");
						return false;
					}
				
				document.getElementById("DatabaseActionsForm").action = "/Choice/JSP/DatabaseJSP/DeleteExistingEntry.jsp";
				document.DatabaseActionsForm.submit();
			}
		
		function UpdateExistingEntry(rows)
			{
				var checkedAtleastOne = "false";
				for(i=0;i<rows;i++)
					{
						var checked = document.getElementById("EditableFieldsCheckbox"+(i+2)+"Text").value;
						if(checked == "true")
							{
								checkedAtleastOne = "true";
							}
					}
				
				if(checkedAtleastOne != "true")
					{
						alert("Please select atleast one Entry to be updated !!");
						return false;
					}
				document.getElementById("DatabaseActionsForm").action = "/Choice/JSP/DatabaseJSP/UpdateExistingEntry.jsp";
				document.DatabaseActionsForm.submit();
			}
		
		function updateCheckboxValue(id)
			{
				if(document.getElementById(id).checked)
					{
						document.getElementById(id+"Text").value = "true";
					}
					else
						{
							document.getElementById(id+"Text").value = "false";
						}
			}
		
		</script>
		
	<h4 style="color:#ff6a22">Edit Forms & Tables</h4><br><br>
	
	</head>

	<body>
	
		<form id="DatabaseActionsForm" name="DatabaseActionsForm" method="POST">
	
<%
			if(resultArray[0][0] == "No DB")
				{
%>
					Database not installed.
<%
				}
			else if(resultArray[0][0] == "No Data Found")
			{
%>
				No Data Found.	
<%				
			}
			else if(resultArray[0][0].trim() == "Exception")
			{
%>
				Wrong input details.
<%
			}
			else
				{
					int rows = Integer.parseInt(resultArray[0][0]); 
					int columns = Integer.parseInt(resultArray[0][1]); 
					int rowsWithKeys = Integer.parseInt(resultArrayWithKeys[0][0]); 
					int columnsWithKeys = Integer.parseInt(resultArrayWithKeys[0][1]); 
					String[] primaryKeys = new String[rows];
					
					for(int i=2;i<rowsWithKeys+2;i++)
					{
						for(int k=2;k<columnsWithKeys+2;k++)
							{
								if(resultArrayWithKeys[1][k].equalsIgnoreCase(strTableName+"_UID"))
									{
										primaryKeys[i-2] = resultArrayWithKeys[i][k];
									}
							}
					}
%>

					<table border="1" id="NewField">	
					<th>Select Fields</th>	
<%
					for(int z=2;z<columns+2;z++)
						{

%>
											<th id="tableHeading<%=z%>"><%=resultArray[1][z]%></th>
<%	
						}

					for(int i=2;i<rows+2;i++)
						{
							if(!primaryKeys[i-2].equals("1"))
								{
%>
								<tr>
								
									<td>
										<input type="checkbox" id="EditableFieldsCheckbox<%=i %>" name="EditableFieldsCheckbox<%=i %>" onclick="allowEdit(<%=i %>,<%=rows %>,<%=columns %>);">
										<input type="hidden" id="EditableFieldsCheckbox<%=i %>Text" name="EditableFieldsCheckbox<%=i %>Text" value="false">
									</td>
<%								
								for(int k=2;k<columns+2;k++)
									{	
%>
												<td id="EditableFields<%=i %>_<%=k%>"><%= resultArray[i][k]%></td>	
												<input type="hidden" id="EditableFieldsHidden<%=i %>_<%=k%>" name="EditableFieldsHidden<%=i %>_<%=k%>" value="<%= resultArray[i][k]%>">							
<%
									}
%>								

								</tr>			
<%
								}
								else
								{
%>
									<input type="hidden" id="EditableFieldsCheckbox<%=i %>Text" name="EditableFieldsCheckbox<%=i %>Text" value="false">
<%
								}
						}
								
%>							
					</table>
					

						<input type="hidden" name="NewFieldHidden" id="NewFieldHidden" value="" />
						
					<script>
					 	storeInnerHTML();
					 	AddNewFields(<%=rows %>,<%=columns %>);
					</script>
						
						

							<input type="button" name="Update" id="Update" value="Update" style="width: 125px; height: 30px" onclick="UpdateExistingEntry(<%=rows %>);" />
<%
					if(!strTableName.equalsIgnoreCase("formfield"))
					{
%>
							<input type="button" name="Delete" id="Delete" value="Delete" style="width: 125px; height: 30px" onclick="DeleteExistingEntry(<%=rows %>);" />

<%	
					}
				}
		}
		catch(Exception e)
			{
				System.out.println("Exception in DatabaseDataActionsProcess.jsp ::"+e);
%>
				<jsp:forward page="/JSP/ErrorJSP/Error.jsp"></jsp:forward>
<%
			}
%>
		</form>
		
	</body>
<%
		}
}
%>

</html>