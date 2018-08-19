package com.s3s.jsp.dao;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.s3s.jsp.model.Consultant;
import com.s3s.jsp.model.Payment;

public class PaymentDao implements IPaymentDao {

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
	
	@Override
	public List<Payment> getPaymentBy_Id(float id) {
		
		String query = "select * from payment where p_id = " + id;
		Connection conn = getConnection();
		List<Payment> paymentList = new ArrayList<>();
		Payment payment = null;

		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				payment = new Payment();
				payment.setEmployeeID(rs.getInt("p_id"));
				payment.setFirstName(rs.getString("firstName"));
				payment.setLastName(rs.getString("lastName"));
				payment.setAmount(rs.getFloat("amount"));
				payment.setType(rs.getString("type"));
				payment.setDate(rs.getString("date"));
				payment.setTransactionID(rs.getInt("transactionID"));
				payment.setFileName(rs.getString("fileName"));
				paymentList.add(payment);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return paymentList;
	}

	@Override
	public boolean delete_Payment(float id) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Payment create_Payment(Payment payment) {

		String query = "insert into payment (firstName, lastName, amount, type, date, p_id, fileName) values (?,?,?,?,?,?,?)";
		Connection conn = getConnection();
		int primaryKey = 0;
	
		try {
//			System.out.println("Beginning of Writing to DB ");
			PreparedStatement pstmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, payment.getFirstName());
			pstmt.setString(2, payment.getLastName());
			pstmt.setFloat(3, payment.getAmount());
			pstmt.setString(4, payment.getType());
			pstmt.setString(5, payment.getDate());
			pstmt.setInt(6, payment.getEmployeeID());
			pstmt.setString(7,payment.getFileName());
			payment.setTransactionID(primaryKey); 
			primaryKey = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		return payment;
	}

	@Override
	public List<Payment> get_AllPayments() {
		List<Payment> paymentList = new ArrayList<>();
		String query = "select * from payment";
		Connection conn = getConnection();
		Payment payment = null;

		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				payment = new Payment();
				payment.setEmployeeID(rs.getInt("p_id"));
				payment.setFirstName(rs.getString("firstName"));
				payment.setLastName(rs.getString("lastName"));
				payment.setAmount(rs.getFloat("amount"));
				payment.setType(rs.getString("type"));
				payment.setDate(rs.getString("date"));
				payment.setTransactionID(rs.getInt("transactionID"));
				payment.setFileName(rs.getString("fileName"));
				paymentList.add(payment);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return paymentList;
	}
	
}
