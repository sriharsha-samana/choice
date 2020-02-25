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
		String strTableName = request.getParameter("tableName");
		Actions action = new Actions();	
		String strWhere = null;
		String strHeading = null;
		String strSubHeading = null;
		String strTitle = null;
		String strWhereCondition = null;
		String DBTableName= null;
		String strFields = null;
		List<String> FieldsList = new ArrayList<String>();
		List<String> FieldLabelsList = new ArrayList<String>();
try
{
		strWhere = "Name != 'NA'";
		if(strTableName != null)
			{
				strWhere += " AND Name = '"+strTableName+"'";
			}
		
		CachedRowSet resultSetTableMaster = action.fetchDataFromDB("tablemaster", null, strWhere);
		ResultSetMetaData resultSetTableMasterMetaData = resultSetTableMaster.getMetaData();
		
		
			if(resultSetTableMaster.next())
				{
					DBTableName = resultSetTableMaster.getString("TableName");
					strHeading = resultSetTableMaster.getString("Heading");
					strSubHeading = resultSetTableMaster.getString("SubHeading");
					strTitle = resultSetTableMaster.getString("Title");
					strWhereCondition = resultSetTableMaster.getString("WhereCondition");
					CachedRowSet resultSetRequestedTableData = action.fetchDataFromDB(DBTableName, null, null);
					ResultSetMetaData resultSetRequestedTableDataMetaData = resultSetRequestedTableData.getMetaData();
					int columns = resultSetRequestedTableDataMetaData.getColumnCount();
					if(resultSetRequestedTableData.next())
					{
						strFields = resultSetTableMaster.getString("Fields");
						
						if(strFields.equalsIgnoreCase("NA") || strFields == null || strFields.trim().equalsIgnoreCase("") || strFields.trim().equalsIgnoreCase("*"))
						{
							for(int i=0;i<columns;i++)
							{
								FieldsList.add((String)resultSetRequestedTableDataMetaData.getColumnName(i+1));
								FieldLabelsList.add((String)resultSetRequestedTableDataMetaData.getColumnLabel(i+1));
							}
						}
						else
						{
							if(strFields.contains(","))
							{
								FieldsList = Arrays.asList(strFields.split(","));
								FieldLabelsList = FieldsList;
							}
							else
							{
								FieldsList.add(strFields);
								FieldLabelsList.add(strFields);
							}
						}
					}
						
				}
			else
				{
					strTableName = null;
				}
			
			if(strTableName != null)
			{
%>

<%
			if(strTitle != null)
				{		
%>
					<title><%=strTitle%></title>
<%
				}
			}

	if(strTableName != null)
	{
		if(strHeading != null)
			{
%>	
				<br><h4 style="color:#ff6a22"><%=strHeading%></h4>
<%
			}
	}
%>	
	</head>
	
	<body>
		<div id="subHeader" class="subHeader">
<%
	if(strTableName != null)
		{
		if(strSubHeading != null && !strSubHeading.equals("") && !strSubHeading.equalsIgnoreCase("NA"))
			{
%>
				<h6><%=strSubHeading%></h6>
<%
			}
		}
%>
		</div>
		
		<div id="tableData" class="tableData">
		
			<br><table border="1">
<%
			
			if(strTableName != null)
				{
					
%>
					<div id="innerTableData" class="innerTableData">
<%
					if(strWhereCondition != null && !strWhereCondition.trim().equalsIgnoreCase("NA") && !strWhereCondition.trim().equalsIgnoreCase("") && !strWhereCondition.trim().equalsIgnoreCase("*"))
					{
						strWhereCondition += " AND "+FieldsList.get(0)+" != 'NA'";
					}
					else
					{
						strWhereCondition = FieldsList.get(0)+" != 'NA'";
					}
					
					CachedRowSet resultSetSearchResults = action.fetchDataFromDB(DBTableName, null, strWhereCondition);
					if(resultSetSearchResults.next())
					{
						for(int a=0;a<FieldsList.size();a++)
						{
							if(!FieldsList.get(a).equalsIgnoreCase(DBTableName+"_UID"))
							{
								String Label = FieldLabelsList.get(a).replace("_", " ");
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
							for(int b=0;b<FieldsList.size();b++)
							{
								if(!FieldsList.get(b).equalsIgnoreCase(DBTableName+"_UID"))
								{
									String eachFieldName = FieldsList.get(b);
									String eachFieldData = resultSetSearchResults.getString(eachFieldName);
%>
										<td><%=eachFieldData%></td>
<%
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