package com.titanenduserportal;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;

import net.sf.json.JSONObject;

import org.apache.http.Consts;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.titanenduserportal.table.Role;
import com.titanenduserportal.table.User;
import com.titanenduserportal.table.UserGroup;

public class CommonLib {
	private static Logger logger = Logger.getLogger(CommonLib.class);

	public static String filterJSonSpecialCharacter(String s) {
		if (s == null) {
			return "";
		} else {
			s = s.replaceAll("\n", "\\n");
			return s.replaceAll("\\\\", "\\\\\\\\").replaceAll("\"", "\\\\\"");
		}
	}

	public static String getUsername() {
		String username = (String) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		return username;
	}

	public static List<GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> authorities = (List<GrantedAuthority>) SecurityContextHolder.getContext().getAuthentication().getAuthorities();
		return authorities;
	}

	public static void initDB() {
		logger.info("initDB()");
		Session session = HibernateUtil.openSession();
		Transaction tx = session.beginTransaction();
		try {
			User user = new User();
			user.setUsername("peter");
			user.setPassword("1234");
			user.setEnable(true);

			UserGroup group1 = new UserGroup();
			group1.setName("user");
			user.getUserGroups().add(group1);
			session.save(group1);

			Role role1 = new Role();
			role1.setName("server");
			role1.setDescription("Server management");
			group1.getRoles().add(role1);
			session.save(role1);

			Role role2 = new Role();
			role2.setName("network");
			role2.setDescription("Network management");
			group1.getRoles().add(role2);
			session.save(role2);

			session.save(user);
		} catch (Exception ex) {
			logger.error(ex.getMessage());
		} finally {
			tx.commit();
			session.close();
		}
	}

	public static boolean isUserTableEmpty() {
		Session session = HibernateUtil.openSession();
		try {
			List<User> tables = session.createQuery("from User").list();
			return tables.size() == 0;
		} catch (Exception ex) {
			ex.printStackTrace();
			return true;
		} finally {
			session.close();
		}
	}

	private byte[] toByteArray(Blob fromBlob) {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		try {
			return toByteArrayImpl(fromBlob, baos);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} catch (IOException e) {
			throw new RuntimeException(e);
		} finally {
			if (baos != null) {
				try {
					baos.close();
				} catch (IOException ex) {
				}
			}
		}
	}

	private byte[] toByteArrayImpl(Blob fromBlob, ByteArrayOutputStream baos) throws SQLException, IOException {
		byte[] buf = new byte[4000];
		InputStream is = fromBlob.getBinaryStream();
		try {
			for (;;) {
				int dataSize = is.read(buf);
				if (dataSize == -1)
					break;
				baos.write(buf, 0, dataSize);
			}
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (IOException ex) {
				}
			}
		}
		return baos.toByteArray();
	}

	public static String sendPost(String url, Hashtable ht, File file) throws Exception {
		CloseableHttpClient client = HttpClients.createDefault();
		HttpPost post = new HttpPost(url);

		List<NameValuePair> nvps = new ArrayList<NameValuePair>();

		post.setEntity(new UrlEncodedFormEntity(nvps, Consts.UTF_8));

		MultipartEntity entity = new MultipartEntity();
		if (file != null) {
			entity.addPart("image", new FileBody(file));
		}
		if (ht != null) {
			Enumeration<String> it = ht.keys();
			while (it.hasMoreElements()) {
				String key = it.nextElement();
				String value = (String) ht.get(key);
				entity.addPart(key, new StringBody(value, Charset.forName("UTF-8")));
			}
		}
		post.setEntity(entity);

		HttpResponse response = client.execute(post);
		HttpEntity entityResponse = response.getEntity();
		String r = EntityUtils.toString(entityResponse);
		client.close();
		return r;
	}

	public static String formatJSon(String str) {
		JsonParser parser = new JsonParser();
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		JsonElement el = parser.parse(str);
		return gson.toJson(el);
	}

	public static String getJSONString(JSONObject obj, String key, String returnValue) {
		try {
			return obj.getString(key);
		} catch (Exception ex) {
			return returnValue;
		}
	}

}
