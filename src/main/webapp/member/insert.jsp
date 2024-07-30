<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
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
String pn1 = request.getParameter("pn1");
String pn2 = request.getParameter("pn2");
String pn3 = request.getParameter("pn3");
String gen = request.getParameter("gender");
String email = request.getParameter("email");

//아이디 중복 확인
String s = "select count(*) from member where id = '"+id+"'";

Connection c = DriverManager.getConnection(url, user, password);
Statement st = c.createStatement();
ResultSet rs = st.executeQuery(s);



//가입년월일
Date date = new Date();
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String signdate = dateFormat.format(date);


int num = 0;

if(rs.next()){
	num = rs.getInt(1);
}

rs.close();
st.close();
c.close();



if(num == 1){
//존재하는 아이디가 있다.
	%>
	<script>
		alert("아이디가 존재합니다.\n다른 아이디를 이용하세요.");
		history.back();
	</script>
	<%
}else{
	// 회원가입 처리 부분
	String sql = "insert into member (name, id, pass, zc, zc1, zc2, zc3, zc4, pn1, pn2, pn3, gender, email, signdate, level)";
	sql = sql + " values ('"+name+"','"+id+"','"+pass+"','"+zc+"','"+zc1+"','"+zc2+"','"+zc3+"','"+zc4+"','"+pn1+"','"+pn2+"','"+pn3+"','"+gen+"','"+email+"','"+signdate+"','1')";
	
	Connection conn = DriverManager.getConnection(url, user, password);
	Statement stmt = conn.createStatement();
	stmt.executeUpdate(sql);
	
	stmt.close();
	conn.close();
	
	response.sendRedirect("/"); // 페이지 이동
}
%>

















