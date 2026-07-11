
<%
	String headerImage = request.getParameter("headerImage");
	if (headerImage == null) {
		headerImage = "/common/images/emptyheader.gif";
	}
	//com.dcx.prdev.dapis.DapisLog.getAppLog().println("Reached pageHeader.jsp");
%>
<%@ page import="com.dcx.prdev.dapis.security.*,org.apache.commons.text.StringEscapeUtils "%>
<%
	LDAPUser user = AppProperties.getUser(request);
%>

<%@page import="com.dcx.prdev.dapis.AppProperties"%>
<table width='100%' border='0' cellspacing='0' cellpadding='0'>
	<tr>

		<td valign='top' style='width: 102px; height: 40px;'><img
			src='/common/images/FCA_LOGO.png'></img></td>
		<td valign='top'>
			<table width='100%' border='0' cellspacing='0' cellpadding='0'>
				<tr>
					<td width='100%' height='30' valign='top' nowrap
						style='height: 30; background-image: url("<%=StringEscapeUtils.escapeHtml4(headerImage)%>")'>
						<%
							if (user != null) {
						%>
						<div align='right' class='fineprint'>
							<span class='bold'>Welcome <%=user.getName()%></span>&nbsp;|&nbsp;<a
								href="/prdev/dapis/logout.jsp" target="_top">Log Out</a>
						</div> <%
 	} else {
 %>
						<div align='right' class='fineprint'>
							<span class="bold">Welcome Guest</span>&nbsp;|&nbsp;<a
								href="/prdev/dapis/LDAPLogin.jsp" target="_top">Login</a>
						</div> <%
 	}
 %>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
