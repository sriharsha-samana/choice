<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="databaseActions.Actions"%>
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
		<link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/globals.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/typography.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/grid.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/ui.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/forms.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/orbit.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/reveal.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/mobile.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/app.css"><link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/responsive-tables.css"><link rel="stylesheet" href="/Choice/CSS/Common/jquery-ui.css"><link rel="stylesheet" href="/Choice/CSS/Common/jquery-ui.css"><script src="/Choice/JS/ResponsiveTables/jquery.min.js"></script><script src="/Choice/JS/ResponsiveTables/responsive-tables.js"></script><script src="/Choice/JS/CommonJS.js"></script><script src="/Choice/JS/jquery-ui.js"></script>
		<script src="/Choice/JS/CommonJS.js"></script>
		<script src="/Choice/JS/jquery.js"></script>
		<link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css" />
		

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
			</script>
		
		<title>Set Logo</title>
	</head>

	<body>
		<div id = Formheader class = "Formheader">
			<h4 style="color:#ff6a22">Set Client Logo</h4><br><br>
		</div>

		<div id="Set_Cliet_LogoDiv" class="Set_Cliet_LogoDiv">

			<form id="Set_Cliet_LogoForm" name="Set_Cliet_LogoForm" method="POST" action="/Choice/JSP/DatabaseJSP/SetClientLogoProcess.jsp" enctype="multipart/form-data">

<%
			Actions action = new Actions();
			CachedRowSet checkExistingLogo = action.fetchDataFromDB("clientpreferences", null, "name = 'Logo'");
			if(checkExistingLogo.next())
			{
				String strLogoURL = checkExistingLogo.getString("Value");
				strLogoURL = "/Choice/Images/Icons/"+strLogoURL;
%>
				<h6>Client Logo already exists!</h6><br><br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="<%=strLogoURL%>" height="75" width="75" alt="Logo"></img><br><br>
				<br><h6 style="color:#ff6a22">Do you want to Change?</h6><br><br>
<%
			}
%>				

				<input type="hidden" id="DatabaseTableName" name="DatabaseTableName" value="clientpreferences" />

				<table id="Set_Cliet_LogoTable" name="Set_Cliet_LogoTable" border="1" bgcolor="#e5e5e5">

					

					<tr>

						<td>

							Logo

						</td>

						<td>

							&nbsp<input type="text" id="Name" name="Name" value="Logo" required readonly/>

						</td>

									<input type="hidden" id="NameDatabaseTableFieldName" name="NameDatabaseTableFieldName" value="Name" />

						</tr>

					<tr>

						<td>

							Select Image

						</td>

						<td>

							&nbsp<input type="file" id="Value" name="Value" value="" required />

						</td>

									<input type="hidden" id="ValueDatabaseTableFieldName" name="ValueDatabaseTableFieldName" value="Value" />

						</tr>

					

				</table>

				<table id="Set_Cliet_LogoSubmitTable" name="Set_Cliet_LogoSubmitTable">

					<input type="submit" id="Set_Cliet_LogoSubmit" name="Set_Cliet_LogoSubmit" value="Set Logo" />

				</table>

			</form>

		</div>

	</body>

<%

%>
</html>