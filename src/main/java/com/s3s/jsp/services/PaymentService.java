package com.s3s.jsp.services;

import java.util.List;

import com.s3s.jsp.dao.ConsultantDao;
import com.s3s.jsp.dao.PaymentDao;
import com.s3s.jsp.model.Payment;

public class PaymentService implements IPaymentService {

	PaymentDao paymentDao;
	
	public PaymentService() {
		this.paymentDao = new PaymentDao();
	}
	
	@Override
	public List<Payment> getPaymentById(float id) {
		return paymentDao.getPaymentBy_Id(id);
	}

	@Override
	public boolean deletePayment(float id) {
		return paymentDao.delete_Payment(id);
	}

	@Override
	public Payment createPayment(Payment payment) {
		return paymentDao.create_Payment(payment);
	}

	@Override
	public List<Payment> getAllPayments() {
		return paymentDao.get_AllPayments();
	}

}
