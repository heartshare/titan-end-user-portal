<%@ include file="../template1Header.jsp"%>

<style>
#keyTable td {
	border-bottom: 1px solid #dedede;
	padding-top: 10px;
	padding-bottom: 10px;
	vertical-align: middle;
}
</style>
<script>
	function getCheckedCount(){
		var count=0;
		$('#keyTable input[type=checkbox]').each(function(){
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
		$('#searchKey').click(function() {
			if ($(this).val() == 'Search key') {
				$('#searchKey').val('');
			}
		});

		$('#searchKey').focusout(function() {
			if ($(this).val() == '') {
				$('#searchKey').val('Search key');
			}
		});
		
		$('#searchKeyButton').click(function(e) {
			var keyName=$('#searchKey').val();
			if (keyName=='Search key'){
				keyName='';
			}
			window.location="index.htm?keyName="+keyName;
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
						<li><a id="createVMFromKey" href=#><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/add.png"><p>Create key</p></a></li>
						<li><a id="deleteKey" href=#><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/cross.png"><p>Delete key</p></a></li>
					</ul>
				</div>
			</div>
		</td>
		<td valign="top">
			<div class="box1" style="padding: 20px; margin-right: 40px;">
				<input id="searchKey" type="search" width="200" value="${keyName}" />
				<input id="searchKeyButton" type="button" value="Search" class="sexybutton sexysimple sexyblue" />
				<br>
				<c:choose>
					<c:when test="${not empty error}">
						${error}
					</c:when>
					<c:otherwise>
						<table width="100%" id="keyTable" cellpadding="0" cellspacing="0">
							<tr>
								<th></th>
								<th align="left">Name</th>
								<th>Fingerprint</th>
							</tr>
							<c:forEach items="${keys}" var="item">
								<tr>
									<td><input id="${item.name}" type="checkbox" /></td>
									<td align="left">
										<a href="keyDetail.htm?keyName=<c:out value="${item.name}"/>"><c:out value="${item.name}" /></a>
									</td>
									<td align="center">${item.fingerprint}</td>
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
