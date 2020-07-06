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
<%@ page session="true"%>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>
<%!
public Connection getConnection() throws Exception {
	//DataSource datasource = (DataSource) new InitialContext().lookup("java:/comp/env/jdbc/hsql");
	//return datasource.getConnection();
	return DriverManager.getConnection("jdbc:hsqldb:mydatabase","sa","");
}
Random rand = new Random();
%>
<html>
<body>
<%
Thread.sleep(rand.nextInt(1000));

Connection conn = getConnection();
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * from scouter");
	while (rs.next()) {
		String id = rs.getString(1);
		String name = rs.getString(2);
		out.println(id + " " + name + "<br>");
	}
	rs.close();
	stmt.close();
	conn.commit();
	conn.close();
%>	
This is e2end.jsp
</body>
</html>
