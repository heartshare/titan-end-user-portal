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
		color: #505050;
	}
	
	#vmDetailTable td
	{
		padding: 10px;
	}
</style>

<link rel="stylesheet" href="../novnc/include/base.css" />
<link rel="stylesheet" href="../novnc/include/titan.css" />
<script src="../novnc/include/util.js"></script>

<script>
	function wait(title){
		$("#waitDialog").dialog({
			width : 300,
			height : 100,
			title : title,
			modal : true
		});
	}
	
	$(document).ready(function() {
		$('#actions').change(function(){
			var selectedValue=$('#actions').val();
			$('#actions option:first-child').attr("selected", "selected");
			if (selectedValue=='Stop'){
				if (confirm('Confirm to stop vm?')){
					wait();
					var instanceId="${instanceId}";
					
					$.get('<c:out value="${titanServerRestURL}" />/rest/titan/sendCommand.htm?titanCommand=from titan:nova stop&$InstanceId='+instanceId, function(data) {
						
					});
					setTimeout(function(){location.reload();}, 2000);
				}
			}else if (selectedValue=='Soft reboot'){
				if (confirm('Confirm to soft reboot vm?')){
					wait();
					var instanceId="${instanceId}";
					
					$.get('<c:out value="${titanServerRestURL}" />/rest/titan/sendCommand.htm?titanCommand=from titan:nova soft-reboot&$InstanceId='+instanceId, function(data) {
						
					});
					setTimeout(function(){location.reload();}, 2000);
				}
			}else if (selectedValue=='Hard reboot'){
				if (confirm('Confirm to hard reboot vm?')){
					wait();
					var instanceId="${instanceId}";
					
					$.get('<c:out value="${titanServerRestURL}" />/rest/titan/sendCommand.htm?titanCommand=from titan:nova hard-reboot&$InstanceId='+instanceId, function(data) {
						
					});
					setTimeout(function(){location.reload();}, 2000);
				}
			}else if (selectedValue=='Remote'){
				window.location="remote?instanceId=${instanceId}";
			}
		});
	});
</script>

<div align="center">
	<table border="0" width="100%" height="100%" style="max-width:1200px;">
		<tr>
			<td valign="top">
				<div class="box1" style="padding:20px; margin-left:10px; margin-right:10px;">
					<a href="index.htm"><img src="../theme/<fmt:bundle basename="main"><fmt:message key="theme" /></fmt:bundle>/en/image/famfamfam/icons/arrow_left.png">Back</a>
					
					<select style="float: right;" id="actions">
						<option>Actions</option>
						<option>Stop</option>
						<option>Soft reboot</option>
						<option>Hard reboot</option>
						<option>Scale up/down</option>
						<option>Change password</option>
						<option>Remote</option>
						<option>Take snapshot</option>
						<option>Schedule</option>
						<option>Remove</option>
					</select>
					<br>
					<br>
					
					<div id="noVNC_screen">
			            <div id="noVNC_status_bar" class="noVNC_status_bar" style="margin-top: 0px;">
			                <table border=0 width="100%"><tr>
			                    <td><div id="noVNC_status" style="position: relative; height: auto;">
			                        Loading
			                    </div></td>
			                    <td width="1%"><div id="noVNC_buttons">
			                        <input type=button value="Ctrl Alt Del"
			                            id="sendCtrlAltDelButton">
			                        <span id="noVNC_xvp_buttons">
			                        <input type=button value="Shutdown"
			                            id="xvpShutdownButton">
			                        <input type=button value="Reboot"
			                            id="xvpRebootButton">
			                        <input type=button value="Reset"
			                            id="xvpResetButton">
			                        </span>
			                            </div></td>
			                </tr></table>
			            </div>
			            <canvas id="noVNC_canvas" width="640px" height="20px">
			                Canvas not supported.
			            </canvas>
			        </div>
        
					
				</div>
			</td>
		</tr>
	</table>
</div>
<div id="waitDialog" title="" style="display: none;" align="center">
	<br>
	Please wait, updating status
	<br>
