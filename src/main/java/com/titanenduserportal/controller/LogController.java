package com.titanenduserportal.controller;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;
import com.titanenduserportal.CommonLib;
import com.titanenduserportal.HibernateUtil;
import com.titanenduserportal.table.Log;

@Controller
@RequestMapping("/log")
public class LogController {

	@Secured("ROLE_LOGINED")
	@RequestMapping(value = "/index.htm", method = RequestMethod.GET)
	public String main(ModelMap model) {
		model.addAttribute("username", CommonLib.getUsername());
		model.addAttribute("authorities", CommonLib.getAuthorities());
		return "log/index";
	}

	@RequestMapping(value = "/gridLog.htm", method = RequestMethod.GET)
	public String gridLog(ModelMap model, int page, int rows, String sidx, String sord, String filters, String searchString) {
		Session session = HibernateUtil.openSession();
		Query query;
		if (searchString == null || searchString.equals("")) {
			query = session.createQuery("from Log order by " + sidx + " " + sord);
		} else {
			query = session.createQuery("from Log where logId like :str or message like :str order by " + sidx + " " + sord);
			query.setString("str", "%" + searchString + "%");
		}
		query.setCacheable(false);
		query.setFirstResult((page - 1) * rows);
		query.setMaxResults(rows);
		List<Log> logs = query.list();

		int maxNoOfRow = Integer.parseInt(session.createSQLQuery("select count(*) from `log`").list().get(0).toString());
		model.addAttribute("page", page);
		model.addAttribute("total", maxNoOfRow / rows);
		model.addAttribute("rows", maxNoOfRow);
		model.addAttribute("logs", logs);
		session.close();

		Gson gson = new Gson();
		model.addAttribute("gridContent", gson.toJson(logs));
		return "log/gridLog";
	}

}