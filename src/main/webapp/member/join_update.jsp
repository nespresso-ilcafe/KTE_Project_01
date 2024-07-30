<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
//////////////////////////////회원수정 인서트//////////////////////////////


request.setCharacterEncoding("utf-8");
//한글 깨짐 방지

String name = request.getParameter("name");
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String zc = request.getParameter("zipcode");
String zc1 = request.getParameter("zipcode1");
String zc2 = request.getParameter("zipcode2");
String zc3 = request.getParameter("zipcode3");
String zc4 = request.getParameter("zipcode4");
String pn1 = request.getParameter("phoneNum1");
String pn2 = request.getParameter("phoneNum2");
String pn3 = request.getParameter("phoneNum3");
String gen = request.getParameter("gender");
String email = request.getParameter("email");

//회원수정 처리 부분
String sql = "update member set name = '"+name+"',zc = '"+zc+"',zc1 = '"+zc1+"',zc2 = '"+zc2+"',zc3 = '"+zc3+"',zc4 = '"+zc4+"' where id = '"+id+"'";
// 비밀번호는 변경하지 않았을 때

if(!pass.equals("")){
//	패스에 값이 있다면,
	sql = "update member set pass = '"+pass+"' , name = '"+name+"',zc = '"+zc+"',zc1 = '"+zc1+"',zc2 = '"+zc2+"',zc3 = '"+zc3+"',zc4 = '"+zc4+"',pn1= '"+pn1+"',pn2='"+pn2+"', pn3='"+pn3+"', email='"+email+"', where id = '"+id+"'";
//	비밀번호도 변경해라
// 비밀번호도 변경했을 때
}

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);

response.sendRedirect("/main.jsp");
// 회원수정 완료시 페이지 이동

%>
