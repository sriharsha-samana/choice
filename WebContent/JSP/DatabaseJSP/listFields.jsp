<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="databaseActions.Actions"%>
<%
if (session == null || session.getAttribute("User") == null) {
%>
		<script>
			window.open("/Choice/Login.jsp","_top");
		</script>
<%
}
	
	String targetId = request.getParameter("tableName");
	
	if (targetId != null) 
	{
		Actions action = new Actions();	
		List FieldsList = new ArrayList<String>();
		FieldsList = action.listFields(targetId);
		String returnString = FieldsList.toString();
		returnString = returnString.trim();
		response.setContentType("text/xml");
	    response.setHeader("Cache-Control", "no-cache");
	    response.getWriter().write(returnString);
	} 
	else 
	{
	   response.setContentType("text/xml");
	   response.setHeader("Cache-Control", "no-cache");
	   response.getWriter().write("false");
	}

%>