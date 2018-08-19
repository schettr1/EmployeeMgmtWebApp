
<!DOCTYPE html>
<html>
<head>
<title>Gold Team Project</title>
<%@ include file="pages/header.jsp"%>
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
	

  /* Form Validation with error msg */
  input.valid {
    border: 1.5px solid green;
  }
  input.invalid {
    border: 1.5px solid red;
  }
  .error {
    color: red;
    margin-left: 5px;
  }
  label.error {
    display: inline;
  }
</style>	
</head>
<body>
	<div class="container wrapper">
		<div id="loginModal">
			<div class="modal-header">
				<div style="display: none" id="Success_RegistrationAlertMessage">
				  <div class="panel panel-default" style="background: green; text-align: center; color: white">
				    <h5>You have been successfully registered &nbsp;<span class="glyphicon glyphicon-ok"></span></h5>
				  </div >
				</div>
				<div style="display: none" id="Failed_RegistrationAlertMessage">
				  <div class="panel panel-default" style="background: red; text-align: center; color: white">
				    <h5>Username has already been used. Try a different username &nbsp;<span class="glyphicon glyphicon-remove"></span></h5>
				  </div >
				</div>
							
				<h3>Have an Account?</h3>
			</div>
			<div class="container">
				<div class="modal-body">

					<!------------------------------------ NAV BAR --------------------------------------------->
					<div class="well">
						<ul class="nav nav-tabs">
							<li><a class="current" href="#login" data-toggle="tab">Login</a></li>
							<li><a href="#create" data-toggle="tab">Create Account</a></li>
						</ul>
					</div>
					<div id="myTabContent" class="tab-content"></div>

					<!------------------------------------ LOGIN PAGE --------------------------------------------->
			
					<div id="login" class="tab">
						<div class="container" >
							<form id="SignInForm" action="pages/loginDetail.jsp" method="POST">
								<div class="row">
									<label class="col-xs-1" style="margin-top: 5px" for="username">Username:</label>
									<span class="col-xs-3"><input id="user" class="form-control" placeholder="Username Here.."
										type="text" name="username"></span>
								</div>
								<br/>
								<div class="row">
									<label class="col-xs-1" style="margin-top: 5px" for="password">Password:</label>
									<span class="col-xs-3"><input id="pass" class="form-control" placeholder="Password Here.."
										type="password" name="password"></span>
								</div>
									<%
										if (session.getAttribute("InvalidUP") != null) {
											String InvalidUP = session.getAttribute("InvalidUP").toString();
									%>
								<div class="row">
									<label class="col-xs-1" style="margin-top: 5px"></label>
									<span class="col-xs-6" style="color:red"><%=InvalidUP%></span>
									<%
										}
										session.removeAttribute("InvalidUP");
									%>
								</div>
								<br/>
								<div class="row">
									<label class="col-xs-1" style="margin-top: 5px"></label>
									<span class="col-xs-3" style="margin-left: 20px"><input class="btn btn-success" id="signIn" type="submit"
										style="width: 100px" value="Sign-In"></span>
								</div>	
							</form>
						</div>
					</div>
					

					<!------------------------------------ CREATE ACCOUNT PAGE --------------------------------------------->
					<div id="create" class="tab">
						<div class="container" >
							<div class="">
								<form id="CreateAccountForm" action="validate" method="POST" enctype="multipart/form-data">
										<div class="row">
											<label class="col-xs-2" style="margin-top: 5px" for="firstName">First Name:</label>
											<span class="col-xs-3"><input id="firstName"
												class="form-control" type="text" name="firstName"
												placeholder="First Name Here.."></span>
										</div>
										<br/>
										<div class="row">
											<label class="col-xs-2" style="margin-top: 5px" for="lastName">Last
												Name:</label>
											<span class="col-xs-3"><input id="lastName"
												class="form-control" type="text" name="lastName"
												placeholder="Last Name Here.."></span>
										</div>
										<br/>
										<div class="row">
											<label class="col-xs-2" style="margin-top: 5px" for="address">Address:</label>
											<span class="col-xs-3"><input id="address"
												class="form-control" type="text" name="address"
												placeholder="Address Here.."></span>
										</div>
										<br/>
										<div class="row">
											<label class="col-xs-2" style="margin-top: 5px" for="dob">DOB:</label>
											<span class="col-xs-3"><input id="dob"
												class="form-control" type="date" name="dob"
												placeholder="DOB Here.."></span>
										</div>
										<br/>
										<div class="row">
											<label class="col-xs-2" style="margin-top: 5px" for="email">Email:</label>
											<span class="col-xs-3"><input id="email"
												class="form-control" type="text" name="email"
												placeholder="Email Here.."></span>
										</div>
										<br/>
										<div class="row">
											<label class="col-xs-2" style="margin-top: 5px" for="license">License:</label>
											<span class="col-xs-3"><input id="license"
												class="form-control" type="text" name="license"
												placeholder="License Here.."></span>
										</div>
										<br/>
										<div class="row">
											<label class="col-xs-2" style="margin-top: 5px" for="ssn">SSN:</label>
											<span class="col-xs-3"><input id="ssn"
												class="form-control" type="text" name="ssn"
												placeholder="SSN Here.."></span>
										</div>
										<br/>
										<div class="row">
											<label class="col-xs-2" style="margin-top: 5px" for="username">Username:</label>
											<span class="col-xs-3"><input id="username"
												class="form-control" type="text" name="username"
												placeholder="Username Here.."></span>
										</div>
										<br/>
										<div class="row">
											<label class="col-xs-2" style="margin-top: 5px" for="password">Password:</label>
											<span class="col-xs-3"><input id="password"
												class="form-control" type="password" name="password"
												placeholder="Password Here.."></span>
										</div>
										<br/>
										<div class="row">
											<label class="col-xs-2" style="margin-top: 5px" for="gender">Gender:</label>
											<span class="col-xs-3"><select id="gender"
												class="form-control" name="gender" >
													<option value="">--select--</option>
													<option value="Male">MALE</option>
													<option value="Female">FEMALE</option>
											</select></span>
										</div>
										<br/>
										<div class="row">
											<label class="col-xs-2" style="margin-top: 5px" for="education">Highest Level Education:</label>
											<span class="col-xs-3" style="margin-top:10px"><select id="education"
												class="form-control" name="education" >
													<option value="">--select--</option>
													<option value="Diploma">Diploma</option>
													<option value="Bachelor">Bachelor</option>
													<option value="Master">Master</option>
													<option value="Doctoral">Doctoral</option>
											</select></span>
										</div>
										<br/>
										<div class="row">
											<label class="col-xs-2" style="margin-top: 5px" for="imageBrowse">Upload
												Image:</label>
											<span class="col-xs-3"><input
												type="file" class="btn btn-default" id="imageBrowse"
												name="image" value="Image here"
												accept="image/x-png,image/gif,image/jpeg">
											</span>
										</div>
										
										<br/>
										<div class="row">
											<label class="col-xs-2" style="margin-top: 5px"></label>
											<span class="col-xs-3">
											<img id="userImage" src="" height="200" width="200" alt="" style="display: none"></span>
										</div>
										<br/>
										
										<!-- accept="image/*" OR, "image/x-png,image/gif,image/jpeg" -->
										<div class="row">
											<label class="col-xs-2" style="margin-top: 5px"></label>
											<span class="col-xs-3"><input
												type="button" class="btn btn-info" id="imageUpload" style="display: none"
												value="Preview Image">
											</span>
											<label class="col-xs-2" style="margin-top: 5px"></label>
											<span class="col-xs-3"><input type="text" class="form-control"
												id="response" name="base64valueInString"
												placeholder="base64output" style="visibility: hidden"></span>
										</div>
										<br/>
										<div class="row">
											<label class="col-xs-2"></label>
											<span class="col-xs-3"><input
												type="reset" class="btn btn-success" style="width: 100px" name="reset"></span>
										</div>
										<br/>
										<div class="row">
											<label class="col-xs-2"></label>
											<span class="col-xs-3"><input
												type="submit" class="btn btn-success" style="width: 100px" value="Submit"></span>
										</div>
									</div>
								</form>
							</div>
						</div>
						<br></br> <br></br>
					</div>
					<!-- ------------------------------------------------------------------------------------------------------- -->

				</div>
			</div>
		</div>
	</div>
	<div class="push"></div>
	<div class="footer">
		<%@ include file="pages/footer.jsp"%>	
	</div>
