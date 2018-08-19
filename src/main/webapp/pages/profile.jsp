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
		String UP = session.getAttribute("LoggedInUser").toString();
		System.out.println("Profile Page: LoggedInUser = " + UP);
		String[] UPs = UP.split(" ");

		String username = UPs[0];
		String password = UPs[1];

		login.setUsername(username);
		Login returnedLogin = new Login();
		returnedLogin = loginservice.getLoginByUsername(login);

		System.out.println("Profile page: " + username);
		System.out.println("Profile page: " + password);

		consultant = consultantservice.getConsultantById(returnedLogin.getU_id());
	%>
	<div class="container wrapper">
		<div>
			<div style="float:right" class="text-info"> <a id="home" href="MainPage.jsp" class="glyphicon glyphicon-home"></a> &nbsp | &nbsp 
				<span><i class="glyphicon glyphicon-user"><%=consultant.getFirstName() + consultant.getLastName() %></i></span>&nbsp | &nbsp
				<span><a id="logout" href="../index.jsp" >Sign out</a></span>
			</div>
			</br>
			</br>
			<div class="panel" style="width: 800px; float: left">
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
							<td><b>Position:</td>
							<td id="Position"><%=consultant.getPosition()%></td>
						</tr>
						<tr>
							<td><b>Username:</td>
							<td id="Username"><%=returnedLogin.getUsername()%></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div style="display:inline-block; margin-left: 20px">
				<div>
					<img
						src="<%="http://localhost:8080/GoldTeamProject/Images/" + consultant.getFileName()%>"
						alt="Image Not Available" height="250px" width="250px">
				</div>
				<br/></br/>
				<div>
					<form method="GET" action="editByUser.jsp">
						<input class="btn btn-info" type="button" value="X"
							name="UP" style="visibility: hidden"><input id="TRC"
							style="margin-left:50px; width: 100px" class="btn btn-primary" type="submit"
							value="Edit">
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<!--
	
	<div style="float: left; margin-left: 130px">	
		<a id="clickMe" style="font-style: italic; font-weight: bold; text-decoration: underline; font-size: 16px; color: red" href="#">Additional Info.</a>	
	</div>
	
	<div id="additionalInformation" style="float: left; margin-left: 130px; display: none">	
		<div class="panel">
			<div style="float: left; margin-left: 130px">	
				<button id="resume" class="btn btn-primary" style="width: 150px">Resume</button>	
			</div>
			<div style="display: inline-block; margin-left: 50px">	
				<button id="jobExperience" class="btn btn-primary" style="width: 150px">Job Experience</button>	
			</div>
			<div style="display: inline-block; margin-left: 50px">	
				<button id="employmentHistory" class="btn btn-primary" style="width: 150px">Employment History</button>	
			</div>
		</div>
	</div>
	
	 -->
	
	<div class="push"></div>
	<div class="footer">
		<%@ include file="footer.jsp"%>	
	</div>
</body>
<script>
$(document).ready(function(){
	$("#clickMe").on('click', function(){
		if($("#clickMe").text() == "Additional Info." ){
			$("#additionalInformation").fadeIn(1000);
			document.getElementById("clickMe").innerHTML = "Hide Info.";
		}else{
			$("#additionalInformation").fadeOut(500);
			document.getElementById("clickMe").innerHTML = "Additional Info.";
		}
	});
	
	$("#resume").on('click', function(){
		var User = $("#Username").text();
		var Pass = $("#Password").text();
		window.location = "./resume.jsp?username=" + User + "&password=" + Pass;
	});
	
	$("#jobExperience").on('click', function(){
		var User = $("#Username").text();
		var Pass = $("#Password").text();
		window.location = "./resume.jsp?username=" + User + "&password=" + Pass;
	});
	
	$("#employmentHistory").on('click', function(){
		var User = $("#Username").text();
		var Pass = $("#Password").text();
		window.location = "./resume.jsp?username=" + User + "&password=" + Pass;
	});
	
	
	
});
</script>
</html>
