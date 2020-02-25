<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="databaseActions.Actions"%>
<%@page import="javax.sql.rowset.CachedRowSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="javax.sql.rowset.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>

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
		String strTableName = "clientreminders";
		Actions action = new Actions();	
		String strWhere = null;

try
{
		strWhere = "Name != 'NA'";

%>
				<title>Reminders</title>

				<br><h4 style="color:#ff6a22">Reminders</h4><br><br>

	</head>
	
	<body>
		
		<div id="tableData" class="tableData">
		
			<table border="1">
<%
			
			if(strTableName != null)
				{
					
%>
					<div id="innerTableData" class="innerTableData">
<%			
					Date todayDate = new Date();
					SimpleDateFormat sf = new SimpleDateFormat("MM/dd/yyyy");
					SimpleDateFormat sf1 = new SimpleDateFormat("dd MMM, yyyy");
%>
					<h6><b>Date</b> : <%=sf1.format(todayDate)%></h6><br>
					
<%					CachedRowSet resultSetSearchResults = action.fetchDataFromDB("clientreminders", null, strWhere);
					ResultSetMetaData resultSetSearchResultsMetaData = resultSetSearchResults.getMetaData();
					int columnCount = resultSetSearchResultsMetaData.getColumnCount();
					
					if(resultSetSearchResults.next())
					{
						for(int a=0;a<columnCount;a++)
						{
							if(!resultSetSearchResultsMetaData.getColumnName(a+1).equalsIgnoreCase("clientreminders_UID") && !resultSetSearchResultsMetaData.getColumnName(a+1).equalsIgnoreCase("User") && !resultSetSearchResultsMetaData.getColumnName(a+1).equalsIgnoreCase("ReminderDate"))
							{
								String Label = resultSetSearchResultsMetaData.getColumnName(a+1).replace("_", " ");
								
								if(resultSetSearchResultsMetaData.getColumnName(a+1).equalsIgnoreCase("RemindPerson"))
								{
									Label = "Whom to Remind?";
								}
%>
								<th><%=Label%></th>
<%							
							}
						}
					}
					else
					{
%>
						<br><br><h6><b>No Data Found.</b></h6>
<%						
					}
					resultSetSearchResults.beforeFirst();
					while(resultSetSearchResults.next())
					{
%>
						<tr>
<%	
							for(int b=0;b<columnCount;b++)
							{
								String eachReminderDate =  resultSetSearchResults.getString("ReminderDate");
								Date reminderDate = new Date();
								try
								{
								 	reminderDate = sf.parse(eachReminderDate);
								}
								catch(Exception ex)
								{
									reminderDate = null;
								}
								if(reminderDate != null)
								{
									if(reminderDate.getDay() == todayDate.getDay() && reminderDate.getMonth() == todayDate.getMonth() && reminderDate.getYear() == todayDate.getYear())
									{
										if(!resultSetSearchResultsMetaData.getColumnName(b+1).equalsIgnoreCase("clientreminders_UID") && !resultSetSearchResultsMetaData.getColumnName(b+1).equalsIgnoreCase("User") && !resultSetSearchResultsMetaData.getColumnName(b+1).equalsIgnoreCase("ReminderDate"))
										{
											String eachFieldName = resultSetSearchResultsMetaData.getColumnName(b+1);
											String eachFieldData = resultSetSearchResults.getString(eachFieldName);
											
%>
												<td><%=eachFieldData%></td>
<%
										}
									}
								}

							}
%>
						</tr>
<%
					}
%>
					</div>
<%				
				}
%>	
			</table>
			
		</div>
<%
	}
	catch(Exception e)
	{
		System.out.println("Exception in CommonTable.jsp::"+e);
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