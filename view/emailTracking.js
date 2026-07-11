var nonSent = "no";
var hasAnyFileAttachment = "no;"

function validateEmail(email) {
	var emailReg = '/^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/';
	return emailReg.test(email);
}
$(".attrEmail").validate({
	rules : {
		emailfield : {
			required : true,
			email : true
		}
	}
});

function filterShow() {
	$("#filterModal").fadeIn(1000);
	$("#filterModal").css("z-index", "999");
	$("#page-cover").css("opacity", "0.2");
	$("#page-cover").css("z-index", "0");
	var nodes = document.getElementById("page-cover").getElementsByTagName('*');
	for (var i = 0; i < nodes.length; i++) {
		nodes[i].disabled = true;
	}
	$("#page-cover").children().prop('disabled', true);
	$("#table0").children().prop('disabled', true);
	$("#table0 *").attr("disabled", "disabled");
	$("a").addClass('disabled');
}

$(document).ready(function() {

	$(".my_select_box").chosen({
		disable_search : false,
		width : "99%",
		search_contains : "true"
	});

	$(".datepicker").datepicker({
		shortYearCutoff : 1,
		changeMonth : true,
		changeYear : true,
		dateFormat : 'mm/dd/yy'
	});

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

	function getFormattedDate(date) {
		var d = date.getDate();
		var m = date.getMonth() + 1;
		var y = date.getFullYear();
		var h = date.getHours();
		var min = date.getMinutes();
		var s = date.getSeconds();
		var dateString = (m <= 9 ? '0' + m : m) + '/'
				+ (d <= 9 ? '0' + d : d) + '/' + y + ' '
				+ (h <= 9 ? '0' + h : h) + ':'
				+ (min <= 9 ? '0' + min : min) + ':'
				+ (s <= 9 ? '0' + s : s);
		return dateString;
	}

	$(document).ajaxStart(function() {
		$("#loadScreen").fadeIn(1000);
		$("body").css("opacity", "0.5");
	});

	$(document).ajaxComplete(function() {
		$("body").css("opacity", "1");
		$("#loadScreen").fadeOut(1000);
	});

	var table = $('#table0')
			.DataTable(
					{
						"processing" : true,
						"serverSide" : true,
						"scrollY" : "70vh",
						"scrollCollapse" : false,
						"paging" : true,
						"pageLength" : 50,
						"deferRender" : true,
						"bFilter" : true,
						"order" : [ 0, "desc" ],
						"lengthMenu" : [ 10, 25, 50, 100, 250,
								500, 1000 ],
						"language" : {
							"loadingRecords" : "Please wait - loading ..."
						},
						"columns" : [
								{
									"data" : "emailHistSeq",
									className : 'value',
									render : function(data,
											type, row) {
										if (row.sentDate == null
												|| row.sentDate == "") {
											className: 'notsend'
											if (type === 'display'
													|| type === 'filter') {
												return '<div style="text-align: center; color: red; font_weight: bold; border-width:thin; "> '
														+ data
														+ '  <br>  ( <a style="text-align: center" href="/prdev/dapis/emailtracking/EmailHistoryView?emailHistSeq='
														+ data
														+ '" target=_blank>'
														+ 'View'
														+ '</a> ) , ( <a style="text-align: center" href="/prdev/dapis/emailtracking/EmailHistoryUpdate?emailHistSeq='
														+ data
														+ '&source=direct" target=_blank>'
														+ 'Re-Send'
														+ '</a> ) </div>'
											}
										} else {
											className: 'value'
											if (type === 'display'
													|| type === 'filter') {
												return '<div style="text-align: center"> '
														+ data
														+ '  <br>  ( <a style="text-align: center" href="/prdev/dapis/emailtracking/EmailHistoryView?emailHistSeq='
														+ data
														+ '" target=_blank>'
														+ 'View'
														+ '</a> ) </div>'
											}
										}
									}
								},
								{
									"data" : "creationDate",
									className : 'value',
									render : function(data,
											type, row) {
										if (row.sentDate == null
												|| row.sentDate == "") {
											className: 'notsend'
											if (type === 'display'
													|| type === 'filter') {
												var d = new Date(
														data);
												return '<div style="text-align: center; border-width:thin; color:red "> '
														+ getFormattedDate(d)
														+ ' </div>';
											}
										} else if (type === 'display'
												|| type === 'filter') {
											className: 'value'
											var d = new Date(
													data);
											return '<div style="text-align: center; border-width:thin; "> '
													+ getFormattedDate(d)
													+ ' </div>';
										}
									}
								},
								{
									"data" : "sentDate",
									"visible" : false,
									render : function(data,
											type, row) {
										var d = new Date(data);
										if (d == null) {
											return ' <div style="text-align: center">  </div> ';
										} else {
											return '<div style="text-align: center"> '
													+ (d
															.getFullYear()
															+ '-'
															+ d
																	.getMonth()
															+ 1
															+ '-'
															+ d
																	.getDate()
															+ ' '
															+ d
																	.getHours()
															+ ':'
															+ d
																	.getMinutes()
															+ ':' + d
															.getSeconds())
													+ ' </div>';
										}
									}
								},
								{
									"data" : "subjectName",
									className : 'value',
									render : function(data,
											type, row) {
										if (row.sentDate == null
												|| row.sentDate == "") {
											className: 'notsend'
											if (type === 'display'
													|| type === 'filter') {
												return '<div style="text-align: left; color: red; font_weight: bold; border-width:thin; "> '
														+ data
														+ ' </div>';
											}
										} else if (type === 'display'
												|| type === 'filter') {
											className: 'value'
											return '<div style="text-align: left; border-width:thin; "> '
													+ data
													+ '</div>';
										}
									}
								},
								{
									"data" : "sysName",
									className : 'value',
									render : function(data,
											type, row) {
										if (row.sentDate == null
												|| row.sentDate == "") {
											className: 'notsend'
											if (type === 'display'
													|| type === 'filter') {
												return '<div style="text-align: center; color: red; font_weight: bold; border-width:thin; "> '
														+ data
														+ ' </div>';
											}
										} else if (type === 'display'
												|| type === 'filter') {
											className: 'value'
											return '<div style="text-align: center; border-width:thin; "> '
													+ data
													+ '</div>';
										}
									}
								},
								{
									"data" : "workspace",
									className : 'value',
									render : function(data,
											type, row) {
										if (row.sentDate == null
												|| row.sentDate == "") {
											className: 'notsend'
											if (type === 'display'
													|| type === 'filter') {
												return '<div style="text-align: center; color: red; font_weight: bold; border-width:thin; "> '
														+ data
														+ ' </div>';
											}
										} else if (type === 'display'
												|| type === 'filter') {
											className: 'value'
											return '<div style="text-align: center; border-width:thin; "> '
													+ data
													+ '</div>';
										}
									}
								} ],
						"columnDefs" : [],
						"dataType" : "json",
						"contentType" : "application/json;charset=utf-8",
						"ajax" : {
							"url" : "/prdev/dapis/emailtracking/rest/EmailTrackingLoading",
							"type" : "POST",
							"data" : {
								"searchString" : function() {
									return $("#searchbox")
											.val()
								},
								"nonSent" : function() {
									return nonSent
								},// $("#isNonSent").val() },
								"hasAnyFileAttachment" : function() {
									return hasAnyFileAttachment
								},
								"emailHistSeq" : function() {
									return $("#emailHistSeq")
											.val()
								},
								"subjectName" : function() {
									return $("#subjectName")
											.val()
								},
								"body" : function() {
									return $("#body").val()
								},
								"sysName" : function() {
									return $("#sysName").val()
								},
								"creationDateFrom" : function() {
									return $("#filterFromDate")
											.val()
								},
								"creationDateTo" : function() {
									return $("#filterToDate")
											.val()
								},
								"workspace" : function() {
									return $("#workspace")
											.val()
								},
								"files" : function() {
									var ary = [];
									$('#filesTable tr')
											.each(
													function() {
														var filePath = $(
																this)
																.find(
																		'td:eq(0)')
																.find(
																		"input")
																.val();
														ary
																.push({
																	filePath : filePath
																});
													});
									return JSON.stringify(ary)
								},
								"recipients" : function() {
									var ary = [];
									$('#recipientsTable tr')
											.each(
													function() {
														var rcptEmail = $(
																this)
																.find(
																		'td:eq(0)')
																.find(
																		"input")
																.val();
														var rcptType = $(
																this)
																.children(
																		"td:eq(1)")
																.find(
																		".my_select_box")
																.val();
														ary
																.push({
																	rcptEmail : rcptEmail,
																	rcptType : rcptType
																});
													});
									return JSON.stringify(ary);
								}
							}
						},
						"fnInitComplete" : function(oSettings,
								json) {
							$('#table0 tbody tr:first').click();
						}
					});

	$.fn.dataTable.ext.errMode = 'none';
	$('#searchbox').keypress(function(e) {
		var key = e.which;
		if (key == 13) {
			table.ajax.reload();
		}
	});
	$('#nonSentEmails').on('click', function(e) {
		nonSent = "yes";
		nonSent = "yes";
		$("#isNonSent").val('yes');
		table.ajax.reload();
	});

	$('#ApplyFilter').on('click', function(e) {
		closeFilter();
		table.ajax.reload();
	});

	$('#clearFilter').on('click', function() {
		document.getElementById("emailHistSeq").value = '';
		document.getElementById("subjectName").value = '';
		document.getElementById("body").value = '';
		document.getElementById("sysName").value = '';
		document.getElementById("filterFromDate").value = '';
		document.getElementById("filterToDate").value = '';
		document.getElementById("workspace").value = '';
		$("#workspace").val("").trigger("chosen:updated");
		$("a").removeClass('disabled');
		$('#tbody').html("");
		$('#tbody1').html("");
		$("#hasAnyFileAttachment").prop("checked", false);
		$("#nonSentEmail").prop("checked", false);
		nonSent = "no";
		hasAnyFileAttachment = "no";
	});

	$('#Close').on('click', function() {
		closeFilter();
	});

$('#addBtn').on('click',function() {
			$(".my_select_box").chosen({
				disable_search : false,
				width : "99%",
				search_contains : "true"
			});
			$('#tbody')
					.append(
							' <tr > <td id="data">  <input class="attrEmail" required style="display: table-cell; width: 98%" type="email" id="email" name="email"> </td>   <td id="data">   <select class="my_select_box ">  <option value="To">To</option>   <option value="CC">CC</option> 	<option value="BCC">BCC</option>  </select>   </td>    <td  style="color:red;text-align: center;" id="data">    <label  class="remove" style="color:red;" >X</lable></td>  </tr>  ');
			$(".my_select_box").chosen({
				disable_search : false,
				width : "99%",
				search_contains : "true"
			});
		});

	$('#tbody').on('click', '.remove', function() {
		$(this).closest('tr').remove();
	});

	$('#addBtn1')
			.on('click',
					function() {

						$('#tbody1').append(' <tr >    <td id="data"> <input required style="display: table-cell; width: 99%" type="text" />  </td>   <td  style="color:red;text-align: center;" id="data">    <label  class="remove"  style="color:red;" >X</lable></td>  </tr>  ');

					});

	$('#tbody1').on('click', '.remove', function() {
		$(this).closest('tr').remove();
	});

	$('input[type=checkbox][name=nonSentEmail]').change(
			function() {
				if ($(this).is(':checked')) {
					nonSent = "yes";
				} else {
					nonSent = "no";
				}
			});

	$('input[type=checkbox][name=hasAnyFileAttachment]')
			.change(function() {
				if ($(this).is(':checked')) {
					hasAnyFileAttachment = "yes";
				} else {
					hasAnyFileAttachment = "no";
				}
			});
	});

function closeFilter() {
	$("#filterModal").fadeOut(1000);
	$("#filterModal").css("z-index", "0");
	$("#page-cover").css("opacity", "1");
	$("#page-cover").css("z-index", "999");
	var nodes = document.getElementById("page-cover").getElementsByTagName('*');
	for (var i = 0; i < nodes.length; i++) {
		nodes[i].disabled = false;
	}
	$("#page-cover").children().prop('disabled', false);
	$("#table0").children().prop('disabled', false);
	$("#table0 *").attr("disabled", false);
	$("a").attr('href');
}
