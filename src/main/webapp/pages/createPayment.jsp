<html>
<head>
<title>Payment Page</title>
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
.visibility {
	visibility: hidden;
}

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
		// This selectedID is coming from the listAll.jsp page where one user is selected for making a payment
		int selectedID = Integer.valueOf(request.getParameter("selected"));
		consultant = consultantservice.getConsultantById(selectedID);

		/* Logged In User Information */
		String LoggedInUser = session.getAttribute("LoggedInUser").toString();
		System.out.println("createPayment.jsp LoggedInUser : " + LoggedInUser);
		//	String UP = request.getParameter("listAll");
		//	System.out.println("ListAll Page:" + UP);
		String[] LoggedInUsers = LoggedInUser.split(" ");
		System.out.println("createPayment.jsp: Username is : " + LoggedInUsers[0]);
		System.out.println("createPayment.jsp: Password is : " + LoggedInUsers[1]);
		login.setUsername(LoggedInUsers[0]);
		login.setPassword(LoggedInUsers[1]);
		Login newLogin = new Login();
		newLogin = loginservice.getConsultant_Type(login);
		Consultant consultant1 = new Consultant();
		consultant1 = consultantservice.getConsultantById(newLogin.getU_id());
		
		/*String LoggedInUser = session.getAttribute("LoggedInUser").toString();
		System.out.println("ListAll.jsp LoggedInUser : " + LoggedInUser);
		
		String[] LoggedInUsers = LoggedInUser.split(" ");
		System.out.println("createPayment.jsp: Username is : " + LoggedInUsers[0]);
		System.out.println("createPayment.jsp: Password is : " + LoggedInUsers[1]);
		login.setUsername(LoggedInUsers[0]);
		login.setPassword(LoggedInUsers[1]);
		Login newLogin = new Login();
		newLogin = loginservice.getConsultant_Type(login);
		consultant = consultantservice.getConsultantById(newLogin.getU_id());
		
		// redirect to paymentHistory.jsp page if user is a consultant
		if(consultant.getPosition().equals("consultant")){
			response.sendRedirect(request.getContextPath() + "/pages/paymentHistory.jsp");
		}
		*/
	%>
	<div class="container wrapper">
		<div style="float:right" class="text-info"> <a id="home" href="MainPage.jsp" class="glyphicon glyphicon-home"></a> &nbsp | &nbsp 
			<span><i class="glyphicon glyphicon-user"><%=consultant1.getFirstName() + consultant1.getLastName() %></i></span>&nbsp | &nbsp
			<span><a id="logout" href="../index.jsp" >Sign out</a></span>
		</div>
		<div class="row">
			<div class="span12">
				<div id="loginModal">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true"></button>
						<h3>Create Payment</h3>
					</div>
					<div class="modal-body">

						<!--------------------------- CREATE PAYMENT PAGE ------------------------------------>
						<div class="tab" id="create">
							<form method="POST" action="paymentDetail.jsp"
								enctype="multipart/form-data">
								<table>
									<tr>
										<td style="float: left; width: 50%; margin-top: 15px">EmployeeID:</td>
										<td style="float: left; width: 50%; margin-top: 10px"><input
											class="form-control" type="text" name="employeeID"
											id="employeeID" value="<%=consultant.getId()%>"></td>
										<!-------	<td style="float: left; width: 50%; margin-top: 10px"><input
											class="form-control" type="button" name="searchByID" value="Search"></td> ----->
									</tr>
									<tr>
										<td style="float: left; width: 50%; margin-top: 15px">First
											Name:</td>
										<td style="float: left; width: 50%; margin-top: 10px"><input
											class="form-control" type="text" name="firstName"
											value="<%=consultant.getFirstName()%>"></td>
									</tr>
									<tr>
										<td style="float: left; width: 50%; margin-top: 15px">Last
											Name:</td>
										<td style="float: left; width: 50%; margin-top: 6px"><input
											class="form-control" type="text" name="lastName"
											value="<%=consultant.getLastName()%>"></td>
									</tr>
									<tr>
										<td style="float: left; width: 50%; margin-top: 15px">Amount:</td>
										<td style="float: left; width: 50%; margin-top: 10px"><input
											class="form-control" type="text" name="amount"
											placeholder="Amount Here.."></td>
									</tr>
									<tr>
										<td style="float: left; width: 50%; margin-top: 15px">Date:</td>
										<td style="float: left; width: 50%; margin-top: 10px"><input
											class="form-control" type="date" name="date"></td>
									</tr>
									<tr>
										<td style="float: left; width: 50%; margin-top: 15px">Type:</td>
										<td style="float: left; width: 50%; margin-top: 10px"><select
											class="form-control" name="type" id="PaymentType">
												<option value="check">CHECK</option>
												<option value="cash">CASH</option>
										</select></td>
										<td><input type="file" id="PaymentFile"
											class="form-control"
											style="margin-left: 10px; margin-top: 10px" name="file"
											size="50" accept="application/pdf" /></td>
									</tr>
									<tr>
										<td style="float: left; width: 50%; margin-top: 15px"></td>
										<td style="float: left; width: 50%; margin-top: 10px"><input
											type="reset" class="btn btn-success" name="reset"></td>
									</tr>
									<tr>
										<td style="float: left; width: 50%; margin-top: 15px"></td>
										<td style="float: left; width: 50%; margin-top: 10px"><input
											type="submit" class="btn btn-success" value="Submit"></td>
									</tr>
								</table>
							</form>
						</div>
					</div>
					<br></br>
				</div>
			</div>
		</div>
	</div>

</body>
<script>
	$(document).ready(function() {

		$("#PaymentType").click(function() {
			if ($("#PaymentType").val() == "check") {
				$("#PaymentFile").removeClass("visibility");
			}
		});

		$("#PaymentType").change(function() {
			if ($("#PaymentType").val() == "cash") {
				$("#PaymentFile").addClass("visibility");
			}
		});

		/* 		$("#employeeID").keypress(function() {
		 $("span").text(i += 1);
		 }); */

		$("#adminHome").click(function() {
			returnAdminHome();
		});
	});

	function returnAdminHome() {
		var User = $("#Username").text();
		var Pass = $("#Password").text();
		//		alert(User + " " + Pass);
		window.location = "./MainPage.jsp?username=" + User + "&password="
				+ Pass;
	}
</script>
</html>
