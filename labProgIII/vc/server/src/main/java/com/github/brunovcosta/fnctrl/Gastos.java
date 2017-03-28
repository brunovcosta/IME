package com.github.brunovcosta.fnctrl;

import java.util.Date;

public class Gastos {
	private String userName;
	private Date createdAt;
	private String description;
	private int amount;

	public Gastos(
		String userName,Date createdAt,
		String description, int amount)
	{
		this.userName = userName;
		this.createdAt = createdAt;
		this.description = description;
		this.amount = amount;

	}
	public String getUserName(){
		return this.userName;
	}
	public Date getCreatedAt(){
		return this.createdAt;
	}
	public String getDescription(){
		return this.description;
	}
	public int getAmount(){
		return this.amount;
	}

	@Override
	public String toString(){
		return "{"+
			"userName: \""+userName+
			"\",createdAt: \""+createdAt+
			"\",description: \""+description+
			"\",amount: "+amount+
		"}";
	}
}
