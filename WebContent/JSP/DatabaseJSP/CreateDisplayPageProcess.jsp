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
	
	</head>

	<body>
<%
	try
		{
			String strHeading = request.getParameter("Heading");
			String strContent = request.getParameter("area2");
			String strTitle = request.getParameter("Title");
			String[] Parameters = new String[10];
			File appFolder = new File(application.getRealPath("/"));
			String strApplicationPath = appFolder.toURL().toString();
			strApplicationPath = strApplicationPath.substring(strApplicationPath.indexOf("file:/")+6, strApplicationPath.length());
			FormActions action = new FormActions();
			boolean IsFormCreated = action.createDisplayPage(strContent, strTitle, strHeading, strApplicationPath);
			
			if(IsFormCreated)
			{
							
%>
				<script type="text/javascript">
				
					alert("Display Page created successfully");
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