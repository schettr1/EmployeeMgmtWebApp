package com.s3s.jsp.dao;

import java.util.List;

import com.s3s.jsp.model.Payment;

public interface IPaymentDao {

	/**
	 * {@inheritDoc}
	 */
	public List<Payment> getPaymentBy_Id(float id);
	
	/**
	 * {@inheritDoc}
	 */

	public boolean delete_Payment(float id);
	
	/**
	 * {@inheritDoc}
	 */
	public Payment create_Payment(Payment payment);
	
	/**
	 * {@inheritDoc}
	 */
	public List<Payment> get_AllPayments();


}
