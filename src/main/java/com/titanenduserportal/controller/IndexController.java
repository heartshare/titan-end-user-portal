package com.titanenduserportal.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.log4j.MDC;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.titanenduserportal.CommonLib;
import com.titanenduserportal.HibernateUtil;
import com.titanenduserportal.table.User;

@Controller
public class IndexController {
	private static Logger logger = Logger.getLogger(IndexController.class);

	@RequestMapping(value = "/index.htm", method = RequestMethod.GET)
	public String index(ModelMap model) {
		if (CommonLib.isUserTableEmpty()) {
			CommonLib.initDB();
		}

		return "/index";
	}

	@RequestMapping(value = "/login.htm", method = RequestMethod.POST)
	public String login(HttpServletRequest request, Model model, Principal principal, @RequestParam String username, @RequestParam String password) {
		Session session = HibernateUtil.openSession();
		Criteria criteria = session.createCriteria(User.class);
		criteria.add(Restrictions.eq("username", username));
		criteria.add(Restrictions.eq("password", password));
		criteria.add(Restrictions.eq("enable", true));
		List<User> users = criteria.list();
		session.close();

		if (users.size() == 0) {
			model.addAttribute("errorMsg", "password incorrect");
			logger.warn("password incorrect");
			return "index";
		} else {
			MDC.put("username", username);
			logger.info("user login: " + username);

			List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
			authorities.add(new GrantedAuthorityImpl("ROLE_LOGINED"));
			Authentication auth = new UsernamePasswordAuthenticationToken(username, password, authorities);

//			request.getSession();

			SecurityContext securityContext = SecurityContextHolder.getContext();
			securityContext.setAuthentication(auth);

			// Create a new session and add the security context.
			request.getSession().setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, securityContext);

			return "redirect:/vm/index.htm";
		}
	}

	@RequestMapping(value = "/logout.htm", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response, Model model) {
		MDC.remove("username");

		request.getSession(false).invalidate();
		// SecurityContextHolder.getContext().setAuthentication(null);
		SecurityContextHolder.clearContext();
		return "redirect:/index.htm";
	}
}
