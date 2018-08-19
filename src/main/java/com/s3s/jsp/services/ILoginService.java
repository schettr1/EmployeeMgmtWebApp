package com.s3s.jsp.services;

import com.s3s.jsp.model.Login;

public interface ILoginService {

	public Login createLogin(Login login);
	
	public Login getConsultant_Type(Login login);
	
	public Login updateLogin(Login login);
	
	public Login getConsultantByID(Login login);
	
	public Login updateLoginbyCoordinator(Login login);
	
	public Login getLoginByUsername(Login login);
}
