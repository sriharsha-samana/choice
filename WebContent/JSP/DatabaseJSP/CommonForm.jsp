<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="databaseActions.Actions"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.sql.rowset.CachedRowSet"%>
<%@page import="java.util.ArrayList"%>

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
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/globals.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/typography.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/grid.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/ui.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/forms.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/orbit.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/reveal.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/mobile.css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/app.css">
			  <link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css" type="text/css">
			  <link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/responsive-tables.css">
			  <link rel="stylesheet" href="/Choice/CSS/Common/jquery-ui.css">
			  <link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css">
			  <script src="/Choice/JS/ResponsiveTables/jquery.min.js"></script>
			  <script src="/Choice/JS/ResponsiveTables/responsive-tables.js"></script>
			  <script src="/Choice/JS/CommonJS.js"></script>
  			  <script src="/Choice/JS/jquery-ui.js"></script>
  			  <script src="/Choice/JS/HomePage/colpick.js"></script>
			  <link rel="stylesheet" href="/Choice/CSS/HomePage/colpick.css">


<%
		String strFormName = request.getParameter("formName");
		Actions action = new Actions();	
		String strWhere = null;
		String strDBTableName = null;
		String strNoOfFields = null;
		String strNoOfColumns = null;
		String strNoOfRows = null;
		String strHeading = null;
		String strSubHeading = null;
		String strSubmitLabel = null;
		String strTitle = null;
		String strAutoNumberLabel = null;
		String strAutoNumberPrefix = null;
		
		if(strFormName != null)
			{
				strWhere = "Name = '"+strFormName+"'";
			}
		
		CachedRowSet resultSetFormMaster = action.fetchDataFromDB("formmaster", null, strWhere);
	
			if(resultSetFormMaster.next())
				{
					strDBTableName = resultSetFormMaster.getString("TableName");
					strNoOfFields = resultSetFormMaster.getString("NumberOfFields");
					strNoOfColumns = resultSetFormMaster.getString("NumberOfColumns");
					strNoOfRows = resultSetFormMaster.getString("NumberOfRows");
					strHeading = resultSetFormMaster.getString("Heading");
					strSubHeading = resultSetFormMaster.getString("SubHeading");
					strSubmitLabel = resultSetFormMaster.getString("SubmitLabel");
					strTitle = resultSetFormMaster.getString("Title");
				}
			else
				{
					strFormName = null;
				}
%>

<%
			if(strTitle != null)
				{		
%>
					<title><%=strTitle%></title>
<%
				}
%>
		
		<script type="text/javascript">
			
		function setCheckboxes(name)
			{
				var value = "";
				var checkboxes = document.getElementsByName(name);
				for(var i=0;i<checkboxes.length;i++)
					{
						var obj = checkboxes[i];
						if(obj.checked)
							{
								value = value + "," + obj.value;
							}
					}
				
				if(value != "")
				{
					value=value.substring(1,value.length);
				}
				
				document.getElementById(name).value = value;
			}
		  
		</script>
		
<%
		if(strHeading != null)
			{
%>	
				<br><h4 style="color:#ff6a22"><%=strHeading%></h4>
<%
			}
%>	
	</head>
	
	<body>
		<div id="subHeader" class="subHeader">
<%
		if(strSubHeading != null && !strSubHeading.equals("") && !strSubHeading.equalsIgnoreCase("NA"))
			{
%>
				<h6><%=strSubHeading%></h6>
<%
			}
%>
		</div>
		
		<div id="formData" class="formData">
		
			<form id="commonForm" name="commonForm" method="post" action="/Choice/JSP/DatabaseJSP/CommonFormProcess.jsp" onsubmit="return checkInputFields();showProgress();">
				<input type="hidden" name="formName" id="formName" value="<%=strFormName%>"/>
