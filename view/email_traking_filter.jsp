<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib
	prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
<title>Email Tracking Filter</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

	<style type='text/css'>
html, body {
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
	width: 120px;
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

#invDocDiv {
	border: 1px solid rgb(220, 220, 220);
	box-shadow: 5px 10px 18px #888888;
	background-color: white;
	padding-top: 5px;
	padding-left: 30px;
	padding-right: 30px;
	padding-bottom: 5px;
	margin-top: 15px;
}

#surroundingDiv {
	position: relative;
	min-width: 700px;
}

table.contentTable {
	width: 100%;
	page-break-inside: avoid;
}

table {
	page-break-inside: avoid;
}

table {
	display: table;
	border-collapse: separate;
	box-sizing: border-box;
	text-indent: initial;
	border-spacing: 2px;
	border-color: grey;
}
</style>
</head>
<body width='100%' height='100%'>
	<span style="display: none" id="hiddenSource"> <s:property
			value="source" />
	</span>
	<span style="display: none" id="hiddenrecept"> <s:property
			value="emailTrackingRecipientsList" />
	</span>
	<div id='container' width='100%' height='100%'>
		<div id='surroundingDiv' width='100%' height='100%'>
			<div id='invDocDiv' class='content' position='absolute' left='35%'
				top='10%' style='padding-bottom: 10px'>
				<p>
					<h1>Email Tracking Filter</h1>
				</p>
				<!-- general data -->
				<c:set var="emailHist" value="${emailTrackingInfo}" />
				<s:form id='form1' action="EmailHistorySaveUpdate" theme='simple'
					enctype="multipart/form-data">
					<input type="hidden" name="emailTrackingHistoryBean.emailHistSeq"
						value='<s:property value="emailTrackingHistoryBean.emailHistSeq"/>' />
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
										value="" /> <input id="emailHistSeq" required
									style="display: table-cell; width: 99%" type="text"
									name="emailTrackingHistoryBean.subjectName"
									value='<s:property value="%{#session.filter.emailHistoryID}"/>' />
								</td>
							</tr>
							<tr>
								<td class='displayValue' style='text-align: left' width="20%">Subject
									Name:</td>
								<td id="data" background-color='white' class='displayValue'
									style='text-align: left'><input required id="subjectName"
									style="display: table-cell; width: 99%" type="text"
									name="emailTrackingHistoryBean.subjectName"
									value='<s:property value="%{#session.filter.subjectName}"/>' /></td>
							</tr>
							<tr>
								<td class='displayValue' style='text-align: left' width="20%">Body:</td>
								<td id="data" form="usrform" name="body" class='displayValue'
									style='text-align: left' background-color='white'><s:property
										value="EmailTrackingHistoryBean.body" escapeHtml="false" /> <input
									required id="body" style="display: table-cell; width: 99%"
									type="text" name="emailTrackingHistoryBean.subjectName"
									value='<s:property value="%{#session.filter.body}"/>' /></td>
							</tr>
							<tr>
								<td class='displayValue' style='text-align: left' width="20%">System
									Name:</td>
								<td id="data" class='displayValue' style='text-align: left'
									background-color='white'><s:property
										value="EmailTrackingHistoryBean.sysName" /> <input required
									id="sysName" style="display: table-cell; width: 99%"
									type="text" name="emailTrackingHistoryBean.sysName"
									value='<s:property value="%{#session.filter.systemName}"/>' />

								</td>
							</tr>
							<tr>
								<td class='displayValue' style='text-align: left' width="20%">Creation
									Date:</td>

								<td id="data" class='displayValue' style='text-align: left'
									background-color='white'><b>From: </b> <input
									id="filterFromDate" name="filterFromDate" type='text'
									class='datepicker'
									value="<s:date name="#session.filter.creationDateFrom" format="MM/dd/yyyy" />" />
									<b> To: </b> <input id="filterToDate" name="filterToDate"
									type='text' class='datepicker'
									value="<s:date name="#session.filter.creationDateTo" format="MM/dd/yyyy" />" />
								</td>
							</tr>
							<tr>
								<td class='displayValue' style='text-align: left' width="20%">Workspace:</td>
								<td id="data" class='displayValue' style='text-align: left'
									background-color='white'><s:property
										value="EmailTrackingHistoryBean.workspace" /> <select
									id="workspace" class="my_select_box ">
										<option value=""></option>
										<option value="Web">Web</option>
										<option value="Unix">Unix</option>
								</select></td>
							</tr>
						</table>
					</div>
					<br> <!-- Email Tracking Recipients -->
						<div id='firstTableSection'>
							<table class='contentTable'
								style='border-collapse: collapse; margin-top: 10px; border: 1px solid black'
								id="recipientsTable">
								<thead>
									<tr>
										<td class='label' colspan='3'
											style='background-color: gray; color: white'>Recipients
											:</td>
									</tr>
									<tr>
										<td width="70%" class='displayValue'>Recipient Email:</td>
										<td width="15%" class='displayValue'>Recipient Type:</td>
										<td width="15%" class='displayValue'>Delete:</td>
									</tr>
								</thead>
								<tbody id="tbody">
									<s:iterator value="%{#session.filter.recipients}"
										var="emailTrackingRecipient" status="status">
										<tr>
											<td id="data"><input class="attrEmail" required
												style="display: table-cell; width: 98%" type="email"
												id="email" name="email"
												value="<s:property value='#emailTrackingRecipient.rcptEmail' />" />
											</td>
											<td id="data"><select class="my_select_box ">
													<option value="To">
														<s:property value="#emailTrackingRecipient.rcptType" />
													</option>
													<option value="CC">CC</option>
													<option value="BCC">BCC</option>
											</select></td>
											<td style="color: red; text-align: center;" id="data"><label
												class="remove">X</lable></td>
										</tr>
									</s:iterator>
								</tbody>
							</table>
							<div style="margin-top: 5px;">
								<input id="addBtn" class="btn"
									style="background-color: rgb(51, 102, 153);" type='button'
									value="Add">
							</div>
						</div> <br> <!-- Email Tracking Files -->
							<div id='firstTableSection'>
								<table class='contentTable' id="filesTable"
									style='table-layout: auto; border-collapse: collapse; margin-top: 10px; border: 1px solid black'>
									<thead>
										<tr>
											<td class='label' colspan='2'
												style='background-color: gray; color: white'>Files:</td>
										</tr>
										<tr>
											<td width="80%" class='displayValue'>File Path:</td>
											<td width="20%" class='displayValue'>Delete:</td>
										</tr>
									</thead>
									<tbody id="tbody1">
										<s:iterator value="%{#session.filter.emailHistoryID}"
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
								<div>
									<s:if test="source.equals('error') || source.equals('direct')">
										<input type="button" value="Re-Send" class="btn"
											style="background-color: rgb(51, 102, 153); width: 70px"
											id='sendButton' />
										<s:submit value="Re-Send" class="btn" display="none"
											style="background-color: rgb(51, 102, 153); width:70px "
											id='submitButton' />
									</s:if>
								</div>
								<div style="margin-top: 5px;">
									<input id="addBtn1" class="btn"
										style="background-color: rgb(51, 102, 153);" type='button'
										value="Add">
								</div>
								<br> <input type="checkbox" id="hasAnyFileAttachment"
									name="hasAnyFileAttachment" value="hasAnyFileAttachment">
										<label for="hasAnyFileAttachment"> Emails with
											attachment </label> <br> <input type="checkbox"
											id="nonSentEmail" name="nonSentEmail" value="nonSentEmail">
												<label for="nonSentEmail"> Non Sent Emails</label> <br></br>
												<div style="margin-top: 5px;">
													<table>
														<tr>
															<td><input id="ApplyFilter" class="btn"
																style="background-color: rgb(51, 102, 153); width: 120px"
																type='button' value="Apply Filter"></td>
															<td width="5%"></td>
															<td><input id="Close" class="btn"
																style="background-color: rgb(51, 102, 153); width: 120px"
																type='button' value="Close"></td>
															<td width="5%"></td>
															<td><input id="clearFilter" class="btn"
																style="background-color: rgb(51, 102, 153); width: 120px"
																type='button' value="Clear Filter"></td>
														</tr>
													</table>
												</div>
							</div>
				</s:form>
			</div>
		</div>
	</div>
</body>
</html>