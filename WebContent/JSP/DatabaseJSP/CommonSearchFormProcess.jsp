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
<%
	try
	{
		String strFormName = request.getParameter("formName");
		Actions action = new Actions();	
		String strWhere = null;
		String strDBTableName = null;
		String AutoNumberPrefix = null;
		
		

		if(strFormName != null)
			{
				strWhere = "Name = '"+strFormName+"'";
			}
		
		CachedRowSet resultSetFormMaster = action.fetchDataFromDB("formmaster", null, strWhere);
	
			if(resultSetFormMaster.next())
				{
					strDBTableName = resultSetFormMaster.getString("TableName");
					CachedRowSet searchResultsForAutoNumberPrefix = action.fetchDataFromDB(strDBTableName, null, strDBTableName+"_UID = '1'");
					if(searchResultsForAutoNumberPrefix.next())
					{
						AutoNumberPrefix = searchResultsForAutoNumberPrefix.getString(strDBTableName+"_AutoNumberPrefix");
					}
				}
			else
				{
					strFormName = null;
				}
%>

		
	<h4 style="color:#ff6a22">Search Results: </h4>
	</head>
	
	<body>
	<div id="formData" class="formData">
	</div>
<%	

			if(strFormName != null)
			{
				String IsNewEntryAdded = null;
				String eachFieldName = null;
				String eachFieldValue = null;
				String eachDataBaseTableField = null;
				
				strWhere = "FormName = '"+strFormName+"'";
				CachedRowSet resultSetFormField = action.fetchDataFromDB("formfield", null, strWhere);
				strWhere = "";
				int i = 0;
				while(resultSetFormField.next())
				{
					eachDataBaseTableField = resultSetFormField.getString("DBTableField");
					eachFieldName = resultSetFormField.getString("FieldName");
					eachFieldValue = request.getParameter(eachFieldName);
					strWhere += eachDataBaseTableField + " LIKE '" +  eachFieldValue + "' AND "+eachDataBaseTableField+" != 'NA' AND ";
					i++;
				}
				
				strWhere = strWhere.substring(0,strWhere.length()-5);
				
				CachedRowSet searchResults = action.fetchDataFromDB(strDBTableName, null, strWhere);
				
				if(searchResults != null)
				{	
					ResultSetMetaData searchResultsMetaData = searchResults.getMetaData();
					int columnCount = searchResultsMetaData.getColumnCount();
					int tableSize = columnCount;
%>
			<br><br><table border="1">
<%
			if(columnCount > 4)
			{
				tableSize = 4;
			}

			for(int k=0;k<columnCount;k++)
				{
					String eachColumnName = searchResultsMetaData.getColumnName(k+1);
					if(!eachColumnName.equalsIgnoreCase(strDBTableName+"_UID") && !eachColumnName.equalsIgnoreCase(strDBTableName+"_AutoNumberPrefix"))
					{
						
						if(tableSize == k)
						{
							break;
						}
						eachColumnName = eachColumnName.replace("_", " ");
%>
					<th><%=eachColumnName%></th>
<%
					}
				}

%>
				<th>Auto Number</th>
<%
					while(searchResults.next())
					{
%>
						<tr>
<%
						String eachPrimaryKey = searchResults.getString(strDBTableName+"_UID");
						String href = "/Choice/JSP/DatabaseJSP/CommonPropertiesForm.jsp?table="+strDBTableName+"&pk="+eachPrimaryKey;
						boolean hyperlink = true;
						for(int j=0;j<columnCount;j++)
							{
								String eachColumnName = searchResultsMetaData.getColumnName(j+1);
								eachColumnName = eachColumnName.trim();
								if(!eachColumnName.equalsIgnoreCase(strDBTableName+"_UID") && !eachColumnName.equalsIgnoreCase(strDBTableName+"_AutoNumberPrefix"))
								{
									if(tableSize == j)
									{
										break;
									}
									String eachColumnValue = searchResults.getString(eachColumnName);
									if(hyperlink)
									{
										hyperlink = false;
%>
										<td><u><span onclick="loadClientActiveScreen('<%=href%>'); return false;"><%=eachColumnValue%></span></u></td>
<%										
									}
									else
										{
%>
									<td><%=eachColumnValue%></td>
<%
								
										}
								}
							}
						if(AutoNumberPrefix != null)
						{
						if(!AutoNumberPrefix.equalsIgnoreCase("NA") && !AutoNumberPrefix.equalsIgnoreCase("null"))
							{
%>					
								<td><%=AutoNumberPrefix%>-<%=eachPrimaryKey%></td>
<%
							}
							else
							{
%>					
								<td>NA</td>
<%									
							}
						}
							else
							{
%>					
								<td>NA</td>
<%							
							}
%>							
						</tr>
<%
						
					}
				
%>
			</table>
<%
				}
			}
	}
	catch(Exception e)
				{
					System.out.println("Exception is CommonSearchFormProcess.jsp ::"+e);
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