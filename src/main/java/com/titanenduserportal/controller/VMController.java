package com.titanenduserportal.controller;

import java.net.ConnectException;
import java.net.URLEncoder;
import java.util.Hashtable;
import java.util.Vector;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.titanenduserportal.CommonLib;
import com.titanenduserportal.HibernateUtil;

@Controller
@RequestMapping("/vm")
public class VMController {
	@Value("${titanServerRestURL}")
	private String titanServerRestURL;

	@Secured("ROLE_LOGINED")
	@RequestMapping(value = "/index.htm", method = RequestMethod.GET)
	public String main(ModelMap model) {
		String error = null;
		try {
			model.addAttribute("username", CommonLib.getUsername());
			model.addAttribute("authorities", CommonLib.getAuthorities());

			String resultStr;

			//parse
			//			System.out.println(CommonLib.formatJSon(resultStr));
			JSONObject obj;
			JSONObject base;

			resultStr = CommonLib.sendPost(titanServerRestURL + "/rest/titan/sendCommand.htm?titanCommand=" + URLEncoder.encode("from titan: nova flavor-list"), null, null);
			obj = JSONObject.fromObject(resultStr);
			base = JSONObject.fromObject(obj.getJSONObject("values").getJSONObject("result").getJSONObject("map").getJSONObject("result").getString("content").toString());
			JSONArray flavorsArr = base.getJSONArray("flavors");
			Hashtable<String, Hashtable<String, String>> flavors = new Hashtable<String, Hashtable<String, String>>();
			for (int x = 0; x < flavorsArr.size(); x++) {
				JSONObject flavor = flavorsArr.getJSONObject(x);
				Hashtable<String, String> ht = new Hashtable<String, String>();
				ht.put("name", flavor.getString("name"));
				ht.put("ram", flavor.getString("ram") + "MB");
				ht.put("disk", flavor.getString("disk") + "GB");
				ht.put("vcpus", flavor.getString("vcpus"));
				flavors.put(flavor.getString("id"), ht);
			}
			model.addAttribute("flavors", flavors);

			resultStr = CommonLib.sendPost(titanServerRestURL + "/rest/titan/sendCommand.htm?titanCommand=" + URLEncoder.encode("from titan: nova list"), null, null);
			obj = JSONObject.fromObject(resultStr);
			base = JSONObject.fromObject(obj.getJSONObject("values").getJSONObject("result").getJSONObject("map").getJSONObject("result").getString("content").toString());
			JSONArray servers = base.getJSONArray("servers");
			Vector<Hashtable<String, String>> instances = new Vector<Hashtable<String, String>>();
			for (int x = 0; x < servers.size(); x++) {
				obj = servers.getJSONObject(x);
				try {
					Hashtable<String, String> ht = new Hashtable<String, String>();
					String address = "";
					try {
						JSONArray addressArray = obj.getJSONObject("addresses").getJSONArray("vmnet");
						for (int z = 0; z < addressArray.size(); z++) {
							JSONObject link = addressArray.getJSONObject(z);
							//							address += "type=" + link.getString("OS-EXT-IPS:type") + ", ";
							address += link.getString("addr");
							//							address += "version=" + link.getString("version") + ", ";
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
					instances.add(ht);

					String flavorId = CommonLib.getJSONString(obj.getJSONObject("flavor"), "id", "");
					//					Hashtable<String, String> parameters = new Hashtable<String, String>();
					//					parameters.put("titanCommand", "from titan: nova flavor-show");
					//					parameters.put("$FlavorId", flavorId);
					//					if (!cachedFlavors.keySet().contains(flavorId)) {
					//						resultStr = CommonLib.sendPost(titanServerRestURL + "/rest/titan/sendCommand.htm", parameters, null);
					//						cachedFlavors.put(flavorId, resultStr);
					//					} else {
					//						resultStr = cachedFlavors.get(flavorId);
					//					}
					//					obj = JSONObject.fromObject(resultStr);
					//					base = JSONObject.fromObject(obj.getJSONObject("values").getJSONObject("result").getJSONObject("map").getJSONObject("result").getString("content").toString());
					//					JSONObject flavor = base.getJSONObject("flavor");
					model.addAttribute("flavorName", flavors.get(flavorId).get("name"));
					model.addAttribute("flavorRam", flavors.get(flavorId).get("ram"));
					model.addAttribute("flavorVcpus", flavors.get(flavorId).get("vcpus"));
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
			model.addAttribute("instances", instances);

			resultStr = CommonLib.sendPost(titanServerRestURL + "/rest/titan/sendCommand.htm?titanCommand=" + URLEncoder.encode("from titan: glance image-list"), null, null);
			obj = JSONObject.fromObject(resultStr);
			base = JSONObject.fromObject(obj.getJSONObject("values").getJSONObject("result").getJSONObject("map").getJSONObject("result").getString("content").toString());
			JSONArray imagesArr = base.getJSONArray("images");
			Vector<Hashtable<String, String>> images = new Vector<Hashtable<String, String>>();
			for (int x = 0; x < imagesArr.size(); x++) {
				JSONObject image = imagesArr.getJSONObject(x);
				if (image.getString("status").equals("active")) {
					Hashtable<String, String> ht = new Hashtable<String, String>();
					ht.put("name", image.getString("name"));
					ht.put("size", CommonLib.convertFilesize(Long.parseLong(image.getString("size"))));
					images.add(ht);
				}
			}
			model.addAttribute("images", images);

		} catch (ConnectException e) {
			error = "Connection refused : " + titanServerRestURL + "/rest/titan/sendCommand.htm";
		} catch (Exception e) {
			e.printStackTrace();
		}

		Session session = HibernateUtil.openSession();
		model.addAttribute("regions", session.createQuery("from Region").list());
		session.close();
		model.addAttribute("error", error);
		return "/vm/index";
	}

	@RequestMapping(value = "/vmDetail.htm", method = RequestMethod.GET)
	public String vmDetail(ModelMap model, String instanceId) {
		String resultStr = null;
		try {
			model.addAttribute("username", CommonLib.getUsername());
			model.addAttribute("authorities", CommonLib.getAuthorities());

			// nova show
			Hashtable<String, String> parameters = new Hashtable<String, String>();
			parameters.put("titanCommand", "from titan: nova show");
			parameters.put("$InstanceId", instanceId);
			resultStr = CommonLib.sendPost(titanServerRestURL + "/rest/titan/sendCommand.htm", parameters, null);
			JSONObject obj = JSONObject.fromObject(resultStr);
			JSONObject base = JSONObject.fromObject(obj.getJSONObject("values").getJSONObject("result").getJSONObject("map").getJSONObject("result").getString("content")
					.toString());
			JSONObject server = base.getJSONObject("server");
			//			System.out.println(CommonLib.formatJSon(server.toString()));
			String id = CommonLib.getJSONString(server, "id", "");
			model.addAttribute("id", id);

			String address = "";
			try {
				JSONArray addressArray = server.getJSONObject("addresses").getJSONArray("vmnet");
				for (int z = 0; z < addressArray.size(); z++) {
					JSONObject link = addressArray.getJSONObject(z);
					//					address += "type=" + link.getString("OS-EXT-IPS:type") + ", ";
					address += link.getString("addr");
					//					address += "version=" + link.getString("version") + ", ";
				}
			} catch (Exception ex) {
			}
			model.addAttribute("address", address);
			model.addAttribute("status", CommonLib.getJSONString(server, "status", ""));
			model.addAttribute("updated", CommonLib.getJSONString(server, "updated", ""));
			model.addAttribute("hostId", CommonLib.getJSONString(server, "hostId", ""));
			model.addAttribute("image", CommonLib.getJSONString(server.getJSONObject("image"), "id", ""));
			String flavorId = CommonLib.getJSONString(server.getJSONObject("flavor"), "id", "");
			model.addAttribute("flavor", flavorId);
			model.addAttribute("name", CommonLib.getJSONString(server, "name", ""));
			model.addAttribute("created", CommonLib.getJSONString(server, "created", ""));
			model.addAttribute("tenant_id", CommonLib.getJSONString(server, "tenant_id", ""));
			model.addAttribute("accessIPv4", CommonLib.getJSONString(server, "accessIPv4", ""));
			model.addAttribute("accessIPv6", CommonLib.getJSONString(server, "accessIPv6", ""));
			model.addAttribute("fault", CommonLib.getJSONString(server.getJSONObject("fault"), "message", ""));
			model.addAttribute("instanceName", CommonLib.getJSONString(server, "OS-EXT-SRV-ATTR:instance_name", ""));
			model.addAttribute("name", CommonLib.getJSONString(server, "name", ""));

			String imageId = CommonLib.getJSONString(server.getJSONObject("image"), "id", "");

			if (!flavorId.equals("")) {
				parameters = new Hashtable<String, String>();
				parameters.put("titanCommand", "from titan: nova flavor-show");
				parameters.put("$FlavorId", flavorId);
				resultStr = CommonLib.sendPost(titanServerRestURL + "/rest/titan/sendCommand.htm", parameters, null);
				obj = JSONObject.fromObject(resultStr);
				base = JSONObject.fromObject(obj.getJSONObject("values").getJSONObject("result").getJSONObject("map").getJSONObject("result").getString("content").toString());
				JSONObject flavor = base.getJSONObject("flavor");
				//				System.out.println(CommonLib.formatJSon(flavor.toString()));
				model.addAttribute("flavorName", CommonLib.getJSONString(flavor, "name", ""));
				model.addAttribute("flavorRam", CommonLib.getJSONString(flavor, "ram", ""));
				model.addAttribute("flavorVcpus", CommonLib.getJSONString(flavor, "vcpus", ""));
			}
			if (!imageId.equals("")) {
				parameters = new Hashtable<String, String>();
				parameters.put("titanCommand", "from titan: glance image-show");
				parameters.put("$ImageId", imageId);
				resultStr = CommonLib.sendPost(titanServerRestURL + "/rest/titan/sendCommand.htm", parameters, null);
				//				System.out.println(CommonLib.formatJSon(resultStr));
				obj = JSONObject.fromObject(resultStr);
				JSONArray headers = obj.getJSONObject("values").getJSONObject("result").getJSONObject("map").getJSONObject("result").getJSONArray("headers");
				for (int x = 0; x < headers.size(); x++) {
					JSONObject item = (JSONObject) headers.get(x);
					model.addAttribute("glance_" + item.getString("name").replaceAll("-", "_"), item.getString("value"));
				}
				model.addAttribute("glance_imagesize", CommonLib.convertFilesize(Long.parseLong(model.get("glance_Content_Length").toString())));
			}
		} catch (ConnectException e) {
			resultStr = "Connection refused : " + titanServerRestURL + "/rest/titan/sendCommand.htm";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/vm/vmDetail";
	}
}