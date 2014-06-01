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
		String resultStr = null;
		try {
			model.addAttribute("username", CommonLib.getUsername());
			model.addAttribute("authorities", CommonLib.getAuthorities());

			Hashtable<String, String> ht = new Hashtable<String, String>();
			ht.put("titanCommand", "from titan: nova list");
			resultStr = CommonLib.sendPost(titanServerRestURL + "/rest/titan/sendCommand.htm", ht, null);

			JSONObject json = JSONObject.fromObject(resultStr);

			model.addAttribute("result", CommonLib.formatJSon(json.toString()).replaceAll("\n", "<br>").replaceAll(" ", "&nbsp;&nbsp;"));
			//		model.addAttribute("result", json.get("name"));
		} catch (ConnectException e) {
			resultStr = "Connection refused : " + titanServerRestURL + "/rest/titan/sendCommand.htm";
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("result", resultStr);
		return "/vm/index";
	}

}