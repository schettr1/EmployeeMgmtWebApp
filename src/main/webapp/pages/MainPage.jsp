<!DOCTYPE html>
<html>
<head>
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
<%@ page import="org.apache.commons.io.output.*"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalDateTime"%>	
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
	System.out.println("Main Page: LoggedInUser = " + UP);
	String[] UPs = UP.split(" ");
	
	String username = UPs[0];
	String password = UPs[1];
	
	login.setUsername(username);
	Login returnedLogin = new Login();
	returnedLogin = loginservice.getLoginByUsername(login);
	
	System.out.println("MainPage.jsp : username = " + username);
	System.out.println("MainPage.jsp : password = " + password);
	
	consultant = consultantservice.getConsultantById(returnedLogin.getU_id());
	
	DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MM-dd-yyyy HH:mm");
	LocalDateTime now = LocalDateTime.now();
	System.out.println("Current Date: " + dtf.format(now));
	System.out.println("MainPage.jsp : consultant.getPosition() = " + consultant.getPosition());

%>




	<div class="container wrapper">
		<div style="float:right" class="text-info"> <a id="home" href="MainPage.jsp" class="glyphicon glyphicon-home"></a> &nbsp | &nbsp 
			<span><i class="glyphicon glyphicon-user"><%=consultant.getFirstName() + consultant.getLastName() %></i></span>&nbsp | &nbsp
			<span><a id="logout" href="../index.jsp" >Sign out</a></span>
		</div>
		<br/><br/>
			<div style="display: none" id="JobApplication_AlertMessage">
				  <div class="panel panel-default" style="background: red; text-align: center; color: white">
				    <p>Please Submit Your Job Application Form Now!</p>
				  </div >
			</div>
				
			<div style="display:inline-block">
				<h4 style="text-decoration: underline" class="text-info"><b>Main Menu</b></h4>
			</div>
			<div style="display:inline-block; margin-left:750px; margin-top: 30px">
			</div>
				<ul id="userMenu" class="list-unstyled collapse in" >
					<li id="profile" style="padding: 10px 0; font-size: 32px"><a href="profile.jsp"><i
							class="glyphicon glyphicon-user"></i> Profile</a></li>
					<li id="settings" style="padding: 10px 0; font-size: 32px"><a href="settings.jsp" id="test"><i
							class="glyphicon glyphicon-cog"></i> Settings</a><span class="glyphicon glyphicon-file notation" style="color:red; vertical-align: super; font-size: 18px"></span></li>
					<li id="messages" style="padding: 10px 0; font-size: 32px"><a href="email.jsp"><i
							class="glyphicon glyphicon-envelope"></i> Messages </a></li>		
					<li id="staffList" style="padding: 10px 0; font-size: 32px"><a href="listAllforAdmin.jsp"><i
							class="glyphicon glyphicon-user"></i> Staff List</a></li>
					<%if(consultant.getPosition().equals("Consultant")){ %>
						<li id="payments" style="padding: 10px 0; font-size: 32px"><a href="consultantPaymentHistory.jsp"><i
									class="glyphicon glyphicon-usd"></i> Payments</a></li>
					<%} else{%>
						<li id="payments" style="padding: 10px 0; font-size: 32px"><a href="AllUsersPaymentHistory.jsp"><i
							class="glyphicon glyphicon-usd"></i> Payments</a></li>
					<%} %>		
					
				</ul>
	</div>
	<input style="height: 0; visibility:hidden" type="text" id="LoggerPosition" value="<%=consultant.getPosition() %>" ></input>
	<div class="push"></div>
	<div class="footer">
		<%@ include file="footer.jsp"%>	
	</div>
</body>
<script>

$(document).ready(function(){
//	alert($("#LoggerPosition").val());
	if($("#LoggerPosition").val() == "Admin"){
		
	//	$("#transaction").hide();
	}
	if($("#LoggerPosition").val() == "Coordinator"){
		
	}
	if($("#LoggerPosition").val() == "Consultant"){
		
		$("#staffList").hide();
	}
	
	<%
	if (consultant.getApplicant().equals("true")) {
	%>
		$('#JobApplication_AlertMessage').show();
		$("#test").css("color", "red");
	<%
		}else{
	%>
		$('#NewHire_AlertMessage').hide();
		$(".notation").css("display", "none");
		$("#settings").css("color", "blue");
	<%	}
	%>
});

	
</script>
</html>

