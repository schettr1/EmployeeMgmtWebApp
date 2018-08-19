package com.s3s.jsp.dao;

import com.s3s.jsp.model.Login;
import com.s3s.jsp.model.Consultant;

public interface ILoginDao {

	public Login createLogin(Login login);
	
	public boolean deleteLogin(int id);

	public Login getConsultantType(Login login);
	
	public Login update_Login(Login login);
	
	public Login getConsultantBy_ID(Login login);
	
	public Login update_LoginByCoordinator(Login login);
	
	public Login getLoginBy_Username(Login login);
}
