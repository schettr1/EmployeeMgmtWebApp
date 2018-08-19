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
		/* Logged In User Information */
		String LoggedInUser = session.getAttribute("LoggedInUser").toString();
		System.out.println("editByAdmin.jsp LoggedInUser : " + LoggedInUser);
		//	String UP = request.getParameter("listAll");
		//	System.out.println("ListAll Page:" + UP);
		String[] LoggedInUsers = LoggedInUser.split(" ");
		System.out.println("editByAdmin.jsp: Username is : " + LoggedInUsers[0]);
		System.out.println("editByAdmin.jsp: Password is : " + LoggedInUsers[1]);
		login.setUsername(LoggedInUsers[0]);
		login.setPassword(LoggedInUsers[1]);
		Login newLogin = new Login();
		newLogin = loginservice.getConsultant_Type(login);
		Consultant consultant2 = new Consultant();
		consultant2 = consultantservice.getConsultantById(newLogin.getU_id());
		
		/* Updated User Information */
		int ID = Integer.valueOf(request.getParameter("hiddenID"));
		System.out.println("UpdateByCoordinator ID : " + ID);

		consultant.setId(ID); // pass ID as the id of consultant object
		login.setU_id(ID); // pass ID as the u_id of login object

		System.out.println("UpdateByCoordinator ID : " + consultant.getId());

		consultant.setFirstName(request.getParameter("firstName"));
		consultant.setLastName(request.getParameter("lastName"));
		consultant.setAddress(request.getParameter("address"));
		consultant.setEmail(request.getParameter("email"));
		consultant.setDOB(request.getParameter("age"));
		consultant.setLicense(request.getParameter("license"));
		consultant.setSSN(request.getParameter("ssn"));
		consultant.setGender(request.getParameter("gender"));
		consultant.setEducation(request.getParameter("education"));
		consultant.setPosition(request.getParameter("position"));
		login.setUsername(request.getParameter("username"));
		login.setPassword(request.getParameter("password"));

		consultantservice.updateConsultantbyCoordinator(consultant); // Service call that updates all parameters except ID.

		loginservice.updateLoginbyCoordinator(login); // Service call that updates user's username and password 

		Login login1 = new Login();
		login1 = loginservice.getConsultantByID(login); // retrieves updated data from the DB and stores in login1 object

		Consultant consultant1 = new Consultant();
		consultant1 = consultantservice.getConsultantById(ID); // retrieves updated data from the DB and stores in consultant1 object

	%>
	<div class="container wrapper">
		<div style="float:right" class="text-info"> <a id="home" href="MainPage.jsp" class="glyphicon glyphicon-home"></a> &nbsp | &nbsp 
			<span><i class="glyphicon glyphicon-user"><%=consultant2.getFirstName() + consultant2.getLastName() %></i></span>&nbsp | &nbsp
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
				<td><%=consultant1.getDOB()%></td>
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
				<td id="username"><%=login1.getUsername()%></td>
			</tr>
			<tr>
				<td><b>Password :</td>
				<td id="password"><%=login1.getPassword()%></td>
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
