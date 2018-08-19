<html>
<head>
<title>Edit Page</title>
<%@ page import="java.util.*"%>
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
		<br></br>
		<div class="col-xs-10" style="padding: 10px; margin-top: 50px; margin-left: 100px">
			<div>	
				<button id="jobApplicationBtn" class="btn btn-primary buttons" style="width: 150px">Job Application</button>
			</div>
			<div id="jobApplicationForm" value="no" class="panel panel-default col-xs-10 tabs" style="padding: 10px; margin-left: 100px; display: none">
				<div style="padding: 40px">
					<a class="closeTab" style="font-size: 16px; float: right; color: gray; cursor: pointer">X</a>
					<h2>Job Application Form:</h2><br/>
					<p>Thank you for your interest in working with us. Please check below for available job opportunities that meet your criteria and send your application by filling out the Job Application Form.</p>
					
					<form id="jobApplicationFormSubmit" method="POST">
						<div class="row">
							<div class="col-xs-6">
								<label>First Name:</label><br/>
								<input type="text" class="form-control" id="fName" placeholder="first name"/>
							</div>
							<div class="col-xs-6">
								<label>Last Name:</label><br/>
								<input type="text" class="form-control" id="lName" placeholder="last name"/>
							</div>
						</div>
						<br/>
						<div class="row">
							<div class="col-xs-6">
								<label>Email:</label><br/>
								<input type="text" class="form-control" id="fName" placeholder="email"/>
							</div>
							<div class="col-xs-6">
								<label>Phone:</label><br/>
								<input type="text" class="form-control" id="lName" placeholder="phone"/>
							</div>
						</div>
						<br/>
						<div class="row">
							<div class="col-xs-6">
								<label>What position are you applying for?</label><br/>
								<span>
									<select id="position" class="form-control" name="position" >
											<option value="">--select--</option>
											<option value="Consultant">Consultant</option>
											<option value="Coordinator">Coordinator</option>
											<option value="Admin">Administrator</option>
									</select>
								</span>
							</div>
							<div class="col-xs-6">
								<label>Available Start Date? </label><br/>
								<span>
									<input id="startDate" class="form-control" type="date" name="startDate" />
								</span>
							</div>
						</div>
						<br/>
						<div class="row">
							<div class="col-xs-12">
								<label>What is your current employment status?</label><br/>
								<input type="checkbox" name="" value="Employed">Employed<br>
								<input type="checkbox" name="" value="Self-Employed">Self-Employed<br>
								<input type="checkbox" name="" value="Unemployed" checked>Unemployed<br>
								<input type="checkbox" name="" value="Student">Student<br>
							</div>
						</div>
						<br/>
						<div class="row">
							<div class="col-xs-12">
								<label>Would you like to list references?</label><br/>
								<input type="checkbox" name="" value="Yes">Yes<br>
								<input type="checkbox" name="" value="No">No<br>
							</div>
						</div>
						<br/>
						<div class="row">
							<div class="col-xs-12">
								<label>Submit your resume by providing your resume URL:</label><br/>
								<input type="text" class="form-control" id="resume" placeholder="resume URL"/>
								
							</div>
						</div>
						<br/>
						<div>
							<button class="btn btn-primary" style="width: 150px; margin-left: 270px">Submit</button>
						</div>		
					</form>
				</div>
			</div>
			
			<br/><br/>
			
			<div>	
				<button id="employmentHistoryBtn" class="btn btn-primary buttons" style="width: 150px">Employment History</button>	
			</div>
			<div id="employmentHistoryForm" class="panel panel-default col-xs-10 tabs" style="padding: 10px; margin-left: 100px; display: none">
				<div style="padding: 40px">
					<a class="closeTab" style="font-size: 16px; float: right; color: gray; cursor: pointer">X</a>
					<h2>Employment History Form:</h2><br/>
					<p>Thank you for your interest in working with us. Please check below for available job opportunities that meet your criteria and send your application by filling out the Job Application Form.</p>
					
					<form>
						<div class="row">
							<div class="col-xs-6">
								<label>First Name:</label><br/>
								<input type="text" class="form-control" id="fName" placeholder="first name"/>
							</div>
							<div class="col-xs-6">
								<label>Last Name:</label><br/>
								<input type="text" class="form-control" id="lName" placeholder="last name"/>
							</div>
						</div>
						<br/>
						<div class="row">
							<div class="col-xs-6">
								<label>Email:</label><br/>
								<input type="text" class="form-control" id="fName" placeholder="email"/>
							</div>
							<div class="col-xs-6">
								<label>Phone:</label><br/>
								<input type="text" class="form-control" id="lName" placeholder="phone"/>
							</div>
						</div>
						<br/>
						<div class="row">
							<div class="col-xs-6">
								<label>What position are you applying for?</label><br/>
								<span>
									<select id="position" class="form-control" name="position" >
											<option value="">--select--</option>
											<option value="Consultant">Consultant</option>
											<option value="Coordinator">Coordinator</option>
											<option value="Admin">Administrator</option>
									</select>
								</span>
							</div>
							<div class="col-xs-6">
								<label>Available Start Date? </label><br/>
								<span>
									<input id="startDate" class="form-control" type="date" name="startDate" />
								</span>
							</div>
						</div>
						<br/>
						<div class="row">
							<div class="col-xs-12">
								<label>What is your current employment status?</label><br/>
								<input type="checkbox" name="" value="Employed">Employed<br>
								<input type="checkbox" name="" value="Self-Employed">Self-Employed<br>
								<input type="checkbox" name="" value="Unemployed" checked>Unemployed<br>
								<input type="checkbox" name="" value="Student">Student<br>
							</div>
						</div>
						<br/>
						<div class="row">
							<div class="col-xs-12">
								<label>Would you like to list references?</label><br/>
								<input type="checkbox" name="" value="Yes">Yes<br>
								<input type="checkbox" name="" value="No">No<br>
							</div>
						</div>
						<br/>
						<div class="row">
							<div class="col-xs-12">
								<label>Submit your resume by providing your resume URL:</label><br/>
								<input type="text" class="form-control" id="resume" placeholder="resume URL"/>
								
							</div>
						</div>
						<br/>
						<div>
							<button id="employmentHistoryFormSubmit" class="btn btn-primary" style="width: 150px; margin-left: 270px">Submit</button>
						</div>		
					</form>
				</div>
			</div>
			
			<br/><br/>
			
			<div>	
				<button id="jobExperienceBtn" class="btn btn-primary buttons" style="width: 150px">Job Experience</button>	
			</div>
			<div id="jobExperienceForm" class="panel panel-default col-xs-10 tabs" style="padding: 10px; margin-left: 100px; display: none">
				<div style="padding: 40px">
					<a class="closeTab" style="font-size: 16px; float: right; color: gray; cursor: pointer">X</a>
					<h2>Job Experience Form:</h2><br/>
					<p>Thank you for your interest in working with us. Please check below for available job opportunities that meet your criteria and send your application by filling out the Job Application Form.</p>
					
					<form>
						<div class="row">
							<div class="col-xs-6">
								<label>First Name:</label><br/>
								<input type="text" class="form-control" id="fName" placeholder="first name"/>
							</div>
							<div class="col-xs-6">
								<label>Last Name:</label><br/>
								<input type="text" class="form-control" id="lName" placeholder="last name"/>
							</div>
						</div>
						<br/>
						<div class="row">
							<div class="col-xs-6">
								<label>Email:</label><br/>
								<input type="text" class="form-control" id="fName" placeholder="email"/>
							</div>
							<div class="col-xs-6">
								<label>Phone:</label><br/>
								<input type="text" class="form-control" id="lName" placeholder="phone"/>
							</div>
						</div>
						<br/>
						<div class="row">
							<div class="col-xs-6">
								<label>What position are you applying for?</label><br/>
								<span>
									<select id="position" class="form-control" name="position" >
											<option value="">--select--</option>
											<option value="Consultant">Consultant</option>
											<option value="Coordinator">Coordinator</option>
											<option value="Admin">Administrator</option>
									</select>
								</span>
							</div>
							<div class="col-xs-6">
								<label>Available Start Date? </label><br/>
								<span>
									<input id="startDate" class="form-control" type="date" name="startDate" />
								</span>
							</div>
						</div>
						<br/>
						<div class="row">
							<div class="col-xs-12">
								<label>What is your current employment status?</label><br/>
								<input type="checkbox" name="" value="Employed">Employed<br>
								<input type="checkbox" name="" value="Self-Employed">Self-Employed<br>
								<input type="checkbox" name="" value="Unemployed" checked>Unemployed<br>
								<input type="checkbox" name="" value="Student">Student<br>
							</div>
						</div>
						<br/>
						<div class="row">
							<div class="col-xs-12">
								<label>Would you like to list references?</label><br/>
								<input type="checkbox" name="" value="Yes">Yes<br>
								<input type="checkbox" name="" value="No">No<br>
							</div>
						</div>
						<br/>
						<div class="row">
							<div class="col-xs-12">
								<label>Submit your resume by providing your resume URL:</label><br/>
								<input type="text" class="form-control" id="resume" placeholder="resume URL"/>
								
							</div>
						</div>
						<br/>
						<div>
							<button id="jobExperienceFormSubmit" class="btn btn-primary" style="width: 150px; margin-left: 270px">Submit</button>
						</div>		
					</form>
				</div>
			</div>
			
			<br/><br/>
			
		</div>
	</div>
	<div class="push"></div>
	<div class="footer">
		<%@ include file="footer.jsp"%>	
	</div>
