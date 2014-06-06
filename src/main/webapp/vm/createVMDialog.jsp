<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<div id="createVMDialog" title="Create vm" style="display: none;">
	<table border="0" cellpadding="10">
		<tr>
			<td>Name</td>
			<td><input type="text" id="name" size="40" /></td>
		</tr>
		<tr>
			<td>Region</td>
			<td>
				<select id="region">
					<c:forEach var="region" items="${regions}">
						<option value="<c:out value="${region.id}" />"><c:out value="${region.name}" /></option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td>Image</td>
			<td>
				<select id="image">
					<c:forEach var="image" items="${images}">
						<option value="<c:out value="${image.id}" />"><c:out value="${image.name}" /> - <c:out value="${image.size}" /></option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td>Flavor</td>
			<td>
				<select id="flavor">
					<c:forEach var="flavor" items="${flavors}">
						<option value="<c:out value="${flavor.key}" />"><c:out value="${flavor.value.name}" /></option>
					</c:forEach>
				</select>
			</td>
		</tr>
	</table>
</div>
