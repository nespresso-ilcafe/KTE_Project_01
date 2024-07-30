<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String code = request.getParameter("code"); //DB 어디 테이블에
String uid = request.getParameter("uid"); //몇번째 글인지 확인
String view_comment = request.getParameter("view_comment"); //댓글을 달기 위해 추가

String field = request.getParameter("field");
String search = request.getParameter("search");
String page_now = request.getParameter("page_now");

//댓글 단 년월일시
Date today = new Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String signdate = cal.format(today);

//댓글 단 게시판이 어딘지, 몇번째 글인지, id와 name이 뭔지, 뭐라고 달았는지, 언제 달았는지를 담는다 
String sql = "insert into comment values (null,'"+code+"',"+uid+",'"+session_id+"','"+session_name+"','"+view_comment+"','"+signdate+"')";

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
stmt.executeUpdate(sql);
// 인서트 친구들 불러오기

%>
<script>
location.href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field %>&search=<%=search %>&page_now=<%=page_now %>";
	//댓글달고 화면으로 나가기
</script>