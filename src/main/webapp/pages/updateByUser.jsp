<html>
<head>
<title>UpdateByID Page</title>
<%@ page import="com.s3s.jsp.model.*, com.s3s.jsp.services.*"%>
<%@ page import="java.util.*"%>
<%@ include file="header.jsp"%>
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
<jsp:useBean id="login" class="com.s3s.jsp.model.Login" />
<jsp:useBean id="consultant" class="com.s3s.jsp.model.Consultant" />
<jsp:useBean id="consultantservice"
	class="com.s3s.jsp.services.ConsultantService" scope="page" />
<jsp:useBean id="loginservice" class="com.s3s.jsp.services.LoginService"
	scope="page" />
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
		int ID = Integer.valueOf(request.getParameter("hiddenID"));

		System.out.println("UpdateByUser page: " + ID);

		consultant.setId(ID);
		consultant.setAddress(request.getParameter("address"));
		consultant.setEmail(request.getParameter("email"));
		consultant.setDOB(request.getParameter("age"));
		System.out.println("UpdateByUser.jsp: DOB: " + request.getParameter("dob"));
		consultant.setEducation(request.getParameter("education"));
		login.setU_id(ID);

		consultantservice.updateConsultant(consultant); // Service call that updates user's address, email, age, education and position.

		// PERFORM THIS ONLY IF PASSWORD HAS CHANGED, ELSE DO NOT PERFORM IT
		// loginservice.updateLogin(login); // Service call that updates user's Password 

		// Update the session object(username, password) for the user
		session.removeAttribute("LoggedInUser");
		// create updatedLogin object and pass u_id of login to obtain updated username and password		
		Login UpdatedLogin = new Login();
		UpdatedLogin = loginservice.getConsultantByID(login);
		String UP = UpdatedLogin.getUsername() + " " + UpdatedLogin.getPassword();
		session.setAttribute("LoggedInUser", UP);
		Login login1 = new Login();
		login1 = loginservice.getConsultantByID(login);

		// Retrieve updated information from the user		
		Consultant consultant1 = new Consultant();
		consultant1 = consultantservice.getConsultantById(ID);
	%>

	<div class="container wrapper">
		<div style="float:right" class="text-info"> <a id="home" href="MainPage.jsp" class="glyphicon glyphicon-home"></a> &nbsp | &nbsp 
			<span><i class="glyphicon glyphicon-user"><%=consultant1.getFirstName() + consultant1.getLastName() %></i></span>&nbsp | &nbsp
			<span><a id="logout" href="../index.jsp" >Sign out</a></span>
		</div>
		<h2>Updated Information:</h2>
		<table class="table table-hover">
			<tr>
				<td><b>FirstName :</td>
				<td><%=consultant1.getFirstName()%></td>
			</tr>
			<tr>
				<td><b>LastName :</td>
				<td><%=consultant1.getLastName()%></td>
			</tr>
			<tr>
				<td><b>Address :</td>
				<td><%=consultant1.getAddress()%></td>
			</tr>
			<tr>
				<td><b>Email :</td>
				<td><%=consultant1.getEmail()%></td>
			</tr>
			<tr>
				<td><b>DOB :</td>
				<td><%=consultant1.getDOB()%></div></td>
			</tr>
			<tr>
				<td><b>License :</td>
				<td><%=consultant1.getLicense()%></td>
			</tr>
			<tr>
				<td><b>SSN :</td>
				<td><%=consultant1.getSSN()%></td>
			</tr>
			<tr>
				<td><b>Gender :</td>
				<td><%=consultant1.getGender()%></td>
			</tr>
			<tr>
				<td><b>Education :</td>
				<td><%=consultant1.getEducation()%></td>
			</tr>
			<tr>
				<td><b>Position :</td>
				<td><%=consultant1.getPosition()%></td>
			</tr>
			<tr>
				<td><b>Username :</td>
				<td><%=login1.getUsername()%></td>
			</tr>
		</table>
	</div>
	</br>
	</br>
	<div class="push"></div>
	<div class="footer">
		<%@ include file="footer.jsp"%>	
	</div>
</body>
</html>
