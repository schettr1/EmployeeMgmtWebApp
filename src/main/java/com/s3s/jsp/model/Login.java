package com.s3s.jsp.model;

public class Login {

	private String username;
	private String password;
	private int u_id;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getU_id() {
		return u_id;
	}

	public void setU_id(int u_id) {
		this.u_id = u_id;
	}

	@Override
	public String toString() {
		return "Login [username=" + username + ", password=" + password + ", u_id=" + u_id + "] \n";
	}

}
