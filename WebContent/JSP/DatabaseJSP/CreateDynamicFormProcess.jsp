<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="adminActions.FormActions"%>
<%@page import="java.io.File"%>

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

		
		<title>Create User</title>
		
	
	</head>

	<body>
<%
	try
		{
	String strNoOfFields = request.getParameter("NoOfFields");
	String strNoOfColumns = request.getParameter("NoOfColumns");
	String strNoOfRows = request.getParameter("NoOfRows");
	int columns = Integer.valueOf(strNoOfColumns);
	int rows = Integer.valueOf(strNoOfRows);
	String DatabaseTableName = request.getParameter("DatabaseTableName");
	int NoOfFields = Integer.valueOf(strNoOfFields);
	String Types[] = new String[NoOfFields];
	String Names[] = new String[NoOfFields];
	String Labels[] = new String[NoOfFields];
	String Options[] = new String[NoOfFields];
	String Validations[] = new String[NoOfFields];
	String DatabaseTableFieldNames[] = new String[NoOfFields];
	for(int i=0;i<NoOfFields;i++)
	{
		String strEachType = request.getParameter("Type"+i);
		Types[i] = strEachType.trim();
		String strEachName = request.getParameter("Name"+i);
		Names[i] = strEachName.trim();
		String strEachLabel = request.getParameter("Label"+i);
		Labels[i] = strEachLabel.trim();
		String strEachOptionValue = "";
		String strEachOptionsCount = request.getParameter("OptionsCount"+i);
		if(strEachOptionsCount == null)
		{
			strEachOptionValue = request.getParameter("Options"+i);
		}
		else
		{
			int EachOptionsCount = Integer.valueOf(strEachOptionsCount);
			for(int j=0;j<EachOptionsCount;j++)
			{
				String tempValue = request.getParameter("Options"+i+"Internal"+j).trim();
				if(j==(EachOptionsCount-1))
				{
					strEachOptionValue = strEachOptionValue + tempValue;
				}
				else
				{
					strEachOptionValue = strEachOptionValue + tempValue + ",";
				}
			}
		}
		
		Options[i] = strEachOptionValue;
		
		String strEachValidations = request.getParameter("Validations"+i);
		if(strEachValidations.equalsIgnoreCase("NA"))
		{
			Validations[i] = "NA";
		}
		
		String strEachDatabaseTable = request.getParameter("DatabaseTable"+i);
		String strEachDatabaseTableField = request.getParameter("DatabaseField"+i);
		DatabaseTableFieldNames[i] = strEachDatabaseTableField.trim();
	}
	String strSubmitLabel = request.getParameter("SubmitLabel");
	strSubmitLabel = strSubmitLabel.trim();
	String strFormTitle = request.getParameter("FormTitle");
	strFormTitle = strFormTitle.trim();
	String strFormHeading = request.getParameter("FormHeading");
	strFormHeading = strFormHeading.trim();
	String strFormSubHeading = request.getParameter("FormSubHeading");
	strFormSubHeading = strFormSubHeading.trim();
	String strSuccessMessage = request.getParameter("SuccessMessage");
	strSuccessMessage = strSuccessMessage.trim();

	File appFolder = new File(application.getRealPath("/"));
	String strApplicationPath = appFolder.toURL().toString();
	strApplicationPath = strApplicationPath.substring(strApplicationPath.indexOf("file:/")+6, strApplicationPath.length());
	FormActions action = new FormActions();
	boolean isSearchForm = false;
	boolean IsFormCreated = false;
	String isWriteJSP = request.getParameter("isWriteJSP");
	if(isWriteJSP.equalsIgnoreCase("true"))
	{
		IsFormCreated = action.createForm(Types, Names, Labels, Options, Validations, DatabaseTableName, DatabaseTableFieldNames, strSubmitLabel, strFormTitle, strFormHeading, columns, rows, isSearchForm, strApplicationPath);
	}
	else
	{
		IsFormCreated = action.createDynamicForm(Types, Names, Labels, Options, Validations, DatabaseTableName, DatabaseTableFieldNames, strSubmitLabel, strFormTitle, strFormHeading, strFormSubHeading, strSuccessMessage, columns, rows, "false");
	}
	
	if(IsFormCreated)
	{
%>
				<script type="text/javascript">
				
					alert("Form created successfully");
					window.open("/Choice/AdminHome.jsp","_top");
					
				</script>		
<%				
			}
			else
				{			
%>
					<script type="text/javascript">
					
						alert("Something went wrong! Please try again.");
						window.open("/Choice/AdminHome.jsp","_top");
						
					</script>
<%					
				}
		}
		catch(Exception e)
			{
				System.out.println("Exception::"+e);
%>
				<jsp:forward page="/JSP/ErrorJSP/Error.jsp"></jsp:forward>
<%
			}
%>

	</body>
<%

		}
}
%>
</html>