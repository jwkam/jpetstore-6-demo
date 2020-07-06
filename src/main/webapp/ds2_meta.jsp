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
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import = "java.sql.*,java.util.*" %>
<%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;


        try{
        String url = "jdbc:mysql://mysql.demo:3306/test";
        String id = "root";
        String pw = "root";
        Class.forName("com.mysql.jdbc.Driver");
        conn=DriverManager.getConnection(url,id,pw);

        String sql = "select now()";

        DatabaseMetaData meta = conn.getMetaData();
        out.print("<b><i>Database URL : "+meta.getURL()+"</i></b><br><br>");
        out.println("\n=============\nDatabase Product Name is ... " + meta.getDatabaseProductName()+"<br>");
        out.println("\nDatabase Product Version is  " + meta.getDatabaseProductVersion()+"<br>");
        out.println("\n=============\nJDBC Driver Name is ........ " + meta.getDriverName()+"<br>");
        out.println("\nJDBC Driver Version is ..... " + meta.getDriverVersion()+"<br>");
        out.println("\nJDBC Driver Major Version is " + meta.getDriverMajorVersion()+"<br>");
        out.println("\nJDBC Driver Minor Version is " + meta.getDriverMinorVersion()+"<br>");
        out.print("<b><i>Query("+sql+") Result</b><br><br>");

        pstmt = conn.prepareStatement(sql);
        pstmt.executeQuery();
            rs = pstmt.executeQuery();
            while (rs.next()){
                out.print(rs.getString(1));
            }


        }catch(Exception e){
        e.printStackTrace();
        }finally{
        if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
        if(conn != null) try{conn.close();}catch(SQLException sqle){}
        }

%>
