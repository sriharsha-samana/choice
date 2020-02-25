<%@page import="java.net.InetAddress"%>
<%@page import="java.net.UnknownHostException"%>
<html>
<%	
		InetAddress ip = InetAddress.getLocalHost();
		String URL="http://"+ip.getHostAddress()+":"+request.getServerPort()+"/Choice/LoginM.jsp";
		response.sendRedirect(URL);
		//URL="http://382c47cc.ngrok.com/Choice/LoginM.jsp";
%>