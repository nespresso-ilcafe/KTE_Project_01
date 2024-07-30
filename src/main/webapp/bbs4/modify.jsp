<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
String code = request.getParameter("code"); //db : table 명
String uid = request.getParameter("uid");	//수정할 게시물을 컴퓨터에게 알려주기 위해서 uid 추가(게시글은 중복이 가능하기 때문)
String page_now = request.getParameter("page_now");

String bbs_title = ""; //게시판 이름(bbs_title) 과 DB의 테이블 이름(String code = request.getParameter("code"))매칭
if(code.equals("jayu")){
	bbs_title = "자유방";
}else if(code.equals("ungwon")){
	bbs_title = "응원방";
}else if(code.equals("jarang")){
	bbs_title = "자랑방";
}else if(code.equals("jungko")){
	bbs_title = "중고방";
}
%>

<table width=100% height=50 border=0>
	<tr>
		<td align=center style="color:#777;font-size:14px;font-weight:bold;">[<%=bbs_title %>]_글쓰기</td>
	</tr>
</table>

<%
String sql = "select * from "+code+" where uid="+uid;

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);

if(rs.next()){
	String g = rs.getString("gongji");
	String file1 = rs.getString("file1");
%>

<center>
<form method="post" action="update.jsp" ENCTYPE="multipart/form-data">
	<input type="hidden" name="code" value="<%=code%>">
	<input type="hidden" name="uid" value="<%=uid%>">
	<input type="hidden" name="page_now" value="<%=page_now%>">
<table width="700" border="0" cellpadding="0" cellspacing="0">
	<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
	<tr>
		<td height=26>옵션</td>
		<td>
			<input type="radio" name="gongji" value="1" <%if(g.equals("1")){%>checked<%}%>>공지 
			<input type="radio" name="gongji" value="2" <%if(g.equals("2")){%>checked<%}%>>일반 
			<input type="radio" name="gongji" value="3" <%if(g.equals("3")){%>checked<%}%>>비밀 
		</td>
	</tr>
	<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
	<tr>
		<td height=26>제목</td>
		<td><input name="subject" style="height:20px;width:99%;" value="<%=rs.getString("subject")%>"></td>
	</tr>
	<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
	<tr>
		<td>내용</td>
		<td>
			<textarea name="comment" style="height:92px;width:99%;"><%=rs.getString("comment")%></textarea>
		</td>
	</tr>
	<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
	<tr>
		<td height=28>첨부</td>
		<td>
			<input type="file" name="file1">
			<%if(!file1.equals("")){ //첨부파일 존재 %>
				<%=file1 %> <img src="img/icon_file.gif">
			<%} %>
		</td>
	</tr>
	<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
</table>
<br>
<table width="700" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center"><button>작성완료</button></td>
	</tr>
</table>
<br>
</form>
</center>
<%
}
%>
<%@ include file="/include/footer.jsp" %>