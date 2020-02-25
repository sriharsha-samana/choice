<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="files.FileActions"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="connectionDatabase.Connect"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.FileNotFoundException"%>

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
		  <!-- End Combine and Compress These CSS Files -->
				<link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/app.css">
				<link rel="stylesheet" href="/Choice/CSS/ResponsiveTables/responsive-tables.css">
				<script src="/Choice/JS/ResponsiveTables/jquery.min.js"></script>
				<script src="/Choice/JS/ResponsiveTables/responsive-tables.js"></script>
				<link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css" type="text/css">

		
		<title>Create Database</title>
		
	</head>

	<body>

<%	
	try
	{
		File appFolder = new File(application.getRealPath("/"));
		String strApplicationPath = appFolder.toURL().toString();
		strApplicationPath = strApplicationPath.substring(strApplicationPath.indexOf("file:/")+6, strApplicationPath.length());
		File DBRootFile = new File(strApplicationPath+"/Database/dbRootFile.properties");
		String mode = request.getParameter("mode");
		String strSubHeading = null;
		String strConfirm = null;
		String strButton = null;
		String strForwardURL = null;
		String strCancelURL = "/Choice/AdminHome.jsp";
		
		if(mode == null)
			{
%>
				<div class="Admin-sub-heading" id="Admin-sub-heading" onmousemove="javascript:window.open('/Choice/Login.jsp','_top');">Session expired!!!<br><br></div>
<%			
			}
			else
				{
					if(mode.equals("create"))
						{
							strSubHeading = "Create new Database";
							strConfirm = "Do you want to create new database?";
							strButton = "Create";
							strForwardURL = "/Choice/JSP/DatabaseJSP/CreateDatabase.jsp";
						}
						else if(mode.equals("delete"))
							{
								strSubHeading = "Do you want to delete exisiting Database?!";
								strConfirm = "Do you want to clear and create new database?";
								strButton = "Delete";
								strForwardURL="/Choice/JSP/DatabaseJSP/DeleteDatabaseProcess.jsp";
							}
							else
								{
									strSubHeading = "Error";
									strConfirm = "Error";
									strButton = "Error";
								}
				
				boolean replaceDB = true;
				if(!DBRootFile.exists())
					{
					 	if(mode.equals("delete"))
						 	{
					 			strSubHeading = "Database does not exist!!";
					 			strConfirm = "Do you want to create new database?";
								strButton = "Create";
								strForwardURL = "/Choice/JSP/DatabaseJSP/CreateDatabase.jsp";
						 	}
%>
						<div class="Admin-sub-heading" id="Admin-sub-heading"><h4 style="color:#ff6a22"><%=strSubHeading %></h4><br><br></div>
						<p>

						&nbsp;&nbsp;<%= strConfirm%>
						<br><br>
						&nbsp;&nbsp;If "Yes" Please click on <b><%=strButton %></b> else click on <b>"Cancel"</b>. 	
						</p>
						

		
								<br><input type="button" value="<%=strButton%>" onclick='confirmAndforward("<%=strForwardURL%>")'/>
		
								&nbsp;<input type="button" value="Cancel" onclick='javascript:window.open("<%=strCancelURL %>","_top")'/>

<%
					}
					else
						{
							if(mode != null)
							{
								if(mode.equals("create"))
									{
										strSubHeading = "Database Already Exists!!";
										strConfirm = "Do you want to replace database?";	
										strButton = "Replace";
									}
							}
%>
							<div class="Admin-sub-heading" id="Admin-sub-heading"><h4 style="color:#ff6a22"><%=strSubHeading %></h4><br><br><p>&nbsp;&nbsp;Database details are as below:</p></div>
							<br>
							<table border="1">
<%
								
								Properties readData = new Properties();
								
								InputStream stream = null;
								try {
									stream = new FileInputStream(strApplicationPath + "/Database/dbRootFile.properties");
								} catch (FileNotFoundException e1) {
									stream.close();
									System.out.println("Exception in CheckIfDBExists::"+e1);
								}

								readData.load(stream);
								String strDatabaseType = null;
								String strDatabaseName = null;
								try
									{
										strDatabaseType = readData.getProperty("db.type");
										strDatabaseName = readData.getProperty("db.name");
									}
									catch(Exception e)
										{
											strDatabaseType = "";
											strDatabaseName = "";
										}

								stream.close();

								if(strDatabaseType.equals("Access"))
									{
										strDatabaseName = "AccessDB";
									}
															
%>
										<tr>
											<td>
												Database: 
											</td>
											<td>
												<%=strDatabaseType %>
											</td>
										</tr>
										<tr>		
											<td>
												Database Name: 
											</td>
											<td>
												<%=strDatabaseName %>
											</td>
										</tr>
							</table>
							<p>
							<br>
							&nbsp;&nbsp;<%= strConfirm%>
							<br><br>
							&nbsp;&nbsp;If "Yes" Please click on <b><%=strButton %></b> else click on <b>"Cancel"</b>. 	
							</p>

<%
									if(strButton.equalsIgnoreCase("Delete"))
									{
%>
											<br><input type="button" value= "<%=strButton %>" onclick='confirmAndforward("<%=strForwardURL%>"); showProgress();'/>
<%										
									}
									else
									{
%>
										<br><input type="button" value= "<%=strButton %>" onclick='confirmAndforward("<%=strForwardURL%>");'/>
<%										
									}
%>	
									
									&nbsp;<input type="button" value="Cancel" onclick='javascript:window.open("<%=strCancelURL %>","_top")'/>
	
<%
						}
				}
	}
	catch(Exception ex)
		{
			System.out.println("Exception in CheckIfDBExists.jsp::"+ex);
%>
			<jsp:forward page="/JSP/ErrorJSP/Error.jsp"></jsp:forward>
<% 
		}
%>
<%
		}
}
%>
</html>