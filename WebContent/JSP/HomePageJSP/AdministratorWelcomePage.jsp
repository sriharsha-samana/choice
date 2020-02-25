<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="databaseActions.Actions"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.File"%>
<%@page import="javax.sql.rowset.CachedRowSet"%>
<%@page import="java.util.ArrayList"%>
<html>
<%
if (session == null || session.getAttribute("User") == null || !session.getAttribute("User").equals("Administrator")) {
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
		<link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css" type="text/css">
		<link rel="stylesheet" href="/Choice/CSS/Common/jquerycss.css" type="text/css">
		<link rel="stylesheet" href="/Choice/CSS/HomePage/sidenavigator.css">
   		<script src="/Choice/JS/HomePage/sidenavigator.js"></script>
		<script src="/Choice/JS/CommonJS.js"></script>
		<script src="/Choice/JS/jquery.js"></script>
		<script src="/Choice/JS/jquerymobile.js"></script>


<%
	Actions action = new Actions();	
	String strWhere = "Name != 'NA'";
	CachedRowSet resultSetAdminSideNavigator = null;
	CachedRowSet resultSetAdminTopNavigator = null;
	File appFolder = new File(application.getRealPath("/"));
	String strApplicationPath = appFolder.toURL().toString();
	strApplicationPath = strApplicationPath.substring(strApplicationPath.indexOf("file:/")+6, strApplicationPath.length());
	File DBRootFile = new File(strApplicationPath+"/Database/dbRootFile.properties");
	ArrayList<String> Navigators = new ArrayList<String>();
	Navigators = action.getNavigatorsList();

%>
		
		<title>Welcome</title>	
		
		<script type="text/javascript">
			
			$(document).ready(function()
					{
						$('#completeNavigator').hide();
						$('#progressBar').hide();
						var height = $(window).height();
						height = height - 85;

						$('#completeNavigator').css("height",height+"px");
						$('#completeNavigator').css("overflow","auto");
					});

			
			function showMenu()
			{
				var value = document.getElementById("toggleMenuBarHidden").value;
				value = value.trim();
				if(value == "Show Menu")
					{
						document.getElementById("toggleMenuBarHidden").value = "Hide Menu";
						$('#completeNavigator').show();
					}
				else
					{
						document.getElementById("toggleMenuBarHidden").value = "Show Menu";
						$('#completeNavigator').hide();	
					}
				
			}
			
			
			$('.adminActiveScreen, .leafCommand').click(function() { $('.completeNavigator').hide(); document.getElementById("toggleMenuBarHidden").value = "Show Menu";});

		</script>
		
	</head>

	<body class="landing">
	
	<div id="page-wrapper">
	
		<div id="adminHeader" class="adminHeader">
			
			<div id=adminLogo class="adminLogo">
				<img src="/Choice/Images/Icons/Logo.gif"></img>
			</div>
			
			<div id=adminHome class="adminHome">
				<img title="Home" onclick="javascript:window.open('/Choice/AdminHome.jsp','_top')" src="/Choice/Images/Icons/Home.png"></img>
			</div>
			
			<div id=adminLogout class="adminLogout">
				<img title="Logout" onclick="javascript:window.open('/Choice/JSP/LogoutJSP/Logout.jsp','_top')" src="/Choice/Images/Icons/Logout.png"></img>
			</div>
			
			<!-- <div id=adminWelcome class="adminWelcome">
				Welcome: <%=session.getAttribute("User")%>
			</div>-->
			
			<div title="Menu" id="toggleMenuBar" class="toggleMenuBar" onclick="showMenu();">
				<span class="box-shadow-menu" name="toggleMenuBar" id="toggleMenuBar"></span>
				<input type="hidden" name="toggleMenuBarHidden" id="toggleMenuBarHidden" value="Show Menu" />
			</div>
			
			
			<div id="completeNavigator" class="completeNavigator">	
					<div id='cssmenu'>
							<ul>
								<li class='has-sub'>
									<a href="#"><span>Database</span></a>
										<ul>
											<li><a><span title="Create Database" class="leafCommand" onclick="loadAdminActiveScreen('/Choice/JSP/DatabaseJSP/CheckIfDBExists.jsp?mode=create');">Create Database</span></a></li>
											<li><a><span title="Delete Database" class="leafCommand" onclick="loadAdminActiveScreen('/Choice/JSP/DatabaseJSP/CheckIfDBExists.jsp?mode=delete');">Delete Database</span></a></li>
<%
									if(DBRootFile.exists())
										{
											resultSetAdminSideNavigator = action.fetchDataFromDB("admintopnavigator", null, strWhere);
											if(resultSetAdminSideNavigator != null)
											{
												while(resultSetAdminSideNavigator.next())
												{
													String strTitle = resultSetAdminSideNavigator.getString("Label");
													String strIcon = resultSetAdminSideNavigator.getString("ICON");
													String strLink = resultSetAdminSideNavigator.getString("LINK");
													strIcon = "/Choice/Images/Icons/" + strIcon;
													String strURLLink = "/Choice/JSP/DatabaseJSP/" + strLink;
%>
													<li><a><span title="<%=strTitle%>" class="leafCommand" onclick="loadAdminActiveScreen('<%=strURLLink%>');"><%=strTitle%></span></a></li>
<%

												}
											}
%>

										</ul>
								</li>
						</ul>
						
					</div>	
													
							
<%
				resultSetAdminTopNavigator = action.fetchDataFromDB("adminsidenavigator", null, strWhere);
				if(resultSetAdminTopNavigator != null)
				{
					while(resultSetAdminTopNavigator.next())
					{
						String strName = resultSetAdminTopNavigator.getString("Name");
						String strTitle = resultSetAdminTopNavigator.getString("Label");
						String strIcon = resultSetAdminTopNavigator.getString("ICON");
						String strLink = resultSetAdminTopNavigator.getString("LINK");
						String strIsMenuCheck = resultSetAdminTopNavigator.getString("IsMenu");
						String strURLLink =  null;
						if(strIsMenuCheck.equalsIgnoreCase("false"))
							{
								strURLLink = "/Choice/JSP/DatabaseJSP/" + strLink;
							}
						else
							{
								strURLLink = "";
							}
						strIcon = "/Choice/Images/Icons/" + strIcon;

%>
					<div id='cssmenu'>	
						<ul>
							<li class='has-sub'> 
								<a><span title="<%=strTitle%>" onclick="loadAdminActiveScreen('<%=strURLLink%>'); return false;"><%=strTitle%></span></a>
<%
									if(strIsMenuCheck.equalsIgnoreCase("true"))
									{
%>
										<ul>
<%
											strWhere = "Name != 'NA' AND Name = '"+strName+"'";
											CachedRowSet resultSetAdminTopNavigatorSubMenu = action.fetchDataFromDB("adminsidenavigatorsubmenu", null, strWhere);
											if(resultSetAdminTopNavigatorSubMenu != null)
											{
												strWhere = "Name != 'NA' AND MenuName = '"+strName+"'";
												CachedRowSet resultSetAdminTopNavigatorSubMenuCommand = action.fetchDataFromDB("adminsidenavigatorsubmenucommand", null, strWhere);
												if(resultSetAdminTopNavigatorSubMenuCommand.next())
												{
													resultSetAdminTopNavigatorSubMenuCommand.beforeFirst();
													while(resultSetAdminTopNavigatorSubMenuCommand.next())
													{
														String strMenuName = resultSetAdminTopNavigatorSubMenuCommand.getString("Name");
														String strMenuTitle = resultSetAdminTopNavigatorSubMenuCommand.getString("Label");
														String strMenuIcon = resultSetAdminTopNavigatorSubMenuCommand.getString("ICON");
														String strMenuLink = resultSetAdminTopNavigatorSubMenuCommand.getString("LINK");
														String strMenuURLLink =  null;
														strMenuURLLink = "/Choice/JSP/DatabaseJSP/" + strMenuLink;
														
														if(Navigators.contains(strMenuName))
														{
%>

															<li> 
																<a><span title="<%=strMenuTitle%>" class="leafCommand" onclick="loadAdminActiveScreenObject('<%=strMenuURLLink%>'); return false;"><%=strMenuTitle%></span></a>
															</li>
<%															
														}
														else
															{
%>

														<li> 
															<a><span title="<%=strMenuTitle%>" class="leafCommand" onclick="loadAdminActiveScreen('<%=strMenuURLLink%>'); return false;"><%=strMenuTitle%></span></a>
														</li>
<%
													
															}
													}

												}
																
%>
										</ul>
<%
																											
											}
									}

									
%>
							</li>
						</ul>
					
					</div>
<%										
					}
				}
%>
						<div id='cssmenu'>	
							<ul>
								<li><a><span title="Set Client Logo" class="leafCommand" onclick="loadAdminActiveScreenObject('/Choice/JSP/DatabaseJSP/SetClientLogo.jsp'); return false;">Set Client Logo</span></a></li>
								<li><a><span title="Exit Application" class="leafCommand" onclick="javascript:window.open('index.html','_top');">Exit Application</span></a></li>
								<li><a><span title="Logout" class="leafCommand" onclick="javascript:window.open('/Choice/JSP/LogoutJSP/Logout.jsp','_top');">Logout</span></a></li>
							</ul>
						</div>	

<%
		
		}
%>			

			
			</div>
			
		</div>
		
		<div class="adminActiveScreen" id="adminActiveScreen" name="adminActiveScreen">
		</div>
		
		
		<div class="adminActiveScreenForward" id="adminActiveScreenForward" name="adminActiveScreenForward">
			<img src="/Choice/Images/Icons/forward.png" onclick="loadAdminActiveScreenForward(); return false;"></img>
		</div>
		<div class="adminActiveScreenBack" id="adminActiveScreenBack" name="adminActiveScreenBack">
			<img src="/Choice/Images/Icons/back.png" onclick="loadAdminActiveScreenBack(); return false;"></img>
		</div>
		


		<div id="progressBar" class="progressBar">
		</div>

	</div>
	</body>
<%
		}
}
%>
</html>