</div>
<br>
<script>
	/*jslint white: false */
	/*global window, $, Util, RFB, */
	"use strict";
	
	// Load supporting scripts
	Util.load_scripts(["webutil.js", "base64.js", "websock.js", "des.js",
	                   "keysymdef.js", "keyboard.js", "input.js", "display.js",
	                   "jsunzip.js", "rfb.js"]);
	
	var rfb;
	
	function passwordRequired(rfb) {
	    var msg;
	    msg = '<form onsubmit="return setPassword();"';
	    msg += '  style="margin-bottom: 0px">';
	    msg += 'Password Required: ';
	    msg += '<input type=password size=10 id="password_input" class="noVNC_status">';
	    msg += '<\/form>';
	    $D('noVNC_status_bar').setAttribute("class", "noVNC_status_warn");
	    $D('noVNC_status').innerHTML = msg;
	}
	function setPassword() {
	    rfb.sendPassword($D('password_input').value);
	    return false;
	}
	function sendCtrlAltDel() {
	    rfb.sendCtrlAltDel();
	    return false;
	}
	function xvpShutdown() {
	    rfb.xvpShutdown();
	    return false;
	}
	function xvpReboot() {
	    rfb.xvpReboot();
	    return false;
	}
	function xvpReset() {
	    rfb.xvpReset();
	    return false;
	}
	function updateState(rfb, state, oldstate, msg) {
	    var s, sb, cad, level;
	    s = $D('noVNC_status');
	    sb = $D('noVNC_status_bar');
	    cad = $D('sendCtrlAltDelButton');
	    switch (state) {
	        case 'failed':       level = "error";  break;
	        case 'fatal':        level = "error";  break;
	        case 'normal':       level = "normal"; break;
	        case 'disconnected': level = "normal"; break;
	        case 'loaded':       level = "normal"; break;
	        default:             level = "warn";   break;
	    }
	
	    if (state === "normal") {
	        cad.disabled = false;
	    } else {
	        cad.disabled = true;
	        xvpInit(0);
	    }
	
	    if (typeof(msg) !== 'undefined') {
	        sb.setAttribute("class", "noVNC_status_" + level);
	        s.innerHTML = msg;
	    }
	}
	
	function xvpInit(ver) {
	    var xvpbuttons;
	    xvpbuttons = $D('noVNC_xvp_buttons');
	    if (ver >= 1) {
	        xvpbuttons.style.display = 'inline';
	    } else {
	        xvpbuttons.style.display = 'none';
	    }
	}
	
	window.onscriptsload = function () {
	    var host, port, password, path, token;
	
	    $D('sendCtrlAltDelButton').style.display = "inline";
	    $D('sendCtrlAltDelButton').onclick = sendCtrlAltDel;
	    $D('xvpShutdownButton').onclick = xvpShutdown;
	    $D('xvpRebootButton').onclick = xvpReboot;
	    $D('xvpResetButton').onclick = xvpReset;
	
	    WebUtil.init_logging(WebUtil.getQueryVar('logging', 'warn'));
	    // By default, use the host and port of server that served this file
	    host = '210.5.164.14';//WebUtil.getQueryVar('host', window.location.hostname);
	    port = 6002;//WebUtil.getQueryVar('port', window.location.port);
	
	    // if port == 80 (or 443) then it won't be present and should be
	    // set manually
	    if (!port) {
	        if (window.location.protocol.substring(0,5) == 'https') {
	            port = 443;
	        }
	        else if (window.location.protocol.substring(0,4) == 'http') {
	            port = 80;
	        }
	    }
	
	    // If a token variable is passed in, set the parameter in a cookie.
	    // This is used by nova-novncproxy.
	    token = WebUtil.getQueryVar('token', null);
	    if (token) {
	        WebUtil.createCookie('token', token, 1)
	    }
	
	    password = 'ppffrmit';//WebUtil.getQueryVar('password', '');
	    path = WebUtil.getQueryVar('path', 'websockify');
	
	    if ((!host) || (!port)) {
	        updateState('failed',
	            "Must specify host and port in URL");
	        return;
	    }
	
	    rfb = new RFB({'target':       $D('noVNC_canvas'),
	                   'encrypt':      WebUtil.getQueryVar('encrypt',
	                            (window.location.protocol === "https:")),
	                   'repeaterID':   WebUtil.getQueryVar('repeaterID', ''),
	                   'true_color':   WebUtil.getQueryVar('true_color', true),
	                   'local_cursor': WebUtil.getQueryVar('cursor', true),
	                   'shared':       WebUtil.getQueryVar('shared', true),
	                   'view_only':    WebUtil.getQueryVar('view_only', false),
	                   'updateState':  updateState,
	                   'onXvpInit':    xvpInit,
	                   'onPasswordRequired':  passwordRequired});
	    rfb.connect(host, port, password, path);
	};
</script>
<%@ include file="../template1Footer.jsp" %>
