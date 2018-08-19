package com.s3s.jsp.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.s3s.jsp.model.Login;
import com.s3s.jsp.model.Consultant;

public class LoginDao implements ILoginDao {

	public static void main(String[] args) {
		Login login;
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
					"Unable to connect to database. Please check database connectivity port number, username or password is right.");
		}
		return conn;
	}

	public Login createLogin(Login login) {

		Connection conn = getConnection();

		// determine the last id of user
		String query1 = "select * from consultant";
		int lastKey = 0;
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query1);
			while (rs.next()) {
				lastKey = rs.getInt("id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		// insert login credentials to login table in db
		String query = "insert into login (username, password, u_id) values (?,?,?)";
		int primaryKey = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, login.getUsername());
			pstmt.setString(2, login.getPassword());
			pstmt.setInt(3, lastKey);
			primaryKey = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return login;
	}

	public boolean deleteLogin(int id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Login getConsultantType(Login login) {

		Login login1 = new Login();
		String query = " select * from login where username = '" + login.getUsername() + "' AND password = '"
				+ login.getPassword() + "'";
		Connection conn = getConnection();
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			if (rs.next()) {
				login1.setUsername(rs.getString("username"));
				login1.setPassword(rs.getString("password"));
				login1.setU_id(rs.getInt("u_id"));
			} else {
				login1.setUsername(null);
				login1.setPassword(null);
				login1.setU_id(0);
			}
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		 System.out.println("LoginDao-> username:" + login1.getUsername() + "password:" + login1.getPassword());
		return login1;

	}

	@Override
	public Login update_Login(Login login) {
		
		String query = "update login set password = ? where u_id =" + login.getU_id();
		Connection conn = getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, login.getPassword());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return login;
	}

	@Override
	public Login getConsultantBy_ID(Login login) {

		Login login1 = new Login();
		String query = " select * from login where u_id = "	+ login.getU_id();
		Connection conn = getConnection();
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			if (rs.next()) {
				login1.setUsername(rs.getString("username"));
				login1.setPassword(rs.getString("password"));
				login1.setU_id(rs.getInt("u_id"));
			} else {
				login1.setUsername(null);
				login1.setPassword(null);
				login1.setU_id(0);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return login1;
	}

	@Override
	public Login update_LoginByCoordinator(Login login) {

		String query = "update login set username = ?, password = ? where u_id =" + login.getU_id();
		Connection conn = getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, login.getUsername());
			pstmt.setString(2, login.getPassword());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return login;
		
	}

	@Override
	public Login getLoginBy_Username(Login login) {

		String query = "select * from login";
		Connection conn = getConnection();
		Login updatedlogin = new Login();
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				if(login.getUsername().equals(rs.getString("username"))){
					updatedlogin.setU_id(rs.getInt("u_id"));
					updatedlogin.setUsername(rs.getString("username"));
					updatedlogin.setPassword(rs.getString("password"));
					System.out.println("LoginDao : updatedlogin.getPassword() " + updatedlogin.getPassword());
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return updatedlogin;
		
	}
	
}
