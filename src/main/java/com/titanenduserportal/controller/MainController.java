package com.titanenduserportal.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.titanenduserportal.CommonLib;

@Controller
public class MainController {

	@RequestMapping(value = "/main/index.htm", method = RequestMethod.GET)
	public String main(ModelMap model) {
		model.addAttribute("username", CommonLib.getUsername());
		model.addAttribute("authorities", CommonLib.getAuthorities());
		return "main/index";
	}

}