<html>
<head>
<title>List All For Coordinator</title>
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
		String LoggedInUser = session.getAttribute("LoggedInUser").toString();
		System.out.println("ListAll.jsp LoggedInUser : " + LoggedInUser);
		//	String UP = request.getParameter("listAll");
		//	System.out.println("ListAll Page:" + UP);
		String[] LoggedInUsers = LoggedInUser.split(" ");
		System.out.println("listAll.jsp: Username is : " + LoggedInUsers[0]);
		System.out.println("listAll.jsp: Password is : " + LoggedInUsers[1]);

		login.setUsername(LoggedInUsers[0]);
		login.setPassword(LoggedInUsers[1]);
		Login newLogin = new Login();
		newLogin = loginservice.getConsultant_Type(login);
		consultant = consultantservice.getConsultantById(newLogin.getU_id());


			// Return all the users from the db to the list
			List<Consultant> consultantList = new ArrayList<>();
			consultantList = consultantservice.getAllConsultants();
			if (consultantList.size() > 0) {
	%>

	<div class="container wrapper">
		<div style="float:right" class="text-info"> <a id="home" href="MainPage.jsp" class="glyphicon glyphicon-home"></a> &nbsp | &nbsp 
			<span><i class="glyphicon glyphicon-user"><%=consultant.getFirstName() + consultant.getLastName() %></i></span>&nbsp | &nbsp
			<span><a id="logout" href="../index.jsp" >Sign out</a></span>
		</div>
		<div>
			<table class="table table-hover">
				<thead>
					<tr>
						<td id="Select"><input type="button" value="Select" style="visibility:hidden"></td>
						<td><b>ID</b></td>
						<td><b>FirstName</b></td>
						<td><b>LastName</b></td>
						<td><b>Email</b></td>
						<td><b>DOB</b></td>
						<td><b>Gender</b></td>
						<td><b>Education</b></td>
						<td><b>Position</b></td>
						<td><b>Status</b></td>
						<td><b>Edit</b></td>
					</tr>
				</thead>
				<tbody>
					<%
						for (Consultant c : consultantList) {
					%>
					<tr class="clickable-row">
						<td class="id"><input style="margin-left: 20px; visibility:hidden"
							type="checkbox" name="id" class="idClass" value="<%=c.getId()%>"></td>
						<td><%=c.getId()%></td>
						<td><%=c.getFirstName()%></td>
						<td><%=c.getLastName()%></td>
						<td><%=c.getEmail()%></td>
						<td><%=c.getDOB()%></td>
						<td><%=c.getGender()%></td>
						<td><%=c.getEducation()%></td>
						<td><%=c.getPosition()%></td>
						<td id="statusID" class="status"><%=c.getStatus()%></td>
						<td class="Edit"><button id="EditB" class="btn btn-default"
								style="margin-left: 12px">
								<img src="http://localhost:8080/GoldTeamProject/Images/edit.png"
									height="15px" width="15px" alt="Edit">
							</button></td>
					</tr>
					<%
						}
					%>
					<tr class="clickable-row">
						<td id="Username" style="visibility: hidden"><%=LoggedInUsers[0]%></td>
						<td id="Password" style="visibility: hidden"><%=LoggedInUsers[1]%></td>
				</tbody>
			</table>
		</div>
		<div class="clearfix"></div>
		<ul class="pagination pull-right">
			<li class="disabled"><a href="#"><span
					class="glyphicon glyphicon-chevron-left"></span></a></li>
			<li class="active"><a href="#">1</a></li>
			<li><a href="#">2</a></li>
			<li><a href="#">3</a></li>
			<li><a href="#">4</a></li>
			<li><a href="#">5</a></li>
			<li><a href="#"><span
					class="glyphicon glyphicon-chevron-right"></span></a></li>
		</ul>
	</div>
	<%
		}
	%>
	<br></br>
	<div class="push"></div>
	<div class="footer">
		<%@ include file="footer.jsp"%>	
	</div>
</body>
<script>
	$(document).ready(function() {

		// Disable Edit and Delete Buttons and coloring inactive users
		$(".status").each(
				function() {
					if ($(this).text() == "inactive") {
						//		alert("Hi");
						$(this).css('background-color',
								'yellow');
						$(this).parent().find("#EditB").prop(
								'disabled', 'disabled');
						$(this).parent().find("#DeleteB").prop(
								'disabled', 'disabled');
					} else {
						$(this).parent().find("#EditB").prop(
								'enabled', 'enabled');
						$(this).parent().find("#DeleteB").prop(
								'enabled', 'enabled');
					}
				});

		// to use 'each' function, specify class name not id name. Id name will not work here.
		// Edit user when clicked!
		$(".Edit").each(function() {
			if ($(this).parent().find("#EditB").is(':enabled')) { // condition if .Edit class parent's child id:EditB is enabled, execute the code.
				$(this).on("click",	function() {
					var key = $(this).parent().find(".idClass").val(); // store ID in key
					//			alert(key);

					// code to call jsp page from jQuery
					window.location = "./editByAdmin.jsp?key=" + key;
				});
			}
		});

		// to use 'each' function, specify class name not id name. Id name will not work here.
		// Delete user when clicked!
		$(".Delete").each(function() {
			if ($(this).parent().find("#EditB").is(':enabled')) {
				$(this).on("click",	function() {
					var key = $(this).parent().find(".idClass").val(); // store ID in key
					//			alert(key);

					// code to call jsp page from jQuery
					window.location = "./deleteByCoordinator.jsp?selected="	+ key;
				});
			}
		});

		// Activate Users
		$("#enableUser").click(function() {
			enableUserByIDs();
		});

		$("#createPayment").click(function() {
			selectUserByID();
		});

	});

	function enableUserByIDs() {
		var checkedArray = [];
		$(".idClass:checked").each(function() {
			//		alert($(this).val()); // display selected checkbox value
			checkedArray.push($(this).val());
		});
		var selected;
		selected = checkedArray.join(',');

		window.location = "./activateUser.jsp?selected=" + selected;
	}

	function selectUserByID() {
		var checkedArray = [];
		$(".idClass:checked").each(function() {
			checkedArray.push($(this).val());
		});
		if (checkedArray.length > 1) {
			alert("Multiple users are selected. Please select one user only.");
		} else {
			var selected = checkedArray[0];
			window.location = "./createPayment.jsp?selected=" + selected;

		}

	}
</script>
</html>


