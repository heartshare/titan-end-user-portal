<%@ include file="../template1Header.jsp"%>

<style>
#storageTable td {
	border-bottom: 1px solid #dedede;
	padding-top: 10px;
	padding-bottom: 10px;
	vertical-align: middle;
}
</style>
<script>
	function getCheckedCount(){
		var count=0;
		$('#storageTable input[type=checkbox]').each(function(){
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
		$('#searchStorage').click(function() {
			if ($(this).val() == 'Search storage') {
				$('#searchStorage').val('');
			}
		});

		$('#searchStorage').focusout(function() {
			if ($(this).val() == '') {
				$('#searchStorage').val('Search storage');
			}
		});
		
		$('#searchStorageButton').click(function(e) {
			var storageName=$('#searchStorage').val();
			if (storageName=='Search storage'){
				storageName='';
			}
			window.location="index.htm?storageName="+storageName;
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
						<li><a id="createVMFromStorage" href=#><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/add.png"><p>Create storage</p></a></li>
						<li><a id="deleteStorage" href=#><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/cross.png"><p>Delete storage</p></a></li>
					</ul>
				</div>
			</div>
		</td>
		<td valign="top">
			<div class="box1" style="padding: 20px; margin-right: 40px;">
				<input id="searchStorage" type="search" width="200" value="${storageName}" />
				<input id="searchStorageButton" type="button" value="Search" class="sexybutton sexysimple sexyblue" />
				<br>
				<c:choose>
					<c:when test="${not empty error}">
						${error}
					</c:when>
					<c:otherwise>
						<table width="100%" id="storageTable" cellpadding="0" cellspacing="0">
							<tr>
								<th></th>
								<th align="left">Name</th>
								<th>Description</th>
								<th align="center">Size</th>
								<th align="center">Created at</th>
								<th align="center">Host</th>
							</tr>
							<c:forEach items="${storages}" var="item">
								<tr>
									<td><input id="${item.id}" type="checkbox" /></td>
									<td align="left">
										<a href="storageDetail.htm?storageName=<c:out value="${item.display_name}"/>"><c:out value="${item.display_name}" /></a>
									</td>
									<td align="center">${item.display_description}</td>
									<td align="center">${item.size}</td>
									<td align="center">${item.created_at}</td>
									<td align="center">${item.os-vol-host-attr-host}</td>
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
