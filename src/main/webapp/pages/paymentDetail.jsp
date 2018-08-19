<html>
<head>
<title>User Detail Page</title>
<%@ page import="com.s3s.jsp.model.*, com.s3s.jsp.services.*"%>
<%@ include file="header.jsp"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.io.output.*"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.LocalDateTime"%>

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
	<jsp:useBean id="consultant" class="com.s3s.jsp.model.Consultant" />
<jsp:useBean id="login" class="com.s3s.jsp.model.Login" />
<jsp:useBean id="payment" class="com.s3s.jsp.model.Payment" />
<jsp:useBean id="paymentService"
	class="com.s3s.jsp.services.PaymentService" scope="page" />
<jsp:useBean id="loginservice" class="com.s3s.jsp.services.LoginService"
	scope="page" />
<jsp:useBean id="consultantservice" class="com.s3s.jsp.services.ConsultantService"
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
		
		/* Payment Form Info. */
		File file;
		int maxFileSize = 5000 * 1024;
		int maxMemSize = 5000 * 1024;
		ServletContext context = pageContext.getServletContext();
		String filePath = context.getInitParameter("file-path-from-web.xml");	// you are getting this path from web.xml file
		String filename = null;
		// Verify the content type

		String firstName = null, lastName = null, type = null, date = null, employeeID = null, amount = null,
				fileName = null; // declare variables in String

		String contentType = request.getContentType();
		if ((contentType.indexOf("multipart/form-data") >= 0)) {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// maximum size that will be stored in memory
			factory.setSizeThreshold(maxMemSize);

			// Location to save data that is larger than maxMemSize.
			factory.setRepository(new File("c:\\temp"));

			// Create a new file upload handler
			ServletFileUpload upload = new ServletFileUpload(factory);

			// maximum file size to be uploaded.
			upload.setSizeMax(maxFileSize);

			try {
				// Parse the request to get file items.
				List fileItems = upload.parseRequest(request);

				// Process the uploaded file items
				Iterator itr = fileItems.iterator();

				while (itr.hasNext()) {
					FileItem fileItem = (FileItem) itr.next();
					if (fileItem.isFormField()) {
						// Get the uploaded file parameters
						if (fileItem.getFieldName().equals("employeeID")) {
							employeeID = fileItem.getString();					
							System.out.println(employeeID);
						}
						if (fileItem.getFieldName().equals("firstName")) {
							firstName = fileItem.getString();
							System.out.println(firstName);
						}
						if (fileItem.getFieldName().equals("lastName")) {
							lastName = fileItem.getString();
							System.out.println(lastName);
						}
						if (fileItem.getFieldName().equals("amount")) {
							amount = fileItem.getString();
							System.out.println(amount);
						}
						if (fileItem.getFieldName().equals("type")) {
							type = fileItem.getString();
							System.out.println(type);
						}
						if (fileItem.getFieldName().equals("date")) {
							date = fileItem.getString();
							System.out.println("Date: " + date);
						}
					} else {

						DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
						LocalDateTime now = LocalDateTime.now();
						System.out.println("Current Date: " + dtf.format(now));

						if (fileItem.getFieldName().equals("file") && type.equals("check")) {
							fileName = fileItem.getName();
							fileName = employeeID + "_CheckNo_" + dtf.format(now)
									+ fileName.substring(fileName.indexOf('.'), fileName.length()); // prefix employee ID to check's file name							
							filename = fileName;
							System.out.println(fileName);

							boolean isInMemory = fileItem.isInMemory();
							long sizeInBytes = fileItem.getSize();

							if (fileName.lastIndexOf("\\") >= 0) {
								file = new File(
										filePath + File.separator + fileName.substring(fileName.lastIndexOf("\\")));
							} else {
								file = new File(filePath + File.separator
										+ fileName.substring(fileName.lastIndexOf("\\") + 1));
							}
							fileItem.write(file); // Write the file
							System.out.println("Uploaded FilePath: " + filePath + " </br>" + "FileName: " + fileName);
						}
					}
				}

			} catch (Exception ex) {
				System.out.println(ex);
			}
		} else {
			out.println("Unable to upload file(s).");
		}

		payment.setEmployeeID(Integer.valueOf(employeeID));
		payment.setFirstName(firstName);
		payment.setLastName(lastName);
		payment.setAmount(Integer.valueOf(amount));
		payment.setType(type);
		payment.setDate(date);
		System.out.println(" paymentDetail.jsp -payment.getDate()" + payment.getDate());
		payment.setFileName(filename);
		// Send user to record in db
		Payment returnPayment = new Payment();
		returnPayment = paymentService.createPayment(payment);
	//	String adminKey = request.getSession().getAttribute("adminKey").toString();
	//	String LoggedInUser = request.getSession().getAttribute("LoggedInUser").toString();
	%>

	<div class="container wrapper">
		<div style="float:right" class="text-info"> <a id="home" href="MainPage.jsp" class="glyphicon glyphicon-home"></a> &nbsp | &nbsp 
			<span><i class="glyphicon glyphicon-user"><%=consultant.getFirstName() + consultant.getLastName() %></i></span>&nbsp | &nbsp
			<span><a id="logout" href="../index.jsp" >Sign out</a></span>
		</div>
		<div align="center">
			<h2>Payment Receipt:</h2>
		</div>
		<div class="container" style="margin-top: 50px">
			<table class="table table-hover">
				<tr>
					<td><b>EmployeeID :</td>
					<td><%=returnPayment.getEmployeeID()%></td>
				</tr>
				<tr>
					<td><b>FirstName :</td>
					<td><%=returnPayment.getFirstName()%></td>
				</tr>
				<tr>
					<td><b>LastName :</td>
					<td><%=returnPayment.getLastName()%></td>
				</tr>
				<tr>
					<td><b>Amount :</td>
					<td><%=returnPayment.getAmount()%></td>
				</tr>
				<tr>
					<td><b>Type :</td>
					<td><%=returnPayment.getType()%></td>
				</tr>
				<tr>
					<td><b>Date :</td>
					<td><%=returnPayment.getDate()%></td>
				</tr>
			</table>
			<a style="float: left; margin-left: 10px; visibility:hidden; width:0" href="#"><input
				class="btn btn-info" id="adminKey" type="text" value="<%=LoggedInUser%>">
			</a>

		</div>
	</div>
	</br>
	</br>
	<div class="push"></div>
	<div class="footer">
		<%@ include file="footer.jsp"%>	
	</div>

</body>
</html>
