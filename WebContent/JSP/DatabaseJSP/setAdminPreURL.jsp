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
	try
	{
		String key = "adminActiveScreenPreURL";
		String value = request.getParameter("value");
		
		ArrayList<String> preURLs = null;
		preURLs = (ArrayList<String>)session.getAttribute(key);

		if(preURLs !=  null)
		{
			if(!((String)preURLs.get(preURLs.size()-1)).equalsIgnoreCase(value))
			{
				preURLs.add(value);
			}	
			
		}
		else
			{
				preURLs = new ArrayList<String>();
				preURLs.add(value);
			}

		session.setAttribute(key, preURLs);
		session.setAttribute("currentAdminURL", value);
		response.setContentType("text/xml");
	    response.setHeader("Cache-Control", "no-cache");
	    response.getWriter().write("true");
	} 
	catch(Exception ex)
	{
		response.setContentType("text/xml");
	    response.setHeader("Cache-Control", "no-cache");
	    response.getWriter().write("false");
	}
%>