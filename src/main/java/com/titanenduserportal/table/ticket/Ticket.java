package com.titanenduserportal.table.ticket;

import static javax.persistence.GenerationType.IDENTITY;

import java.io.File;
import java.sql.Blob;

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

	public Blob attachment1;
	public Blob attachment2;
	public Blob attachment3;

	public Integer getTicketId() {
		return ticketId;
	}

	public void setTicketId(Integer ticketId) {
		this.ticketId = ticketId;
	}

	public String getHeader() {
		return header;
	}

	public void setHeader(String header) {
		this.header = header;
	}

	public TicketCategory getCategory() {
		return category;
	}

	public void setCategory(TicketCategory category) {
		this.category = category;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Blob getAttachment1() {
		return attachment1;
	}

	public void setAttachment1(Blob attachment1) {
		this.attachment1 = attachment1;
	}

	public Blob getAttachment2() {
		return attachment2;
	}

	public void setAttachment2(Blob attachment2) {
		this.attachment2 = attachment2;
	}

	public Blob getAttachment3() {
		return attachment3;
	}

	public void setAttachment3(Blob attachment3) {
		this.attachment3 = attachment3;
	}

}
