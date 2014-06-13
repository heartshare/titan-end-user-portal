package com.titanenduserportal.controller;

import java.util.Date;

import org.apache.log4j.Logger;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.titanenduserportal.CommonLib;
import com.titanenduserportal.HibernateUtil;
import com.titanenduserportal.table.ticket.Ticket;

@Controller
@RequestMapping("/support")
public class SupportController {
	private static Logger logger = Logger.getLogger(SupportController.class);

	@RequestMapping(value = "/index.htm", method = RequestMethod.GET)
	public String index(ModelMap model) {
		model.addAttribute("username", CommonLib.getUsername());
		model.addAttribute("authorities", CommonLib.getAuthorities());
		return "/support/index";
	}

	@RequestMapping(value = "/ticket.htm", method = RequestMethod.GET)
	public String ticket(ModelMap model, String ticketName) {
		model.addAttribute("username", CommonLib.getUsername());
		model.addAttribute("authorities", CommonLib.getAuthorities());
		model.addAttribute("tickets", HibernateUtil.createQuery("from Ticket order by date desc"));

		model.addAttribute("ticketName", (ticketName == null || ticketName.equals("")) ? "Search ticket" : ticketName);
		return "/support/ticket";
	}

	@RequestMapping(value = "/createTicket.htm", method = RequestMethod.GET)
	public String createTicket(ModelMap model) {
		model.addAttribute("username", CommonLib.getUsername());
		model.addAttribute("authorities", CommonLib.getAuthorities());
		model.addAttribute("ticketCategories", HibernateUtil.createQuery("from TicketCategory order by name"));
		return "/support/createTicket";
	}

	@RequestMapping(value = "/saveTicket.htm", method = RequestMethod.POST)
	public String saveTicket(ModelMap model, Integer category, String header, String message, MultipartFile file1, MultipartFile file2, MultipartFile file3) {
		Session session = HibernateUtil.openSession();
		Transaction tx = session.beginTransaction();
		try {
			Ticket ticket = new Ticket();
			ticket.date = new Date();
			ticket.header = header;
			ticket.message = message;
			if (file1 != null) {
				ticket.attachment1 = Hibernate.getLobCreator(session).createBlob(file1.getInputStream(), file1.getInputStream().available());
			}
			if (file2 != null) {
				ticket.attachment1 = Hibernate.getLobCreator(session).createBlob(file2.getInputStream(), file2.getInputStream().available());
			}
			if (file3 != null) {
				ticket.attachment1 = Hibernate.getLobCreator(session).createBlob(file3.getInputStream(), file3.getInputStream().available());
			}
			session.save(ticket);
		} catch (Exception ex) {
			logger.error(ex.getMessage());
		}
		tx.commit();
		session.close();

		model.addAttribute("username", CommonLib.getUsername());
		model.addAttribute("authorities", CommonLib.getAuthorities());
		return "/support/saveTicketResult";
	}

}