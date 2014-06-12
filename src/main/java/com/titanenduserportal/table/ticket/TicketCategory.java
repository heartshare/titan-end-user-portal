package com.titanenduserportal.table.ticket;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

public class TicketCategory {
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "ticketCategoryId", unique = true, nullable = false)
	Integer ticketCategoryId;

	String name;
}
