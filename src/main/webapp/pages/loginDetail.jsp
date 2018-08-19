<html>
<head>
<title>LogIn Detail Page</title>
<script
	src="http://localhost:8080/GoldTeamProject/javascripts/jquery-3.3.1.min.js"></script>
<script
	src="http://localhost:8080/GoldTeamProject/javascripts/commonUtil.js"></script>
<script
	src="http://localhost:8080/GoldTeamProject/javascripts/selectCheckedBox.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<%@ page
	import="com.s3s.jsp.dao.*, com.s3s.jsp.services.*, com.s3s.jsp.model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="javax.servlet.http.*"%>
<jsp:useBean id="login" class="com.s3s.jsp.model.Login" scope="session" />
<jsp:useBean id="consultant" class="com.s3s.jsp.model.Consultant" />
<jsp:useBean id="loginservice" class="com.s3s.jsp.services.LoginService"
	scope="page" />
<jsp:useBean id="consultantservice"
	class="com.s3s.jsp.services.ConsultantService" scope="page" />

</head>
<body>
	<%
		login.setUsername(request.getParameter("username"));
		login.setPassword(request.getParameter("password"));


		// Send login record in userlogin table in db, retrieve login u_id from the consultantlogin table 
		// If username and password doesnot match in DB, it will return username=null, password=null, u_id=0
		Login login1 = new Login();

		login1 = loginservice.getConsultant_Type(login);
		if (login1.getU_id() != 0) {
			consultant = consultantservice.getConsultantById(login1.getU_id());
		}

		System.out.println(login1.toString());

		if (login.getUsername() == "" || login.getPassword() == "" || login1.getU_id() == 0 || consultant.getStatus().equals("inactive")) {
			
			// create session object and send the info. to login page
			session.setAttribute("InvalidUP", "		Invalid username or password");
			response.sendRedirect(request.getContextPath() + "/index.jsp");
		}

		else if (consultant.getPosition().equals("Admin")) {
			String UP = login1.getUsername() + " " + login1.getPassword();
//			session.setAttribute("adminKey", UP);
			session.setAttribute("LoggedInUser", UP);
			System.out.println("LoggedInUser Value: " + session.getAttribute("LoggedInUser").toString());
		//	response.sendRedirect(request.getContextPath() + "/pages/adminLogin.jsp");
			response.sendRedirect(request.getContextPath() + "/pages/MainPage.jsp");

		}

		else if (consultant.getPosition().equals("Coordinator")) {
			String UP = login1.getUsername() + " " + login1.getPassword();
	//		session.setAttribute("coordinatorKey", UP);
			session.setAttribute("LoggedInUser", UP);
			System.out.println("LoggedInUser Value: " + session.getAttribute("LoggedInUser").toString());
			response.sendRedirect(request.getContextPath() + "/pages/MainPage.jsp");
	
		}

		else if (consultant.getPosition().equals("Consultant")){
			String UP = login1.getUsername() + " " + login1.getPassword();
//			session.setAttribute("consultantKey", UP);
			session.setAttribute("LoggedInUser", UP);
			System.out.println("LoggedInUser Value: " + session.getAttribute("LoggedInUser").toString());
			response.sendRedirect(request.getContextPath() + "/pages/MainPage.jsp");
		}	
			
	%>
	</body>
</html>
