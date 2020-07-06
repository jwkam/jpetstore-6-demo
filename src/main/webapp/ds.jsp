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
	
	Random generator = new Random();        
	        
	int num1;
  
       num1= generator.nextInt(5)+3;        
  
        int num2 = generator.nextInt(9) * 100; 
		
	try{
	String url = "jdbc:mysql://mysql.oss:3306/wordpress";
	String id = "wordpress";                              
	String pw = "wordpress";                             
	Class.forName("com.mysql.jdbc.Driver"); 
	conn=DriverManager.getConnection(url,id,pw);
	String sql = "select 'test',sleep(?)=0";
	pstmt = conn.prepareStatement(sql); 
	pstmt.setInt(1,num1);
	pstmt.executeQuery();

	sql = "select 'test2'";
	pstmt = conn.prepareStatement(sql); 
	pstmt.executeQuery();

	}catch(Exception e){   
	e.printStackTrace();
	}finally{        
	if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}  
	if(conn != null) try{conn.close();}catch(SQLException sqle){}    
	}

	Thread.sleep(num2);
%>
execute query
