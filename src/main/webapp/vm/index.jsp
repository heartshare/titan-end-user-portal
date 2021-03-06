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
	function getCheckedCount(){
		var count=0;
		$('#serverTable input[type=checkbox]').each(function(){
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
		
		$('#searchVMButton').click(function(e) {
			var vmName=$('#searchVM').val();
			if (vmName=='Search vm'){
				vmName='';
			}
			window.location="index.htm?vmName="+vmName;
		});

		$('#searchVM').keypress(function(e) {
			if (e.which == 13) {
			}
		});

		$('#createVM').click(function(e) {
			$("#createVMDialog").dialog({
				width : 400,
				height : 320,
				modal : true
			});
		});

		$('#deleteVM').click(function(e) {
			if (getCheckedCount()>0 && confirm('Confirm to delete vm?')){
				wait();
				$('#serverTable input[type=checkbox]').each(function(){
					var checkbox=$(this);
					if (checkbox.attr('checked')){
						var instanceId=$(this).attr('id');
					
						$.get('<c:out value="${titanServerRestURL}" />/rest/titan/sendCommand.htm?titanCommand=from titan:nova delete&$InstanceId='+instanceId, function(data) {
							
						});
					}
				});
				setTimeout(function(){location.reload();}, 2000);
			}
		});
		
		$('#softRebootVM').click(function(e) {
			if (getCheckedCount()>0 && confirm('Confirm to soft reboot vm?')){
				wait();
				$('#serverTable input[type=checkbox]').each(function(){
					var checkbox=$(this);
					if (checkbox.attr('checked')){
						var instanceId=$(this).attr('id');
					
						$.get('<c:out value="${titanServerRestURL}" />/rest/titan/sendCommand.htm?titanCommand=from titan:nova soft-reboot&$InstanceId='+instanceId, function(data) {
							
						});
					}
				});
				setTimeout(function(){location.reload();}, 2000);
			}
		});
		
		$('#hardRebootVM').click(function(e) {
			if (getCheckedCount()>0 && confirm('Confirm to hard reboot vm?')){
				wait();
				$('#serverTable input[type=checkbox]').each(function(){
					var checkbox=$(this);
					if (checkbox.attr('checked')){
						var instanceId=$(this).attr('id');
					
						$.get('<c:out value="${titanServerRestURL}" />/rest/titan/sendCommand.htm?titanCommand=from titan:nova hard-reboot&$InstanceId='+instanceId, function(data) {
							
						});
					}
				});
				setTimeout(function(){location.reload();}, 2000);
			}
		});
		
		$('#stopVM').click(function(e) {
			if (getCheckedCount()>0 && confirm('Confirm to stop vm?')){
				wait();
				$('#serverTable input[type=checkbox]').each(function(){
					var checkbox=$(this);
					if (checkbox.attr('checked')){
						var instanceId=$(this).attr('id');
					
						$.get('<c:out value="${titanServerRestURL}" />/rest/titan/sendCommand.htm?titanCommand=from titan:nova stop&$InstanceId='+instanceId, function(data) {
							
						});
					}
				});
				setTimeout(function(){location.reload();}, 2000);
			}
		});
		
		$('#pauseVM').click(function(e) {
			if (getCheckedCount()>0 && confirm('Confirm to pause vm?')){
				wait();
				$('#serverTable input[type=checkbox]').each(function(){
					var checkbox=$(this);
					if (checkbox.attr('checked')){
						var instanceId=$(this).attr('id');
					
						$.get('<c:out value="${titanServerRestURL}" />/rest/titan/sendCommand.htm?titanCommand=from titan:nova pause&$InstanceId='+instanceId, function(data) {
							
						});
					}
				});
				setTimeout(function(){location.reload();}, 2000);
			}
		});
		
		$('#unpauseVM').click(function(e) {
			if (getCheckedCount()>0 && confirm('Confirm to unpause vm?')){
				wait();
				$('#serverTable input[type=checkbox]').each(function(){
					var checkbox=$(this);
					if (checkbox.attr('checked')){
						var instanceId=$(this).attr('id');
					
						$.get('<c:out value="${titanServerRestURL}" />/rest/titan/sendCommand.htm?titanCommand=from titan:nova unpause&$InstanceId='+instanceId, function(data) {
							
						});
					}
				});
				setTimeout(function(){location.reload();}, 2000);
			}
		});
		
		$('#suspendVM').click(function(e) {
			if (getCheckedCount()>0 && confirm('Confirm to suspend vm?')){
				wait();
				$('#serverTable input[type=checkbox]').each(function(){
					var checkbox=$(this);
					if (checkbox.attr('checked')){
						var instanceId=$(this).attr('id');
					
						$.get('<c:out value="${titanServerRestURL}" />/rest/titan/sendCommand.htm?titanCommand=from titan:nova suspend&$InstanceId='+instanceId, function(data) {
							
						});
					}
				});
				setTimeout(function(){location.reload();}, 3000);
			}
		});
		
		$('#resumeVM').click(function(e) {
			if (getCheckedCount()>0 && confirm('Confirm to resume vm?')){
				wait();
				$('#serverTable input[type=checkbox]').each(function(){
					var checkbox=$(this);
					if (checkbox.attr('checked')){
						var instanceId=$(this).attr('id');
					
						$.get('<c:out value="${titanServerRestURL}" />/rest/titan/sendCommand.htm?titanCommand=from titan:nova resume&$InstanceId='+instanceId, function(data) {
							
						});
					}
				});
				setTimeout(function(){location.reload();}, 4000);
			}
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
						<li><a id="createVM" href=#><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/add.png"><p>Create vm</p></a></li>
						<li><a id="deleteVM" href=#><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/cross.png"><p>Delete vm</p></a></li>
						<li><a id="softRebootVM" href=#><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/arrow_refresh.png"><p>Soft reboot</p></a></li>
						<li><a id="hardRebootVM" href=#><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/arrow_refresh_red.png"><p>Hard reboot</p></a></li>
						<li><a id="stopVM" href=#><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/stop.png"><p>Stop</p></a></li>
						<li><a id="pauseVM" href=#><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/control_pause.png"><p>Pause</p></a></li>
						<li><a id="unpauseVM" href=#><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/control_play.png"><p>Unpause</p></a></li>
						<li><a id="suspendVM" href=#><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/disk.png"><p>Suspend</p></a></li>
						<li><a id="resumeVM" href=#><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/drive_disk.png"><p>Resume</p></a></li>
					</ul>
				</div>
			</div>
		</td>
		<td valign="top">
			<div class="box1" style="padding: 20px; margin-right: 40px;">
				<input id="searchVM" type="search" width="200" value="${vmName}" />
				<input id="searchVMButton" type="button" value="Search" class="sexybutton sexysimple sexyblue" />
				<br>
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
								<th>Disk</th>
							</tr>
							<c:forEach items="${instances}" var="item">
								<tr>
									<td><input id="${item.id}" type="checkbox" /></td>
									<td align="left">
										<a href="vmDetail.htm?instanceId=<c:out value="${item.id}"/>"><c:out value="${item.name}" /></a>
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
										<c:if test="${item.status == 'SHUTOFF'}">
											<img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/stop.png">
										</c:if>
										<c:if test="${item.status == 'PAUSED'}">
											<img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/control_pause.png">
										</c:if>
										<c:if test="${item.status == 'SUSPENDED'}">
											<img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/disk.png">
										</c:if>
										<c:out value="${item.status}" />
									</td>
									<td align="center">${item.flavorName}</td>
									<td align="center">${item.flavorVcpus}</td>
									<td align="center">${item.flavorRam}</td>
									<td align="center">${item.flavorDisk}</td>
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
<div id="waitDialog" title="" style="display: none;" align="center">
	<br>
	Please wait, updating status
	<br>
</div>

<%@ include file="../template1Footer.jsp"%>
