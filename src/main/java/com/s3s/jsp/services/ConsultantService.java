package com.s3s.jsp.services;

import java.util.List;

import com.s3s.jsp.dao.ConsultantDao;
import com.s3s.jsp.model.Consultant;

public class ConsultantService implements IConsultantService {

	ConsultantDao consultantDao;

	public ConsultantService() {
		this.consultantDao = new ConsultantDao();
	}

	public Consultant getConsultantById(int id) {

		return consultantDao.getConsultantBy_Id(id);
	}

	public Consultant updateConsultant(Consultant consultant) {

		return consultantDao.update(consultant);
	}

	public boolean deleteConsultant(int id) {

		return consultantDao.delete(id);
	}

	public Consultant createConsultant(Consultant consultant) {

		return consultantDao.create(consultant);
	}

	public List<Consultant> getAllConsultants() {

		return consultantDao.getAll();
	}

	public void updateApplicant(Consultant consultant) {

		consultantDao.updateApplicant(consultant);
	}
	
	@Override
	public Consultant updateConsultantbyCoordinator(Consultant consultant) {

		return consultantDao.updateByCoordinator(consultant);
	}

	@Override
	public boolean activateUserByID(int id) {

		return consultantDao.activate_UserByID(id);
	}

	@Override
	public boolean getConsultantbyUsername(String username) {
		
		return consultantDao.getConsultantby_Username(username);
	}

	@Override
	public Consultant getConsultantID(String username) {

		return consultantDao.getConsultant_ID(username);
	}

	@Override
	public boolean updateConsultantFileName(Consultant consultant) {

		return consultantDao.updateConsultant_FileName(consultant);
	}

}
