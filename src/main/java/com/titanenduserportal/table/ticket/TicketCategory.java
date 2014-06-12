package com.titanenduserportal.table.ticket;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ticketCategory")
public class TicketCategory {
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "ticketCategoryId", unique = true, nullable = false)
	public Integer ticketCategoryId;

	public String name;
}
