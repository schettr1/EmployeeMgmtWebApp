<html>
<head>
<title>AllUsersPaymentHistory Page</title>
<%@ page import="com.s3s.jsp.model.*, com.s3s.jsp.services.*"%>
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

<jsp:useBean id="login" class="com.s3s.jsp.model.Login" />
<jsp:useBean id="consultant" class="com.s3s.jsp.model.Consultant" />
<jsp:useBean id="payment" class="com.s3s.jsp.model.Payment" />
<jsp:useBean id="consultantservice"
	class="com.s3s.jsp.services.ConsultantService" scope="page" />
<jsp:useBean id="loginservice" class="com.s3s.jsp.services.LoginService"
	scope="page" />
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
		String username = null;
		String password = null;
		String UP = session.getAttribute("LoggedInUser").toString();
		System.out.println("Email Page: UP = " + UP);
		if (UP != null) {
			String[] UPs = UP.split(" ");
			username = UPs[0];
			password = UPs[1];
			System.out.println("AllUsersPaymentHistory page: username = " + username);
			System.out.println("AllUsersPaymentHistory page: password = " + password);
		}
		login.setUsername(username);
		login.setPassword(password);
		Login newLogin = new Login();
		newLogin = loginservice.getConsultant_Type(login);
		consultant = consultantservice.getConsultantById(newLogin.getU_id());
		List<Payment> paymentList = new ArrayList<>();
		paymentList = paymentservice.getAllPayments();
		System.out.println("AllUsersPaymentHistory page: paymentList = " + paymentList.toString());
	%>

	<div class="container wrapper" >
		<div style="float:right" class="text-info"> <a id="home" href="MainPage.jsp" class="glyphicon glyphicon-home"></a> &nbsp | &nbsp 
			<span><i class="glyphicon glyphicon-user"><%=consultant.getFirstName() + consultant.getLastName() %></i></span>&nbsp | &nbsp
			<span><a id="logout" href="../index.jsp" >Sign out</a></span>
		</div>
		<div>
			<table id="DataTable" class="table table-hover">
				<thead>
					<tr>
						<th><b>TxnID</b></th>
						<th><b>FirstName</b></th>
						<th><b>LastName</b></th>
						<th><b>Date</b></th>
						<th><b>Type</b></th>
						<th><b>Amount</b></th>
						<th><b>Image</b></th>
					</tr>
				</thead>
				<tbody>
					<%
						for (Payment p : paymentList) {
					%>
					<tr class="clickable-row">
						<td><%=p.getTransactionID()%></td>
						<td><%=p.getFirstName()%></td>
						<td><%=p.getLastName()%></td>
						<td><%=p.getDate()%></td>
						<td><%=p.getType()%></td>
						<td><%=p.getAmount()%></td>
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
								id="DisplayCheckImage" style="margin-left: 12px"></label></a></td>
						<%
							}
						%>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
		<div>
			<button id="createPayment" class="btn btn-primary"	style="float: left; margin-left: 12px">Make Payment</button>
		</div>
		<br/><br/><br/>
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
		
		$("#SearchByDate").click(function() {
			var startDate = $("#StartDate").val();
			var endDate = $("#EndDate").val();
			alert(startDate + " " + endDate);
		});
		
		$("#createPayment").click(function() {
			selectUserByID();
		});
	});
	
	function selectUserByID() {
		var checkedArray = [];
		$(".idClass:checked").each(function() {
			checkedArray.push($(this).val());
		});
		if (checkedArray.length > 1) {
			alert("Multiple users are selected. Please select one user only.");
		} else {
			var selected = checkedArray[0];
			window.location = "./paymentPage.jsp?selected=" + selected;
		}
	}
	
	
</script>
</html>
