package com.titanenduserportal.controller;

import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.format.annotation.DateTimeFormat;
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
		return "/log/index";
	}

	@RequestMapping(value = "/gridLog.htm", method = RequestMethod.GET)
	public String gridLog(ModelMap model, int page, int rows, String sidx, String sord, String filters, String searchString, @DateTimeFormat(pattern = "yyyy-MM-dd") Date dateFrom,
			@DateTimeFormat(pattern = "yyyy-MM-dd") Date dateTo) {
		if (dateTo != null) {
			dateTo.setHours(23);
			dateTo.setMinutes(59);
			dateTo.setSeconds(59);
		}
		//		System.out.println(dateFrom + "," + dateTo);
		Session session = HibernateUtil.openSession();
		//		Query query;
		//		if (searchString == null || searchString.equals("")) {
		//			query = session.createQuery("from Log order by " + sidx + " " + sord);
		//		} else {
		//			query = session.createQuery("from Log where logId like :str or message like :str order by " + sidx + " " + sord);
		//			query.setString("str", "%" + searchString + "%");
		//		}
		//		List<Log> logs = query.list();

		Criteria criteria = session.createCriteria(Log.class);
		if (searchString != null) {
			Criterion c1 = Restrictions.sqlRestriction("logID like '%" + searchString + "%'");
			Criterion c2 = Restrictions.like("message", "%" + searchString + "%");
			criteria.add(Restrictions.or(c1, c2));
		}

		if (dateFrom != null) {
			criteria.add(Restrictions.ge("date", dateFrom));
		}
		if (dateTo != null) {
			criteria.add(Restrictions.le("date", dateTo));
		}
		criteria.setCacheable(false);
		criteria.setFirstResult((page - 1) * rows);
		criteria.setMaxResults(rows);
		if (sord.equals("asc")) {
			criteria.addOrder(Order.asc(sidx));
		} else {
			criteria.addOrder(Order.desc(sidx));
		}
		List<Log> logs = criteria.list();

		int maxNoOfRow = Integer.parseInt(session.createSQLQuery("select count(*) from `log`").list().get(0).toString());
		model.addAttribute("page", page);
		model.addAttribute("total", maxNoOfRow / rows);
		model.addAttribute("rows", maxNoOfRow);
		model.addAttribute("logs", logs);
		session.close();

		Gson gson = new Gson();
		model.addAttribute("gridContent", gson.toJson(logs));
		return "/log/gridLog";
	}
}