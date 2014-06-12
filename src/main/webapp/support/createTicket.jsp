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
		
		$('#saveButton').click(function() {
			var values = {};
			values["category"]=$('#category').val();
			values["header"]=$('#header').val();
			values["message"]=$('#message').val();
			$.post("saveTicket.htm", values, 
				function(data) {
					if (data == "yes") {
						alert("Save successfully");
						$("#editEmployeeDialog").dialog("close");
			            $("#employeeGrid").trigger("reloadGrid");
					}
				}
			);
		});
	});
</script>
<table border="0" width="100%" height="100%">
	<tr>
		<td valign="top" align="center">
			<div class="box1" style="width: 800px;padding: 20px;" align="left">
				<a href="ticket.htm"><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/arrow_left.png">Back</a>
				<br>
				<br>
				<table border="0" cellpadding="5" cellspacing="0" width="100%">
					<tr>
						<td align="right">Category</td>
						<td>
							<select id="category">
								<c:forEach var="ticketCategory" items="${ticketCategories}">
									<option value="<c:out value="${ticketCategory.ticketCategoryId}" />">${ticketCategory.name}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td align="right">Header</td>
						<td><input id="header" type="text" style="width: 600px;" /></td>
					</tr>
					<tr>
						<td align="right">Message</td>
						<td><textarea id="message" style="width: 600px; height:100px;" ></textarea></td>
					</tr>
					<tr>
						<td align="right">Attachments</td>
						<td>
							<input type="file" id="file1" /><br>
							<input type="file" id="file2" /><br>
							<input type="file" id="file3" />
						</td>
					</tr>
					<tr>
						<td align="right"></td>
						<td>
							<input type="button" id="saveButton" value="Save" class="sexybutton sexysimple sexyblue" />
						</td>
					</tr>
				</table>
			</div>
		</td>
	</tr>
</table>
<%@ include file="../template1Footer.jsp" %>
