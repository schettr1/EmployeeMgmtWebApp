<%@ page import="com.s3s.jsp.model.*, com.s3s.jsp.services.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="consultantservice" class="com.s3s.jsp.services.ConsultantService"
	scope="page" />


<%
	String selectedId = request.getParameter("selected");
	System.out.println("Delete ID: " + Integer.valueOf(selectedId));
	consultantservice.deleteConsultant(Integer.valueOf(selectedId));
	
	String LoggedInUser = session.getAttribute("LoggedInUser").toString();
	String[] LoggedInUsers = LoggedInUser.split(" ");
	System.out.println("deleteByAdmin LoggedInUser: " + LoggedInUser);

	response.sendRedirect(request.getContextPath() + "/pages/listAllforAdmin.jsp?listAll=LoggedInUsers[0] LoggedInUsers[1]");
%>


