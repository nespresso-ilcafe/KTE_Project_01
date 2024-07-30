<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	
<%@ include file="/include/dbconnection.jsp" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>This is Anfield.kr</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<%
String session_id = (String)session.getAttribute("id");
String session_name = (String)session.getAttribute("name");
String session_level = (String)session.getAttribute("level");
%>

<table width="100%" height="75" style="background-color: #A11A20;position: fixed;top: 0;">
    <tr>
        <td align="center">
            <table width="1080" height="50">
                <tr>
                    <td width="10%" align="center"style="height:50;width:150px;background-color:#e2b604;"><a href="/bbs4/list.jsp?code=jayu" style=";font-weight:bold;font-size:16px;color:#A11A20">자유방</a></td>
                    <td width="5%" align="center"></td>
                    <td width="10%" align="center"style="height:50;width:150px;background-color:#e2b604;"><a href="/bbs/list.jsp?code=ungwon" style=";font-weight:bold;font-size:16px;color:#A11A20">응원방</a></td>
                    <td width="5%" align="center"></td>
                    <td width="40%" align="center">
                    <%if(session_id != null){ %>
                    	<a href="/main.jsp"><img src = "/img/liverpool/header_logo.png"></a>
                    <%}else{%>
                    	<a href="/"><img src = "/img/liverpool/header_logo.png"></a>
                    <%}%>
					</td>
                    <td width="5%" align="center"></td>
                    <td width="10%" align="center"style="height:50;width:150px;background-color:#e2b604;"><a href="/bbs3/list.jsp?code=jarang" style=";font-weight:bold;font-size:16px;color:#A11A20">자랑방</a></td>
                    <td width="5%" align="center"></td>
                    <td width="10%" align="center"style="height:50;width:150px;background-color:#e2b604;"><a href="/bbs2/list.jsp?code=jungko" style=";font-weight:bold;font-size:16px;color:#A11A20">중고방</a></td>
                </tr>
            </table>
        </td>
    </tr>
</table>