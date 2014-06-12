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
		<td valign="top" align="left" width="200" style="padding-left: 40px; padding-right: 20px;">
			<div class="menu-container">
				<div class="nav">
				    Functions
				    <div class="settings"></div>
				</div>
				
				<div class="menu">
				    <ul>
				      <li><a id="ticket" href="ticket.htm"><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/page_green.png"><p>Ticket</p></a></li>
				      <li><a id="createTicketBtton" href="createTicket.htm"><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/add.png"><p>Create ticket</p></a></li>
				      <li><a href="#" target="_blank"><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/script.png"><p>Service plan</p></a></li>
				    </ul>
				</div>
			</div>
		</td>
		<td valign="top">
			<div class="box1" style="padding: 20px; margin-right: 40px;">
				<input id="searchTicket" type="search" width="200" value="${ticketName}" />
				<input id="searchTicketButton" type="button" value="Search" class="sexybutton sexysimple sexyblue" />
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
