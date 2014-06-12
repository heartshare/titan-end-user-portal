package com.titanenduserportal.table.ticket;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "ticket")
public class Ticket {
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "ticketId", unique = true, nullable = false)
	Integer ticketId;

	String header;

	@OneToOne(cascade = CascadeType.ALL, mappedBy = "ticket")
	TicketCategory category;
}
