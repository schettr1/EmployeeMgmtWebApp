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
<%@ include file="header.jsp"%>
</head>
<body>
	<div class="container wrapper">
		</br>
		</br>
		</br>
		</br>
		<form action="loginDetail.jsp" method="POST">
			<table>
				<tr>
					<td style="float: left; width: 50%; margin-top: 6px">Username:</td>
					<td style="float: left; width: 50%; margin-top: 6px"><input
						type="text" name="username"></td>
				</tr>
				<tr>
					<td style="float: left; width: 50%; margin-top: 6px">Password:</td>
					<td style="float: left; width: 50%; margin-top: 6px"><input
						type="password" name="password"></td>
				</tr>
				<tr>
					<td style="float: left; width: 50%; margin-top: 6px"></td>
					<td style="float: left; width: 50%; margin-top: 6px">
					<input
						type="checkbox" style="width:15px; height:15px" id="remember" name="remember"><a><i>&nbspRemember Me?</i></a></td>
				</tr>
				<tr>
					<td style="float: left; width: 50%; margin-top: 16px"></td>
					<td style="float: left; width: 50%; margin-top: 16px"><input
						class="btn btn-info" id="signIn" type="submit" value="Sign-In"></td>
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
	HttpSession
	session2 = request.getSession();
	if (session2.getAttribute("key") != null) {
		alert("Invalid Username and/or Password. Please try later again.");
	}
	if (session2 != null) {
		session2.invalidate();
	}
</script>
</html>
