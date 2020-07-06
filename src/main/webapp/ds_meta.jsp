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
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.sql.*" %>

<%
   Context ctx = null;
   DataSource ds = null;
   Connection con = null;
   PreparedStatement ps = null;
   ResultSet rs = null;
   //String sql = "select * from inventory";
   //mysql
   String sql = "select now()";
   //String sleep = (request.getParameter("sleep") == null || "".equals(request.getParameter("sleep")) ) ? "5" : request.getParameter("sleep");
   //int sleepTime = Integer.parseInt(sleep);
   
  try {
    ctx = new InitialContext();
    //ds = (DataSource) ctx.lookup("dataSource");
	//ds = (DataSource) ctx.lookup("java:comp/env/dataSource");
	ds = (DataSource) ctx.lookup("java:/dataSource");
	//tomcat
    //ctx = (Context) ctx.lookup("java:comp/env");
    //ds = (DataSource) ctx.lookup("dataSource");
	
    con = ds.getConnection();
    DatabaseMetaData meta = con.getMetaData();
    out.print("<b><i>Database URL : "+meta.getURL()+"</i></b><br><br>");
    out.println("\n=============\nDatabase Product Name is ... " + meta.getDatabaseProductName()+"<br>");
    out.println("\nDatabase Product Version is  " + meta.getDatabaseProductVersion()+"<br>");
    out.println("\n=============\nJDBC Driver Name is ........ " + meta.getDriverName()+"<br>");
    out.println("\nJDBC Driver Version is ..... " + meta.getDriverVersion()+"<br>");
    out.println("\nJDBC Driver Major Version is " + meta.getDriverMajorVersion()+"<br>");
    out.println("\nJDBC Driver Minor Version is " + meta.getDriverMinorVersion()+"<br>");
    out.print("<b><i>Query("+sql+") Result</b><br><br>");

    ps = con.prepareStatement(sql);
    rs = ps.executeQuery();
    while (rs.next()){
     out.print(rs.getString(1));
    }
   } catch ( Exception e ) {
     e.printStackTrace();
	 out.print("Exception Msg : "+e.getMessage());
   } finally {
     if ( ps != null ) try { ps.close(); } catch(Exception e) {}
     if ( con != null ) try { con.close(); } catch(Exception e) {} 
   }
   //Thread.sleep(1000*sleepTime);
%>
    Query Execution
