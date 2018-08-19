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
<%@ page import="java.io.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ include file="header.jsp"%>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<jsp:useBean id="login" class="com.s3s.jsp.model.Login" scope="session" />
<jsp:useBean id="consultant" class="com.s3s.jsp.model.Consultant" />
<jsp:useBean id="loginservice" class="com.s3s.jsp.services.LoginService"
	scope="page" />
<jsp:useBean id="consultantservice"
	class="com.s3s.jsp.services.ConsultantService" scope="page" />
</head>
<body>

	<%
	
		String UP = session.getAttribute("LoggedInUser").toString();
		System.out.println("emailConfirmation Page: UP = " + UP);
		String[] UPs = UP.split(" ");

		String username = UPs[0];
		String password = UPs[1]; 

		System.out.println("emailConfirmation page: username = " + username);
		System.out.println("emailConfirmation page: password = " + password);
		
		

		String receiverEmail = request.getParameter("emailAddress");
		String subject = request.getParameter("subject");
		String message = request.getParameter("message");
		
 		login.setUsername(username);
		login.setPassword(password);  
		Login checkLogin = new Login();
		checkLogin = loginservice.getLoginByUsername(login);
		consultant = consultantservice.getConsultantById(checkLogin.getU_id()); 

		String senderEmail = consultant.getEmail();
		String Password = "333Network";
		
		if(request.getParameter("emailAddress").isEmpty() || request.getParameter("subject").isEmpty()  || request.getParameter("message").isEmpty()){
			System.out.println("IncompleteForm submitted!");
			request.getSession().setAttribute("ImcompleteForm", "ImcompleteForm");
			response.sendRedirect(request.getContextPath() + "/pages/email.jsp");
		}
		else{
			
			System.out.println("request.getParameter(emailAddress) : " + request.getParameter("emailAddress"));
			System.out.println("request.getParameter(subject) : " + request.getParameter("subject"));
			System.out.println("request.getParameter(message) : " + request.getParameter("message"));
			String hostName = "smtp.gmail.com";
			int portNo = 465;
	//		String fromName = consultant.getFileName() + " " + consultant.getLastName();
	//		System.out.println("emailConfirmation page: consultant.getFileName() = " + "  consultant.getFileName() = " + consultant.getLastName());
			
		
			try{
				
				// SMTPAuthentiation() IS NOT REQUIRED FOR GMAIL. HOWEVER, YOU NEED TO TURN ON SECURITY SETTING IN GMAIL ACCOUNT:
				Properties property = new Properties();
			 	property.setProperty("mail.smtp.host", "smtp.gmail.com");
			 	property.setProperty("mail.smtp.port", "465");
			 	property.setProperty("mail.smtp.user", senderEmail);
			 	property.setProperty("mail.smtp.auth", "true"); // enable auth
			 	property.setProperty("mail.user",senderEmail);
			 	property.setProperty("mail.password", Password);
			 	property.setProperty("mail.smtp.starttls.enable", "true"); // enable TLS
			 	property.setProperty("mail.debug", "true");
			 	property.setProperty("mail.smtp.debug", "true");
			 	
				// create session for the properties
				Session emailSession = Session.getInstance(property);
				emailSession.setDebug(true);
				
				try{
					// Create mime style email message object to obtain html style message
					MimeMessage MimeMsg = new MimeMessage(emailSession);
					MimeMsg.setFrom(new InternetAddress(senderEmail));
					MimeMsg.addRecipient(Message.RecipientType.TO, new InternetAddress(receiverEmail));
					MimeMsg.setText(message);
		//			MimeMsg.setContent(message, "html/text");
					MimeMsg.setText(message);
					MimeMsg.setSubject(subject);
				
					// Use Transport to send the MimeMessage
					Transport transport = emailSession.getTransport("smtps");	
					transport.connect("smtp.gmail.com", 465, senderEmail, Password );
					transport.sendMessage(MimeMsg, MimeMsg.getAllRecipients());
					System.out.println("messege delivered successfully");
					
					request.getSession().setAttribute("MessagingSuccessful", "");
					response.sendRedirect(request.getContextPath() + "/pages/email.jsp");
					
					transport.close();
				}catch(MessagingException mex){
					System.out.println("MESSAGE_NOT_SENT");
					request.getSession().setAttribute("MESSAGE_NOT_SENT", "");
					response.sendRedirect(request.getContextPath() + "/pages/email.jsp");
				}
			}catch(Exception e){
				System.out.println("FILE_NOT_FOUND");
				request.getSession().setAttribute("FILE_NOT_FOUND", "");
				response.sendRedirect(request.getContextPath() + "/pages/email.jsp");
			}
		}
	%>
	
</body>
</html>