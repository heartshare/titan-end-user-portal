<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Titan end user portal</title>
	<style type="text/css">
	</style>
	<link rel="stylesheet" type="text/css" href="theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/main.css" />
	<link rel="stylesheet" type="text/css" href="theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/SexyButtons/sexybuttons.css" />
	<script type='text/javascript' src='jquery-1.8.3.min.js'></script>
	<script>
		$(document).ready(function() {
			$("#username").focus();
		});
	</script>
</head>

<body>
	<div class="loginBox">
		<div style="padding: 9px 15px; border-bottom: 1px solid #EEE;">
			<h3>
				<spring:message code="login" />
			</h3>
		</div>
		<form id="" class="" action="login.htm" method="post">
			<div>
				<fieldset style="border: 0px">
					<div>
						<label for="username" style="display: block; text-align: left; color: #555; font-size: 12px; font-weight: bold; margin-bottom: 10px;"><spring:message code="username" /></label> <span class="help-block"></span>
						<div class="input">
							<input type="text" name="username" id="username" style="width: 350px;" class="input_textarea_select" />
						</div>
					</div>
					<div>
						<label for="password" style="display: block; text-align: left; color: #555; font-size: 12px; font-weight: bold; margin-bottom: 10px;"><spring:message code="password" /></label>
						<div class="input">
							<input type="password" name="password" id="password" style="width: 350px;" class="input_textarea_select" />
							<span style="font-size: 12px; color: orange;">${errorMsg}</span>
						</div>
					</div>
				</fieldset>
			</div>
			<div class="box-footer"">
				<table border="0" width="100%">
					<tr>
						<td>
							<button type="submit" class="sexybutton sexysimple sexyblue"><spring:message code="login" /></button>
						</td>
						<td align="right">
							<a href="?lang=en"><img src="theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/flag/usa.png" width="25" style="vertical-align: middle;" /></a>
							<a href="?lang=hk"><img src="theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/flag/hk.png" width="25" style="vertical-align: middle" /></a> 
							<a href="?lang=cn"><img src="theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/flag/china.png" width="25" style="vertical-align: middle" /></a>
							<!-- ${pageContext.response.locale} -->
							<span style="color: #878787; font-size:10px;">
								<fmt:bundle basename="main">
									<fmt:message key="version" />
								</fmt:bundle>
							</span>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<div style="display:block;position:absolute;top:0;right:0;color: #878787; font-size:10px;">
		<fmt:bundle basename="main">
			<fmt:message key="build.date" />
		</fmt:bundle>
	</div>
</body>
</html>
