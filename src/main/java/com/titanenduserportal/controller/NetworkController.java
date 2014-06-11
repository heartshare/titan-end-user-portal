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
@RequestMapping("/network")
public class NetworkController {
	@Value("${titanServerRestURL}")
	private String titanServerRestURL;

	@Secured("ROLE_LOGINED")
	@RequestMapping(value = "/index.htm", method = RequestMethod.GET)
	public String main(ModelMap model, String networkName) {
		String error = null;
		try {
			model.addAttribute("username", CommonLib.getUsername());
			model.addAttribute("authorities", CommonLib.getAuthorities());

			String resultStr;

			//parse
			//			System.out.println(CommonLib.formatJSon(resultStr));
			JSONObject obj;
			JSONObject base;

			resultStr = CommonLib.sendPost(titanServerRestURL + "/rest/titan/sendCommand.htm?titanCommand=" + URLEncoder.encode("from titan: nova network-list"), null, null);
			obj = JSONObject.fromObject(resultStr);
			System.out.println(CommonLib.formatJSon(resultStr));
			base = JSONObject.fromObject(obj.getJSONObject("values").getJSONObject("result").getJSONObject("map").getJSONObject("result").getString("content").toString());
			JSONArray servers = base.getJSONArray("networks");
			Vector<Hashtable<String, String>> networks = new Vector<Hashtable<String, String>>();
			for (int x = 0; x < servers.size(); x++) {
				obj = servers.getJSONObject(x);
				try {
					System.out.println(obj);
					Hashtable<String, String> ht = new Hashtable<String, String>();

					ht.put("bridge", CommonLib.getJSONString(obj, "bridge", ""));
					ht.put("vpn_public_port", CommonLib.getJSONString(obj, "vpn_public_port", ""));
					ht.put("dhcp_start", CommonLib.getJSONString(obj, "dhcp_start", ""));
					ht.put("bridge_interface", CommonLib.getJSONString(obj, "bridge_interface", ""));
					ht.put("id", CommonLib.getJSONString(obj, "id", ""));
					ht.put("cidr_v6", CommonLib.getJSONString(obj, "cidr_v6", ""));
					ht.put("deleted_at", CommonLib.getJSONString(obj, "deleted_at", "").replaceAll("T", " "));
					ht.put("gateway", CommonLib.getJSONString(obj, "gateway", ""));
					ht.put("rxtx_base", CommonLib.getJSONString(obj, "rxtx_base", ""));

					String label = CommonLib.getJSONString(obj, "label", "");
					ht.put("label", label);
					ht.put("priority", CommonLib.getJSONString(obj, "priority", ""));
					ht.put("project_id", CommonLib.getJSONString(obj, "project_id", ""));
					ht.put("vpn_private_address", CommonLib.getJSONString(obj, "vpn_private_address", ""));
					ht.put("deleted", CommonLib.getJSONString(obj, "deleted", ""));
					ht.put("vlan", CommonLib.getJSONString(obj, "vlan", ""));
					ht.put("broadcast", CommonLib.getJSONString(obj, "broadcast", ""));
					ht.put("netmask", CommonLib.getJSONString(obj, "netmask", ""));
					ht.put("injected", CommonLib.getJSONString(obj, "injected", ""));
					ht.put("cidr", CommonLib.getJSONString(obj, "cidr", ""));
					ht.put("vpn_public_address", CommonLib.getJSONString(obj, "vpn_public_address", ""));
					ht.put("multi_host", CommonLib.getJSONString(obj, "multi_host", ""));
					ht.put("dns2", CommonLib.getJSONString(obj, "dns2", ""));
					ht.put("created_at", CommonLib.getJSONString(obj, "created_at", "").replaceAll("T", " "));
					ht.put("host", CommonLib.getJSONString(obj, "host", ""));
					ht.put("gateway_v6", CommonLib.getJSONString(obj, "gateway_v6", ""));
					ht.put("netmask_v6", CommonLib.getJSONString(obj, "netmask_v6", ""));
					ht.put("dns1", CommonLib.getJSONString(obj, "dns1", ""));

					if (networkName == null || label.toLowerCase().contains(networkName.toLowerCase())) {
						networks.add(ht);
					}
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
			model.addAttribute("networks", networks);
			model.addAttribute("titanServerRestURL", titanServerRestURL);
		} catch (ConnectException e) {
			error = "Connection refused : " + titanServerRestURL + "/rest/titan/sendCommand.htm";
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("regions", HibernateUtil.createQuery("from Region"));
		model.addAttribute("error", error);
		model.addAttribute("networkName", (networkName == null || networkName.equals("")) ? "Search network" : networkName);
		return "/network/index";
	}

	@RequestMapping(value = "/networkDetail.htm", method = RequestMethod.GET)
	public String networkDetail(ModelMap model, String instanceId) {
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
			model.addAttribute("network", CommonLib.getJSONString(server.getJSONObject("network"), "id", ""));
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

			String networkId = CommonLib.getJSONString(server.getJSONObject("network"), "id", "");

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
			if (!networkId.equals("")) {
				parameters = new Hashtable<String, String>();
				parameters.put("titanCommand", "from titan: glance network-show");
				parameters.put("$ImageId", networkId);
				resultStr = CommonLib.sendPost(titanServerRestURL + "/rest/titan/sendCommand.htm", parameters, null);
				//				System.out.println(CommonLib.formatJSon(resultStr));
				obj = JSONObject.fromObject(resultStr);
				JSONArray headers = obj.getJSONObject("values").getJSONObject("result").getJSONObject("map").getJSONObject("result").getJSONArray("headers");
				for (int x = 0; x < headers.size(); x++) {
					JSONObject item = (JSONObject) headers.get(x);
					model.addAttribute("glance_" + item.getString("name").replaceAll("-", "_"), item.getString("value"));
				}
				model.addAttribute("glance_networksize", CommonLib.convertFilesize(Long.parseLong(model.get("glance_Content_Length").toString())));
			}
		} catch (ConnectException e) {
			resultStr = "Connection refused : " + titanServerRestURL + "/rest/titan/sendCommand.htm";
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/network/networkDetail";
	}
}