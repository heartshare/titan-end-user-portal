package com.titanenduserportal.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.titanenduserportal.CommonLib;
import com.titanenduserportal.HibernateUtil;

@Controller
@RequestMapping("/support")
public class SupportController {

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

}