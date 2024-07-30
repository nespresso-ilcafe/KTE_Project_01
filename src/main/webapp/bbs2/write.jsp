<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
String code = request.getParameter("code"); //db : table 명

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

<table width=100% height=50 border=0 style="margin-top:75px;">
	<tr>
		<td align=center style="color:#777;font-size:14px;font-weight:bold;">[<%=bbs_title %>] 글쓰기</td>
	</tr>
</table>

<center>
<form action="insert.jsp" method="post" ENCTYPE="multipart/form-data">
	<!-- 파일첨부를 위해서 ENCTYPE="multipart/form-data"로 사용해야함 -->
	
<input type="hidden" name="code" value="<%=code%>">
	<!-- request.getParameter로 받은 코드값 -->
	
<table width="650" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan=3 height=1 width=100% bgcolor=#A11A20></td>
	</tr>
	<tr>
		<td height=26>옵션</td>
		<td colspan=3>
			<%if(session_level != null && session_level.equals("10")) {%>
			<input type="radio" name="gongji" value="1">공지
			<%} %>
			<input type="radio" name="gongji" value="2" checked>일반 
			<input type="radio" name="gongji" value="3">비밀 
		</td>
	</tr>
	<tr>
		<td colspan=3 height=1 width=100% bgcolor=#A11A20></td>
	</tr>
	<tr>
		<td height=26>제목</td>
		<td colspan=3>
			<input name="subject" style="height:20px;width:99%;" placeholder="제목을 입력하세요">
		</td>
	</tr>
	<tr>
		<td colspan=3 height=1 width=100% bgcolor=#A11A20></td>
	</tr>
	<tr>
		<td>내용</td>
		<td colspan=3>
			<textarea name="comment" style="height:250px;width:99%;"></textarea>
		</td>
	</tr>
	<tr>
		<td colspan=3 height=1 width=100% bgcolor=#A11A20></td>
	</tr>
	<tr height="25">
		<td></td>
		<td>
			<select name="trade">
				<option selected>택배거래</option>
				<option>직거래</option>
			</select>
		</td>
		<td style="font-size:14px;">
			<input name="price" placeholder="원하는 가격을 적어주세요" pattern="^[0-9]{0,20}" title="숫자만 입력가능합니다" required>
		</td>
	</tr>
	<tr>
		<td colspan=3 height=1 width=100% bgcolor=#A11A20></td>
	</tr>
	<tr>
		<td>첨부</td>
		<td>
			<input type="file" name="file1">
		</td>
	</tr>
	<tr>
		<td colspan=3 height=1 width=100% bgcolor=#A11A20></td>
	</tr>
</table>
<br>
<table width="800" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center"><button>작성완료</button></td>
	</tr>
</table>
<br>
</form>
</center>

<%@ include file="/include/footer.jsp" %>