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
	//	String UP = request.getParameter("edit");
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
		<br></br><br></br>
		<form id="userByID" action="updateByUser.jsp" method="GET">
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
								name="firstName" disabled></td>
						</tr>
						<tr>
							<td>LastName:</td>
							<td><input type="text" id="LName" class="form-control"
								style="margin-left: 50px" value=<%=consultant.getLastName()%>
								name="lastName" disabled></td>
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
								name="email" disabled></td>
						</tr>
						<tr>
							<td>DOB:</td>
							<td><input type="text" id="Age" class="form-control"
								style="margin-left: 50px" value="<%=consultant.getDOB()%>"
								name="age" disabled></td>
						</tr>
						<tr>
							<td>License:</td>
							<td><input type="text" id="License" class="form-control"
								style="margin-left: 50px" value="<%=consultant.getLicense()%>"
								name="license" disabled></td>
						</tr>
						<tr>
							<td>SSN:</td>
							<td><input type="text" id="SSN" class="form-control"
								style="margin-left: 50px" value="<%=consultant.getSSN()%>"
								name="ssn" disabled></td>
						</tr>
						<tr>
							<td>Gender:</td>
							<td><select style="margin-left: 50px"
								class="form-control" name="gender" disabled>
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
								class="form-control" name="position" disabled>
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
								name="username" disabled></td>
						</tr>
					</tbody>
				</table>
			</div>
			</br>
			<div>
				<input class="btn btn-default" type="text"
					style="visibility: hidden; width: 10px"
					value="<%=consultant.getId()%>" name="hiddenID"> <a
					style="margin-left: 500px"> <input class="btn btn-primary"
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

<!-- 

	<div class="container wrapper">
		<div style="float:right" class="text-info"> <a id="home" href="MainPage.jsp" class="glyphicon glyphicon-home"></a> &nbsp | &nbsp 
			<span><i class="glyphicon glyphicon-user"><%=consultant.getFirstName() + consultant.getLastName() %></i></span>&nbsp | &nbsp
			<span><a id="logout" href="../index.jsp" >Sign out</a></span>
		</div>
		<br></br><br></br>
		<p style="margin-left: 220px; font-size: 30px">
			<b>This Page is under maintenance: 
		</p>
		<br></br>
		<div>
			<button class="btn btn-primary"	style="float: left; margin-left: 12px">Resume</button>
		</div>
		<br/><br/><br/><br/>
		<div>
			<button class="btn btn-primary"	style="float: left; margin-left: 12px">Work Experience</button>
		</div>
		<br/><br/><br/><br/>
		<div>
			<button class="btn btn-primary"	style="float: left; margin-left: 12px">Job History</button>
		</div>
	</div>


 -->