<%@page import="com.fca.dapis.util.service.DapisCodeLookup, com.fca.dapis.util.service.impl.DapisCodeLookupImpl, java.text.ParseException,
					java.util.List, java.util.Date, java.text.SimpleDateFormat, com.fca.dapis.logging.DapisLog"%>
<%
DapisCodeLookup lkup = new DapisCodeLookupImpl();
List<String> list = lkup.getAllDescriptions("DAPISLUPD", "Recall");
Date lastModified = null;
if (list != null && list.size() > 0) {
	try {
		SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
		lastModified = df.parse(list.get(0));
	} catch(ParseException e) {
		DapisLog.getErrLog().info(e);
	}
}
%>
 
<table style='width:100%' border="0" cellspacing="0" cellpadding="2">
	<tr class="bgMdBlue">
		<td class="footerLeft">Copyright&copy; 2020 FCA US LLC, All Rights Reserved.</td>
		<td class="footerCenter">Provided by <a class="na1"
			href="mailto:dapis@fcagroup.com?cc=khaldon.saadeh@external.fcagroup.com"
			onmouseover="window.status='e-Mail: dapis@fcagroup.com'; return true"
			onmouseout="window.status=' '; return true"> WebDAPIS Support Group</a></td>
		<td class="footerRight">Last Updated : <%= lastModified != null ? new SimpleDateFormat("EEE, MMMM dd, yyyy").format(lastModified) : "-" %>
		<img border="0"
			src="/common/images/spacer.gif" width="1" height="1" /></td>
	</tr>
</table>