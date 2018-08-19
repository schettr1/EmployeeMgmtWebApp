<%@ page import="com.s3s.jsp.model.*, com.s3s.jsp.services.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.http.*"%>
<jsp:useBean id="consultantservice" class="com.s3s.jsp.services.ConsultantService"
	scope="page" />


<%
	String selectedIds = request.getParameter("selected");
	if (selectedIds != null && !selectedIds.isEmpty()) {
		List<String> ids = Arrays.asList(selectedIds.split("\\s*,\\s*"));
		for (String id : ids) {
			System.out.println("Activate ID: " + Integer.valueOf(id));
			consultantservice.activateUserByID(Integer.valueOf(id));
		}
	}
	
	String LoggedInUser = session.getAttribute("LoggedInUser").toString();
	System.out.println("activateUser.jsp LoggedInUser : " + LoggedInUser);
	String[] LoggedInUsers = LoggedInUser.split(" ");

	
	response.sendRedirect(request.getContextPath() + "/pages/listAllforAdmin.jsp?listAll=" + LoggedInUsers[0] + " " + LoggedInUsers[1]);
%>
