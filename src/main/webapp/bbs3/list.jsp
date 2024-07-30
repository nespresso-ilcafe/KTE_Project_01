<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>


<%


//검색
String field, search, sql_search;

String code = request.getParameter("code");

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

<table width=100% style="margin-top:95px;">
	<tr>
		<td align="center">
			<table >
				<tr>
					<td width=800 height=65 align="center" style="letter-spacing:3px; font-size:26px; font-weight:bold; background-color: #a11a20; color:#fefefe;">
						<%=bbs_title %>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<%
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////// 총 게시물 수 ///////////////////////////////

String sql = "select count(*) from "+code+" where gongji != '1'"+sql_search;
	// 테이블의 총 게시글을 가져와 카운트(*)로 숫자를 보여준다 

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);
	//jsp에서 select사용시 필수로 같이 가는애들

int total_record = 0; //전역변수 0으로 선언
if(rs.next()){
	total_record = rs.getInt(1); //갯수 카운트 후 전역변수에 총 갯수 업데이트
}

rs.close();
stmt.close();
con.close();
	//부하들 닫기
%>

<%
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////// 페이징관련 변수 ///////////////////////////////

int page_now = 1;

if(request.getParameter("page_now") != null){
	page_now = Integer.parseInt(request.getParameter("page_now"));
}

int num_per_page = 12;
	// 페이지당 출력 게시물 수 
int page_per_block = 5;
	// 한 블럭 당 링크 수 (1,2,3,4,5 가 한 개의 블럭)
int total_page = (int)Math.ceil(total_record / (double)num_per_page);
	// 총 페이지 수 ceil(올림)으로 123개면 13페이지
int first = num_per_page * (page_now - 1);
	// limit 시작 값
%>

<center>
<br>
<table width="800" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="50%" style="font-size:12px;">
		총 게시물 : <%=total_record %>
		</td>
	</tr>
</table>
<table width="800" border="0" cellpadding="0" cellspacing="0">
	<tr bgcolor=#A11A20 height="30" style="color:#fefefe;">
		<td width="60" align="center" id="bbsLabel">번호</td>
		<td width="440" id="bbsLabel" colspan="3">제목</td>
		<td width="100" align="center" id="bbsLabel">글쓴이</td>
		<td width="100" align="center" id="bbsLabel">날짜</td>
	</tr>

<%
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////// 공지글 반복문 ///////////////////////////////

if(page_now == 1){
	//공지글은 1페이지만 출력될 수 있도록 처리
	
	String sql_notice = "select * from "+code+" where gongji='1'";
	
	Connection c_notice = DriverManager.getConnection(url, user, password);
	Statement st_notice = c_notice.createStatement();
	ResultSet rs_notice = st_notice.executeQuery(sql_notice);
	
	
	while(rs_notice.next()){
		int uid = rs_notice.getInt("uid");
		String signdate = rs_notice.getString("signdate");
		String file1 = rs_notice.getString("file1"); //리네임파일 이름
		String subject = rs_notice.getString("subject");
		
		//제목길이값 구하기
		int sub_len = subject.length();
		
		//...처리
		if(sub_len > 20){
			subject = subject.substring(0,20)+"...";
		}
%>

	<tr height=22 bgcolor="#FFF6FA">
		<td align=center style="font-weight:bold;color:#A11A20;">공지</td>
		<td colspan="3" style="font-weight:bold;color:#A11A20;">
			<a href="view.jsp?code=<%=code%>&uid=<%=uid%>"><%=subject %></a>
			<!-- 제목 -->
			<%if(!file1.equals("")){%><img src="img/icon_file.gif"><%}%>
			<!-- 첨부파일 표시 -->
		</td>
			<%if(rs_notice.getString("name").equals("관리자")){ %>
				<td align=center style="font-weight:bold; color:#4db18b"><%=rs_notice.getString("name") %>
			<%}else{%>
				<td align=center><%=rs_notice.getString("name") %></td>
			<%}%>
			<!-- 글쓴이 -->
<!-- /////////////////////////// 관리자는 볼드체-->
		<td align=center style="font-size:12px;"><%=signdate %></td>
			<!-- 작성일 -->
	</tr>
	<tr>
		<td colsapn=5></td>
	</tr>
</table>
<%
}
rs_notice.close();
st_notice.close();
c_notice.close();

} //if문
%>
<table border="0" width="800">
<%
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////// 일반, 비밀글 반복문 ///////////////////////////////

String s_normal = "select * from "+code+" where gongji != '1' "+sql_search+"order by uid desc limit "+first+","+num_per_page;

Connection c_normal = DriverManager.getConnection(url, user, password);
Statement st_normal = c_normal.createStatement();
ResultSet rs_normal = st_normal.executeQuery(s_normal);

int num = total_record - ((page_now - 1) * num_per_page); //넘버링 처리
int i=0;

