<%@page import="org.apache.commons.io.FilenameUtils"%>
<%
	final java.util.Date lastModified = new java.util.Date(
		new java.io.File(FilenameUtils.normalize(
			application.getRealPath(request.getServletPath()))).lastModified());
%>
 
<table style='width:100%' border="0" cellspacing="0" cellpadding="2" height="25">
	<tr class="bgMdBlue">
		<td  style="font-size:18px; font-family: Times New Roman; font-weight: bold;" class="footerLeft">Email Tracking Dashboard</td>
	
	</tr>
</table>