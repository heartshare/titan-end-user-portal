<%@ include file="../template1Header.jsp" %>

<style>
	#header{
		font-weight: bold;
		text-transform: uppercase;
		color: #999;
		margin-bottom: 10px;
		font-size: 12px;
		line-height: 12px;
	}
	
	hr{
		color: #cccccc;
		background-color: #cccccc;
		height: 1px;
		border: 0px;
	}
	
	h1{
		font-size: 24px;
	}
	
	h2{
		font-size: 22px;
	}
	
	h3{
		font-size: 18px;
	}
	
	h4{
		font-size: 14px;
	}
	
	code{
		padding: 10px;
		word-wrap: normal;
		white-space: pre;
		background-color: #80e9ff;
	}
	
	#vmDetailTable
	{
		color: #505050;
	}
	
	#vmDetailTable td
	{
		padding: 10px;
	}
</style>
<script>
	function wait(title){
		$("#waitDialog").dialog({
			width : 300,
			height : 100,
			title : title,
			modal : true
		});
	}
	
	$(document).ready(function() {
		$('#actions').change(function(){
			var selectedValue=$('#actions').val();
			$('#actions option:first-child').attr("selected", "selected");
			if (selectedValue=='Stop'){
				if (confirm('Confirm to stop vm?')){
					wait();
					var instanceId="${instanceId}";
					
					$.get('<c:out value="${titanServerRestURL}" />/rest/titan/sendCommand.htm?titanCommand=from titan:nova stop&$InstanceId='+instanceId, function(data) {
						
					});
					setTimeout(function(){location.reload();}, 2000);
				}
			}else if (selectedValue=='Soft reboot'){
				if (confirm('Confirm to soft reboot vm?')){
					wait();
					var instanceId="${instanceId}";
					
					$.get('<c:out value="${titanServerRestURL}" />/rest/titan/sendCommand.htm?titanCommand=from titan:nova soft-reboot&$InstanceId='+instanceId, function(data) {
						
					});
					setTimeout(function(){location.reload();}, 2000);
				}
			}else if (selectedValue=='Hard reboot'){
				if (confirm('Confirm to hard reboot vm?')){
					wait();
					var instanceId="${instanceId}";
					
					$.get('<c:out value="${titanServerRestURL}" />/rest/titan/sendCommand.htm?titanCommand=from titan:nova hard-reboot&$InstanceId='+instanceId, function(data) {
						
					});
					setTimeout(function(){location.reload();}, 2000);
				}
			}else if (selectedValue=='Remote'){
				window.location="remote?instanceId=${instanceId}";
			}
		});
	});
</script>
<div align="center">
	<table border="0" width="100%" height="100%" style="max-width:1200px;">
		<tr>
			<td valign="top">
				<div class="box1" style="padding:20px; margin-left:10px; margin-right:10px;">
					<a href="index.htm"><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/arrow_left.png">Back</a>
					
					<select style="float: right;" id="actions">
						<option>Actions</option>
						<option>Stop</option>
						<option>Soft reboot</option>
						<option>Hard reboot</option>
						<option>Scale up/down</option>
						<option>Change password</option>
						<option>Remote</option>
						<option>Take snapshot</option>
						<option>Schedule</option>
						<option>Remove</option>
					</select>
					<br>
					<br>
					
				</div>
			</td>
		</tr>
	</table>
</div>
<div id="waitDialog" title="" style="display: none;" align="center">
	<br>
	Please wait, updating status
	<br>
</div>
<br>
<%@ include file="../template1Footer.jsp" %>