</body>


<script>
$(document).ready(function() {				
	// At the beginning of loading the page,
	$(".tab").hide(); // initially, hide all the tab-contents
	$("#login").show(); // display only the login tab-content

	<%if (request.getSession().getAttribute("FieldMissing") != null) {%>
	$(".tab").show(); // hide all the tab-contents
	$("#login").hide(); // display only the create user tab-content
	alert("Fields are missing. Try again.");
	<%}
	request.getSession().removeAttribute("FieldMissing");
	%>
	
	<%if (request.getSession().getAttribute("InvalidSSN") != null) {%>
	$(".tab").show(); // hide all the tab-contents
	$("#login").hide(); // display only the create user tab-content
	alert(" SSN must have 9 digits. Letters and characters are invalid. ");
	<%}
	request.getSession().removeAttribute("InvalidSSN");
	%>

	<%if (request.getSession().getAttribute("InvalidUsername") != null) {%>
	$('#Failed_RegistrationAlertMessage').show();
	$(".tab").show(); // hide all the tab-contents
	$("#login").hide(); // display only the create user tab-content
	// alert(" Username is already in use. Try a different username. ");
	<%}
	request.getSession().removeAttribute("InvalidUsername");
	%>

	<%if (request.getSession().getAttribute("InvalidPassword") != null) {%>
	$(".tab").show(); // hide all the tab-contents
	$("#login").hide(); // display only the create user tab-content
	alert("Password must contain at least 6 characters. It should contain upper case letter, lower case letter and numbers.");
	<%}
	request.getSession().removeAttribute("InvalidPassword");
	%>

	<%if (request.getSession().getAttribute("SuccessfulRegistration") != null) {%>
	$('#Success_RegistrationAlertMessage').fadeIn(1500);
    $('#Success_RegistrationAlertMessage').fadeOut(1500);
	// alert("Registration is Successfully Completed!");
	<%}
	request.getSession().removeAttribute("SuccessfulRegistration");
	%>
	
	// When any tab is clicked,
	$(".well ul li a").click(function(event) {
		event.preventDefault();		// this will prevent the brower from jumping to bottom of page.
		$("a").removeClass("current");
		$(this).addClass("current");
		//	alert("Hi");
		$(".tab").hide();
		$(this.hash).show();
	});

	$("#imageBrowse").change(function() {
		var fileSelected = document.getElementById("imageBrowse").files;
		if (fileSelected.length > 0) {
			var fileToLoad = fileSelected[0];
			var fileReader = new FileReader();
			fileReader.onload = function(fileLoadedEvent) {
				var base64value = fileLoadedEvent.target.result;
				console.log(base64value);
				//	alert(base64value);
				$("#response").val(base64value);
				document.getElementById('userImage').setAttribute('src', $("#response").val());
			};
			fileReader.readAsDataURL(fileToLoad);
		}
	});

	$("#imageUpload").click(function() {
	    var x = document.getElementById("userImage");
	    if (x.style.display === "none") {
	        x.style.display = "block";
	        document.getElementById("imageUpload").value = "Hide Image";
	    } else {
	        x.style.display = "none";
	        document.getElementById("imageUpload").value = "Preview Image";
	    }
		
	});
	

// FORM-VALIDATION
  $("#user").on("input", function(){
    $(".error").remove();   // prevents error message from accumulating when submit button is clicked
    if ($(this).val() == null || $(this).val() == ""){
      $(this).removeClass("valid").addClass("invalid");
    }else{
      $(this).removeClass("invalid").addClass("valid");
    }
  });
  $("#pass").on("input", function(){
    $(".error").remove();   // prevents error message from accumulating when submit button is clicked
    if ($(this).val() == null || $(this).val() == ""){
      $(this).removeClass("valid").addClass("invalid");
    }else{
      $(this).removeClass("invalid").addClass("valid");
    }
  });
  $("#firstName").on("input", function(){
    $(".error").remove();   // prevents error message from accumulating when submit button is clicked
    if ($(this).val() == null || $(this).val() == ""){
      $(this).removeClass("valid").addClass("invalid");
    }else{
      $(this).removeClass("invalid").addClass("valid");
    }
  });
  $("#lastName").on("input", function(){
    $(".error").remove();   // prevents error message from accumulating when submit button is clicked
    if ($(this).val() == null || $(this).val() == ""){
      $(this).removeClass("valid").addClass("invalid");
    }else{
      $(this).removeClass("invalid").addClass("valid");
    }
  });
  $("#address").on("input", function(){
    $(".error").remove();   // prevents error message from accumulating when submit button is clicked
    if ($(this).val() == null || $(this).val() == ""){
      $(this).removeClass("valid").addClass("invalid");
    }else{
      $(this).removeClass("invalid").addClass("valid");
    }
  });
  $("#dob").on("input", function(){
	  console.log(new Date());
	  console.log(new Date($("#dob").val()));
	  var DOBdate = new Date($("#dob").val());
	  var currentDate = new Date();
    $(".error").remove();   // prevents error message from accumulating when submit button is clicked
    if ($(this).val() == "" || DOBdate > currentDate ){
      $(this).removeClass("valid").addClass("invalid");
      $("#dob").after('<span class="error">Date of birth cannot be future date</span>');
    }else{
      $(this).removeClass("invalid").addClass("valid");
    }
  });
  $("#email").on("input", function(){
    $(".error").remove();   // prevents error message from accumulating when submit button is clicked
    if ($(this).val() == null || $(this).val() == ""){
      $(this).removeClass("valid").addClass("invalid");
    }else{
      $(this).removeClass("invalid").addClass("valid");
    }
  });
  $("#username").on("input", function(){
    $(".error").remove();   // prevents error message from accumulating when submit button is clicked
    if ($(this).val().length > 5){
      $(this).removeClass("invalid").addClass("valid");
    }else{
      $(this).removeClass("valid").addClass("invalid");
      $("#username").after('<span class="error">Username must contain at least 6 characters</span>');
    }
  });
  $("#password").on("input", function(){
    $(".error").remove();   // prevents error message from accumulating when submit button is clicked
    var regEx = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?!.*[&%$]).{6,}$/;   // RegExpression for at least one uppercase, one lowercase and one number
    if ( regEx.test($(this).val()) && $(this).val().length > 5 ){
    	console.log("0-9,a-zA-Z,>5");
      $(this).removeClass("invalid").addClass("valid");
    }else{
      $(this).removeClass("valid").addClass("invalid");
      $('#password').after('<span style="width: 100%" class="error">Password must contain at least 5 characters with at least one character between 0~9, a~z and A~Z</span>');
    }
  });
  $("#license").on("input", function(){
    $(".error").remove();   // prevents error message from accumulating when submit button is clicked
    if ($(this).val() == null || $(this).val() == ""){
      $(this).removeClass("valid").addClass("invalid");
    }else{
      $(this).removeClass("invalid").addClass("valid");
    }
  });
  $("#ssn").on("input", function(){
    $(".error").remove();   // prevents error message from accumulating when submit button is clicked
    if ( !isNaN($(this).val()) && $(this).val().length == 9){
      $(this).removeClass("invalid").addClass("valid");
    }else{
      $(this).removeClass("valid").addClass("invalid");
      $('#ssn').after('<span class="error">Please enter a valid SSN</span>');
    }
  });
  $("#gender").on("input", function(){
    $(".error").remove();   // prevents error message from accumulating when submit button is clicked
    if ($(this).val() == null || $(this).val() == ""){
      $(this).removeClass("valid").addClass("invalid");
    }else{
      $(this).removeClass("invalid").addClass("valid");
    }
  });
  $("#education").on("input", function(){
    $(".error").remove();   // prevents error message from accumulating when submit button is clicked
    if ($(this).val() == null || $(this).val() == ""){
      $(this).removeClass("valid").addClass("invalid");
    }else{
      $(this).removeClass("invalid").addClass("valid");
    }
  });
  $("#imageBrowse").on("input", function(){
    $(".error").remove();   // prevents error message from accumulating when submit button is clicked
    if ($(this).val() == null || $(this).val() == ""){
      $(this).removeClass("valid").addClass("invalid");
      var x = document.getElementById("imageUpload");
      var y = document.getElementById("userImage");
      x.style.display = "none";
      y.style.display = "none";
    }else{
      $(this).removeClass("invalid").addClass("valid");
      var x = document.getElementById("imageUpload");
      x.style.display = "block";
    }
  }); 
	  

  $("#SignInForm").submit(function(event){
    var error_free = true;
    $(".error").remove();   // prevents error message from accumulating when submit button is clicked
    if($("#user").val().length < 1){
      $('#user').after('<span class="error">This field is required</span>');
      error_free = false;
    }
    if($("#pass").val().length < 1){
      $('#pass').after('<span class="error">This field is required</span>');
      error_free = false;
    }
    if (!error_free){
      event.preventDefault();
    }
  });

  
  $("#CreateAccountForm").submit(function(event){

//	event.preventDefault();
    var error_free = true;
    $(".error").remove();   // prevents error message from accumulating when submit button is clicked
    if($("#firstName").val().length < 1 || $("#firstName").hasClass("invalid")){
      $('#firstName').after('<span class="error">This field is required</span>');
      error_free = false;
    }
    if($("#lastName").val().length < 1 || $("#lastName").hasClass("invalid")){
      $('#lastName').after('<span class="error">This field is required</span>');
      error_free = false;
    }
    if($("#address").val().length < 1 || $("#address").hasClass("invalid")){
      $('#address').after('<span class="error">This field is required</span>');
      error_free = false;
    }
    if($("#dob").val() == "" || $("#dob").hasClass("invalid")){
        $('#dob').after('<span class="error">This field is required</span>');
        error_free = false;
      }    
    if($("#email").val().length < 1 || $("#email").hasClass("invalid")){
      $('#email').after('<span class="error">This field is required</span>');
      error_free = false;
    } 
    if($("#license").val().length < 1 || $("#license").hasClass("invalid")){
      $('#license').after('<span class="error">This field is required</span>');
      error_free = false;
    } 
    if($("#ssn").val().length < 1 || $("#ssn").hasClass("invalid")){
      $('#ssn').after('<span class="error">This field is required</span>');
      error_free = false;
    }    
    if($("#username").val().length < 1 || $("#username").hasClass("invalid")){
      $('#username').after('<span class="error">This field is required</span>');
      error_free = false;
    }
    if($("#password").val().length < 1 || $("#password").hasClass("invalid")){
      $('#password').after('<span class="error">This field is required</span>');
      error_free = false;
    }
    if($("#gender").val() == "" || $("#gender").hasClass("invalid")){
        $('#gender').after('<span class="error">This field is required</span>');
        error_free = false;
      }
    if($("#education").val() == "" || $("#education").hasClass("invalid")){
        $('#education').after('<span class="error">This field is required</span>');
        error_free = false;
      }    
    if($("#imageBrowse").val() == "" || $("#imageBrowse").hasClass("invalid")){
        $('#imageBrowse').after('<span class="error">This field is required</span>');
        error_free = false;
      }
    
    if (!error_free){
      event.preventDefault();
    }
  });

  

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
});

	/*	
	// Comment Section Here....
	
					<tr>
						<td style="float: left; width: 50%; margin-top: 10px"></td>
						<td style="float: left; width: 50%; margin-top: 10px"><input
							type="text" class="form-control" id="response"
							placeholder="base64 value"></td>
					</tr>
	
	 */
</script>
</html>














