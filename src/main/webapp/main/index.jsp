<%@ include file="../template1Header.jsp" %>
<style>
	.shortCutLink{
		line-height:40px;
	}
</style>
<script>
	$(function() {
	  $( "#accordion" ).accordion({
		  fillSpace: true
	  });
	});
	$(window).bind('resize', function() {
		$('#accordion div').css("width",'150px');
		$('#accordion div').css("height",$(window).height()-gridMarginHeight);
	}).trigger('resize');

	$(document).ready(function() {
		$(window).resize();
	});
</script>
<script>
	gridMarginWidth=12;
	gridMarginHeight=305;
	
	$(document).ready(function() {
		var chart = new Highcharts.Chart({
            chart: {
                renderTo: 'container',
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                width: 600,
                height: 600
            },
            title: {
                text: 'Browser market shares at a specific website, 2010'
            },
            tooltip: {
        	    pointFormat: '{series.name}: <b>{point.percentage}%</b>',
            	percentageDecimals: 1
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'p valign="top"ointer',
                    dataLabels: {
                        enabled: true,
                        color: '#000000',
                        connectorColor: '#000000',
                        formatter: function() {
                            return '<b>'+ this.point.name +'</b>: '+ this.percentage +' %';
                        }
                    }
                }
            },
            series: [{
                type: 'pie',
                name: 'Browser share',
                data: [
                    ['Firefox',   45.0],
                    ['IE',       26.8],
                    {
                        name: 'Chrome',
                        y: 12.8,
                        sliced: true,
                        selected: true
                    },
                    ['Safari',    8.5],
                    ['Opera',     6.2],
                    ['Others',   0.7]
                ]
            }]
        });
	});
	
	$(document).ready(function(){
		/* This code is executed after the DOM has been completely loaded */

		/* Changing thedefault easing effect - will affect the slideUp/slideDown methods: */
		$.easing.def = "easeOutBounce";

		/* Binding a click event handler to the links: */
		$('li.button a').click(function(e){
		
			/* Finding the drop down list that corresponds to the current section: */
			var dropDown = $(this).parent().next();
			
			/* Closing all other drop down sections, except the current one */
			$('.dropdown').not(dropDown).slideUp('slow');
			dropDown.slideToggle('slow');
			
			/* Preventing the default event (which would be to navigate the browser to the link's address) */
			e.preventDefault();
		})
		
	});
	
</script>
<!-- 
<img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/mainPageIcons/home.png" border="0" width="50" height="50" />
<img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/mainPageIcons/news.jpg" border="0" width="50" height="50" />
<img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/mainPageIcons/payslip.jpg" border="0" width="50" height="50" />
 -->
