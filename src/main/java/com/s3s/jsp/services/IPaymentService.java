package com.s3s.jsp.services;

import java.util.List;

import com.s3s.jsp.model.Payment;

public interface IPaymentService {

	/**
	 * {@inheritDoc}
	 */
	public List<Payment> getPaymentById(float id);
	
	/**
	 * {@inheritDoc}
	 */

	public boolean deletePayment(float id);
	
	/**
	 * {@inheritDoc}
	 */
	public Payment createPayment(Payment payment);
	
	/**
	 * {@inheritDoc}
	 */
	public List<Payment> getAllPayments();


}

