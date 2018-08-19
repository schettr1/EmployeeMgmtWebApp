package com.s3s.jsp.services;

import java.util.List;

import com.s3s.jsp.model.Consultant;

public interface IConsultantService {
	
	/**
	 * {@inheritDoc}
	 */
	public Consultant getConsultantById(int id);
	
	/**
	 * {@inheritDoc}
	 */
	public Consultant updateConsultant(Consultant consultant);
	
	/**
	 * {@inheritDoc}
	 */
	public boolean deleteConsultant(int id);
	
	/**
	 * {@inheritDoc}
	 */
	public Consultant createConsultant(Consultant consultant);
	
	/**
	 * {@inheritDoc}
	 */
	public List<Consultant> getAllConsultants();

	/**
	 * {@inheritDoc}
	 */
	public Consultant updateConsultantbyCoordinator(Consultant consultant);
	
	/**
	 * {@inheritDoc}
	 */
	public boolean activateUserByID(int id);
	
	/**
	 * {@inheritDoc}
	 */
	public boolean getConsultantbyUsername(String username);
	
	/**
	 * {@inheritDoc}
	 */
	public Consultant getConsultantID(String username);

	/**
	 * {@inheritDoc}
	 */
	public boolean updateConsultantFileName(Consultant consultant);

	
}
