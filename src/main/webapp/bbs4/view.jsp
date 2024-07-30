<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
String code = request.getParameter("code"); //db - table 명
String uid = request.getParameter("uid");
String field = request.getParameter("field");
String search = request.getParameter("search");
String page_now = request.getParameter("page_now");

String bbs_title = ""; //게시판 이름
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
		<td align=center style="color:#777;font-size:14px;font-weight:bold;">[<%=bbs_title %>]_상세보기</td>
	</tr>
</table>

<%
String sql = "select * from "+code+" where uid="+uid;

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);
String id = "";

if(rs.next()){	
	String g = rs.getString("gongji");
	String g_h = "";
	if(g.equals("1")){
		g_h = "공지글";
	}else if(g.equals("2")){
		g_h = "일반글";
	}else{
		g_h = "비밀글";
	}
	//comment 개행처리
	String comment = rs.getString("comment");
	pageContext.setAttribute("cmt", comment);
	pageContext.setAttribute("LF", "\n");
	String file1 = rs.getString("file1");//첨부파일
	
	id = rs.getString("id");
	
//비밀글일때 (관리자와 작성자만 볼 수 있어야 한다)
	if(g.equals("3")){ //gongji의 "3"값은 공지사항임
		if(session_level != null && (session_level.equals("10") || session_id.equals(id))){
			//관리자와 작성자 조건설정
		}else{
			%>
				<script>
					alert("뭐하는거야");
					history.back();
				</script>
			<%
		}
	}
%>
<center>
<table width="800" border="0" cellpadding="0" cellspacing="0" style="margin-top:50px;">
	<tr>
		<td>
			<a href=list.jsp?code=<%=code%>&field=<%=field %>&search=<%=search %>&page_now=<%=page_now %>>[목록]</a>
			<%if(session_level != null && (session_level.equals("10") || session_id.equals(id))){ %>
				<a href=reply.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>>[답변]</a>
			<%} %>
		<td align=right>
			<%if(session_level != null && (session_level.equals("10") || session_id.equals(id))){ %>
				<a href="modify.jsp?code=<%=code%>&uid=<%=uid%>&page_now=<%=page_now %>">[수정]</a>
				<a onclick="delete_go()">[삭제]</a>
			<%}else {%>
				<span onclick="alert('작성자만 수정할 수 있습니다')">[수정]</span>
				<span onclick="alert('작성자만 수정할 수 있습니다')">[삭제]</span>
			<%}%>
		</td>
	</tr>
</table>

<table width="800" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan=2 height=1 width=100% bgcolor=#A11A20></td>
	</tr>
	<tr>
		<td colspan=2 height=1 width=100% bgcolor=#A11A20></td>
	</tr>
	<tr>
		<td width=800 align="center" style="font-size:18px;">제목</td>
		<td width=100 align="center" style="font-size:12px;">글쓴이</td>
	</tr>
	<tr>
		<td colspan=2 height=1 width=100% bgcolor=#A11A20></td>
	</tr>
	<tr height=50>
		<%if(g_h.equals("공지글")){ %>
			<td width=800 align="center" style="font-size:16px;"><%=rs.getString("subject") %></td>
			<td width=100 align="center" style="font-size:16px;"><%=id %></td>
		<%}else{ %>
			<td width=800 align="center" style="font-size:16px;"><%=rs.getString("subject") %><font style="font-size:12px;">[<%=g_h %>]</font></td>
			<td width=100 align="center" style="font-size:16px;"><%=id %></td>
		<%} %>
	</tr>
	<tr>
		<td colspan=2 height=1 width=100% bgcolor=#A11A20></td>
	</tr>
	<tr>
		<td colspan=2>
			<table width=100% >
				<tr>
					<td colspan=3 align="center" >
						<%if(!file1.equals("")){ //첨부파일 존재 %>
						<img src="/upload/<%=file1%>">
						<%} %>
						<br>
						${fn:replace(cmt, LF, '<br>')}
						<br>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<%if(!file1.equals("")){ //첨부파일 존재 %>
	<tr height=26>
		<td colspan=2 style="font-size:12px">첨부 : <a href="/upload/<%=file1 %>" download><%=file1 %></a></td>
	</tr>
	<tr>
		<td colspan=2 height=1 width=100% bgcolor=#A11A20></td>
	</tr>
	<%} %>
</table>
<br>
<%
}
rs.close();
stmt.close();
con.close();
%>