<table border="0" width="100%" height="100%">
	<tr>
		<td valign="top">
			  <div id="accordion">
			    <h3>Shortcut</h3>
			    <div>
			    	<a class="shortCutLink" href=#><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/pill.png" />&nbsp;Apply sick leave</a><br>
			    	<a class="shortCutLink" href=#><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/clock.png" />&nbsp;Late record</a><br>
			    	<a class="shortCutLink" href=#><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/calendar.png" />&nbsp;Fill in timesheet</a><br>
			    	<a class="shortCutLink" href=#><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/money.png" />&nbsp;Check payslip</a><br>
			    	<a class="shortCutLink" href=#><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/book.png" />&nbsp;Appraisal result</a><br>
			    	<a class="shortCutLink" href=#><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/date.png" />&nbsp;Holiday</a><br>
			    	<a class="shortCutLink" href=#><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/group.png" />&nbsp;Contact list</a><br>
			    </div>
			    <h3>Your department - IT</h3>
			    <div>
					<div style="max-height:30px;">
						<img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/user_red.png" />&nbsp;Peter Cheung<br>
					</div>
					<div style="margin-left:35px; max-height:70px;">
						Department head<br>
						peter@hrapp.net<br>
						3580 0991 direct<br>
					</div>
					<div style="max-height:30px;">
						<img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/user.png" />&nbsp;Leo Ma<br>
					</div>
					<div style="margin-left:35px; max-height:70px;">
						System Architect<br>
						Leo@hrapp.net<br>
						3580 1231 direct<br>
					</div>
					<div style="max-height:30px;">
						<img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/user_orange.png" />&nbsp;Keith Lee<br>
					</div>
					<div style="margin-left:35px; max-height:70px;">
						System Analyst<br>
						keith@hrapp.net<br>
						3422 0991 direct<br>
					</div>
					<div style="max-height:30px;">
						<img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/user_green.png" />&nbsp;Ken Lo<br>
					</div>
					<div style="margin-left:35px; max-height:70px;">
						Infrastructure Specialist<br>
						ken@hrapp.net<br>
						3580 1112 direct<br>
					</div>
			    </div>
			    <h3>Your team</h3>
			    <div>
			    	<div style="max-height:30px;">
						<img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/user_red.png" />&nbsp;Peter Cheung<br>
					</div>
					<div style="margin-left:35px; max-height:70px;">
						Department head<br>
						peter@hrapp.net<br>
						3580 0991 direct<br>
					</div>
					<div style="max-height:30px;">
						<img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/user.png" />&nbsp;Leo Ma<br>
					</div>
					<div style="margin-left:35px; max-height:70px;">
						System Architect<br>
						Leo@hrapp.net<br>
						3580 1231 direct<br>
					</div>
					<div style="max-height:30px;">
						<img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/user_orange.png" />&nbsp;Keith Lee<br>
					</div>
					<div style="margin-left:35px; max-height:70px;">
						System Analyst<br>
						keith@hrapp.net<br>
						3422 0991 direct<br>
					</div>
					<div style="max-height:30px;">
						<img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/user_green.png" />&nbsp;Ken Lo<br>
					</div>
					<div style="margin-left:35px; max-height:70px;">
						Infrastructure Specialist<br>
						ken@hrapp.net<br>
						3580 1112 direct<br>
					</div>
			    </div>
			    <h3>Useful files</h3>
			    <div>
			    	<a class="shortCutLink" href=#><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/script.png" />&nbsp;Sick leave form</a><br>
			    	<a class="shortCutLink" href=#><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/script.png" />&nbsp;Expense claim form</a><br>
			    	<a class="shortCutLink" href=#><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/script.png" />&nbsp;Quotation sample</a><br>
			    	<a class="shortCutLink" href=#><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/script.png" />&nbsp;Position review request</a><br>
			    	<a class="shortCutLink" href=#><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/script.png" />&nbsp;Salary adjustment form</a><br>
			    	<a class="shortCutLink" href=#><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/script.png" />&nbsp;Research activities form</a><br>
			    	<a class="shortCutLink" href=#><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/script.png" />&nbsp;Disability accommodation request</a><br>
			    	<a class="shortCutLink" href=#><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/script.png" />&nbsp;Health care provider statement</a><br>
			    	<a class="shortCutLink" href=#><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/script.png" />&nbsp;Request to initiate layoff</a><br>
			    	<a class="shortCutLink" href=#><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/script.png" />&nbsp;Appointment letter</a><br>
			    	<a class="shortCutLink" href=#><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/script.png" />&nbsp;Performance evaluation</a><br>
			    	<a class="shortCutLink" href=#><img src="${pageContext.request.contextPath}/theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam_silk_icons_v013/icons/script.png" />&nbsp;Performance feedback</a><br>
			    </div>
			  </div>
		</td>
		<td valign="top">
			<jsp:include page="../panelTop.jsp"><jsp:param name="title" value="News" /></jsp:include>
				<p style="word-wrap:break-word; text-align:left;">
					<span style="color:orange;">HRApp</span> is an easy-to-use, integrated, flexible, fully featured Payroll and Human Resources Management System (HRMS) suitable for most companies in Hong Kong with 
					general expectations. HRApp is compliant to local needs and practices so it is the 
					easiest way to replace manual processes.<br>
					<br>
					HRApp make payroll, auto-pay and tax-return processing an automated, predictable 
					and timely process with flexible and powerful functionalities that allows you to 
					operate more effective, smarter, and more accuracy.
				</p>
			<jsp:include page="../panelBottom.jsp" />
			<div style="height:5px;">&nbsp;</div>
			<jsp:include page="../panelTop.jsp"><jsp:param name="title" value="Announcement" /></jsp:include>
				<p style="word-wrap:break-word; text-align:left;">
					<span style="color:orange;">HRApp</span> is an easy-to-use, integrated, flexible, fully featured Payroll and Human Resources Management System (HRMS) suitable for most companies in Hong Kong with 
					general expectations. HRApp is compliant to local needs and practices so it is the 
					easiest way to replace manual processes.<br>
					<br>
					HRApp make payroll, auto-pay and tax-return processing an automated, predictable 
					and timely process with flexible and powerful functionalities that allows you to 
					operate more effective, smarter, and more accuracy.
				</p>
			<jsp:include page="../panelBottom.jsp" />
		</td>
		<td valign="top">
			<jsp:include page="../panelTop.jsp"><jsp:param name="title" value="Late" /></jsp:include>
				<center>
					<div id="container"></div>
				</center>
			<jsp:include page="../panelBottom.jsp" />
		</td>
	</tr>
</table>
<%@ include file="../template1Footer.jsp" %>
