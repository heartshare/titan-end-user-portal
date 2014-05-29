<?xml version='1.0' encoding='utf-8'?>
<%@ page language="java" contentType="text/html; charset=UTf-8"	pageEncoding="UTf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<rows>
	<page>${page}</page>
	<total>${total}</total>
	<records>${rows}</records>
	<c:forEach var="log" items="${logs}" varStatus="status">
		<row id="${log.logID}">
			<c:set var="name" value='${role.name}' scope="request" />
			<c:set var="description" value='${role.description}' scope="request" />
			<cell>${log.logID}</cell>
			<cell><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${log.date}" /></cell>
			<cell>${log.username}</cell>
			<cell>${log.priority}</cell>
			<cell>${log.category}</cell>
			<cell><c:out value="${log.message}" /></cell>
		</row>
	</c:forEach>
</rows>