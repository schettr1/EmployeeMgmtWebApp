$(document).ready(function() {
	$("#enableUser").click(function() {
		enableUserByIDs();
	});

	$("#adminHome").click(function() {
		returnAdminHome();
	});
	$("#adminMainMenu").click(function() {
		adminMainPage();
	});
	$("#MainPage").click(function() {
		mainPage();
	});
});


function enableUserByIDs() {
	var checkedArray = [];
	$(".idClass:checked").each(function() {
		alert($(this).val()); // display selected checkbox value
		checkedArray.push($(this).val());
	});
	var selected;
	selected = checkedArray.join(',');

	window.location = "./activateUser.jsp?selected=" + selected;
}

function returnAdminHome(){
	var User = $("#Username").text();
	var Pass = $("#Password").text();
	alert(User + " " + Pass);
	window.location = "./MainPage.jsp?username=" + User + "&password=" + Pass;
}

function adminMainPage(){
	var str = $("#adminKey").val();
    var s = str.split(" ");
    alert(s[0]);
    var username = s[0];
    var password = s[1];
    
    window.location = "./MainPage.jsp?username=" + username + "&password=" + password;     
}

function mainPage(){
	var str = $("#Key").val();
    var s = str.split(" ");
      alert(s[0]);
    var username = s[0];
    var password = s[1];
    
    window.location = "./MainPage.jsp?username=" + username + "&password=" + password;     

}


//**********************************************************************************

// AJAX : (Sending request from jQuery to JSP page)
// It will only update the values, it will not redirect to the next page. 
// You must use ***window.location = "./loginDetail.jsp?username=" + User + "&password=" + Pass; ***
// to go to next page. 

//INSIDE JQUERY/SCRIPT TAGS:
/*var value = thisValue; 
$.ajax({
  type: "post",
  url: "/Program.jsp", 
  data: {"key":value}, //pass this parameter like this then you will be able to get it there
  success: function(data) {
    alert("success");
  },
  error:function (xhr, ajaxOptions, thrownError){
    alert("error"); 
    alert(xhr.status);
    alert(thrownError);
  }  
  //   return value;
  //also check return false at bottom;
});


// INSIDE DESTINATION PAGE:
*	String value = request.getParameter("key");
*
*/
//*********************************************************************************************
/*	$("#listAll").click(function() {
sendString();
});*/
/*function sendString(){
	var User = $("#Username").text();
	var Pass = $("#Password").text();
	var UserPass = User + " " + Pass;
	
//	alert("User&Pass: " + UserPass);
	
	window.location = "./listAll.jsp?UserPass=" + UserPass;
}*/

