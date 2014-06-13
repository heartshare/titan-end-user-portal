<%@ include file="../template1Header.jsp" %>
<script type='text/javascript' src='${pageContext.request.contextPath}/jquery.form.min.js'></script>
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
			alert($("#createTicketForm"));
			$("#createTicketForm").ajaxForm({
			success:function(data) { 
				alert(data);
			},
			dataType:"text"
			}).submit();
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
				<form id="createTicketForm" action="${pageContext.request.contextPath}//support/saveTicket.htm" method="post" enctype="multipart/form-data">
					<table border="0" cellpadding="5" cellspacing="0" width="100%">
						<tr>
							<td align="right">Category</td>
							<td>
								<select name="category">
									<c:forEach var="ticketCategory" items="${ticketCategories}">
										<option value="<c:out value="${ticketCategory.ticketCategoryId}" />">${ticketCategory.name}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<td align="right">Header</td>
							<td><input name="header" type="text" style="width: 600px;" /></td>
						</tr>
						<tr>
							<td align="right">Message</td>
							<td><textarea name="message" style="width: 600px; height:100px;" ></textarea></td>
						</tr>
						<tr>
							<td align="right">Attachments</td>
							<td>
								<input type="file" name="file1" /><br>
								<input type="file" name="file2" /><br>
								<input type="file" name="file3" />
							</td>
						</tr>
						<tr>
							<td align="right"></td>
							<td>
								<input type="button" id="saveButton" value="Save" class="sexybutton sexysimple sexyblue" />
							</td>
						</tr>
					</table>
				</form>
			</div>
		</td>
	</tr>
</table>
<%@ include file="../template1Footer.jsp" %>
