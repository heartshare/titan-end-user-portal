<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<script>
	$(document).ready(function() {
		$('#createVMButton').click(function() {
			if ($('#vmName').val().trim() == '') {
				$('#vmName').css('border-style', 'solid');
				$('#vmName').css('border-color', 'red');
				$('#vmName').css('border-width', '1px');
				$('#vmName').focus();
			} else {
				$('#vmName').css('border-style', '');
				$('#vmName').css('border-color', '');
				$('#vmName').css('border-width', '');
				
				var name=$('#vmName').val().trim() ;
				var flavor=$('#vmFlavor').val();
				var image=$('#vmImage').val();
				var min_count=1;
				if (confirm('Confirm to create vm?')){
					$.get('<c:out value="${titanServerRestURL}" />/rest/titan/sendCommand.htm?titanCommand=from titan:nova boot&$name='+name+'&$flavorRef='+flavor+'&$imageRef='+image+'&$min_count='+min_count, function( data ) {
						  alert(data);
					});
				}
			}
		});
	});
</script>
<div id="createVMDialog" title="Create vm" style="display: none;">
	<table border="0" cellpadding="10">
		<tr>
			<td>Name</td>
			<td><input type="text" id="vmName" size="40" /></td>
		</tr>
		<tr>
			<td>Region</td>
			<td><select id="vmRegion">
					<c:forEach var="region" items="${regions}">
						<option value="<c:out value="${region.regionId}" />"><c:out
								value="${region.name}" /></option>
					</c:forEach>
			</select></td>
		</tr>
		<tr>
			<td>Image</td>
			<td>
				<select id="vmImage">
					<c:forEach var="image" items="${images}">
						<option value="<c:out value="${image.id}" />"><c:out value="${image.name}" /> - <c:out value="${image.size}" /></option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td>Flavor</td>
			<td>
				<select id="vmFlavor">
					<c:forEach var="flavor" items="${flavors}">
						<option value="<c:out value="${flavor.key}" />"><c:out value="${flavor.value.name}" /></option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" id="createVMButton" value="Create" class="sexybutton sexysimple sexyblue" />
			</td>
		</tr>
	</table>
</div>
