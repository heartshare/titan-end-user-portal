package com.titanenduserportal.table.ticket;

import static javax.persistence.GenerationType.IDENTITY;

import java.io.File;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.titanenduserportal.table.User;

@Entity
@Table(name = "ticket")
public class Ticket {
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "ticketId", unique = true, nullable = false)
	public Integer ticketId;

	public String header;

	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "ticketCategoryId")
	public TicketCategory category;

	public String subject;
	public String message;

	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "userId")
	public User user;

	public File attachment1;
	public File attachment2;
	public File attachment3;
}
