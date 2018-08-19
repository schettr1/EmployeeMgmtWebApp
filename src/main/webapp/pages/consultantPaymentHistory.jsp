<html>
<head>
<title>List All Users Page</title>
<%@ page
	import="com.s3s.jsp.dao.*, com.s3s.jsp.services.*, com.s3s.jsp.model.*"%>
<%@ page import="java.util.*"%>
<%@ include file="header.jsp"%>

<script
	src="http://localhost:8080/GoldTeamProject/javascripts/commonUtil.js"></script>
<script
	src="http://localhost:8080/GoldTeamProject/javascripts/selectCheckedBox.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>  <!-- Load regular jQuery first -->

<!--Data Table-->
<script type="text/javascript"  src=" https://cdn.datatables.net/1.10.13/js/jquery.dataTables.min.js"></script>
<script type="text/javascript"  src=" https://cdn.datatables.net/buttons/1.2.4/js/dataTables.buttons.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">  <!-- Regular CSS -->

<!--Export table buttons-->
<script type="text/javascript"  src="https://cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.24/build/pdfmake.min.js" ></script>
<script type="text/javascript"  src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.24/build/vfs_fonts.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.2.4/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.2.1/js/buttons.print.min.js"></script>

<!--Export table button CSS-->
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.2.4/css/buttons.dataTables.min.css">

<jsp:useBean id="payment" class="com.s3s.jsp.model.Payment" />
<jsp:useBean id="login" class="com.s3s.jsp.model.Login" />
<jsp:useBean id="consultant" class="com.s3s.jsp.model.Consultant" />
<jsp:useBean id="consultantservice"
	class="com.s3s.jsp.services.ConsultantService" scope="page" />
<jsp:useBean id="loginservice"
	class="com.s3s.jsp.services.LoginService" scope="page" />
<jsp:useBean id="paymentservice"
	class="com.s3s.jsp.services.PaymentService" scope="page" />
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
		String LoggedInUser = session.getAttribute("LoggedInUser").toString();
		System.out.println("ListAll.jsp LoggedInUser : " + LoggedInUser);

		String[] LoggedInUsers = LoggedInUser.split(" ");
		System.out.println("paymentHistory.jsp: Username is : " + LoggedInUsers[0]);
		System.out.println("paymentHistory.jsp: Password is : " + LoggedInUsers[1]);
		login.setUsername(LoggedInUsers[0]);
		login.setPassword(LoggedInUsers[1]);
		Login newLogin = new Login();
		newLogin = loginservice.getConsultant_Type(login);
		consultant = consultantservice.getConsultantById(newLogin.getU_id());
		
		int employeeID = consultant.getId();
		System.out.println("paymentHistory.jsp: UserID = " + employeeID);

		payment.setEmployeeID(employeeID);
		consultant = consultantservice.getConsultantById(employeeID);
		List<Payment> paymentList = new ArrayList<>();

		paymentList = paymentservice.getPaymentById(payment.getEmployeeID());

/* 		//	String coordinatorKey=null, consultantKey=null;
		String LoggedInUser = null;

		if (consultant.getPosition().equals("coordinator")) {
			// used to pass as hidden key to return to CoordinatorMainMenu
			//	coordinatorKey = session.getAttribute("coordinatorKey").toString();	
			LoggedInUser = session.getAttribute("LoggedInUser").toString();
			System.out.println(" Payment History Page: LoggedInUser = " + LoggedInUser);
		}

		else if (consultant.getPosition().equals("consultant")) {
			// used to pass as hidden key to return to CoordinatorMainMenu
			LoggedInUser = session.getAttribute("LoggedInUser").toString();
			System.out.println(" Payment History Page: LoggedInUser = " + LoggedInUser);
		} */
	%>

	<div class="container wrapper">
		<div style="float:right" class="text-info"> <a id="home" href="MainPage.jsp" class="glyphicon glyphicon-home"></a> &nbsp | &nbsp 
			<span><i class="glyphicon glyphicon-user"><%=consultant.getFirstName() + consultant.getLastName() %></i></span>&nbsp | &nbsp
			<span><a id="logout" href="../index.jsp" >Sign out</a></span>
		</div>
		<br/><br/><br/>
		<table id="DataTable" class="table table-hover" style="margin-top: 10px">
			<thead>
				<tr>
					<th align="center"><b>Transaction ID</b></th>
					<th align="center"><b>Date</b></th>
					<th align="center"><b>Amount</b></th>
					<th align="center"><b>Transaction Type</b></th>
					<th align="left"><b>Check Image</b></th>
				</tr>
			</thead>
			<tbody>
				<%
					for (Payment p : paymentList) {
				%>
				<tr>
					<td align="center"><%=p.getTransactionID()%></td>
					<td align="center"><%=p.getDate()%></td>
					<td align="center"><%=p.getAmount()%></td>
					<td align="center"><%=p.getType()%></td>
					<%
						if (p.getType().equals("check")) {
					%>
					<td align="left" class="DisplayCheckImage"><a
						style="width: 600; height: 300"
						href="http://localhost:8080/GoldTeamProject/Images/<%=p.getFileName()%>"
						target="pdf-frame"><button id="DisplayCheckImage"
								class="btn btn-default" style="margin-left: 12px">
								<img
									src="http://localhost:8080/GoldTeamProject/Images/check.png"
									height="15px" width="15px" alt="Edit">
							</button></a>
					</td>
					<%
						} else {
					%>
					<td><a style="width: 600; height: 300" href="#"><label
							id="DisplayCheckImage" style="margin-left: 12px"></label></a>
					</td>
					<%
						}
					%>
				<%
					}
				%>	
			</tbody>
		</table>
		
	</div>
	<div class="push"></div>
	<div class="footer">
		<%@ include file="footer.jsp"%>	
	</div>
</body>
<script>
$.noConflict();
	$(document).ready(function() {
		
		//DataTable Plugin
		$("#DataTable").DataTable();
	});
</script>
</html>