while(rs_normal.next()){
	int uid = rs_normal.getInt("uid");
	
	String signdate = rs_normal.getString("signdate");
	String file1 = rs_normal.getString("file1");
	String gongji = rs_normal.getString("gongji");
	String id = rs_normal.getString("id");
	String subject = rs_normal.getString("subject");
	String file1_s = rs_normal.getString("file1_s");

	//길이값 구하기
	int len_num = subject.length();
	
	//길이값에 따라 ...처리
	if(len_num > 10){
		subject = subject.substring(0, 10)+"...";
	}
	
if(i%4 == 0){
%>
	<tr border="0" cellpadding="0" cellspacing="0">
<%} %>
		<td style="text-align:center; width:200px; height:230px; padding:0px; text-align:center;">
			<a href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>">
			<img src="/upload/<%=file1_s%>" style="width:190px; height:190px; border:1px solid #ddd;"><br>
			<%=subject %>
			</a>
		</td>
<%
if(i%4 == 3){
%>
	</tr>
	<tr><td width="800" colspan=4 height=1 width=100% bgcolor=#A11A20></td></tr>
<%
}

Date signdate2, day2;

Date today = new java.util.Date(); //현재 날짜

Date day_22 = new java.util.Date(today.getTime() - (long)(1000*60*60*24*2)); //현재 날짜 - 2일
SimpleDateFormat bbb = new SimpleDateFormat("yyyy-MM-dd"); //년-월-일 변경
String day_2 = bbb.format(day_22); //2일전 날짜를 문자열 변수에 대입

day2 = new SimpleDateFormat("yyyy-MM-dd").parse(day_2); //2일전
signdate2 = new SimpleDateFormat("yyyy-MM-dd").parse(signdate); //작성일

i++;
num--;
}
rs_normal.close();
st_normal.close();
c_normal.close();

if(total_record == 0){
out.print("<tr><td colspan=5 height=150 align=center>게시물이 없습니다.</td></tr>");
}
%>
</table>

<table width="800" border="0">
	<tr>
		<td width="200" align="left">
		
			<%
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////// 페이징 처리 시작 ///////////////////////////////
			int total_block = 0;
			int block = 0;
			int first_page = 0;
			int last_page = 0;
			int direct_page = 0;
			int my_page = 0;
			// 사용할 전역 변수 선언 및 초기화
			
			total_block = (int)Math.ceil(total_page / (double)page_per_block); //총 블럭 수
			block = (int)Math.ceil(page_now / (double)page_per_block); //현재 블럭
			first_page = (block - 1) * page_per_block; //블럭내 시작하는 수
			last_page = block * page_per_block; //블럭내 끝나는 수
			
			if(total_block <= block) { //마지막 블럭일 때
				last_page = total_page; //반복문 변수 처리
			}
			
			
			// 이전 블럭 처리			
			if(block != 1){ //첫 블럭이 아니라면
			%>
				<a href="list.jsp?code=<%=code%>&field=<%=field%>&search=<%=search%>&page_now=<%=first_page%>"><img src="img/btn_left.gif"></a>&nbsp;&nbsp;
			<%
			}
			
			// 블럭내 페이지 수 출력 
			for(direct_page = first_page + 1; direct_page <= last_page; direct_page++){
				if(page_now == direct_page){
			%>
					<span class="page_on"><%=direct_page%></span>&nbsp;
			<%
				}else{
			%>
					<span class="page_off"><a href="list.jsp?code=<%=code%>&field=<%=field%>&search=<%=search%>&page_now=<%=direct_page%>"><%=direct_page%></a></span>&nbsp;
			<%
				}
			}
			// 다음 블럭 처리
			if(block < total_block) { //다음 블럭 존재
			%>
				&nbsp;<a href="list.jsp?code=<%=code%>&field=<%=field%>&search=<%=search%>&page_now=<%=last_page + 1%>"><img src="img/btn_right.gif"></a>
			<%
			}	
			%>
		</td>
		<td align="center" width="500">
			<form action="list.jsp">
			<input type="hidden" name="code" value="<%=code %>">
			<select name="field" style="height:28px;border-radius:3px">
				<option value='subject' <%if(field.equals("subject")){%>selected<%}%>>제목</option>
				<option value='comment' <%if(field.equals("comment")){%>selected<%}%>>내용</option>
				<option value='name' <%if(field.equals("name")){%>selected<%}%>>글쓴이</option>
			</select>
			<input name="search" value="<%=search %>" style="width:200px;height:25px;">
			<button style="width:50px; height:28px; border-radius:3px; color:#fefefe; font-weight:bold; background-color:#a11a20; border:1px solid #a11a20;">검색</button>
			</form>
		</td>
		<td width="200" align=right style="font-weight:bold; font-size:16px;">
			<%if(session_id != null){ //로그인 후 %>
			<a href="write.jsp?code=<%=code%>">글쓰기</a>
			<%}%>
			<!-- 로그인 하지 않으면 들어올 수 없기 때문에 
				로그인후 작성하실 수 있습니다 제외 -->				
		</td>
	</tr>
<%/////////////////////////////////////////////////////////////////////////////
/////////////////////////////// 검색 /////////////////////////////// %>
	<tr>
		
	</tr>
</table>

<br>
</center>

<%@ include file="/include/footer.jsp" %>
