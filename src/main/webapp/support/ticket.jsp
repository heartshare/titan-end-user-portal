<%@ include file="../template1Header.jsp" %>

<style>
	h1{
		font-size: 28px;
		color: #5c9cd4;
	}
	
	.tdHeader1{
		font-size:20px;
		color: #5c9cff;
	}
</style>
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
				      <li><a id="ticket" href="ticket.htm"><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/add.png"><p>Ticket</p></a></li>
				      <li><a href="#" target="_blank"><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/user.png"><p>Contact US</p></a></li>
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
				<table border="0" cellpadding="20" cellspacing="0">
					<tr>
						<td class="tdHeader1">Support phone</td>
						<td class="tdHeader1">Support email</td>
					</tr>
					<tr>
						<td>(+852) 96554595</td>
						<td>mcheung63@hotmail.com</td>
					</tr><tr>
						<td class="tdHeader1">Officer</td>
						<td class="tdHeader1">Upgrade your support plan</td>
					</tr>
					<tr>
						<td>Peter C.</td>
						<td><a href#>Place your support link here</a></td>
					</tr>
				</table>
			</div>
		</td>
	</tr>
</table>
<%@ include file="../template1Footer.jsp" %>
