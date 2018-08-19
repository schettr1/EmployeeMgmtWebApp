<html>
<head>
<title>Edit Page</title>
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
<%@ include file="header.jsp"%>
<jsp:useBean id="login" class="com.s3s.jsp.model.Login" scope="session" />
<jsp:useBean id="consultant" class="com.s3s.jsp.model.Consultant" />
<jsp:useBean id="loginservice" class="com.s3s.jsp.services.LoginService"
	scope="page" />
<jsp:useBean id="consultantservice"
	class="com.s3s.jsp.services.ConsultantService" scope="page" />
<style>
/*Footer at bottom of page */
	html, body {
	  height: 100%;
	  margin: 0;
	}
	.wrapper {
	  min-height: 67%;
	
	  /* Equal to height of footer */
	  /* But also accounting for potential margin-bottom of last child */
	  margin-bottom: -50px;
	}
	.footer,
	.push {
	  height: 50px;
	}
</style>
</head>
<body>

	<%
	
	    /* Logged In User Info. redirected via jQuery */
		String UP = session.getAttribute("LoggedInUser").toString();
	
		String[] UPs = UP.split(" ");

		String username = UPs[0];
		String password = UPs[1];

		System.out.println("EditByUser page: username : " + username);
		System.out.println("EditByUser page: password : " + password);

		login.setUsername(username);
		login.setPassword(password);
		Login login1 = new Login();
		login1 = loginservice.getConsultant_Type(login);
		System.out.println("edit.jsp: login1.getUsername():" + login1.getUsername() + " login1.getPassword():" + login1.getPassword() + " login1.getU_id():" + login1.getU_id());
		if (login1.getU_id() != 0) {
			consultant = consultantservice.getConsultantById(login1.getU_id());
		}
	%>


	<div class="container wrapper">
		<div style="float:right" class="text-info"> <a id="home" href="MainPage.jsp" class="glyphicon glyphicon-home"></a> &nbsp | &nbsp 
			<span><i class="glyphicon glyphicon-user"><%=consultant.getFirstName() + consultant.getLastName() %></i></span>&nbsp | &nbsp
			<span><a id="logout" href="../index.jsp" >Sign out</a></span>
		</div>
		<br></br>
		<p style="margin-left: 220px; font-size: 30px">
			<b>This Page is under maintenance: 
		</p>
		
	</div>
	
	<div class="push"></div>
	<div class="footer">
		<%@ include file="footer.jsp"%>	
	</div>
</body>
</html>





 