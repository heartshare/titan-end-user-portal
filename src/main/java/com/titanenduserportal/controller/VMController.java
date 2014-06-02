package com.titanenduserportal.controller;

import java.net.ConnectException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Vector;

import net.sf.json.JSONArray;
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
		String resultFlavorStr = null;
		try {
			model.addAttribute("username", CommonLib.getUsername());
			model.addAttribute("authorities", CommonLib.getAuthorities());

			resultStr = CommonLib.sendPost(titanServerRestURL + "/rest/titan/sendCommand.htm?titanCommand=" + URLEncoder.encode("from titan: nova list"), null, null);
			resultFlavorStr = CommonLib.sendPost(titanServerRestURL + "/rest/titan/sendCommand.htm?titanCommand=" + URLEncoder.encode("from titan: nova flavor-list"), null, null);

			//parse
			//			System.out.println(CommonLib.formatJSon(resultStr));
			JSONObject obj = JSONObject.fromObject(resultStr);
			JSONObject base = JSONObject.fromObject(obj.getJSONObject("values").getJSONObject("result").getJSONObject("map").getJSONObject("result").getString("content")
					.toString());
			JSONArray servers = base.getJSONArray("servers");
			Vector<Hashtable<String, String>> v = new Vector<Hashtable<String, String>>();
			for (int x = 0; x < servers.size(); x++) {
				obj = servers.getJSONObject(x);
				try {
					Hashtable<String, String> ht = new Hashtable<String, String>();
					String address = "";
					try {
						for (int z = 0; z < obj.getJSONObject("addresses").getJSONArray("private").size(); z++) {
							JSONObject link = obj.getJSONObject("addresses").getJSONArray("private").getJSONObject(z);
							address += "type=" + link.getString("OS-EXT-IPS:type") + ", ";
							address += "addr=" + link.getString("addr") + ", ";
							address += "version=" + link.getString("version") + ", ";
						}
					} catch (Exception ex) {
					}
					ht.put("address", address);

					String id = CommonLib.getJSONString(obj, "id", "");
					ht.put("id", id);

					String instanceName = CommonLib.getJSONString(obj, "OS-EXT-SRV-ATTR:instance_name", "");
					ht.put("instanceName", instanceName);

					String name = CommonLib.getJSONString(obj, "name", "");
					ht.put("name", name);

					String status = CommonLib.getJSONString(obj, "status", "");
					ht.put("status", status);
					v.add(ht);
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
			model.addAttribute("result", v);
		} catch (ConnectException e) {
			resultStr = "Connection refused : " + titanServerRestURL + "/rest/titan/sendCommand.htm";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/vm/index";
	}

	@RequestMapping(value = "/vmDetail.htm", method = RequestMethod.GET)
	public String vmDetail(ModelMap model, String instanceId) {
		String resultStr = null;
		try {
			model.addAttribute("username", CommonLib.getUsername());
			model.addAttribute("authorities", CommonLib.getAuthorities());

			Hashtable<String, String> parameters = new Hashtable<String, String>();
			parameters.put("$InstanceId", instanceId);

			resultStr = CommonLib.sendPost(titanServerRestURL + "/rest/titan/sendCommand.htm?titanCommand=" + URLEncoder.encode("from titan: nova show"), parameters, null);

			//parse
			System.out.println(CommonLib.formatJSon(resultStr));
			JSONObject obj = JSONObject.fromObject(resultStr);
			JSONObject base = JSONObject.fromObject(obj.getJSONObject("values").getJSONObject("result").getJSONObject("map").getJSONObject("result").getString("content")
					.toString());
			JSONArray servers = base.getJSONArray("servers");
			for (int x = 0; x < servers.size(); x++) {
				obj = servers.getJSONObject(x);
				try {
					String id = CommonLib.getJSONString(obj, "id", "");
					if (id.equals(instanceId)) {
						model.addAttribute("id", id);
						//						System.out.println(CommonLib.formatJSon(obj.toString()));

						String address = "";
						try {
							for (int z = 0; z < obj.getJSONObject("addresses").getJSONArray("private").size(); z++) {
								JSONObject link = obj.getJSONObject("addresses").getJSONArray("private").getJSONObject(z);
								address += "type=" + link.getString("OS-EXT-IPS:type") + ", ";
								address += "addr=" + link.getString("addr") + ", ";
								address += "version=" + link.getString("version") + ", ";
							}
						} catch (Exception ex) {
						}
						model.addAttribute("address", address);
						model.addAttribute("status", CommonLib.getJSONString(obj, "status", ""));
						model.addAttribute("updated", CommonLib.getJSONString(obj, "updated", ""));
						model.addAttribute("hostId", CommonLib.getJSONString(obj, "hostId", ""));
						model.addAttribute("image", CommonLib.getJSONString(obj.getJSONObject("image"), "id", ""));
						model.addAttribute("flavor", CommonLib.getJSONString(obj.getJSONObject("flavor"), "id", ""));
						model.addAttribute("name", CommonLib.getJSONString(obj, "name", ""));
						model.addAttribute("created", CommonLib.getJSONString(obj, "created", ""));
						model.addAttribute("tenant_id", CommonLib.getJSONString(obj, "tenant_id", ""));
						model.addAttribute("accessIPv4", CommonLib.getJSONString(obj, "accessIPv4", ""));
						model.addAttribute("accessIPv6", CommonLib.getJSONString(obj, "accessIPv6", ""));
						model.addAttribute("fault", CommonLib.getJSONString(obj.getJSONObject("fault"), "message", ""));
						model.addAttribute("instanceName", CommonLib.getJSONString(obj, "OS-EXT-SRV-ATTR:instance_name", ""));
						model.addAttribute("name", CommonLib.getJSONString(obj, "name", ""));
						break;
					}
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
		} catch (ConnectException e) {
			resultStr = "Connection refused : " + titanServerRestURL + "/rest/titan/sendCommand.htm";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/vm/vmDetail";
	}
}