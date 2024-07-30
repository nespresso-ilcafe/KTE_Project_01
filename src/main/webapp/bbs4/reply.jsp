<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<style>
#bbsLabel{
	font-size:16px;
	font-weight:bold;}
</style>
<%

//검색
String field, search, sql_search;

String code = request.getParameter("code");
String uid = request.getParameter("uid");
String page_now = request.getParameter("page_now");

if(request.getParameter("search") != null && !request.getParameter("search").equals("")){
	field = request.getParameter("field");
	search = request.getParameter("search");
	sql_search = "and "+field+" like '%"+search+"%'";
}else{
	field = "";
	search = "";
	sql_search = "";	
}

//db에서 request.getParameter로 table이름을 불러온다.

String bbs_title = ""; //게시판 이름
if(code.equals("jayu")){ 	//db 테이블 이름
	bbs_title = "자유방";		//브라우저에 보여주는 이름
}else if(code.equals("ungwon")){
	bbs_title = "응원방";
}else if(code.equals("jarang")){
	bbs_title = "자랑방";
}else if(code.equals("jungko")){
	bbs_title = "중고방";
}
%>

<center>
<table width=100% style="margin-top:95px;">
	<tr>
		<td align="center">
			<table >
				<tr>
					<td width=650 height=65 align="center" style="border:5px solid #4db18b; letter-spacing:3px; font-size:26px; font-weight:bold; background-color: #a11a20; color:#fefefe;">
						<%=bbs_title %>
					</td>
				</tr>
				<tr>
					<td align=center style="color:#777;font-size:14px;font-weight:bold;">[<%=bbs_title %>]_답변</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<%
String sql = "select * from "+code+" where uid="+uid;

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String subject = "";
String comment = "";
int fid = 0;
String thread = "";

if(rs.next()){
	String g = rs.getString("gongji");
	String file1 = rs.getString("file1");
	fid = rs.getInt("fid");
	thread = rs.getString("thread");
%>


<form method="post" action="reply_insert.jsp" ENCTYPE="multipart/form-data">
<input type="hidden" name="code" value="<%=code%>">
<input type="hidden" name="uid" value="<%=uid%>">
<input type="hidden" name="page_now" value="<%=page_now%>">
<input type="hidden" name="fid" value="<%=fid%>">
<input type="hidden" name="thread" value="<%=thread%>">
<table width="700" border="0" cellpadding="0" cellspacing="0">
	<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
	<tr>
		<td height=26>옵션</td>
		<td>
			<%if(session_level != null && session_level.equals("10")){ %>
			<input type="radio" name="gongji" value="1" <%if(g.equals("1")){%>checked<%}%>>공지
			<%}%>
			<input type="radio" name="gongji" value="2" <%if(g.equals("2")){%>checked<%}%>>일반
			<input type="radio" name="gongji" value="3" <%if(g.equals("3")){%>checked<%}%>>비밀
		</td>
	</tr>
	<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
	<tr>
		<td height=26>제목</td>
		<td><input name="subject" style="height:20px;width:99%;" value="re: <%=rs.getString("subject")%>"></td>
	</tr>
	<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
	<tr>
		<td>내용</td>
		<td>
			<textarea name="comment" style="height:92px;width:99%;">re: <%=rs.getString("comment")%></textarea>
		</td>
	</tr>
	<tr><td colspan=3 height=1 width=100% bgcolor=#d1dee2></td></tr>
	<tr>
		<td height=28>첨부</td>
		<td>
			<input type="file" name="file1">
			<%if(!file1.equals("")){ %>
				<%=file1 %>
				<img src="/img/icon_file.gif">
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

<br>
</center>
<%} %>
<%@ include file="/include/footer.jsp" %>
