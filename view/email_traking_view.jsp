<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib
	prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<title>Email Tracking History</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" href="/common/css/dcintranet.css"
		type="text/css" />
	<link rel="stylesheet" href="/common/css/cair.css" type="text/css" />
	<link rel='stylesheet' href='/RegulatoryDocs/css/invdoc.css?v=1.0'
		type='text/css' />
	<link rel='stylesheet' href='/common/css/jquery-custom.css'
		type='text/css' />
	<link rel='stylesheet' href='/common/css/chosen.css' type='text/css' />
	<link rel='stylesheet' type='text/css'
		href='/common/css/tooltips_dfss_invdoc.css' />
	<link rel='stylesheet' type='text/css'
		href='/common/css/alertify.min.css' />

	<script type='text/javascript' src="/common/js/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="/common/js/alertify.min.js"></script>


<style type='text/css'>
#data {
	background-color: white;
	border: 0.5px solid gray;
	font-weight: normal;
	font-family: Arial;
	font-size: 9pt;
	color: black;
	font-size: 9pt;
	font-family: Arial, Helvetica;
	border-style: outset;
	border-color: #E0E0E0;
	border-width: thin;
}
</style>

	<script type='text/JavaScript'>
	
	function updateURLParameter(url, param, paramVal){
	    var newAdditionalURL = "";
	    var tempArray = url.split("?");
	    var baseURL = tempArray[0];
	    var additionalURL = tempArray[1];
	    var temp = "";
	    if (additionalURL) {
	        tempArray = additionalURL.split("&");
	        for (var i=0; i<tempArray.length; i++){
	            if(tempArray[i].split('=')[0] != param){
	                newAdditionalURL += temp + tempArray[i];
	                temp = "&";
	            }
	        }
	    }

	    var rows_txt = temp + "" + param + "=" + paramVal;
	    return baseURL + "?" + newAdditionalURL + rows_txt;
	}
	
		
		$(document).ready(function(e) {
						
			
			alertify.defaults.movable = false;

			alertify.defaults.maximizable = false

			window.alert = function(message) {

				alertify.alert(message).set({
					title : "alert"
				});

			};

			window.confirm = function(message, action, cancel) {

				alertify.confirm(message, action, cancel).set({
					title : "Confirmation"
				});

			};


			if ($("#hiddenSource").text().toString().trim() == "success") {
				setTimeout(function() {
					alert("The email was succesfully resent");
				}, 100);
				window.opener.location.reload()
				
			//
			var newURL = updateURLParameter(window.location.href, 'source', 'stop');
            newURL = updateURLParameter(newURL, 'source', 'stop');
            window.history.replaceState('', '', updateURLParameter(window.location.href, 'source', 'stop'));
			//
				
			} else if ($("#hiddenSource").text().toString().trim() == "error") {
				setTimeout(function() {
					alert("The email was not succesfully resent");
				}, 1000);
				window.opener.location.reload()
			}
		});
	</script>
</head>
<body>
	<span style="display: none" id="hiddenSource"> <s:property
			value="source" />
	</span>
	<span style="display: none" id="reqNo"> <s:property
			value="reqNo" />
	</span>
	<div id="page-cover"></div>
	<div id='surroundingDiv'>
		<div id='invDocDiv' class='content' style='padding-bottom: 10px'>
			<!-- general data -->
			<c:set var="emailHist" value="${emailTrackingInfo}" />
			<div id='firstTableSection'>
				<table class='contentTable'
					style='table-layout: auto; border-collapse: collapse; margin-top: 10px; border: 1px solid black'>
					<tr>
						<td class='label' colspan='2'
							style='background-color: gray; color: white'>Email History /
							General Data:</td>
					</tr>
					<tr>
						<td class='displayValue' style='text-align: left' width="20%">Email
							History ID:</td>
						<td id="data" style='text-align: left' background-color='white'>
							<s:property value="emailTrackingHistoryBean.emailHistSeq" />
						</td>
					</tr>
					<tr>
						<td class='displayValue' style='text-align: left' width="20%">Subject
							Name:</td>
						<td id="data" background-color='white' class='displayValue'
							style='text-align: left'><s:property
								value="emailTrackingHistoryBean.subjectName" /></td>
					</tr>
					<tr>
						<td class='displayValue' style='text-align: left' width="20%">Body:</td>
						<td id="data" class='displayValue' style='text-align: left'
							background-color='white'><s:property
								value="emailTrackingHistoryBean.body" escapeHtml="false" /></td>
					</tr>
					<tr>
						<td class='displayValue' style='text-align: left' width="20%">System
							Name:</td>
						<td id="data" class='displayValue' style='text-align: left'
							background-color='white'><s:property
								value="emailTrackingHistoryBean.sysName" /></td>
					</tr>
					<tr>
						<td class='displayValue' style='text-align: left' width="20%">Creation
							Date:</td>
						<td id="data" class='displayValue' style='text-align: left'
							background-color='white'> 
							<s:date format="MM/dd/yyyy HH:mm:ss"
								name="emailTrackingHistoryBean.creationDate" /></td>
					</tr>
					<tr>
						<td class='displayValue' style='text-align: left' width="20%">From:</td>
						<td id="data" class='displayValue' style='text-align: left'
							background-color='white'><s:property
								value="emailTrackingHistoryBean.from" /></td>
					</tr>
					<tr>
						<td class='displayValue' style='text-align: left' width="20%">Workspace:</td>
						<td id="data" class='displayValue' style='text-align: left'
							background-color='white'><s:property
								value="emailTrackingHistoryBean.workspace" /></td>
					</tr>
				</table>

				<br> <!-- Email Tracking Recipients -->
					<div id='firstTableSection'>
						<table class='contentTable'
							style='table-layout: fixed; border-collapse: collapse; margin-top: 10px; border: 1px solid black'>
							<thead>
								<tr>
									<td class='label' colspan='3'
										style='background-color: gray; color: white'>Email
										Tracking Recipients :</td>
								</tr>
								<tr>
									<td class='displayValue'>Email Recipient No:</td>

									<td class='displayValue'>Recipient Email:</td>
									<td class='displayValue'>Recipient Type:</td>
								</tr>
							</thead>
							<tbody>
								<s:iterator value="emailTrackingRecipientsList"
									var="emailTrackingRecipient">
									<tr>
										<td id="data"><s:property
												value="#emailTrackingRecipient.emailRcptSeq" /></td>
										<td id="data"><label><s:property
													value="#emailTrackingRecipient.rcptEmail" /> </label></td>
										<td id="data"><s:property
												value="#emailTrackingRecipient.rcptType" /></td>
									</tr>
								</s:iterator>
							</tbody>
						</table>
						<br> <!-- Email Tracking Files -->
							<div id='firstTableSection'>
								<table class='contentTable'
									style='table-layout: auto; border-collapse: collapse; margin-top: 10px; border: 1px solid black'>
									<thead>
										<tr>
											<td class='label' colspan='2'
												style='background-color: gray; color: white'>Email
												Tracking Files :</td>
										</tr>
										<tr>
											<td width="20%" class='displayValue'>Email File No:</td>
											<td width="80%" class='displayValue'>File Path:</td>
										</tr>
									</thead>
									<tbody>
										<s:iterator value="emailTrackingFilesList"
											var="emailTrackingFile">

											<tr>
												<td width="20%" id="data"><s:property
														value="#emailTrackingFile.emailFileSeq" /></td>
												<td width="80%" id="data"><s:property
														value="#emailTrackingFile.filePath" /></td>
											</tr>
										</s:iterator>

									</tbody>
								</table>
								<br>
</body>
</html>
