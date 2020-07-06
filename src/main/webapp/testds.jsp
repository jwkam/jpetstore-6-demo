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
<HTML>
<HEAD>
  <TITLE>Testing Connection Pools</TITLE>
<style type="text/css">
  .acc1 {
	font-size:10pt;
	color:white;
	background-color:green;
	border:2px solid #336600;
	padding:3px
  }  
</style>
</HEAD>

<BODY>

<%@ page import="java.sql.*,javax.naming.*,javax.sql.*" %>
<FONT SIZE="5" COLOR="navy">
<table>
<tr><td><CENTER><b>JDBC Testing Center</b></CENTER></td></tr>
</table>


<FORM NAME="testCP" ACTION="testds.jsp" METHOD="POST" style="background-color:#E6E6FA">
<TABLE WIDTH="50%" ALIGN="left" BGCOLOR="#01A982">
        <TR><TD ALIGN="left" WIDTH="30%">Data Source Name</TD>
                <TD WIDTH="70%"><INPUT TYPE="text" NAME="txtDataSource" VALUE="jdbc/testDS" class="acc1"></TD>
        </TR>
        <TR><TD ALIGN="left" WIDTH="30%">Table Name</TD>
                <TD WIDTH="70%"><INPUT TYPE="text" NAME="txtTableName" VALUE='<%= ( request.getParameter("txtTableName") == null ) ? "world.city" : request.getParameter("txtTableName") %>' style="font-size:10pt;color:white;background-color:green;border:2px solid #336600;padding:3px"></TD>
        </TR>
		<tr><td><td></tr><tr><td><td></tr><tr><td><td></tr>
        <TR><TD ALIGN="center" COLSPAN="2">
                        <INPUT TYPE="submit" NAME="btnSubmit" VALUE="Test Data" class="acc1">
                </TD>
        </TR>

</TABLE>
</FORM>


<%
        String datasource = request.getParameter("txtDataSource");
        String table = request.getParameter("txtTableName");
		Context ctx = null;

        if ((datasource != null) && (!datasource.equals(""))) {
			if ((table != null) && (!table.equals(""))) {
				try {
					ctx = new InitialContext();
					//tomcat
					ctx = (Context) ctx.lookup("java:comp/env");

					DataSource ds = (DataSource) ctx.lookup(datasource);
					System.out.println("Looking up the " + datasource + " data source.");
					Connection connection = ds.getConnection();
					System.out.println("Getting the connection from the database.");

					DatabaseMetaData dmeta = connection.getMetaData();

					Statement statement = connection.createStatement();
					String sql = "SELECT * FROM " + table;

					ResultSet rs = statement.executeQuery(sql);
					System.out.println("Querying the database.");
					ResultSetMetaData meta = rs.getMetaData();
					int numColumns = meta.getColumnCount();
%>
<BR>
<BR>
<BR>
<TABLE WIDTH="50%" ALIGN="left" BGCOLOR="#01A982">
		<tr><TD ALIGN="center" COLSPAN="2" class="acc1">Database Information</td></tr>
        <TR>
			<TD ALIGN="left" WIDTH="30%">URL</TD>
            <TD WIDTH="70%"><%=dmeta.getURL()%></TD>
        </TR>
        <TR>
			<TD ALIGN="left" WIDTH="30%">Product Name</TD>
            <TD WIDTH="70%"><%=dmeta.getDatabaseProductName()%></TD>
        </TR>
        <TR>
			<TD ALIGN="left" WIDTH="30%">Product Version</TD>
            <TD WIDTH="70%"><%=dmeta.getDatabaseProductVersion()%></TD>
        </TR>
        <TR>
			<TD ALIGN="left" WIDTH="30%">JDBC Driver Name</TD>
            <TD WIDTH="70%"><%=dmeta.getDriverName()%></TD>
        </TR>
        <TR>
			<TD ALIGN="left" WIDTH="30%">JDBC Driver Version</TD>
            <TD WIDTH="70%"><%=dmeta.getDriverVersion()%></TD>
        </TR>
        <TR>
			<TD ALIGN="left" WIDTH="30%">Query</TD>
            <TD WIDTH="70%"><%=sql%></TD>
        </TR>		
</TABLE>								
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>	

                                <p>
                                <TABLE WIDTH="670" BGCOLOR="wheat" ALIGN="left">

<%
                                out.print("<TR>");
                                for (int j=1; j<numColumns; j++) {
                                        out.print("<TD>" + meta.getColumnName(j) + "</TD>");
                                }
                                out.print("</TR>");
                                while (rs.next()) {
                                        out.print("<TR>");
                                        for (int i=1; i<numColumns; i++) {
                                                out.print("<TD>" + rs.getString(i) + "</TD>");
                                        }
                                        out.print("</TR>");
                                }
%>
                                </TABLE>
                                </p>
<%
                                if (statement != null)
                                        statement.close();
                                if (connection != null)
                                        connection.close();

                        } catch (SQLException sqle) {
%>

                                </FONT><FONT SIZE="4" COLOR="navy">
                                Error: <%= sqle.getMessage() %><BR><BR>
<%
                        }catch (Exception e) {out.print("error: " + e); }

                }
        }


%>
</FONT>


<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<BR>
<p>
</td></tr>
</p>
</BODY>
</HTML>
