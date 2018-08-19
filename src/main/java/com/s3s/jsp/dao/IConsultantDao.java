package com.s3s.jsp.dao;

import java.util.List;

import com.s3s.jsp.model.Consultant;

/**
 * This is for CRUD operation related to User.
 * @author Surya Chettri
 * @since Feb 10, 2018
 */
public interface IConsultantDao {

	/**
	 * Retrieves user by given id
	 * @param id of the user
	 * @return User
	 */
	public Consultant getConsultantBy_Id(int id);
	
	/**
	 * create user 
	 * @param user
	 * @return 
	 */
	public Consultant create(Consultant consultant);
	
	/**
	 * @param id
	 * @return
	 */
	public boolean delete(int id);
	
	/**
	 * @param user
	 * @return
	 */
	public Consultant update(Consultant consultant);
	
	/**
	 * @return
	 */
	List<Consultant> getAll();
	
	/**
	 * @param user
	 * @return
	 */
	public Consultant updateByCoordinator(Consultant consultant);
	
	/**
	 * @param id
	 * @return
	 */
	public boolean activate_UserByID(int id);
	
	/**
	 * @param id
	 * @return
	 */
	public boolean getConsultantby_Username(String username);
	
	/**
	 * @param id
	 * @return
	 */
	public Consultant getConsultant_ID(String username);
	
	/**
	 * @param id
	 * @return
	 */
	public boolean updateConsultant_FileName(Consultant consultant);
}
