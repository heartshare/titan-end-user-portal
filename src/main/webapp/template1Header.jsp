<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Titan end user portal</title>
	<style type="text/css">
	</style>
	
	<script type='text/javascript' src='${pageContext.request.contextPath}/jquery-1.8.3.min.js'></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/SexyButtons/sexybuttons.css" />
	
	<link href="${pageContext.request.contextPath}/jquery-mega-drop-down-menu.1.3.3/jquery-mega-drop-down-menu/css/dcmegamenu.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/jquery-mega-drop-down-menu.1.3.3/jquery-mega-drop-down-menu/css/skins/green.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/jquery-mega-drop-down-menu.1.3.3/jquery-mega-drop-down-menu/css/skins/black.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/jquery-mega-drop-down-menu.1.3.3/jquery-mega-drop-down-menu/css/skins/grey.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/jquery-mega-drop-down-menu.1.3.3/jquery-mega-drop-down-menu/css/skins/blue.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/jquery-mega-drop-down-menu.1.3.3/jquery-mega-drop-down-menu/css/skins/light_blue.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/jquery-mega-drop-down-menu.1.3.3/jquery-mega-drop-down-menu/css/skins/orange.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/jquery-mega-drop-down-menu.1.3.3/jquery-mega-drop-down-menu/css/skins/red.css" rel="stylesheet" type="text/css" />
	<link href="${pageContext.request.contextPath}/jquery-mega-drop-down-menu.1.3.3/jquery-mega-drop-down-menu/css/skins/white.css" rel="stylesheet" type="text/css" />
	<script type='text/javascript' src='${pageContext.request.contextPath}/jquery-mega-drop-down-menu.1.3.3/jquery-mega-drop-down-menu/js/jquery.hoverIntent.minified.js'></script>
	<script type='text/javascript' src='${pageContext.request.contextPath}/jquery-mega-drop-down-menu.1.3.3/jquery-mega-drop-down-menu/js/jquery.dcmegamenu.1.3.3.js'></script>
	
	
	<script type='text/javascript' src="${pageContext.request.contextPath}/jquery-ui-1.10.4.custom/js/jquery-ui-1.10.4.custom.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-ui-1.10.4.custom/css/redmond/jquery-ui-1.10.4.custom.css"/>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/jqgrid/js/i18n/grid.locale-en.js" ></script>
	<script type='text/javascript' src="${pageContext.request.contextPath}/jqgrid/js/jquery.jqGrid.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jqgrid/css/ui.jqgrid.css" />
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/main.css" />
	<script type='text/javascript' src="${pageContext.request.contextPath}/main.js"></script>
	
	
	<script type='text/javascript' src='${pageContext.request.contextPath}/Highcharts-2/js/highcharts.js'></script>
	
	<script type='text/javascript' src='${pageContext.request.contextPath}/global.js'></script>
</head>
<script type="text/javascript">
	$(document).ready(function() {
		$('#mainmenu').dcMegaMenu({
			rowItems: '3',
			speed: 'fast',
			effect: 'fade',
			event: 'click'
		});
	});
</script>
<body>
	<table border="0" width="100%" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/logoSmall.png" border="0" style="margin-left:20px" />
			</td>
		</tr>
		<tr>
			<td valign="bottom">
				<div class="white">					
					<ul id="mainmenu" class="mega-menu megaDropDown_ul">
						<li>
							<a id="tab_home" href="${pageContext.request.contextPath}/main/index.htm"><spring:message code="menuServer" /></a>
						</li>
						<li>
							<a id="tab_news" href="${pageContext.request.contextPath}/payroll/index.htm"><spring:message code="menuServerImage" /></a>
						</li>
						<li>
							<a id="tab_prtg" href="${pageContext.request.contextPath}/orgChart.htm"><spring:message code="menuNetwork" /></a>
						</li>
						<li>
							<a id="tab_prtg" href="${pageContext.request.contextPath}/timesheet/index.htm"><spring:message code="menuSSHKey" /></a>
						</li>
						<li>
							<a id="tab_otrs" href="${pageContext.request.contextPath}/leave.htm"><spring:message code="menuBlockStorage" /></a>
						</li>
						<li>
							<a id="tab_im" href="${pageContext.request.contextPath}/appraisal.htm"><spring:message code="menuStorageSnapshot" /></a>
						</li>
					</ul>
				</div>
				<div style="position: absolute; right:10px; top:5px; text-align: right;">
					Welcome, ${username }
					<span id="logout" style="cursor:pointer;"><a href="${pageContext.request.contextPath}/logout.htm">Logout</a></span>
					<br />
					
					<a href="?lang=en"><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/flag/usa.png" width="25" style="vertical-align: middle" /></a>
					<a href="?lang=hk"><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/flag/hk.png" width="25" style="vertical-align: middle" /></a> 
					<a href="?lang=cn"><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/flag/china.png" width="25" style="vertical-align: middle" /></a>
				</div>
			</td>
		</tr>
	</table>
	