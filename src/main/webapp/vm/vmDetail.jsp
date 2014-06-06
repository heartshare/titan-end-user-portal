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
<div align="center">
	<table border="0" width="100%" height="100%" style="max-width:1200px;">
		<tr>
			<td valign="top">
				<div class="box1" style="padding:20px; margin-left:40px; margin-right:10px;">
					<a href="index.htm"><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/arrow_left.png">Back</a>
					<br>
					<br>
					<span id="header">Virtual machine</span>
					<br>
					<h1>${name} - ${instanceName}</h1>
					<table cellspacing="0" cellpadding="0" id="vmDetailTable">
						<tr>
							<td width="150">ID</td>
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
							<td>Created</td>
							<td>${created}</td>
						</tr>
						<tr>
							<td>Tenant Id</td>
							<td>${tenant_id}</td>
						</tr>
						<tr>
							<td>IPv4</td>
							<td>${accessIPv4} ${address}</td>
						</tr>
						<tr>
							<td>IPv6</td>
							<td>${accessIPv6}</td>
						</tr>
					</table>
					<br>
					<hr>
					<h2>Flavor</h2>
					<table cellspacing="0" cellpadding="0" id="vmDetailTable">
						<tr>
							<td width="150">ID</td>
							<td>${flavor}</td>
						</tr>
						<tr>
							<td>Name</td>
							<td>${flavorName}</td>
						</tr>
						<tr>
							<td>Vcpu</td>
							<td>${flavorVcpus}</td>
						</tr>
						<tr>
							<td>Ram</td>
							<td>${flavorRam} MB</td>
						</tr>
					</table>
					<br>
					<hr>
					<h2>Disk</h2>
					<table cellspacing="0" cellpadding="0" id="vmDetailTable">
						<tr>
							<td width="150">ID</td>
							<td>${glance_X_Image_Meta_Id}</td>
						</tr>
						<tr>
							<td>Name</td>
							<td>${glance_X_Image_Meta_Name}</td>
						</tr>
						<tr>
							<td>Size</td>
							<td>${glance_imagesize}</td>
						</tr>
						<tr>
							<td>Ram</td>
							<td>${flavorRam} MB</td>
						</tr>
						<tr>
							<td>Created at</td>
							<td>${glance_X_Image_Meta_Created_at}</td>
						</tr>
						<tr>
							<td>Status</td>
							<td>${glance_X_Image_Meta_Status}</td>
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
					<code>ssh root@${address}</code>
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
</div>
<br>
<%@ include file="../template1Footer.jsp" %>