<%
			
			if(strFormName != null)
				{
%>
					<div id=formInnerData class=formInnerData>
<%	
						strWhere = "FormName = '"+strFormName+"'";
						CachedRowSet resultSetFormField = action.fetchDataFromDB("formfield", null, strWhere);
						int rows = Integer.parseInt(strNoOfRows);
						int columns = Integer.parseInt(strNoOfColumns);
						int total = Integer.parseInt(strNoOfFields);
%>
						<br><table id="formDataTable" name="formDataTable" border="1">
<%
						
						int x = 0;
						resultSetFormField.next();
						for(int y=0;y<rows;y++)
							{
								
									
%>
								<tr>
									
									
<%
								for(int a=0;a<columns;a++)
								{					
									if(x<total)
										{
											String eachFieldName = resultSetFormField.getString("FieldName");
											eachFieldName = eachFieldName.replace(" ", "_");
											String eachFieldLabel = resultSetFormField.getString("FieldLabel");
											String eachFieldType = resultSetFormField.getString("FieldType");
											String eachFieldOptions = resultSetFormField.getString("FieldOptions");
%>
											<td>
												<%=eachFieldLabel%>
											</td>
<%
											if(eachFieldType.equalsIgnoreCase("text"))
											{
%>
												<td>
													<input type="text" name="<%=eachFieldName%>" id="<%=eachFieldName%>" value="" required />
												</td>
<%										
											}
											if(eachFieldType.equalsIgnoreCase("password"))
											{
%>
												<td>
													<input type="password" name="<%=eachFieldName%>" id="<%=eachFieldName%>" value="" required />
												</td>
<%
												
											}
											if(eachFieldType.equalsIgnoreCase("textarea"))
											{
%>
												<td>
													<textarea name="<%=eachFieldName%>" id="<%=eachFieldName%>" value="" required></textarea>
												</td>
<%
												
											}
											if(eachFieldType.equalsIgnoreCase("date"))
											{
%>
												<td>
													<input type=text id="<%=eachFieldName%>" name="<%=eachFieldName%>" value="" readonly required/>
												</td>
												
												<script>$(function() {$( "#<%=eachFieldName%>" ).datepicker({showOn: "button",buttonImage: "/Choice/Images/Icons/Calendar.gif",buttonImageOnly: true});});</script>
<%										
											}
											if(eachFieldType.equalsIgnoreCase("email"))
											{
%>
												<td>
													<input type="email" id="<%=eachFieldName%>" name="<%=eachFieldName%>" value="" required/>
												</td>
<%											
											}
											if(eachFieldType.equalsIgnoreCase("url"))
											{
%>
												<td>
													<input type="url" id="<%=eachFieldName%>" name="<%=eachFieldName%>" value="" required/>
												</td>
<%											
											}
											if(eachFieldType.equalsIgnoreCase("select") || eachFieldType.equalsIgnoreCase("radio") || eachFieldType.equalsIgnoreCase("checkbox") || eachFieldType.equalsIgnoreCase("number") || eachFieldType.equalsIgnoreCase("range"))
											{
													
												List<String> optionsList = Arrays.asList(eachFieldOptions.split(","));
												if(eachFieldType.equalsIgnoreCase("select"))
												{
%>
													<td>
														<select id="<%=eachFieldName%>" name="<%=eachFieldName%>" required>
<%
															for(int i=0;i<optionsList.size();i++)
															{
																String eachOption = optionsList.get(i).trim();
%>
																<option value="<%=eachOption%>"><%=eachOption%></option>
<%																
															}
%>															
														</select>
													</td>
<%		
												}
												if(eachFieldType.equalsIgnoreCase("radio"))
												{
%>
													<td>
<%
															for(int i=0;i<optionsList.size();i++)
															{
																String eachOption = optionsList.get(i).trim();
%>
																<input type="radio" id="<%=eachFieldName%>" name="<%=eachFieldName%>" value="<%=eachOption%>"/>
																<%=eachOption%>
																<br>
<%																
															}
%>															
													</td>
<%		
												}
												if(eachFieldType.equalsIgnoreCase("checkbox"))
												{
%>
													<td>
<%
															for(int i=0;i<optionsList.size();i++)
															{
																String eachOption = optionsList.get(i).trim();
%>
																<input type="checkbox" id="<%=eachFieldName%>" name="<%=eachFieldName%>" value="<%=eachOption%>" onclick="setCheckboxes(name);"/>
																<%=eachOption%>
																<br>
<%																
															}
%>															
													</td>
<%		
												}
												if(eachFieldType.equalsIgnoreCase("number"))
												{
													String min = optionsList.get(0).trim();
													String max = optionsList.get(1).trim();
%>
													<td>
														<input type="number" id="<%=eachFieldName%>" name="<%=eachFieldName%>" value="" min="<%=min%>" max="<%=max%>" required/>															
													</td>
<%		
												}
												if(eachFieldType.equalsIgnoreCase("range"))
												{
													String min = optionsList.get(0).trim();
													String max = optionsList.get(1).trim();
%>
													<td>
														<input type="range" id="<%=eachFieldName%>" name="<%=eachFieldName%>" value="" min="<%=min%>" max="<%=max%>" required/>															
													</td>
<%		
												}
									
											}	
											
											x++;
											resultSetFormField.next();
										}
								}
%>
									
								</tr>	
<%
							
							}
%>						
						</table>
					</div>
					
					<br><br><input type="submit" name="<%=strFormName%>Submit" id="<%=strFormName%>Submit" value="<%=strSubmitLabel%>" onclick="checkDates();">
<%					
				}
%>	
			</form>
			
		</div>
		
	</body>
<%
		}
}
%>	
</html>