</body>
<script>
	$(document).ready(function(){
	
		$("#jobApplicationBtn").on('click', function(){
			if($(this).text() == "Job Application" ){
				$('.buttons').fadeOut();
				$("#jobApplicationForm").fadeIn(1500);
			}
		});
		
		$("#jobApplicationFormSubmit").submit(function(){
			$("#jobApplicationForm").fadeOut(1500);
		});
		
		
		$("#employmentHistoryBtn").on('click', function(){
			if($(this).text() == "Employment History" ){
				$('.buttons').fadeOut();
				$("#employmentHistoryForm").fadeIn(1500);
			}
		});
		$("#employmentHistoryFormSubmit").on('click', function(){
			$("#employmentHistoryForm").fadeOut(1500);
		});
		
		
		$("#jobExperienceBtn").on('click', function(){
			if($(this).text() == "Job Experience" ){
				$('.buttons').fadeOut();
				$("#jobExperienceForm").fadeIn(1500);
			}
		});
		$("#jobExperienceSubmit").on('click', function(){
			$("#jobExperienceForm").fadeOut(1500);
		});
		
		
		$(".closeTab").on('click', function(){
			$(".tabs").fadeOut();
			$(".buttons").fadeIn(1000);
		});
		
	});
	
	
</script>
</html>





 