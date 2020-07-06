<%--

       Copyright 2010-2020 the original author or authors.

       Licensed under the Apache License, Version 2.0 (the "License");
       you may not use this file except in compliance with the License.
       You may obtain a copy of the License at

          http://www.apache.org/licenses/LICENSE-2.0

       Unless required by applicable law or agreed to in writing, software
       distributed under the License is distributed on an "AS IS" BASIS,
       WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
       See the License for the specific language governing permissions and
       limitations under the License.

--%>
<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="java.util.*,java.text.*"%>
<html>
  <head><title>Session Tracking Test</title>
</head>
<body>
<%
       String userAgent = request.getHeader("User-Agent");
       String browser = "";
       if (userAgent.indexOf("Trident") > 0 || userAgent.indexOf("MSIE") > 0) {
           browser = "IE";
           request.setCharacterEncoding("euc-kr");
       } else if (userAgent.indexOf("Opera") > 0) {
           request.setCharacterEncoding("utf-8");
         browser = "Opera";
       } else if (userAgent.indexOf("Firefox") > 0) {
           request.setCharacterEncoding("utf-8");
         browser = "Firefox";
       } else if (userAgent.indexOf("Safari") > 0) {
           if (userAgent.indexOf("Chrome") > 0) {
               request.setCharacterEncoding("utf-8");
               browser = "Chrome";
           } else {
              request.setCharacterEncoding("utf-8");
              browser = "Safari";
           }
      }
        HttpSession sess = request.getSession();
	if( request.getParameter("key") != null){
            sess.setAttribute(request.getParameter("key"),request.getParameter("val"));
        }
        boolean isNew = session.isNew();
        String sessionId = session.getId();
        long creationTime = session.getCreationTime();
        long lastAccessedTime = session.getLastAccessedTime();
        int maxInactiveInterval = session.getMaxInactiveInterval();
        java.util.Enumeration e = session.getAttributeNames();

%>
        <table border=1 bordercolor="gray" cellspacing=1 cellpadding=0 width="100%">
                <tr bgcolor="gray"><td colspan=2 align="center"><font color="white"><b>Session Info</b></font></td></tr>
                <tr>
                        <td width="25%">Agent</td><td width="75%"><%=browser%></td>
                </tr>
                <tr>
                        <td width="25%">Session ID</td><td width="75%"><%=sessionId%></td>
                </tr>
                <tr>
                        <td>isNew?</td><td><%=isNew%></td>
                </tr>
                <tr>
                        <td>Creation Time</td><td><%=new Date(creationTime)%></td>
                </tr>
                <tr>
                        <td>Last Accessed Time</td><td><%=new Date(lastAccessedTime)%></td>
                </tr>
                <tr>
                        <td>Max Inactive Interval</td><td><%=maxInactiveInterval%> sec</td>
                </tr>

                <tr bgcolor="cyan"><td colspan=2 align="center"><b>Session Vaule List<b></td></tr>
                <tr>
                        <td align="center">NAME</td>
                        <td align="center">VAULE</td>
                </tr>

<%
        String name = null;
        while ( e.hasMoreElements() ) {
                name = (String) e.nextElement();
%>
        <tr>
                        <td align="left"><%=name%></td>
                        <td align="left"><%=session.getAttribute(name)%></td>
                </tr>
<%
        }
%>
        <tr><td colspan=2 align="center"><input type="button" value="back" onclick="javascript:history.back(-1);"></td></tr>
         
        </table>
</body>
</html>
