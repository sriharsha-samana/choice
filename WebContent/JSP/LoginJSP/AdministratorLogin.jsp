<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css" type="text/css">
		<script src="/Choice/JS/CommonJS.js"></script>
		<script src="/Choice/JS/jquery.js"></script>

		<script type = "text/javascript" >
		   function preventBack(){window.history.forward();}
		    setTimeout("preventBack()", 0);
		    window.onunload=function(){null};
		    
			function setWindowSize()
			{
				var width = $(window).width();
				var height = $(window).height();
				var left = ((width/2)-150);
				var top = ((height/2)-250);
				var fontLeft = ((width/2)-125);
				if(width<400)
					{
						left = 25;
					}
				if(height<700)
					{
						top = 100;
					}
				
				$("#AdminLoginFormDiv").css("margin-top",top+"px");
				$("#AdminLoginFormDiv").css("margin-left",left+"px");
				$("#headerText").css("margin-left",fontLeft+"px");
			}
		
		$(document).ready(setWindowSize);    
		$(window).resize(setWindowSize);  
		</script>
		
		<title>Dr.Choice</title>

	</head>

	<body>
		
		<div id=header class="header">
			<div id=headerText class="headerText">Dr. Choice</div>
		</div>
		
		<div id = AdminLoginFormDiv>
		
			<form id="AdminLoginForm" method="post" action="/Choice/JSP/LoginJSP/AdministratorLoginVerification.jsp" onsubmit= "return checkUsernameAndPassword();">
			
				<table>
					<tr>
						<td colspan = 2>
							<Img src="/Choice/Images/Icons/43.png"/>
						</td>
					</tr>
					<tr>
						<td>
					</td>
					<tr>
						<td>
							<label class="hidden-label" for="username"></label>	
							<input type="text" name="username" id="username" placeholder="Administrator login" required>
						</td>
					</tr>
					<tr>
						<td>
							 <label class="hidden-label" for="password"></label>	
							 <input type="password" name="password" id="password" placeholder="Administrator password" required>
						</td>
					</tr>
					
				</table>
				
				<table>
					<tr>
						<td>
							 <input type="submit" id="submit" value="Submit">
						</td>
					</tr>
				</table>
				
			</form>
				
		</div>
		
	</body>

</html>