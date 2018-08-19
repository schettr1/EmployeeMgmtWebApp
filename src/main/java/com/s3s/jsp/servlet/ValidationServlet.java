package com.s3s.jsp.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.s3s.jsp.model.Consultant;
import com.s3s.jsp.model.Login;
import com.s3s.jsp.services.ConsultantService;
import com.s3s.jsp.services.LoginService;

@MultipartConfig(maxFileSize = 16177215) // upload file's size up to 16MB
public class ValidationServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final int BUFFER_SIZE = 4096;
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String address = request.getParameter("address");
		String email = request.getParameter("email");
		String license = request.getParameter("license");
		String dob = request.getParameter("dob");
		String ssn = request.getParameter("ssn");
		
		System.out.println("ssn length" + ssn.length());
		// check if SSN has letters or characters other than numbers

		boolean SSNisValid = true;
		for (int i = 0; i < ssn.length(); i++){
			if (!ssn.substring(i, i + 1).matches("[0-9]")) {
				SSNisValid = false;
				System.out.println("SSNisValid: " + SSNisValid);
			}
		}

		if(ssn.length()==9 && SSNisValid){
			
			String gender = request.getParameter("gender");
			String education = request.getParameter("education");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String jobTitle = "Consultant";
			Part part = request.getPart("image");
			System.out.println("Part name: " + part.toString()); 
	
			/*	Check if username is already in use */
			ConsultantService consultantservice = new ConsultantService();
			if(consultantservice.getConsultantbyUsername(username)){
				System.out.println("Username exists already."); 
				request.getSession().setAttribute("InvalidUsername", "InvalidUsername");
				response.sendRedirect(request.getContextPath() + "/index.jsp");
			} 
			else{
				System.out.println("New Username.");				
				// check if password has lowercase letter, uppercase letter and a number
				boolean upperCaseMatch = false;
				boolean lowerCaseMatch = false;
				boolean numberMatch = false;
				for (int i = 0; i < password.length(); i++) {
					// System.out.println(password.substring(i,i+1)); // print the
					// substrings of password
					if (password.substring(i, i + 1).matches("[a-z]")) {
						upperCaseMatch = true;
					}
					if (password.substring(i, i + 1).matches("[A-Z]")) {
						lowerCaseMatch = true;
					}
					if (password.substring(i, i + 1).matches("[0-9]")) {
						numberMatch = true;
					}
				}
				if (firstName.isEmpty() || lastName.isEmpty() || address.isEmpty() || dob.isEmpty() || email.isEmpty()|| 
						license.isEmpty() || ssn.isEmpty() || username.isEmpty() || password.isEmpty()) { 
					System.out.println("All fileds are missing!"); 
					request.getSession().setAttribute("FieldMissing", "FieldMissing.");
					response.sendRedirect(request.getContextPath() + "/index.jsp");
				}
				else if ((upperCaseMatch == false) || (lowerCaseMatch == false) || (numberMatch == false) || (password.length() < 6)) {
					System.out.println("Invalid password!"); 
					request.getSession().setAttribute("InvalidPassword", "InvalidPassword");
					response.sendRedirect(request.getContextPath() + "/index.jsp");
				} 
				else {
					
					Consultant consultant = new Consultant();
					Login login = new Login();
					consultant.setFirstName(request.getParameter("firstName"));
					consultant.setLastName(request.getParameter("lastName"));
					consultant.setAddress(request.getParameter("address"));
					consultant.setEmail(request.getParameter("email"));
					consultant.setLicense(request.getParameter("license"));
					consultant.setSSN(request.getParameter("ssn"));
					consultant.setDOB(request.getParameter("dob"));
					consultant.setEducation(education);
					consultant.setGender(request.getParameter("gender"));
					consultant.setPosition("Consultant");
					consultant.setStatus("active");
					consultant.setApplicant("true");
					login.setUsername(request.getParameter("username"));
					login.setPassword(request.getParameter("password"));
					
					consultantservice.createConsultant(consultant);		// create new user
					
					LoginService loginservice = new LoginService();
					loginservice.createLogin(login);
					
					Consultant registeredConsultant = new Consultant();		
					registeredConsultant = consultantservice.getConsultantID(username);  // retrieve ID of consultant by using username
					
					System.out.println("registeredConsultant ID: " + registeredConsultant.getId());
						
					String fileName = extractFileName(part); // returns only extension name
					System.out.println("After trimming, fileName : " + fileName);
					fileName = registeredConsultant.getId() + fileName;		
					System.out.println("After adding ID, fileName : " + fileName);
					
					// Specify the location or path of the file using filePath.
					// NOTE: Here, '\' must be replaced with '\\'
					String filePath = "C:\\Users\\Surya Chettri\\Desktop\\JAVA_eclipse\\GoldTeamProject\\src\\main\\webapp\\Images\\" + fileName;
					System.out.println("filePath: " + filePath); 
					
					registeredConsultant.setFileName(fileName);
					registeredConsultant.setFilePath(filePath);
					consultantservice.updateConsultantFileName(registeredConsultant);
												
					// Writing file to disk
			 		InputStream inputStream1 = part.getInputStream(); 	// This code will convert 'Part' to inputStream
					OutputStream outputStream = new FileOutputStream(filePath);
					int bytesRead = -1;
					byte[] buffer = new byte[BUFFER_SIZE];
					while ((bytesRead = inputStream1.read(buffer)) != -1) {
						outputStream.write(buffer, 0, bytesRead);
					}
					inputStream1.close();
					outputStream.close();
					System.out.println("File saved");
					
					/* Registration Successful */
					// request.getSession().setAttribute("NewConsultantID", registeredConsultant.getId());
					request.getSession().setAttribute("SuccessfulRegistration", "SuccessfulRegistration");
					response.sendRedirect(request.getContextPath() + "/index.jsp");
				}
			}
		}

		else{
			request.getSession().setAttribute("InvalidSSN", "InvalidSSN");
			response.sendRedirect(request.getContextPath() + "/index.jsp");		
		}
	}

	
	
	
	//************************************** END OF MAIN METHOD *******************************************
	
	
	// this method will extract the extension name only from filePath.
	private String extractFileName(Part part) {

		String contentDispo = part.getHeader("content-disposition");
		String[] items = contentDispo.split(";");
		for (String s : items) {
			System.out.println("Before Trim: " + s);
			if (s.trim().startsWith("filename")) {
				System.out.println("Before trimimg fileName: " + s);
				return s.substring(s.indexOf('.'), s.length() - 1); // From the filePath, select the string that is after the last '\\'
			}
		}
		return "";
	}
	

}
