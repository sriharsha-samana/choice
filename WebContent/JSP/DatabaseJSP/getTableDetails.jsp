<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="databaseActions.Actions"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>

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
		Map<String, List<String>> detailsMap = new HashMap<String, List<String>>();
		detailsMap = action.getTableDetails(targetId);
		StringBuffer sb = new StringBuffer();
		Iterator iterator = detailsMap.entrySet().iterator();
		while(iterator.hasNext())
		{
			Map.Entry entry = (Map.Entry) iterator.next();
    		sb.append(entry.getKey() + ":" + entry.getValue() + ";");
		}
		
		String returnString = (sb.toString()).trim();
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