<%@ include file="../template1Header.jsp" %>

<script>
	function wait(){
		$("#waitDialog").dialog({
			width : 300,
			height : 100,
			modal : true
		});
	}
	$(document).ready(function() {
		$('#searchTicket').click(function() {
			if ($(this).val() == 'Search ticket') {
				$('#searchTicket').val('');
			}
		});

		$('#searchTicket').focusout(function() {
			if ($(this).val() == '') {
				$('#searchTicket').val('Search ticket');
			}
		});
	});
</script>
<table border="0" width="100%" height="100%">
	<tr>
		<td valign="top">
			<div class="box1" style="padding: 20px; margin-right: 40px;">
				<a href="ticket.htm"><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/arrow_left.png">Back</a>
				<br>
				<br>
				<table border="0" cellpadding="20" cellspacing="0" width="100%">
					<tr>
						<th>Ticket No.</td>
						<th>Header</td>
						<th>Catrgory</td>
						<th>Date</td>
						<th>Last update</td>
						<th>Last update person</td>
						<th>Status</td>
					</tr>
				</table>
			</div>
		</td>
	</tr>
</table>
<%@ include file="../template1Footer.jsp" %>
