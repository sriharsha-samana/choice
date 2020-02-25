<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="/Choice/CSS/LoginPage/LoginCSS.css" type="text/css">
		<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>

		<script type = "text/javascript" >
		    
			function preventBack(){window.history.forward();}
			setTimeout("preventBack()", 0);
			window.onunload=function(){null};
			
		</script>
	
		<title>Choice</title>

	</head>

	<body>
	
						 <!-----start-main---->
				<div class="login-form">
					<div class="head">
						<img src="/Choice/Images/Icons/Logo.gif" alt=""/>
						
					</div>
				<form name="LoginForm" method="post" action="/Choice/JSP/LoginJSP/LoginVerification.jsp" onsubmit= "return checkUsernameAndPassword();">
					<li>
						<input type="text" class="text" name="username" id="username" value="USERNAME" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'USERNAME';}" ><a href="#" class=" icon user"></a>
					</li>
					<li>
						<input type="password" value="Password" name="password" id="password" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Password';}"><a href="#" class=" icon lock" required></a>
					</li>
					<div class="p-container">
								<input type="submit" value="SIGN IN">
							<div class="clear"> </div>
					</div>
				</form>
			</div>
			<!--//End-login-form-->
		  <!-----start-copyright---->
   					<div class="copy-right">
						<p><a href="#"></a></p> 
					</div>
				<!-----//end-copyright---->
		
	</body>

</html>