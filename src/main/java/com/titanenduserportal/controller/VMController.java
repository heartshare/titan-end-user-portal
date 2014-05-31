package com.titanenduserportal.controller;

import java.net.ConnectException;
import java.util.Hashtable;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.titanenduserportal.CommonLib;

@Controller
@RequestMapping("/vm")
public class VMController {
	@Value("${titanServerRestURL}")
	private String titanServerRestURL;

	@Secured("ROLE_LOGINED")
	@RequestMapping(value = "/index.htm", method = RequestMethod.GET)
	public String main(ModelMap model) {
		model.addAttribute("username", CommonLib.getUsername());
		model.addAttribute("authorities", CommonLib.getAuthorities());

		Hashtable<String, String> ht = new Hashtable<String, String>();
		ht.put("titanCommand", "from titan: nova list");
		String resultStr = null;
		try {
			resultStr = CommonLib.sendPost(titanServerRestURL + "/rest/titan/sendCommand.htm", ht, null);
		} catch (ConnectException e) {
			resultStr = "Connection refused";
		} catch (Exception e) {
			e.printStackTrace();
		}

		JSONObject json = JSONObject.fromObject(resultStr);

		model.addAttribute("fuck", CommonLib.formatJSon(json.toString()));
		return "/vm/index";
	}

}