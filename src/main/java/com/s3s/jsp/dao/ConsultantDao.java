package com.s3s.jsp.dao;

import java.io.FileOutputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Part;

import com.s3s.jsp.model.Login;
import com.s3s.jsp.model.Consultant;
import com.s3s.jsp.services.LoginService;

/**
 * CRUD operations is done using UserDao class
 * @author Surya Chettri
 * @since Mar. 10, 2018
 */
public class ConsultantDao implements IConsultantDao {

//	private String fileName = null;

	
	public static void main(String[] args) {
		
		// main method
	}

	public static Connection getConnection() {

		String userName = "root";
		String password = "222Network";
		String url = "jdbc:mysql://localhost:3306/s3s.feb.projects";
		Connection conn = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, userName, password);
		} catch (ClassNotFoundException e) {
			System.out.println("Driver class not found to load.");
		} catch (SQLException e) {
			System.out.println(
					"Unable to connect to database. Check the database connectivity. Please verify the port number, username or password.");
		}
		return conn;
	}
	
/*	private String extractFileName(String filePath) {

		return filePath.substring(filePath.lastIndexOf("\\") + 1, filePath.length() - 1); 

	}*/
	
	public Consultant create(Consultant consultant) {
		System.out.println(consultant.toString());
//		fileName = extractFileName(consultant.getImage());
		
		String query = "insert into consultant (firstName, lastName, address, dob,  email, license, ssn, gender, education, position, status, applicant, fileName, filePath) values (?,?,?,?,?,?,?,?,?,?,?,?,?,? )";
		Connection conn = getConnection();
		int primaryKey = 0;
		
		try {
//			System.out.println("Beginning of Writing to DB ");
			PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, consultant.getFirstName());
			pstmt.setString(2, consultant.getLastName());
			pstmt.setString(3, consultant.getAddress());
			pstmt.setString(4, consultant.getDOB());
			pstmt.setString(5, consultant.getEmail());
			pstmt.setString(6, consultant.getLicense());
			pstmt.setString(7, consultant.getSSN());
			pstmt.setString(8, consultant.getGender());
			pstmt.setString(9, consultant.getEducation());
			pstmt.setString(10, consultant.getPosition());
			pstmt.setString(11, consultant.getStatus());
			pstmt.setString(12, consultant.getApplicant());

//			System.out.println("Middle1 of Writing to DB ");
			consultant.setId(primaryKey); 
			
//			System.out.println("consultant.getImage(): " + consultant.getImage());
			
			if (consultant.getFilePath() != null || consultant.getFilePath() != "") {
				// getImage() method contains filePath of the file/photo. Its data type is String.
//				System.out.println("fileName : " + fileName); 
//				System.out.println("Middle2 of Writing to DB ");
				pstmt.setString(13, consultant.getFileName());
				pstmt.setString(14, consultant.getFilePath());
			}
			// sends the statement to the database server
			primaryKey = pstmt.executeUpdate();
			
			System.out.println("End of Writing to DB ");
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		return consultant;
	}

	public Consultant getConsultantBy_Id(int id) {

		String query = "select * from consultant where id = " + id;
		Connection conn = getConnection();
		Consultant consultant = null;

		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				consultant = new Consultant();
				consultant.setId(rs.getInt("id"));
				consultant.setFirstName(rs.getString("firstName"));
				consultant.setLastName(rs.getString("lastName"));
				consultant.setAddress(rs.getString("address"));
				consultant.setDOB(rs.getString("dob"));
				consultant.setEmail(rs.getString("email"));
				consultant.setLicense(rs.getString("license"));
				consultant.setSSN(rs.getString("ssn"));
				consultant.setGender(rs.getString("gender"));
				consultant.setEducation(rs.getString("education"));
				consultant.setPosition(rs.getString("position"));
				consultant.setStatus(rs.getString("status"));
				consultant.setApplicant(rs.getString("applicant"));
				consultant.setFileName((rs.getString("fileName")));
				consultant.setFilePath((rs.getString("filePath")));
				break;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(consultant.getId());
		return consultant;
	}
	
	// delete user means de-activating the user account
	public boolean delete(int id) {

		String query = "update consultant set status = ? where id = " + id;
		Connection conn = getConnection();
		boolean result = false;
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, "inactive");
			pstmt.executeUpdate();
			result = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	// Limited Update by user
	public Consultant update(Consultant consultant) {

		String query = "update consultant set address = ?, education = ? where id = "
				+ consultant.getId();
		Connection conn = getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, consultant.getAddress());
			pstmt.setString(2, consultant.getEducation());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return consultant;
	}

	
	public void updateApplicant(Consultant consultant){
		String query = "update consultant set applicant = ? where id = "
				+ consultant.getId();
		Connection conn = getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, consultant.getApplicant());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	public List<Consultant> getAll() {

		List<Consultant> consultantList = new ArrayList<>();
		String query = "select * from consultant";
		Connection conn = getConnection();
		Consultant consultant = null;

		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				consultant = new Consultant();
				consultant.setId(rs.getInt("id"));
				consultant.setFirstName(rs.getString("firstName"));
				consultant.setLastName(rs.getString("lastName"));
				consultant.setAddress(rs.getString("address"));
				consultant.setEmail(rs.getString("email"));
				consultant.setDOB(rs.getString("dob"));
				consultant.setGender(rs.getString("gender"));
				consultant.setLicense(rs.getString("license"));
				consultant.setSSN(rs.getString("ssn"));
				consultant.setPosition(rs.getString("position"));
				consultant.setEducation(rs.getString("education"));
				consultant.setStatus(rs.getString("status"));
				consultantList.add(consultant);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return consultantList;
	}

	@Override
	public Consultant updateByCoordinator(Consultant consultant) {

		String query = "update consultant set firstName = ?, lastName = ?, address = ?, dob = ?, email = ?, license = ?, ssn = ?, "
				+ "gender = ?, education = ?, position = ? where id = " + consultant.getId();
		Connection conn = getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, consultant.getFirstName());
			pstmt.setString(2, consultant.getLastName());
			pstmt.setString(3, consultant.getAddress());
			pstmt.setString(4, consultant.getDOB());
			pstmt.setString(5, consultant.getEmail());
			pstmt.setString(6, consultant.getLicense());
			pstmt.setString(7, consultant.getSSN());
			pstmt.setString(8, consultant.getGender());
			pstmt.setString(9, consultant.getEducation());
			pstmt.setString(10, consultant.getPosition());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return consultant;
	}

	@Override
	public boolean activate_UserByID(int id) {

		String query = "update consultant set status = ? where id = " + id;
		Connection conn = getConnection();
		boolean result = false;
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, "active");
			pstmt.executeUpdate();
			result = true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
		
	}

	@Override
	public boolean getConsultantby_Username(String username) {
		String query = "select * from login " ;
		Connection conn = getConnection();
		boolean consultantExists = false;

		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				if(username.equals(rs.getString("username"))){
					consultantExists = true;
				}
				
		//		System.out.println("Username already in use.");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return consultantExists;
	}

	@Override
	public Consultant getConsultant_ID(String username) {

		String query = "select * from consultant, login where consultant.id = login.u_id " ;
		Connection conn = getConnection();
		Consultant consultant = new Consultant();
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				if(username.equals(rs.getString("username"))){
					consultant.setId(rs.getInt("id"));
					System.out.println("consultant.getId : " + consultant.getId());
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return consultant;
		
	}

	@Override
	public boolean updateConsultant_FileName(Consultant consultant) {
		
		String query = "update consultant set fileName = ? , filePath = ? where id = " + consultant.getId();
		Connection conn = getConnection();
		boolean result = false;
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, consultant.getFileName());
			pstmt.setString(2, consultant.getFilePath());
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	

}