package com.s3s.jsp.services;

import com.s3s.jsp.dao.LoginDao;
import com.s3s.jsp.model.Login;

public class LoginService implements ILoginService {

	LoginDao logindao;

	public LoginService() {
		this.logindao = new LoginDao();
	}

	/**
	 * {@inheritDoc}
	 */
	@Override
	public Login createLogin(Login login) {
		return logindao.createLogin(login);
	}

	@Override
	public Login getConsultant_Type(Login login) {
		
		return logindao.getConsultantType(login);
	}

	@Override
	public Login updateLogin(Login login) {

		return logindao.update_Login(login);
	}

	@Override
	public Login getConsultantByID(Login login) {

		return logindao.getConsultantBy_ID(login);
	}

	@Override
	public Login updateLoginbyCoordinator(Login login) {

		return logindao.update_LoginByCoordinator(login);
	}

	@Override
	public Login getLoginByUsername(Login login) {

		return logindao.getLoginBy_Username(login);
	}
	
}
