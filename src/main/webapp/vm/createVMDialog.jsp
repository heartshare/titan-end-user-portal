<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<div id="createVMDialog" title="Create vm" style="display: none;">
	<table border="0" cellpadding="10">
		<tr>
			<td>Name</td>
			<td><input type="text" id="name" size="50" /></td>
		</tr>
		<tr>
			<td>Region</td>
			<td>
				<select id="region">
					<c:forEach var="region" items="${regions}">
						<option><c:out value="${region.name}" /></option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td></td>
			<td></td>
		</tr>
	</table>
</div>
