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

		String key = "adminActiveScreenPreURL";
		ArrayList<String> preURLsList = (ArrayList<String>)session.getAttribute(key);
		String nextURL = "";
		String currentURL = (String)session.getAttribute("currentAdminURL");
		if(currentURL != null)
		{
			currentURL = currentURL.trim();
			if(preURLsList.contains(currentURL))
			{
				int i=preURLsList.size()-1;
				for(;i>0;i--)
				{
					if(preURLsList.get(i).trim().equalsIgnoreCase(currentURL))
							{
								break;
							}
				}
					if(i!=0 && (i+1)<preURLsList.size())
					{
						nextURL = preURLsList.get(i+1);
					}
			}
		}
		response.setContentType("text/xml");
	    response.setHeader("Cache-Control", "no-cache");
	    response.getWriter().write(nextURL);
	    if(!nextURL.trim().equals(""))
	    {
	    	session.setAttribute("currentAdminURL",nextURL);
	    }
		
%>