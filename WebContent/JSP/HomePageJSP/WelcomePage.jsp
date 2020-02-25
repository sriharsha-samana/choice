<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="databaseActions.Actions"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.File"%>
<%@page import="javax.sql.rowset.CachedRowSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<html>
<%
if (session == null || session.getAttribute("User") == null || session.getAttribute("User").equals("Administrator")) {
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
		<link rel="stylesheet" href="/Choice/CSS/Common/ClientCSS.css" type="text/css">
		<link rel="stylesheet" href="/Choice/CSS/Common/jquerycss.css" type="text/css">
		<link rel="stylesheet" href="/Choice/CSS/HomePage/sidenavigator.css">
   		<script src="/Choice/JS/HomePage/sidenavigator.js"></script>
		<script src="/Choice/JS/CommonJS.js"></script>
		<script src="/Choice/JS/jquery.js"></script>
		<script src="/Choice/JS/jquerymobile.js"></script>


<%
	Actions action = new Actions();	
	String strWhere = "Name != 'NA'";
	CachedRowSet resultSetClientTopNavigator = null;
	CachedRowSet resultSetClientSideNavigator = null;
	CachedRowSet resultSetHomePage = null;
	CachedRowSet resultSetBGColor = null;
	File appFolder = new File(application.getRealPath("/"));
	String strApplicationPath = appFolder.toURL().toString();
	strApplicationPath = strApplicationPath.substring(strApplicationPath.indexOf("file:/")+6, strApplicationPath.length());
	File DBRootFile = new File(strApplicationPath+"/Database/dbRootFile.properties");
	resultSetHomePage = action.fetchDataFromDB("clientpreferences", null, "Name = 'HomePage' AND User = '"+(String)session.getAttribute("User")+"'");
	String strHomePageURL = null;
	if(resultSetHomePage.next())
	{
		
		String strValue = resultSetHomePage.getString("Value");
		
		CachedRowSet formMasterData = action.fetchDataFromDB("formmaster", null, "Name = '"+strValue+"'");
		if(formMasterData.next())
		{
			String strIsSearchForm = formMasterData.getString("IsSearchForm");
			if(strIsSearchForm.equalsIgnoreCase("true"))
			{
				strHomePageURL = "/Choice/JSP/DatabaseJSP/CommonSearchForm.jsp?formName=" + strValue;
			}
			else
			{
				strHomePageURL = "/Choice/JSP/DatabaseJSP/CommonForm.jsp?formName=" + strValue;
			} 
		}
		else
		{
			CachedRowSet tableMasterData = action.fetchDataFromDB("tablemaster", null, "name= '"+strValue+"'");
			if(tableMasterData.next())
			{
				strHomePageURL = "/Choice/JSP/DatabaseJSP/CommonTable.jsp?tableName=" + strValue;
			}
		}
	}
	
	if(strHomePageURL != null)
	{
%>
		<script>
			loadClientActiveScreen('<%=strHomePageURL%>');
		</script>
<%		
	}
%>
		
		<title>Welcome</title>	
		
		<script type="text/javascript">
		
			function setInitial()
			{
				$('#completeNavigator').hide();
				$('#clientTopNavigatorHidden').hide();
				$('#progressBar').hide();
				var height = $(window).height();
				var width = $(window).width();
				height = height - 85;

				$('#completeNavigator').css("height",height+"px");
				$('#completeNavigator').css("overflow","auto");
				
				if(width < 550)
					{
						$('#clientTopNavigator').hide();
						$('#clientTopNavigatorHidden').show();
					}
				else
					{
						$('#clientTopNavigator').show();
					}
			}

			
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
			
			
			$('.clientActiveScreen, .leafCommand').click(function() 
					{ 
						$('.completeNavigator').hide(); 
						document.getElementById("toggleMenuBarHidden").value = "Show Menu";
						$('.clientTopNavigatorTitle').hide();
						document.getElementById("clientTopNavigatorToggleHidden").value = "Show Menu";
					});
			
			$(document).ready(setInitial);
			$(window).resize(setInitial);

		</script>
		
	</head>

	<body class="landing">
	
	<div id="page-wrapper">
	
		<div id="clientHeader" class="clientHeader">
			
			<div id=clientLogo class="clientLogo">
<%
			CachedRowSet resultSetClientPreferences = action.fetchDataFromDB("clientpreferences", null, "Name = 'Logo'");
			String strLogoURL = "";
			if(resultSetClientPreferences.next())
			{
				strLogoURL = "/Choice/Images/Icons/" + resultSetClientPreferences.getString("Value");
%>
				<img src="<%=strLogoURL%>"></img>
<%
			}
%>
			</div>
			
			<div id=clientHome class="clientHome">
				<img title="Home" onclick="javascript:window.open('/Choice/Home.jsp','_top')" src="/Choice/Images/Icons/Home.png"></img>
			</div>	
			
			<div id=clientLogout class="clientLogout">
				<img title="Logout" onclick="javascript:window.open('/Choice/JSP/LogoutJSP/Logout.jsp','_top')" src="/Choice/Images/Icons/Logout.png"></img>
			</div>
			
			<!-- <div id=clientWelcome class="clientWelcome">
				Welcome: <%=session.getAttribute("User")%>
			</div>-->
			
			<div title="Menu" id="toggleMenuBar" class="toggleMenuBar" onclick="showMenu();">
				<span class="box-shadow-menu" name="toggleMenuBar" id="toggleMenuBar"></span>
				<input type="hidden" name="toggleMenuBarHidden" id="toggleMenuBarHidden" value="Show Menu" />
			</div>
				
			<div id=clientTopNavigator class="clientTopNavigator">

<%
			if(DBRootFile.exists())
			{


%>					
							<ul>
<%
											String strUser = (String)session.getAttribute("User");
											String strUserGroup = null;
											CachedRowSet UsersSet = action.fetchDataFromDB("userstable", null, "Username = '"+strUser+"'");
											if(UsersSet.next())
											{
												strUserGroup = UsersSet.getString("UserGroup");
											}
											
											resultSetClientTopNavigator = action.fetchDataFromDB("clienttopnavigator", null, strWhere);
											if(resultSetClientTopNavigator != null)
											{
												while(resultSetClientTopNavigator.next())
												{
													String strTitle = resultSetClientTopNavigator.getString("Label");
													String strIcon = resultSetClientTopNavigator.getString("ICON");
													String strLink = resultSetClientTopNavigator.getString("LINK");
													String strURLLink = "";
													strIcon = "/Choice/Images/Icons/" + strIcon;
													CachedRowSet formMasterData = action.fetchDataFromDB("formmaster", null, "Name = '"+strLink+"'");
													if(formMasterData.next())
													{
														String strIsSearchForm = formMasterData.getString("IsSearchForm");
														if(strIsSearchForm.equalsIgnoreCase("true"))
														{
															strURLLink = "/Choice/JSP/DatabaseJSP/CommonSearchForm.jsp?formName=" + strLink;
														}
														else
														{
															strURLLink = "/Choice/JSP/DatabaseJSP/CommonForm.jsp?formName=" + strLink;
														} 
													}
													else
													{
														CachedRowSet tableMasterData = action.fetchDataFromDB("tablemaster", null, "name= '"+strLink+"'");
														if(tableMasterData.next())
														{
															strURLLink = "/Choice/JSP/DatabaseJSP/CommonTable.jsp?tableName=" + strLink;
														}
													}
													
													String strAccessGroups = resultSetClientTopNavigator.getString("AccessGroups");
													List<String> AccessGroupsList = Arrays.asList(strAccessGroups.split(","));
													if(AccessGroupsList.contains(strUserGroup))
													{
%>
													<li>
														<img title="<%=strTitle%>" class="TopMenuIcon" src="<%=strIcon%>" onclick="loadClientActiveScreen('<%=strURLLink%>'); return false;">&nbsp;</img>
													</li>
<%
													}
												}
											}
%>

						</ul>
				
				</div>
				
			</div>
				
				<div id="completeNavigator" class="completeNavigator">		
				
				
						<div id="cssmenu">
							
							<ul id="clientTopNavigatorHidden" class="clientTopNavigatorHidden">
								
								<li class='has-sub'> 
								
									<a><span onclick="loadClientActiveScreen(''); return false;">Top Menu</span></a>
										
										<ul>
<%

											resultSetClientTopNavigator = action.fetchDataFromDB("clienttopnavigator", null, strWhere);
											if(resultSetClientTopNavigator != null)
											{
												while(resultSetClientTopNavigator.next())
												{
													String strTitle = resultSetClientTopNavigator.getString("Label");
													String strIcon = resultSetClientTopNavigator.getString("ICON");
													String strLink = resultSetClientTopNavigator.getString("LINK");
													String strURLLink = "";
													strIcon = "/Choice/Images/Icons/" + strIcon;
													CachedRowSet formMasterData = action.fetchDataFromDB("formmaster", null, "Name = '"+strLink+"'");
													if(formMasterData.next())
													{
														String strIsSearchForm = formMasterData.getString("IsSearchForm");
														if(strIsSearchForm.equalsIgnoreCase("true"))
														{
															strURLLink = "/Choice/JSP/DatabaseJSP/CommonSearchForm.jsp?formName=" + strLink;
														}
														else
														{
															strURLLink = "/Choice/JSP/DatabaseJSP/CommonForm.jsp?formName=" + strLink;
														} 
													}
													else
													{
														CachedRowSet tableMasterData = action.fetchDataFromDB("tablemaster", null, "name='"+strLink+"'");
														if(tableMasterData.next())
														{
															strURLLink = "/Choice/JSP/DatabaseJSP/CommonTable.jsp?tableName=" + strLink;
														}
													}
													
													String strAccessGroups = resultSetClientTopNavigator.getString("AccessGroups");
													List<String> AccessGroupsList = Arrays.asList(strAccessGroups.split(","));
													if(AccessGroupsList.contains(strUserGroup))
													{
%>
													<li class='has-sub'>
														<a><span title="<%=strTitle%>" class="leafCommand" onclick="loadClientActiveScreen('<%=strURLLink%>'); return false;"><%=strTitle%></span></a>
													</li>
<%
													}
												}
											}
%>

									</ul>
							
								</li>
						
						</ul>

						
				</div>									
							
<%
			    resultSetClientSideNavigator = action.fetchDataFromDB("clientsidenavigator", null, strWhere);
				if(resultSetClientSideNavigator != null)
				{
					while(resultSetClientSideNavigator.next())
					{
						String strName = resultSetClientSideNavigator.getString("Name");
						String strTitle = resultSetClientSideNavigator.getString("Label");
						String strIcon = resultSetClientSideNavigator.getString("ICON");
						String strLink = resultSetClientSideNavigator.getString("LINK");
						String strIsMenuCheck = resultSetClientSideNavigator.getString("IsMenu");
						strIcon = "/Choice/Images/Icons/" + strIcon;
						String strURLLink =  null;
						if(strIsMenuCheck.equalsIgnoreCase("false"))
							{
								CachedRowSet formMasterData = action.fetchDataFromDB("formmaster", null, "Name = '"+strLink+"'");
								if(formMasterData.next())
								{
									String strIsSearchForm = formMasterData.getString("IsSearchForm");
									if(strIsSearchForm.equalsIgnoreCase("true"))
									{
										strURLLink = "/Choice/JSP/DatabaseJSP/CommonSearchForm.jsp?formName=" + strLink;
									}
									else
									{
										strURLLink = "/Choice/JSP/DatabaseJSP/CommonForm.jsp?formName=" + strLink;
									} 
								}
								else
								{
									CachedRowSet tableMasterData = action.fetchDataFromDB("tablemaster", null, "name= '"+strLink+"'");
									if(tableMasterData.next())
									{
										strURLLink = "/Choice/JSP/DatabaseJSP/CommonTable.jsp?tableName=" + strLink;
									}
								}
							
							}
						else
							{
								strURLLink = "";
							}
						
						String strAccessGroups = resultSetClientSideNavigator.getString("AccessGroups");
						List<String> AccessGroupsList = Arrays.asList(strAccessGroups.split(","));
						if(AccessGroupsList.contains(strUserGroup))
						{
						
%>
					<div id='cssmenu'>	
						<ul>
							<li class='has-sub'> 
								<a><span title="<%=strTitle%>" onclick="loadClientActiveScreen('<%=strURLLink%>'); return false;"><%=strTitle%></span></a>
<%
									if(strIsMenuCheck.equalsIgnoreCase("true"))
									{
%>
										<ul>
<%
											strWhere = "Name != 'NA' AND Name = '"+strName+"'";
											CachedRowSet resultSetClientSideNavigatorSubMenu = action.fetchDataFromDB("clientsidenavigatorsubmenu", null, strWhere);
											if(resultSetClientSideNavigatorSubMenu != null)
											{
												strWhere = "Name != 'NA' AND MenuName = '"+strName+"'";
												CachedRowSet resultSetClientSideNavigatorSubMenuCommand = action.fetchDataFromDB("clientsidenavigatorsubmenucommand", null, strWhere);
												if(resultSetClientSideNavigatorSubMenuCommand.next())
												{
													resultSetClientSideNavigatorSubMenuCommand.beforeFirst();
													while(resultSetClientSideNavigatorSubMenuCommand.next())
													{
														String strMenuName = resultSetClientSideNavigatorSubMenuCommand.getString("Name");
														String strMenuTitle = resultSetClientSideNavigatorSubMenuCommand.getString("Label");
														String strMenuIcon = resultSetClientSideNavigatorSubMenuCommand.getString("ICON");
														String strMenuLink = resultSetClientSideNavigatorSubMenuCommand.getString("LINK");
														String strMenuURLLink =  null;
														strMenuURLLink = "/Choice/JSP/DatabaseJSP/" + strMenuLink;
														
														CachedRowSet formMasterData = action.fetchDataFromDB("formmaster", null, "Name = '"+strMenuLink+"'");
														if(formMasterData.next())
														{
															String strIsSearchForm = formMasterData.getString("IsSearchForm");
															if(strIsSearchForm.equalsIgnoreCase("true"))
															{
																strMenuURLLink = "/Choice/JSP/DatabaseJSP/CommonSearchForm.jsp?formName=" + strMenuLink;
															}
															else
															{
																strMenuURLLink = "/Choice/JSP/DatabaseJSP/CommonForm.jsp?formName=" + strMenuLink;
															} 
														}
														else
														{
															CachedRowSet tableMasterData = action.fetchDataFromDB("tablemaster", null, "name= '"+strMenuLink+"'");
															if(tableMasterData.next())
															{
																strMenuURLLink = "/Choice/JSP/DatabaseJSP/CommonTable.jsp?tableName=" + strMenuLink;
															}
														}
													
%>
														<li class='has-sub'> 
															<a><span title="<%=strMenuTitle%>" class="leafCommand" onclick="loadClientActiveScreen('<%=strMenuURLLink%>'); return false;"><%=strMenuTitle%></span></a>
														</li>
<%
													
															
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
				}
%>

						<div id='cssmenu'>	
							<ul>
								<li><a><span title="User Preferences" class="leafCommand" onclick="loadClientActiveScreen('/Choice/JSP/DatabaseJSP/SetClientPreferences.jsp'); return false;">User Preferences</span></a>
								</li>
							</ul>
							
							<ul>
								<li><a><span title="Set Reminder" class="leafCommand" onclick="loadClientActiveScreen('/Choice/JSP/DatabaseJSP/SetReminders.jsp'); return false;">Set Reminder</span></a>
								</li>
							</ul>
							
							<ul>
								<li><a><span title="Check Reminders" class="leafCommand" onclick="loadClientActiveScreen('/Choice/JSP/DatabaseJSP/RemindersTable.jsp'); return false;">Check Reminders</span></a>
								</li>
							</ul>
							
							<ul>
								<li><a><span title="Logout" class="leafCommand" onclick="javascript:window.open('/Choice/JSP/LogoutJSP/Logout.jsp','_top');">Logout</span></a>
								</li>
							</ul>
						</div>	
<%
		
		}
%>			

			
			</div>
<%
		String strBGColor = null;
		resultSetBGColor = action.fetchDataFromDB("clientpreferences", null, "Name = 'BackgroundColor' AND User = '"+(String)session.getAttribute("User")+"'");
		if(resultSetBGColor.next())
		{
			strBGColor = resultSetBGColor.getString("Value");
		}
		if(strBGColor != null)
		{
%>		
		<div class="clientActiveScreen" id="clientActiveScreen" name="clientActiveScreen" style="background-color: <%=strBGColor%>">
			<div class="ActiveScreenBackgroundImage">
					<!-- <img src="/Choice/Images/Background/CharminarBlur.jpg" alt=""></img>-->
			</div>
		</div>
<%
		}
		else
		{
%>
			<div class="clientActiveScreen" id="clientActiveScreen" name="clientActiveScreen">
			<div class="ActiveScreenBackgroundImage">
					<!-- <img src="/Choice/Images/Background/CharminarBlur.jpg" alt=""></img>-->
			</div>
				
			</div>
<%
		}
%>		
		<div class="clientActiveScreenForward" id="clientActiveScreenForward" name="clientActiveScreenForward">
			<img src="/Choice/Images/Icons/forward.png" onclick="loadClientActiveScreenForward(); return false;"></img>
		</div>
		<div class="clientActiveScreenBack" id="clientActiveScreenBack" name="clientActiveScreenBack">
			<img src="/Choice/Images/Icons/back.png" onclick="loadClientActiveScreenBack(); return false;"></img>
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