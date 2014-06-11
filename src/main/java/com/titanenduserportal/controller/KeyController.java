package com.titanenduserportal.controller;

import java.net.ConnectException;
import java.net.URLEncoder;
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
import com.titanenduserportal.HibernateUtil;

@Controller
@RequestMapping("/key")
public class KeyController {
	@Value("${titanServerRestURL}")
	private String titanServerRestURL;

	@Secured("ROLE_LOGINED")
	@RequestMapping(value = "/index.htm", method = RequestMethod.GET)
	public String main(ModelMap model, String keyName) {
		String error = null;
		try {
			model.addAttribute("username", CommonLib.getUsername());
			model.addAttribute("authorities", CommonLib.getAuthorities());

			String resultStr;

			//parse
			//			System.out.println(CommonLib.formatJSon(resultStr));
			JSONObject obj;
			JSONObject base;

			resultStr = CommonLib.sendPost(titanServerRestURL + "/rest/titan/sendCommand.htm?titanCommand=" + URLEncoder.encode("from titan: nova keypair-list"), null, null);
			obj = JSONObject.fromObject(resultStr);
			base = JSONObject.fromObject(obj.getJSONObject("values").getJSONObject("result").getJSONObject("map").getJSONObject("result").getString("content").toString());
			JSONArray keypairs = base.getJSONArray("keypairs");
			Vector<Hashtable<String, String>> keys = new Vector<Hashtable<String, String>>();
			for (int x = 0; x < keypairs.size(); x++) {
				obj = keypairs.getJSONObject(x).getJSONObject("keypair");
				try {
					Hashtable<String, String> ht = new Hashtable<String, String>();

					ht.put("public_key", CommonLib.getJSONString(obj, "public_key", ""));
					String name = CommonLib.getJSONString(obj, "name", "");
					ht.put("name", name);
					ht.put("fingerprint", CommonLib.getJSONString(obj, "fingerprint", ""));
					if (keyName == null || name.toLowerCase().contains(keyName.toLowerCase())) {
						keys.add(ht);
					}
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
			model.addAttribute("keys", keys);
			model.addAttribute("titanServerRestURL", titanServerRestURL);
		} catch (ConnectException e) {
			error = "Connection refused : " + titanServerRestURL + "/rest/titan/sendCommand.htm";
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("regions", HibernateUtil.createQuery("from Region"));
		model.addAttribute("error", error);
		model.addAttribute("keyName", (keyName == null || keyName.equals("")) ? "Search key" : keyName);
		return "/key/index";
	}

	@RequestMapping(value = "/keyDetail.htm", method = RequestMethod.GET)
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
			model.addAttribute("key", CommonLib.getJSONString(server.getJSONObject("key"), "id", ""));
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

			String keyId = CommonLib.getJSONString(server.getJSONObject("key"), "id", "");

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
				model.addAttribute("flavorRam", CommonLib.getJSONString(flavor, "ram", "") + "MB");
				model.addAttribute("flavorVcpus", CommonLib.getJSONString(flavor, "vcpus", ""));
				model.addAttribute("flavorDisk", CommonLib.getJSONString(flavor, "disk", "") + "GB");
			}
			if (!keyId.equals("")) {
				parameters = new Hashtable<String, String>();
				parameters.put("titanCommand", "from titan: glance key-show");
				parameters.put("$KeyId", keyId);
				resultStr = CommonLib.sendPost(titanServerRestURL + "/rest/titan/sendCommand.htm", parameters, null);
				//				System.out.println(CommonLib.formatJSon(resultStr));
				obj = JSONObject.fromObject(resultStr);
				JSONArray headers = obj.getJSONObject("values").getJSONObject("result").getJSONObject("map").getJSONObject("result").getJSONArray("headers");
				for (int x = 0; x < headers.size(); x++) {
					JSONObject item = (JSONObject) headers.get(x);
					model.addAttribute("glance_" + item.getString("name").replaceAll("-", "_"), item.getString("value"));
				}
				model.addAttribute("glance_keysize", CommonLib.convertFilesize(Long.parseLong(model.get("glance_Content_Length").toString())));
			}
		} catch (ConnectException e) {
			resultStr = "Connection refused : " + titanServerRestURL + "/rest/titan/sendCommand.htm";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/key/keyDetail";
	}
}