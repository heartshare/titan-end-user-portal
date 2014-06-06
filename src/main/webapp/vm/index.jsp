<%@ include file="../template1Header.jsp"%>

<style>
#serverTable td {
	border-bottom: 1px solid #dedede;
	padding-top: 10px;
	padding-bottom: 10px;
	vertical-align: middle;
}
</style>
<script>
	$(document).ready(function() {
		$('#searchVM').click(function() {
			if ($(this).val() == 'Search vm') {
				$('#searchVM').val('');
			}
		});

		$('#searchVM').focusout(function() {
			if ($(this).val() == '') {
				$('#searchVM').val('Search vm');
			}
		});

		$('#searchVM').keypress(function(e) {
			if (e.which == 13) {
			}
		});

		$('#createVM').click(function(e) {
			$("#createVMDialog").dialog({
				width : 400,
				height : 350,
				modal : true
			});
		});

		$('#deleteVM').click(function(e) {
			$("#deleteVMDialog").dialog({
				height : 140,
				modal : true
			});
		});
	});
</script>
<table border="0" width="100%" height="100%">
	<tr>
		<td valign="top" align="left" width="350">
			<div class="menu-container">
				<div class="nav">
					Functions
					<div class="settings"></div>
				</div>
				<div class="menu">
					<ul>
						<li><a id="createVM" href=#><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/add.png"><p>Create</p></a></li>
						<li><a id="deleteVM" href=#><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/cross.png"><p>Delete</p></a></li>
					</ul>
				</div>
			</div>
		</td>
		<td valign="top">
			<div class="box1" style="padding: 20px; margin-right: 40px;">
				<input id="searchVM" type="search" width="200" value="Search vm" /><br>
				<c:choose>
					<c:when test="${not empty error}">
						${error}
					</c:when>
					<c:otherwise>
						<table width="100%" id="serverTable" cellpadding="0" cellspacing="0">
							<tr>
								<th></th>
								<th align="left">Name</th>
								<th align="left">IP</th>
								<th align="left">Status</th>
								<th>Flavor</th>
								<th>vCpu</th>
								<th>Ram</th>
							</tr>
							<c:forEach items="${instances}" var="item">
								<tr>
									<td><input type="checkbox" /></td>
									<td align="left">
										<a href="vmDetail.htm?instanceId=<c:out value="${item.id}"/>"><c:out value="${item.instanceName}" /></a>
									</td>
									<td align="left">
										<c:choose>
											<c:when test="${item.address == ''}">
												--
											</c:when>
											<c:otherwise>
												<c:out value="${item.address}" />
											</c:otherwise>
										</c:choose></td>
									<td align="left">
										<c:if test="${item.status == 'ERROR'}">
											<img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/error.png">
										</c:if>
										<c:if test="${item.status == 'ACTIVE'}">
											<img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/tick.png">
										</c:if>
										<c:out value="${item.status}" />
									</td>
									<td align="center">${flavorName}</td>
									<td align="center">${flavorVcpus}</td>
									<td align="center">${flavorRam}</td>
								</tr>
							</c:forEach>
						</table>
					</c:otherwise>
				</c:choose>
			</div>
		</td>
	</tr>
</table>

<jsp:include page="createVMDialog.jsp" />
<jsp:include page="deleteVMDialog.jsp" />

<%@ include file="../template1Footer.jsp"%>
