<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Email Tracking Dashboard</title>

<link rel="stylesheet" type="text/css" href="/common/css/cair.css">
<link rel="stylesheet" type="text/css" href="/common/css/dcintranet.css">
<link rel='stylesheet' type='text/css'
	href='/common/css/tooltips_dfss.css' />
<link rel='stylesheet' href='/common/css/jquery-custom.css'
	type='text/css' />
<link rel='stylesheet' href='/common/css/jquery-custom.css'
	type='text/css' />
<link rel='stylesheet' href='/common/css/chosen.min.css' type='text/css' />
<link rel='stylesheet' href='/common/css/buttons.dataTables.min.css' />
<link rel='stylesheet' href='/common/css/jquery.dataTables.min.css' />
<script type='text/javascript' src="/common/js/jquery-1.8.3.js"></script>
<script type='text/JavaScript' src="/common/js/jquery.dataTables.min.js"></script>
<script type='text/JavaScript' src="/common/js/dataTables.scroller.min.js"></script>

<style type='text/css'>

.dataTables_filter {
	display: none;
}

#loadScreen {
background-color:rgb(37, 37, 37);
padding: 20px;
	border-radius: 7px;
	border: 1px solid black;
	 min-width: 200px;
	min-height:200px;
	font-family: Times New Roman Georgia !important;
	position: absolute;
	top: 43%;
	left: 48%;
	-webkit-transform: translate(-50%, -50%);
	-moz-transform: translate(-50%, -50%);
	transform: translate(-50%, -50%);
display: none;
}

#loadspan {
min-width: 97%;
font-size:17px;
font-family: Lucida Console;
top: 75px;
left:40%;
color:blue;
position: absolute;
}

#message{
position: absolute;
top: 150px;
left:40%;
}
#notsend {
	color: red;
	font_weight: bold;
}

