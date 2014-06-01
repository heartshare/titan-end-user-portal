package com.titanenduserportal;

import java.sql.SQLException;

import org.apache.log4j.jdbc.JDBCAppender;

public class CustomJDBCAppender extends JDBCAppender {
	protected void execute(String sql) throws SQLException {
		if (sql.isEmpty()) {
			return;
		}
		sql = sql.replaceAll("\"", "\\\\\"");
		sql = sql.replaceAll("<<<", "\"");
		sql = sql.replaceAll(">>>", "\"");
		super.execute(sql);
	}
}
