<%@ include file="../template1Header.jsp"%>

<style>
#networkTable td {
	border-bottom: 1px solid #dedede;
	padding-top: 10px;
	padding-bottom: 10px;
	vertical-align: middle;
}
</style>
<script>
	function getCheckedCount(){
		var count=0;
		$('#networkTable input[type=checkbox]').each(function(){
			var checkbox=$(this);
			if (checkbox.attr('checked')){
				count++;
			}
		});
		return count;
	}
	
	function wait(){
		$("#waitDialog").dialog({
			width : 300,
			height : 100,
			modal : true
		});
	}
	$(document).ready(function() {
		$('#searchNetwork').click(function() {
			if ($(this).val() == 'Search network') {
				$('#searchNetwork').val('');
			}
		});

		$('#searchNetwork').focusout(function() {
			if ($(this).val() == '') {
				$('#searchNetwork').val('Search network');
			}
		});
		
		$('#searchNetworkButton').click(function(e) {
			var networkName=$('#searchNetwork').val();
			if (networkName=='Search network'){
				networkName='';
			}
			window.location="index.htm?networkName="+networkName;
		});
	});
</script>
<table border="0" width="100%" height="100%">
	<tr>
		<td valign="top" align="left" width="200" style="padding-left: 40px; padding-right: 20px;">
			<div class="menu-container">
				<div class="nav">
					Functions
					<div class="settings"></div>
				</div>
				<div class="menu">
					<ul>
						<li><a id="createVMFromNetwork" href=#><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/add.png"><p>Create vm from network</p></a></li>
						<li><a id="deleteNetwork" href=#><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/cross.png"><p>Delete network</p></a></li>
					</ul>
				</div>
			</div>
		</td>
		<td valign="top">
			<div class="box1" style="padding: 20px; margin-right: 40px;">
				<input id="searchNetwork" type="search" width="200" value="${networkName}" />
				<input id="searchNetworkButton" type="button" value="Search" class="sexybutton sexysimple sexyblue" />
				<br>
				<c:choose>
					<c:when test="${not empty error}">
						${error}
					</c:when>
					<c:otherwise>
						<table width="100%" id="networkTable" cellpadding="0" cellspacing="0">
							<tr>
								<th></th>
								<th align="left">Label</th>
								<th>Cidr</th>
								<th>Netmask</th>
								<th>Gateway</th>
								<th>Dns</th>
								<th>Dhcp start</th>
							</tr>
							<c:forEach items="${networks}" var="item">
								<tr>
									<td><input id="${item.id}" type="checkbox" /></td>
									<td align="left">
										<a href="networkDetail.htm?networkId=<c:out value="${item.id}"/>"><c:out value="${item.label}" /></a>
									</td>
									<td align="center">${item.cidr}</td>
									<td align="center">${item.netmask}</td>
									<td align="center">${item.gateway}</td>
									<td align="center">${item.dns1}</td>
									<td align="center">${item.dhcp_start}</td>
								</tr>
							</c:forEach>
						</table>
					</c:otherwise>
				</c:choose>
			</div>
		</td>
	</tr>
</table>
<div id="waitDialog" title="" style="display: none;" align="center">
	<br>
	Please wait, updating status
	<br>
</div>

<%@ include file="../template1Footer.jsp"%>
