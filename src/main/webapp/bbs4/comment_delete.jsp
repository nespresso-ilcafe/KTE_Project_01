<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String code = request.getParameter("code"); //DB 어디 테이블에
String uid = request.getParameter("uid"); //몇번째 글인지 확인
String mem_uid = request.getParameter("mem_uid");

//댓글 단 게시판이 어딘지, 몇번째 글인지, id와 name이 뭔지, 뭐라고 달았는지, 언제 달았는지를 담는다 
String sql = "delete from comment where uid="+mem_uid;

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
stmt.executeUpdate(sql);
// 인서트 친구들 불러오기

stmt.close();
con.close();

%>
<script>
	location.href="view.jsp?code=<%=code%>&uid=<%=uid%>";
	//댓글달고 화면으로 나가기
</script>