<!-- 한줄 댓글 목록 -->
<%
//댓글 목록
String sql_comment="select * from comment where tb_table='"+code+"' and tb_uid="+uid;

Connection conn_comment=DriverManager.getConnection(url, user, password);
Statement stmt_comment=conn_comment.createStatement();
ResultSet rs_comment=stmt_comment.executeQuery(sql_comment);
%>
<table width="800" border="0" cellpadding="0" cellspacing="0">
	<%
	while(rs_comment.next()){
		String mem_id = rs_comment.getString("tb_id");
			//DB에서 작성자 이름찾기
		
		int mem_uid = rs_comment.getInt("uid");
			//DB에서 댓글의 uid값 찾기
	%>
	<tr>
		<td width="8%" align="center">
			<%=rs_comment.getString("tb_id") %>
				<!-- 댓글 작성자 -->
		</td>
		<td width="84%" align="left">
			<%=rs_comment.getString("tb_comment") %>
				<!-- 댓글 내용 -->
			<%
			if(session_level != null && (session_level.equals("10") || mem_id.equals(session_id))){
				//관리자거나, 작성자가 맞는지 조건
			%>
				<img src="img/comment_del.gif" onclick="comment_delete (<%= mem_uid %>)">
				<span style="font-size:10px; cursor:pointer;" onclick="alert('댓글 수정을 과연 내가 만들까?')">수정</span>
				<script>
					// 삭제전에 다시 확인
					function comment_delete(num){
						result = confirm("댓글 삭제할겨~?")
						if (result == true){
							 location.href="comment_delete.jsp?code=<%=code%>&uid=<%=uid%>&mem_uid="+num;
								//num은 자바스크립트 변수다
						}
					}
					</script>
					<%
					}
					%>
				</td>
		<td width="8%" align="center" style="font-size:12px;">
			<%=rs_comment.getString("tb_date") %>
				<!-- 댓글 입력날짜 -->
		</td>
	</tr>
	<tr><td colspan=3 height=1 width=100% bgcolor=#A11A20></td></tr>
	<%
	}
	%>
</table>
<!-- 한줄 댓글 목록 end-->





<form action="comment_insert.jsp" method="post" onsubmit="return send()">
<input type="hidden" name="code" value="<%=code %>">
<input type="hidden" name="uid" value="<%=uid %>">
<input type="hidden" name="field" value="<%=field %>">
<input type="hidden" name="search" value="<%=search %>">
<input type="hidden" name="page_now" value="<%=page_now %>">

<table width="800" border="0" cellpadding="0" cellspacing="0">
	<tr height=30>
		<td width="8%"></td>
		<td width="79%"><input id="view_comment" name="view_comment" style="width:99%"></td>
		<td width="13%" align=center>
			<%if(session_id != null){ %>
			<button style="border:none; width:80px; height:20px; border-radius:2px; background-color:#A11A20; color:#fefefe;">댓글등록</button>
			<%}else{ %>
			<input type="button" onclick="javascript:alert('넌 못함 ㅋ')" value="댓글등록">
			<%} %>
		</td>
	</tr>
	<tr><td colspan=3 height=1 width=100% bgcolor=#A11A20></td></tr>
</table>
</form>

<!-- 댓글 내용이 없을 때 경고창-->
<script>
function send(){
	if(!view_comment.value){
		alert("댓글 내용을 입력하세요.");
		view_comment.focus();
		return false;
	}
}
</script>

<br>
</center>

<%@ include file="/include/footer.jsp" %>