<%@ include file="../template1Header.jsp" %>

<script>
	$(document).ready(function() {
		$('#searchLog').click(function() {
			if ($(this).val() == 'Search log') {
				$('#searchLog').val('');
			}
		});
		
		$('#searchLog').keypress(function(e) { 
			if(e.which == 13) {
				$('#searchLogButton').trigger('click');
			}
		});
		
		$('#searchLogButton').click(function() {
			if ($('#searchLog').val() == 'Search log') {   
				$('#searchLog').val('');
			}
			$("#logGrid").setGridParam({url: 'gridLog.htm?searchString='+$('#searchLog').val()+'&dateFrom='+$('#dateFrom').val()+'&dateTo='+$('#dateTo').val()});
            $("#logGrid").trigger("reloadGrid");
		});
		

		$('#clearSearchLogButton').click(function() {
			$('#searchLog').val('Search log');
			$("#logGrid").setGridParam({url: 'gridLog.htm?searchString='});
            $("#logGrid").trigger("reloadGrid");
		});
		
		jQuery("#logGrid").jqGrid({
			url:'gridLog.htm',
			datatype: "xml",
			colNames:['ID', 'Date', 'Username', 'Priority', 'Category', 'Message'],
			colModel:[
				{name:'ID',index:'logID', width:70, align: 'center'},
				{name:'Date',index:'Date', width:200, align: 'center'},
				{name:'Username',index:'Username', width:150, align: 'center'},
				{name:'Priority',index:'Priority', width:80, align: 'center'},
				{name:'Category',index:'Category', width:400, align: 'left'},
				{name:'Message',index:'Message', width:850, align: 'left'}
			],
			hidegrid: false,
			shrinkToFit:true,
			height: $(window).height()-gridMarginHeight,
			width: $(window).width()-gridMarginWidth,
			rowNum: 25,
			rowList:[25, 50,100,200],
			pager: '#logGridPager',
			sortname: 'logID',
			viewrecords: true,
			sortorder: "desc",
			caption:"Log"
		});
		
		jQuery("#logGrid").jqGrid('navGrid','#logGridPager',{edit:false,add:false,del:false});
		
		$(function() {
			$("#dateFrom").datepicker({
				changeMonth: true,
				changeYear: true,
				dateFormat: 'yy-mm-dd'
			});
		});
		$(function() {
			$("#dateTo").datepicker({
				changeMonth: true,
				changeYear: true,
				dateFormat: 'yy-mm-dd'
			});
		});
		var now = new Date();
		$("#dateFrom").val(now.format("yyyy-mm-01"));
		$("#dateTo").val(now.format("yyyy-mm-dd"));
		
		$(window).bind('resize', function() {
		    $("#logGrid").setGridWidth($(window).width()-gridMarginWidth);
		    $("#logGrid").setGridHeight($(window).height()-gridMarginHeight);
		}).trigger('resize');
	});
</script>
<table border="0" width="100%">
	<tr>
		<td valign="top" align="center">
			<div class="box1" align="left" style="margin: 0px 20px 0px 20px;">
				<div style="margin:5px">
					<input type="search" id="searchLog" value="Search log" style="width: 300px" />
					<input type="text" id="dateFrom" style="width: 80px;" />
					<input type="text" id="dateTo" style="width: 80px;" />
					<input type="checkbox" checked />&nbsp;All
					<input type="checkbox" />&nbsp;Info
					<input type="checkbox" />&nbsp;Warning
					<input type="checkbox" />&nbsp;Error
					&nbsp;
					<button type="button" class="sexybutton sexysimple sexyblue" id="searchLogButton">Search</button>
					<button type="button" class="sexybutton sexysimple sexyblue" id="clearSearchLogButton">Clear</button>
					<button type="button" class="sexybutton sexysimple sexyblue">Export</button>
					<br />
					<table id="logGrid"></table>
					<div id="logGridPager"></div>
				</div>
			</div>
		</td>
	</tr>
</table>
<%@ include file="../template1Footer.jsp" %>
