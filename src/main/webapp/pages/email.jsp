<html>
<head>
<title>Email Page</title>
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
		String username = null;
		String password = null;
		String UP = session.getAttribute("LoggedInUser").toString();
		System.out.println("Email Page: UP = " + UP);
		if (UP != null) {
			String[] UPs = UP.split(" ");
			username = UPs[0];
			password = UPs[1];
			System.out.println("Email page: username = " + username);
			System.out.println("Email page: password = " + password);
		}
		login.setUsername(username);
		login.setPassword(password);
		Login newLogin = new Login();
		newLogin = loginservice.getConsultant_Type(login);
		consultant = consultantservice.getConsultantById(newLogin.getU_id());
	%>
	<div class="container wrapper">
		<div style="float:right" class="text-info"> <a id="home" href="MainPage.jsp" class="glyphicon glyphicon-home"></a> &nbsp | &nbsp 
			<span><i class="glyphicon glyphicon-user"><%=consultant.getFirstName() + consultant.getLastName() %></i></span>&nbsp | &nbsp
			<span><a id="logout" href="../index.jsp" >Sign out</a></span>
		</div>
		<br/>
		<div style="display: none" id="SuccessEmail_AlertMessage">
		  <div class="panel panel-default" style="background: green; text-align: center; color: white">
		    <h5>Your message has been successfully delivered &nbsp;<span class="glyphicon glyphicon-ok"></span></h5>
		  </div >
		</div>
		<div style="display: none" id="FailedEmail_AlertMessage">
		  <div class="panel panel-default" style="background: red; text-align: center; color: white">
		    <h5>Your message has not been send. Please verify the email address. &nbsp;<span class="glyphicon glyphicon-remove"></span></h5>
		  </div>
		</div>
		<div style="display: inline-block">
			<h2>Send Message:</h2>
		</div>
		<div style="display: inline-block; margin-left: 1000px"></div>
		<form method="GET" action="emailConfirmation.jsp">
			<table>
				<tr>
					<td style="padding: 10px 0"><label class="control-label">To:</label></td>
					<td style="padding: 10px 0"><input type="text"
						class="form-control" style="width: 500px"
						placeholder="email address here.." name="emailAddress"></td>
				</tr>
				<tr>
					<td style="padding: 10px 0"><label class="control-label">Subject:</label></td>
					<td style="padding: 10px 0"><input type="text"
						class="form-control" style="width: 500px"
						placeholder="subject here.." name="subject"></td>
				</tr>
				<tr>
					<td style="align: left; padding: 10px 0"><label
						class="control-label">Attachment:</label></td>
					<td style="padding: 10px 0"><input type="file"
						class="form-control" style="width: 500px" name="file"></td>
				</tr>
				<tr>
					<td><label class="control-label">Message:</label></td>
					<td style="padding: 10px 0"><textarea class="form-control"
							style="width: 700px; height: 200px" placeholder="message here.."
							name="message"></textarea></td>
				</tr>
				<tr>
					<td></td>
					<td style="padding: 20px 0">
						<div style="display: inline-block">
							<input style="width: 100px" type="reset" class="btn btn-primary"
								value="Clear">
						</div>
						<div style="display: inline-block; margin-left: 20px">
							<input style="width: 100px" type="submit" class="btn btn-success"
								value="Send">
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div class="push"></div>
	<div class="footer">
		<%@ include file="footer.jsp"%>	
	</div>
	
</body>
<script>
$(document).ready(function(){
	
	<%
		if (request.getSession().getAttribute("MessagingSuccessful") != null) {
	%>
			$('#SuccessEmail_AlertMessage').fadeIn(1500);
		    $('#SuccessEmail_AlertMessage').fadeOut(1500);
		//	alert("Your message has been sent Successfully!");
	<%
			request.getSession().removeAttribute("MessagingSuccessful");
		}
	%>
	
	<%
		if (request.getSession().getAttribute("MESSAGE_NOT_SENT") != null) {
	%>
			$('#FailedEmail_AlertMessage').fadeIn(1500);
		    $('#FailedEmail_AlertMessage').fadeOut(1500);
		//  alert("Your message has not been send. Please verify the email address.");
	<%
			request.getSession().removeAttribute("MESSAGE_NOT_SENT");
		}
	%>
	
	<%
		if (request.getSession().getAttribute("FILE_NOT_FOUND") != null) {
			System.out.println("FILE_NOT_FOUND");
	%>
		alert("Server is down. Please check with your local administrator.");
	<%
		request.getSession().removeAttribute("FILE_NOT_FOUND");
		}
	%>
	
	<%
		if (request.getSession().getAttribute("ImcompleteForm") != null) {
			System.out.println("ImcompleteForm");
	%>
		alert("Fields are missing. Unable to send the message. Try again.");
	<%
		request.getSession().removeAttribute("ImcompleteForm");
		}
	%>
});
</script>
</html>
