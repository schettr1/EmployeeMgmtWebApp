<html>
<head>
<title>User Detail Page</title>
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
<jsp:useBean id="consultantService"
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
		int id = Integer.valueOf(request.getSession().getAttribute("NewConsultantID").toString());
		consultant = consultantService.getConsultantById(id);

		login.setU_id(id);
		login = loginservice.getConsultantByID(login);

	%>

	<div class="container wrapper">
		<div align="center">
			<h1 style="color:red">Registration is Successfully Complete.</h1>
			<h4>User Details:</h4>
			<img src="http://localhost:8080/GoldTeamProject/Images/<%=consultant.getFileName()%>" alt="Image Not Available" height="250px"
				width="250px">
		</div>
		<div class="container" style="margin-top: 50px">
			<table class="table table-hover" >
				<tr>
					<td><b>FirstName :</td>
					<td><%=consultant.getFirstName()%></td>
				</tr>
				<tr>
					<td><b>LastName :</td>
					<td><%=consultant.getLastName()%></td>
				</tr>
				<tr>
					<td><b>Address :</td>
					<td><%=consultant.getAddress()%></td>
				</tr>
				<tr>
					<td><b>Email :</td>
					<td><%=consultant.getEmail()%></td>
				</tr>
				<tr>
					<td><b>License :</td>
					<td><%=consultant.getLicense()%></td>
				</tr>
				<tr>
					<td><b>SSN :</td>
					<td><%=consultant.getSSN()%></td>
				</tr>
				<tr>
					<td><b>DOB :</td>
					<td><%=consultant.getDOB()%></td>
				</tr>
				<tr>
					<td><b>Education:</td>
					<td><%=consultant.getEducation()%></td>
				</tr>
				<tr>
					<td><b>Gender:</td>
					<td><%=consultant.getGender()%></td>
				</tr>
				<tr>
					<td><b>Job Title:</td>
					<td><%=consultant.getPosition()%></td>
				</tr>
				<tr>
					<td><b>Username:</td>
					<td><%=login.getUsername()%></td>
				</tr>
				<tr>
					<td><b>Password:</td>
					<td><%=login.getPassword()%></td>
				</tr>
			</table>
			<a style="float: left; margin-left: 10px" href="./index.jsp"><input
				class="btn btn-info" type="button" value="Done"></a>
		</div>
	</div>
	</br>
	</br>
	<div class="push"></div>
	<div class="footer">
		<%@ include file="footer.jsp"%>	
	</div>
</body>
</html>
