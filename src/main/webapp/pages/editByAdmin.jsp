<html>
<head>
<title>Edit User By Coordinator Page</title>
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
<%@ include file="header.jsp"%>
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
		Consultant consultant1 = new Consultant();
		consultant1 = consultantservice.getConsultantById(newLogin.getU_id());
		
		int key = Integer.valueOf(request.getParameter("key"));
		System.out.println("editConsultantByAdmin.jsp: ID is : " + key);

		/* Edited User Login Info*/
		login.setU_id(key); // assign key to u_id of login object
		Login login1 = new Login();
		login1 = loginservice.getConsultantByID(login); // get username and password and store it in login1 object

		consultant = consultantservice.getConsultantById(key); // get all values and store it in consultant object
	%>
	<div class="container wrapper">
		<div style="float:right" class="text-info"> <a id="home" href="MainPage.jsp" class="glyphicon glyphicon-home"></a> &nbsp | &nbsp 
			<span><i class="glyphicon glyphicon-user"><%=consultant1.getFirstName() + consultant1.getLastName() %></i></span>&nbsp | &nbsp
			<span><a id="logout" href="../index.jsp" >Sign out</a></span>
		</div>
		<p style="margin-left: 220px; font-size: 30px">
			<b>Edit Information: 
		</p>
		<br></br>
		<form id="userByID" action="updateByAdmin&Coordinator.jsp" method="GET">
			<div>
				<table style="margin-left: 220px; font-size: 20px">
					<tbody>
						<tr>
							<td>ID:</td>
							<td><input type="text" id="ID" class="form-control"
								style="margin-left: 50px" value=<%=consultant.getId()%>
								name="id" disabled></td>
						</tr>
						<tr>
							<td>FirstName:</td>
							<td><input type="text" id="FName" class="form-control"
								style="margin-left: 50px" value=<%=consultant.getFirstName()%>
								name="firstName"></td>
						</tr>
						<tr>
							<td>LastName:</td>
							<td><input type="text" id="LName" class="form-control"
								style="margin-left: 50px" value=<%=consultant.getLastName()%>
								name="lastName"></td>
						</tr>
						<tr>
							<td>Address:</td>
							<td><input type="text" id="Address" class="form-control"
								style="margin-left: 50px" value="<%=consultant.getAddress()%>"
								name="address"></td>
						</tr>
						<tr>
							<td>Email:</td>
							<td><input type="text" id="Email" class="form-control"
								style="margin-left: 50px" value="<%=consultant.getEmail()%>"
								name="email"></td>
						</tr>
						<tr>
							<td>DOB:</td>
							<td><input type="text" id="Age" class="form-control"
								style="margin-left: 50px" value="<%=consultant.getDOB()%>"
								name="age"></td>
						</tr>
						<tr>
							<td>License:</td>
							<td><input type="text" id="License" class="form-control"
								style="margin-left: 50px" value="<%=consultant.getLicense()%>"
								name="license"></td>
						</tr>
						<tr>
							<td>SSN:</td>
							<td><input type="text" id="SSN" class="form-control"
								style="margin-left: 50px" value="<%=consultant.getSSN()%>"
								name="ssn"></td>
						</tr>
						<tr>
							<td>Gender:</td>
							<td><select style="margin-left: 50px"
								class="form-control" name="gender">
									<option value="<%=consultant.getGender()%>" ><%=consultant.getGender()%></option>
									<option value="Male">Male</option>
									<option value="Female">Female</option>
							</select></td>	
						</tr>
						<tr>
							<td>Education:</td>
							<td><select style="margin-left: 50px"
								class="form-control" name="education">
									<option value="<%=consultant.getEducation()%>" ><%=consultant.getEducation()%></option>
									<option value="Diploma">Diploma</option>
									<option value="Bachelor">Bachelor</option>
									<option value="Master">Master</option>
									<option value="Doctoral">Doctoral</option>
							</select></td>	
						</tr>
						<tr>
							<td>Position:</td>
							<td><select style="margin-left: 50px"
								class="form-control" name="position">
									<option value="<%=consultant.getPosition()%>" ><%=consultant.getPosition()%></option>
									<option value="Admin">Admin</option>
									<option value="Recruiter">Recruiter</option>
									<option value="Coordinator">Coordinator</option>
									<option value="Consultant">Consultant</option>
							</select></td>
						</tr>
						<tr>
							<td>Username:</td>
							<td><input type="text" id="Username" class="form-control"
								style="margin-left: 50px" value="<%=login1.getUsername()%>"
								name="username"></td>
						</tr>
						<tr>
							<td>Password:</td>
							<td><input type="text" id="Password" class="form-control"
								style="margin-left: 50px" value="<%=login1.getPassword()%>"
								name="password"></td>
						</tr>
					</tbody>
				</table>
			</div>
			</br>
			<div>
				<input class="btn btn-default" type="text"
					style="visibility: hidden; width: 10px"
					value="<%=consultant.getId()%>" name="hiddenID"> <a
					style="margin-left: 500px"> <input class="btn btn-info"
					type="submit" value="Update">
			
			</div>
		</form>
	</div>
	<div class="push"></div>
	<div class="footer">
		<%@ include file="footer.jsp"%>	
	</div>
</body>
</html>
