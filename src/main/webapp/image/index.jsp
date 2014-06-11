<%@ include file="../template1Header.jsp"%>

<style>
#imageTable td {
	border-bottom: 1px solid #dedede;
	padding-top: 10px;
	padding-bottom: 10px;
	vertical-align: middle;
}
</style>
<script>
	function getCheckedCount(){
		var count=0;
		$('#imageTable input[type=checkbox]').each(function(){
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
		$('#searchImage').click(function() {
			if ($(this).val() == 'Search image') {
				$('#searchImage').val('');
			}
		});

		$('#searchImage').focusout(function() {
			if ($(this).val() == '') {
				$('#searchImage').val('Search image');
			}
		});
		
		$('#searchImageButton').click(function(e) {
			var imageName=$('#searchImage').val();
			if (imageName=='Search image'){
				imageName='';
			}
			window.location="index.htm?imageName="+imageName;
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
						<li><a id="createVMFromImage" href=#><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/add.png"><p>Create vm from image</p></a></li>
						<li><a id="deleteImage" href=#><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/cross.png"><p>Delete image</p></a></li>
					</ul>
				</div>
			</div>
		</td>
		<td valign="top">
			<div class="box1" style="padding: 20px; margin-right: 40px;">
				<input id="searchImage" type="search" width="200" value="${imageName}" />
				<input id="searchImageButton" type="button" value="Search" class="sexybutton sexysimple sexyblue" />
				<br>
				<c:choose>
					<c:when test="${not empty error}">
						${error}
					</c:when>
					<c:otherwise>
						<table width="100%" id="imageTable" cellpadding="0" cellspacing="0">
							<tr>
								<th></th>
								<th align="left">Name</th>
								<th align="left">Status</th>
								<th>Size</th>
								<th>Created at</th>
							</tr>
							<c:forEach items="${images}" var="item">
								<tr>
									<td><input id="${item.id}" type="checkbox" /></td>
									<td align="left">
										<a href="imageDetail.htm?imageId=<c:out value="${item.id}"/>"><c:out value="${item.name}" /></a>
									</td>
									<td align="left">
										<c:if test="${item.status == 'error'}">
											<img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/error.png">
										</c:if>
										<c:if test="${item.status == 'active'}">
											<img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/tick.png">
										</c:if>
										<c:if test="${item.status == 'shutoff'}">
											<img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/stop.png">
										</c:if>
										<c:if test="${item.status == 'pause'}">
											<img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/control_pause.png">
										</c:if>
										<c:if test="${item.status == 'suspended'}">
											<img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/disk.png">
										</c:if>
										<c:out value="${item.status}" />
									</td>
									<td align="center">${item.size}</td>
									<td align="center">${item.created_at}</td>
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
