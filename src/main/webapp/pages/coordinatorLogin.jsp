<html>
<head>
<title>Admin LogIn Page</title>
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
		
	//	String UP = session.getAttribute("coordinatorKey").toString();
		String UP = session.getAttribute("LoggedInUser").toString();
		System.out.println(" Coordinator Login Page: LoggedInUser = " + UP);
		String[] UPs = UP.split(" ");

		String username = UPs[0];
		login.setUsername(username);
		
		Login updatedLogin = new Login();
		
		updatedLogin = loginservice.getLoginByUsername(login);	// return login info after password gets updated.

		String password = updatedLogin.getPassword();
		UP = updatedLogin.getUsername() + " " + updatedLogin.getPassword();
		session.setAttribute("LoggedInUser", UP);		// UPdating the session object with updated password
		System.out.println(" After update: coordinatorLogin.jsp: LoggedInUser = " + UP);
		
		consultant = consultantservice.getConsultantById(updatedLogin.getU_id());


		System.out.println("coordinatorLogin.jsp: updatedLogin.getPassword() : " + updatedLogin.getPassword());
		System.out.println("coordinatorLogin.jsp: consultant fileName : " + consultant.getFileName());
		/* String password = UPs[1];

		login.setUsername(username);
		login.setPassword(password);

		Login login1 = new Login();
		login1 = loginservice.getConsultant_Type(login);

		if (login1.getU_id() != 0) {
			consultant = consultantservice.getConsultantById(login1.getU_id());
		}

		System.out.println("Coordinator Login Page: coordinator fileName : " + consultant.getFileName()); */
	%>

	<div class="container wrapper" >
		<div align="center" style="margin-top: 10px">
			<img
				src="http://localhost:8080/GoldTeamProject/Images/<%=consultant.getFileName()%>"
				alt="Image Not Available" height="250px" width="250px">
		</div>
		<div style="margin-top: 50px">
			<table class="table table-hover">
				<tbody>
					<tr>
					<tr>
						<td><b>FirstName:</td>
						<td><%=consultant.getFirstName()%></td>
					</tr>
					<tr>
						<td><b>LastName:</td>
						<td><%=consultant.getLastName()%></td>
					</tr>
					<tr>
						<td><b>Address:</td>
						<td><%=consultant.getAddress()%></td>
					</tr>
					<tr>
						<td><b>Email:</td>
						<td><%=consultant.getEmail()%></td>
					</tr>
					<tr>
						<td><b>DOB:</td>
						<td><%=consultant.getDOB()%></td>
					</tr>
					<tr>
						<td><b>Gender:</td>
						<td><%=consultant.getGender()%></td>
					</tr>
					<tr>
						<td><b>Education:</td>
						<td><%=consultant.getEducation()%></td>
					</tr>
					<tr>
						<td><b>Username:</td>
						<td id="Username"><%=updatedLogin.getUsername()%></td>
					</tr>
					<tr>
						<td><b>Password:</td>
						<td id="Password"><%=updatedLogin.getPassword()%></td>
					</tr>
					<tr>
						<td><b>Position:</td>
						<td id="Password"><%=consultant.getPosition()%></td>
					</tr>
				</tbody>
			</table>
		</div>
		</br>
		<div style="float: left">
			<form method="GET" action="edit.jsp"
				style="display: inline-block; float: left; padding: 0 40px">
				<input class="btn btn-default" type="text"
					style="visibility: hidden; width: 10px" value="<%=UP%>" name="edit">
				<input class="btn btn-info" type="submit" style="width: 100px"
					value="Edit">
			</form>
			<form method="get" action="email.jsp"
				style="display: inline-block; margin-left: 70px">
				<input class="btn btn-default" type="text"
					style="visibility: hidden; width: 10px" value="<%=UP%>"
					name="email"> <input class="btn btn-info" type="submit"
					style="width: 100px" value="Email">
			</form>
			<form method="get" action="profile.jsp"
				style="display: inline-block; margin-left: 70px">
				<input class="btn btn-default" type="text"
					style="visibility: hidden; width: 10px" value="<%=UP%>"
					name="profile"> <input class="btn btn-info" type="submit"
					style="width: 100px" value="Profile">
			</form>
			<form method="get" action="paymentHistory.jsp"
				style="display: inline-block; margin-left: 50px">
				<input class="btn btn-default" type="text"
					style="visibility: hidden; width: 10px"
					value="<%=updatedLogin.getU_id()%>" name="ID"> <input
					class="btn btn-info" type="submit" style="width: 100px"
					value="Payment">
			</form>
			<form action="../index.jsp"
				style="display: inline-block; margin-left: 100px">
				<input class="btn btn-info" type="submit" style="width: 100px"
					value="Sign Out">
			</form>
		</div>
	</div>
	<div class="push"></div>
	<div class="footer">
		<%@ include file="footer.jsp"%>	
	</div>

</body>
</html>
