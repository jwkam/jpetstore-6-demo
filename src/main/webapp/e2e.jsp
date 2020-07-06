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
<%@ page session="true"
         import="java.io.InputStream,java.net.HttpURLConnection,java.net.URL" %>
<html>
<body>

<%
    String me = request.getRequestURL().toString();
    String next1 = me.replace("e2e.jsp", "e2end.jsp");
    String next2 = me.replace("e2e.jsp", "e2test.jsp");

    for (int i = 0; i < 3; i++) {
        InputStream in = null;
        HttpURLConnection uc = null;
        try {
            URL u = null;
            if (i % 2 == 0) {
                u = new URL(next1 + "?" + i);
            } else {
                u = new URL(next2 + "?" + i);
            }
            uc = (HttpURLConnection) u.openConnection();
            uc.setRequestMethod("POST");

            in = uc.getInputStream();

            byte[] buff = new byte[4096];
            int n = in.read(buff);
            while (n >= 0) {
                n = in.read(buff);
            }
        } catch (Throwable t) {
        } finally {
            if(uc!=null) { uc.disconnect(); }
            if(in!=null) { in.close(); }
        }
    }

%>
This is a test page!!
</body>
</html>
