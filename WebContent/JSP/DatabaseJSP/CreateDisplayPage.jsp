<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
		<link rel="stylesheet" href="/Choice/CSS/Common/CommonCSS.css" type="text/css">
				<script src="/Choice/Rich Text Editor/ckeditor/ckeditor.js"></script>
				<script src="/Choice/JS/jquery.js"></script>
<%
		Object checkSessionExpiry = session.getAttribute("User");
%>
		<title>Create Display Page</title>
		
		
	</head>
	
	<body>

		  
		<form method="post" action="CreateDisplayPageProcess.jsp" onsubmit="showProgress();">

			<table>
			
				  <tr>
				  	<td>
				  		<h4 style="color:#ff6a22">Create Display Page:</h4><br>
				  	</td>
				  </tr>
				  
				  <tr>
					  <td>
					  		Heading :
					  </td>
					  
					  <td>
					  		<input type="text" name="Heading" id="Heading" value="" required />
					  </td>
				  </tr>
				  
				  <tr>
					  <td>
					  		Title :
					  </td>
					  
					  <td>
					  		<input type="text" name="Title" id="Title" value="" required />
					  </td>
				  </tr>
				  
			</table>
			
				  		<textarea name="editor1" id="editor1" style="width: 90%;">
				       		...
						</textarea><br/>
						
			<script>
                // Replace the <textarea id="editor1"> with a CKEditor
                // instance, using default configuration.
                CKEDITOR.replace( 'editor1' );
            </script>
			
			<input type="submit" name="Submit" value="Submit">
				
			
 		</form>
 		
	</body>
<%
		}
}
%>	
</html>