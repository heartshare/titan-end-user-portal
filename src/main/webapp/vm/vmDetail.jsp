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
		color: #a0a0a0;
	}
	
	#vmDetailTable td
	{
		padding: 10px;
	}
</style>

<table border="0" width="100%" height="100%">
	<tr>
		<td valign="top" style="max-width:800px;">
			<div class="box1" style="padding:20px; margin-left:40px; margin-right:10px;">
				<a href="index.htm"><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/arrow_left.png">Back</a>
				<br>
				<br>
				<span id="header">VM</span>
				<br>
				<h1>${name} - ${instanceName}</h1>
				<table cellspacing="0" cellpadding="0" id="vmDetailTable">
					<tr>
						<td>ID</td>
						<td>${id}</td>
					</tr>
					<tr>
						<td>Server Status</td>
						<td>
							${status}
							<c:if test="${status=='ERROR' }">
								&nbsp;${fault}
							</c:if>
						</td>
					</tr>
					<tr>
						<td>System Image</td>
						<td>${image}</td>
					</tr>
					<tr>
						<td>Flavor</td>
						<td>${flavor}</td>
					</tr>
					<tr>
						<td>created</td>
						<td>${created}</td>
					</tr>
					<tr>
						<td>tenant_id</td>
						<td>${tenant_id}</td>
					</tr>
					<tr>
						<td>accessIPv4</td>
						<td>${accessIPv4}</td>
					</tr>
					<tr>
						<td>accessIPv6</td>
						<td>${accessIPv6}</td>
					</tr>
				</table>
				<br>
				<hr>
				<br>
				<h2>Flavor</h2>
				<br>
				<table cellspacing="0" cellpadding="0" id="vmDetailTable">
					<tr>
						<td>ID</td>
						<td>${id}</td>
					</tr>
					<tr>
						<td>Server Status</td>
						<td>
							${status}
							<c:if test="${status=='ERROR' }">
								&nbsp;${fault}
							</c:if>
						</td>
					</tr>
					<tr>
						<td>System Image</td>
						<td>${image}</td>
					</tr>
					<tr>
						<td>Flavor</td>
						<td>${flavor}</td>
					</tr>
					<tr>
						<td>created</td>
						<td>${created}</td>
					</tr>
					<tr>
						<td>tenant_id</td>
						<td>${tenant_id}</td>
					</tr>
					<tr>
						<td>accessIPv4</td>
						<td>${accessIPv4}</td>
					</tr>
					<tr>
						<td>accessIPv6</td>
						<td>${accessIPv6}</td>
					</tr>
				</table>
			</div>
		</td>
		<td valign="top" style="max-width: 200px;">
			<div class="box1" style="padding:20px; margin-left:10px; margin-right:40px;">
				<h3>Managing Your Server</h3>
				<h4>LOG INTO YOUR SERVER NOW</h4>
				For Linux, use the command below to log in via SSH. Open a terminal application and run:<br>
				<br>
				<code>ssh root@119.9.72.168</code>
				<br><br>
				More Remote Login Commands »<br>
				<br>
				HELP ME WITH...<br>
				Configuring Basic Security<br>
				Rebuilding My Server<br>
				Creating a Monitoring Check<br>
				Learn More about Cloud Servers »<br>
				<br>
				<hr>
				<h4>WHAT'S NEXT?</h4>
				Configuring and Using DNS<br>
				Load Balancing My Servers<br>
				Configuring Outbound Email<br>
				Visit Our Knowledge Center »<br>
				<br>
				<hr>
				<h4>MARKETPLACE TOOLS</h4>
				Security: CloudPassage Halo<br>
				Management: RightScale<br>
				App Monitoring: New Relic<br>
				Visit the Cloud Tools Marketplace »<br>
			</div>
		</td>
	</tr>
</table>
<%@ include file="../template1Footer.jsp" %>
