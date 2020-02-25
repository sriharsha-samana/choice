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
				<link rel="stylesheet" href="/Choice/CSS/Common/jquery-ui.css">
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

		$('#commonForm').submit(function() { // catch the form's submit event
		    $.ajax({ // create an AJAX call...
		        data: $(this).serialize(), // get the form data
		        type: $(this).attr('method'), // GET or POST
		        url: $(this).attr('action'), // the file to call
		        success: function(response) { // on success..
		            $('#clientActiveScreen').html(response); // update the DIV
		        }
		    });
		    return false; // cancel original event to prevent form submitting
		});

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
		
			<form id="commonForm" name="commonForm" method="post" action="/Choice/JSP/DatabaseJSP/CommonSearchFormProcess.jsp" onsubmit="return checkInputFields();showProgress();">
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
													<input type="text" name="<%=eachFieldName%>" id="<%=eachFieldName%>" value="*" required />
												</td>
<%										
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
					
					<br><br><input type="submit" name="<%=strFormName%>Submit" id="<%=strFormName%>Submit" value="<%=strSubmitLabel%>">
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