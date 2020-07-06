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
<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "java.util.Enumeration" %>
<html>
<head><title>HTTPS Redirect</title></head>
<body>
<%
System.out.println("######################START##########################");
String url = javax.servlet.http.HttpUtils.getRequestURL(request).toString();
String uri = request.getHeader("x-forwarded-proto") + "://" +   // "http" + "://
             request.getServerName() +       // "myhost"
             ":" +                           // ":"
             request.getServerPort() +       // "8080"
             request.getRequestURI() +       // "/people"
             "?" +                           // "?"
             request.getQueryString();       // "lastname=Fox&age=30"

System.out.println("######URL" + url);
System.out.println("######URI" + uri);
System.out.println("######REQUEST HEADER######");
Enumeration headerEnum = request.getHeaderNames();
while(headerEnum.hasMoreElements()) {
   String headerName = (String)headerEnum.nextElement();
   String headerValue = request.getHeader(headerName);
   System.out.println( headerName + " :: " + headerValue );
}

if(uri.indexOf("http://") > -1 ) {	
	String after = uri.replaceAll("http://","https://");

//if(url.indexOf("http://") > -1 ) {	
//	String after = url.replaceAll("http://","https://") +"?"+ request.getQueryString();

	System.out.println("######REDIRECT" + after);
	System.out.println("######################END############################");


//	response.sendRedirect(url.replaceAll("http://","https://") +"?"+ request.getQueryString());		
        response.setHeader("x-forwarded-proto", "https");
	System.out.println("######REQUEST HEADER######");
	System.out.println("######REDIRECT1" + response.getHeader("x-forwarded-for"));
	System.out.println("######REDIRECT2" + response.getHeader("x-forwarded-by"));
	System.out.println("######REDIRECT2" + response.getHeader("x-forwarded-proto"));
	
	String reuri = "https://" +   // "http" + "://
             request.getServerName() +       // "myhost"
             ":30170" +                           // ":"
             request.getRequestURI() +       // "/people"
             "?" +                           // "?"
             request.getQueryString();       // "lastname=Fox&age=30"
	System.out.println("######REDIRECT" + reuri);
	System.out.println("######################END############################");

	response.sendRedirect(reuri);		

	return;

}
%>
	<h1>HTTPS Redirect</h1>
</body>
</html>