.notsend {
	color: red;
	font_weight: bold;
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

.value {
	border-width: thin;
}

.subjectvalue {
	border-width: thin;
}

.search {
	margin-left: 5px;
	background: rgb(240, 240, 240);
	border-radius: 12px;
	border: 1px solid lightgray;
	height: 16px;
	color: darkslategray;
	height: 14px;
	padding-bottom: 6px;
	text-align: center;
	width: 180px;
	padding: 5px;
	-webkit-transition: width 0.4s ease-in-out;
	transition: width 0.4s ease-in-out;
	font-weight: bold;
	font: normal 12px Arial, Helvetica, sans-serif;
}

.search:focus {
	width: 300px;
}

</style>

<script>

	$(document).ready(function() {
 
		function getFormattedDate(date) {
			var d = date.getDate();
			var m = date.getMonth() + 1;
			var y = date.getFullYear();
			var h = date.getHours();
			var min = date.getMinutes();
			var s = date.getSeconds();
			var dateString =  (m <= 9 ? '0' + m : m) + '/'+ (d <= 9 ? '0' + d : d)  + '/' + y +' '+(h <= 9 ? '0' + h : h)+':'+(min <= 9 ? '0' + min : min)+':'+(s <= 9 ? '0' + s : s) ;
			return dateString;
			}

		$(document).ajaxStart(function() {
		    $("#loadScreen").fadeIn(1000);
		    $("body").css("opacity","0.5");
		});

		$(document).ajaxComplete(function() {
			$("body").css("opacity","1");
			   $("#loadScreen").fadeOut(1000);
		});
		
		$("#isNonSent").val("no");
		
		  var table = $('#table0').DataTable({
			   "processing": true,
		        "serverSide": true,
		        "scrollY" : "70vh",
				"scrollCollapse" : false,
				"paging" : true,
				 "pageLength": 50,
				"deferRender" : true,
				"bFilter" : true,
				"order" : [0, "desc"],
				"lengthMenu":  [10, 25, 50, 100,250,500,1000],
			  "language": {
				  "loadingRecords": "Please wait - loading ..."
			  },
		        "columns": [
		        	{ "data": "emailHistSeq",
		            	className: 'value',
		            	
		         	   render: function ( data, type, row ) {
		            		
		         			 if (row.sentDate == null || row.sentDate == "") {
		            			 className: 'notsend'
		            				 if ( type === 'display' || type === 'filter' ) {
		            		  return  '<div style="text-align: center; color: red; font_weight: bold; border-width:thin; "> '+data+'  <br>  ( <a style="text-align: center" href="/prdev/dapis/emailtracking/EmailHistoryView?emailHistSeq='+data+'" target=_blank>'+'View'+'</a> ) , ( <a style="text-align: center" href="/prdev/dapis/emailtracking/EmailHistoryUpdate?emailHistSeq='+data+'&source=direct" target=_blank>'+'Re-Send'+'</a> ) </div>'
		            		 }
		            		 } else {
		            			 className: 'value'
		            				 if ( type === 'display' || type === 'filter' ) {
				    		        return  '<div style="text-align: center"> '+data+'  <br>  ( <a style="text-align: center" href="/prdev/dapis/emailtracking/EmailHistoryView?emailHistSeq='+data+'" target=_blank>'+'View'+'</a> ) </div>'
		            			 }
		            		 }
		            		 }
		            }, 
		            { "data": "creationDate",
		            	className: 'value',
		            	   render: function ( data, type, row ) { 
		            		 if (row.sentDate == null || row.sentDate == "") {
		            			 className: 'notsend'
		            			 if ( type === 'display' || type === 'filter' ) {
			            	          var d = new Date( data );
			            	          return '<div style="text-align: center; border-width:thin; color:red "> '+ getFormattedDate(d) +' </div>'; 
		            			 }
		            		   }  else if ( type === 'display' || type === 'filter' ) {
		            				className: 'value'
		            	           var d = new Date( data );
                               return '<div style="text-align: center; border-width:thin; "> '+ getFormattedDate(d) +' </div>'; 
		            		   }
		            	    } 
		            },
		            { "data": "sentDate",
		            	"visible": false,
		            	   render: function ( data, type, row ) {
		            		   var d = new Date( data );
		            		   if (d ==null) {
		            			   return   ' <div style="text-align: center">  </div> ';
		            		   } else {
		            			   return  '<div style="text-align: center"> '+(d.getFullYear()+'-'+ d.getMonth()+1 +'-'+ d.getDate()+' '+d.getHours()+':'+d.getMinutes()+':'+d.getSeconds())+' </div>'; 
		            		   } 
		            	   }
		            }, 
		            { "data": "subjectName",
		            	className: 'value',
                           render: function ( data, type, row ) { 
		            		 if (row.sentDate == null || row.sentDate == "") {
		            			 className: 'notsend'
		            			 if ( type === 'display' || type === 'filter' ) {  
			            	            return   '<div style="text-align: left; color: red; font_weight: bold; border-width:thin; "> '+data+' </div>';    	
			            	        } 
		            		   }  else if ( type === 'display' || type === 'filter' ) {
		            				className: 'value' 
		            	            return   '<div style="text-align: left; border-width:thin; "> '+data+'</div>';      
		            	        }   
		            	    }
		            },
		            { "data": "sysName",
		            	className: 'value',
		                render: function ( data, type, row ) { 
		            		 if (row.sentDate == null || row.sentDate == "") {
		            			 className: 'notsend'
		            			 if ( type === 'display' || type === 'filter' ) {
			            	            return   '<div style="text-align: center; color: red; font_weight: bold; border-width:thin; "> '+data+' </div>';	
			            	        }
		            		   }  else if ( type === 'display' || type === 'filter' ) {
		            				className: 'value'
		            	            return   '<div style="text-align: center; border-width:thin; "> '+data+'</div>';    
		            	        }
		            	    }	   
		            },
		            { "data": "workspace" , 
		            	className: 'value',
		                render: function ( data, type, row ) { 
		            		 if (row.sentDate == null || row.sentDate == "") {
		            			 className: 'notsend'
		            			 if ( type === 'display' || type === 'filter' ) { 
			            	            return   '<div style="text-align: center; color: red; font_weight: bold; border-width:thin; "> '+data+' </div>';
			            	        }
		            		   }  else if ( type === 'display' || type === 'filter' ) {
		            				className: 'value'    
		            	            return   '<div style="text-align: center; border-width:thin; "> '+data+'</div>';    
		            	        }   
		            	    }	    
		            }
				],
				"columnDefs": [
				],
				"dataType" : "json",
				"contentType" : "application/json;charset=utf-8",
				"ajax": {
		            "url" : "/prdev/dapis/emailtracking/rest/EmailTrackingLoading",
		            "type": "POST",
		            "data" : {
			             
			                "searchString" : function() { return $("#searchbox").val() },
			                "nonSent" : function() { return $("#isNonSent").val() }
			        }
		        },
		        "fnInitComplete": function(oSettings, json) { 
		        	$('#table0 tbody tr:first').click(); 
		        }
		    });
			
	$.fn.dataTable.ext.errMode = 'none';
		  $('#searchbox').keypress(function(e){ 
				var key = e.which;
				if(key == 13){
					$("#isNonSent").val('no');
					table.ajax.reload();
				}
			 });
			 $('#nonSentEmails').on('click', function(e) {
					$("#isNonSent").val('yes');
			    	table.ajax.reload();
			  });	 	 
	});
	
</script>
</head>
<body style='overflow-y: auto; overflow-x: hidden;'>
	<c:import url="pageHeader.jsp"></c:import>
	<c:import url="emailtrackingheader.jsp"></c:import>
	<br>
	<div>
		<table style='table-layout: auto;'>
			<tr>
				<td><span style='font-weight: bold'> <input
						id="isNonSent" type="hidden" name="isNonSent"
						value="nonSentEmails" /> <input id="nonSentEmails" width="300px"
						class="btn" style="background-color: rgb(51, 102, 153);"
						type="button" value="Non-Sent Emails" />
				</span></td>
				<td width="1%"></td>
				<td><span style='font-weight: bold'>
						<form action="/prdev/dapis/emailtracking/EmailTrackingDashboard" method="GET">
							<td><input class="btn"
								style="background-color: rgb(51, 102, 153);" type="submit"
								value="Reset"></td>
						</form>
				</span></td>
				<td width="5%"></td>
				<td><span style='font-weight: bold'>Search:</span></td>
				<td width="50%"><input class="search" id="searchbox"
					aria-controls="table0"
					style="height: 14px; text-align: center; padding-bottom: 6px;"
					type="text" placeholder="Full Text And Press Enter"
					alphanumericonly=""></td>
			</tr>
		</table>
	</div>
	<br>
	<table id="table0" class="cell-border"
		style="border: none; overflow-x: scroll; margin-top: 0px; width: 100%;">
		<thead>
			<tr style='font-size: 10px'>
				<th class='heading' style='width: 60px'>Email ID</th>
				<th class='heading' style='width: 60px'>Date</th>
				<th class="heading" style='width: 60px; display: none;'>sentDate</th>
				<th class='heading' style='width: 200px'>Subject</th>
				<th class="heading" style='width: 60px'>System Name</th>
				<th class="heading" style='width: 60px'>Workspace</th>
			</tr>
		</thead>
	</table>
	<c:import url="support.jsp"></c:import>
	<c:import url="footer.jsp"></c:import>
	<div id="loadScreen">
<span id="loadspan">
<img style="width:60px; height:60px"
src="images/circle-loader.gif">
</span>
	 <h1 id="message"style="color:white" ><strong> <i>Loading...</i></strong> </h1>
</div>
</body>
</html>