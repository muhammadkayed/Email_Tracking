<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib
	prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<title>Re-Send Email</title>
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
	<script type="text/javascript" src="/common/js/waitScreenAuto.js?v=1.2"></script>

	<style type='text/css'>
	html,body{
	max-height: 90vh;
	}
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
	contenteditable: true
}

.btn {
	background-color: darkgray;
	border: none;
	color: white;
	width: 60px;
	border-radius: 12px;
	padding-top: 6px;
	padding-bottom: 6px;
	font-size: 13px;
	cursor: pointer;
	box-shadow: 5px 7px 10px rgba(0, 0, 0, .5);
	box-shadow: 3px 5px 8px rgba(0, 0, 0, .5);
}

#alertBox {
	position: relative;
	width: 300px;
	min-height: 100px;
	margin-top: 50px;
	border: 1px solid #666;
	background-color: #fff;
	background-repeat: no-repeat;
	background-position: 20px 30px;
}
</style>

	<script type='text/JavaScript'>
	
	
	$(document).ready(function(){
	    document.getElementById("submitButton").style.display = "none";
		$("#sendButton").click(function(e){
			var x = document.getElementById("recipientsTable").rows.length;
			if (x <= 2) {
					alert("There are no recepients ");
			} else {
			alertify.confirm("Do you really want to send the email?",submit,"" ).set({title:"Confirmation"});
			}
		});
	});

	function submit() {
		$("#submitButton").click();
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
	<span style="display: none" id="hiddenrecept"> <s:property
			value="emailTrackingRecipientsList" />
	</span>
	<div id='surroundingDiv'>
		<div id='invDocDiv' class='content' style='padding-bottom: 10px'>
			<!-- general data -->
			<c:set var="emailHist" value="${emailTrackingInfo}" />
			<s:form  id='form1' action="EmailHistorySaveUpdate" theme='simple'
				enctype="multipart/form-data"> 
				<input type="hidden" name="emailTrackingHistoryBean.emailHistSeq"
					value='<s:property value="emailTrackingHistoryBean.emailHistSeq"/>'/>
				<input type="hidden" name="emailTrackingHistoryBean.from"
					value='<s:property value="emailTrackingHistoryBean.from"/>' />
				<input type="hidden" name="command" value="saveUpdate"></input>
				<input type="hidden" name="emailHistSeq"
					value="${emailHist.emailHistSeq}"></input>
				<div id='firstTableSection'>
					<table class='contentTable'
						style='table-layout: auto; border-collapse: collapse; margin-top: 10px; border: 1px solid black'>
						<tr>
							<td class='label' colspan='2'
								style='background-color: gray; color: white'>Email History
								/ General Data:</td>
						</tr>
						<tr>
							<td class='displayValue' style='text-align: left' width="20%">Email
								History ID:</td>
							<td id="data" style='text-align: left' background-color='white'><s:property
									value="EmailTrackingHistoryBean.emailHistSeq" /></td>
						</tr>
						<tr>
							<td class='displayValue' style='text-align: left' width="20%">Subject
								Name:</td>
							<td id="data" background-color='white' class='displayValue'
								style='text-align: left'><input required
								style="display: table-cell; width: 100%" type="text"
								name="emailTrackingHistoryBean.subjectName"
								value='<s:property value="emailTrackingHistoryBean.subjectName"/>' /></td>
						</tr>
						<tr>
							<td class='displayValue' style='text-align: left' width="20%">Body:</td>
							<td id="data" form="usrform" name="body" class='displayValue'
								style='text-align: left' background-color='white'><s:property
									value="EmailTrackingHistoryBean.body" escapeHtml="false" /></td>
						</tr>
						<tr>
							<td class='displayValue' style='text-align: left' width="20%">System
								Name:</td>
							<td id="data" class='displayValue' style='text-align: left'
								background-color='white'><s:property
									value="EmailTrackingHistoryBean.sysName" /></td>
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
									value="EmailTrackingHistoryBean.from" /></td>
						</tr>
						<tr>
							<td class='displayValue' style='text-align: left' width="20%">Workspace:</td>
							<td id="data" class='displayValue' style='text-align: left'
								background-color='white'><s:property
									value="EmailTrackingHistoryBean.workspace" /></td>
						</tr>
					</table>
				</div>
				<br> <!-- Email Tracking Recipients -->
					<div id='firstTableSection'>
						<table class='contentTable'
							style='table-layout: fixed; border-collapse: collapse; margin-top: 10px; border: 1px solid black' id="recipientsTable">
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
									var="emailTrackingRecipient" status="status">
									<tr>
										<td id="data"><s:property
												value="#emailTrackingRecipient.emailRcptSeq" /> <input
											type="hidden" style="display: table-cell; width: 100%"
											type="text"
											name="emailTrackingRecipientsList[<s:property value='#status.index' />].emailRcptSeq"
											value="<s:property value='#emailTrackingRecipient.emailRcptSeq' />" />
										</td>
										<td id="data"><input type="email" required
											style="display: table-cell; width: 100%"
											name="emailTrackingRecipientsList[<s:property value='#status.index' />].rcptEmail"
											value="<s:property value='#emailTrackingRecipient.rcptEmail' />" />
										</td>
										<td id="data"><s:property
												value="#emailTrackingRecipient.rcptType" /> <input
											type="hidden" style="display: table-cell; width: 100%"
											type="text"
											name="emailTrackingRecipientsList[<s:property value='#status.index' />].rcptType"
											value="<s:property value='#emailTrackingRecipient.rcptType' />" />
										</td>
									</tr>
								</s:iterator>
							</tbody>
						</table>
					</div> <br> <!-- Email Tracking Files -->
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
								<div>
									<s:if test="source.equals('error') || source.equals('direct')">
										<input type="button" value="Re-Send" class="btn"
											style="background-color: rgb(51, 102, 153); width:70px "  id='sendButton'/>			
													<s:submit value="Re-Send" class="btn" display = "none"
											style="background-color: rgb(51, 102, 153); width:70px "  id='submitButton'/>		
									</s:if>
								</div> <br>
						</div>
			</s:form>
		</div>
	</div>
</body>
</html>