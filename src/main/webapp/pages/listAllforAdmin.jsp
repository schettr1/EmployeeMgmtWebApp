<html>
<head>
<title>List All Users Page</title>
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

<script
	src="http://localhost:8080/GoldTeamProject/javascripts/commonUtil.js"></script>
<script
	src="http://localhost:8080/GoldTeamProject/javascripts/selectCheckedBox.js"></script>

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
	
  /* Pagination */
  #pager {
    float: right;
  }
</style>
</head>
<body>
	<%
		/* Logged In User Information */
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
			<table id="DataTable" class="table table-hover">
				<thead>
					<tr>
						<th style="visibility: hidden"><b>Test</b></th>
						<th><b>ID</b></th>
						<th><b>FirstName</b></th>
						<th><b>LastName</b></th>
						<th><b>Email</b></th>
						<th><b>DOB</b></th>
						<th><b>Gender</b></th>
						<th><b>Education</b></th>
						<th><b>Position</b></th>
						<th><b>Status</b></th>
						<th><b>Edit</b></th>
						<th><b>Delete</b></th>
						<th style="visibility: hidden"><b>Test</b></th>
						<th style="visibility: hidden"><b>Test</b></th>
					</tr>
				</thead>
				<tbody>
					<%
						for (Consultant c : consultantList) {
					%>
					<tr >
						<td class="id"><input style="margin-left: 20px"
							type="checkbox" name="id" class="idClass" value="<%=c.getId()%>">
						</td>
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
							</button>
						</td>
						<td class="Delete"><button id="EditB" class="btn btn-default"
								style="margin-left: 12px">
								<img src="http://localhost:8080/GoldTeamProject/Images/delete.png"
									height="15px" width="15px" alt="Delete">
							</button>
						</td>
						<td id="Username" style="visibility: hidden"><%=LoggedInUsers[0]%></td>
						<td id="Password" style="visibility: hidden"><%=LoggedInUsers[1]%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
		<div>
			<button id="enableUser" class="btn btn-primary"	style="float: left; margin-left: 12px">Activate</button>
		</div>
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
$.noConflict();
	$(document).ready(function() {
		
		//DataTable Plugin
		$("#DataTable").DataTable();
		
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
							//	alert(key);

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
					window.location = "./deleteByAdmin.jsp?selected="	+ key;
				});
			}
		});

		// Activate Users
		$("#enableUser").click(function() {
			enableUserByIDs();
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

	
</script>
</html>


