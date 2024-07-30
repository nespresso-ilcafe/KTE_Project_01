<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<style>
#bbsLabel{
	font-size:16px;
	font-weight:bold;}
.page_on {
	padding:0px 5px;
	color:#A11A20;
	border:2px solid #A11A20;
	font-weight:bold;
}
.page_off {
	padding:0px 5px;
	color:#4db18b;
	border:2px solid #4db18b;
}
</style>

<table width=100% style="margin-top:95px;">
	<tr>
		<td align="center">
			<table >
				<tr>
					<td width=800 height=65 align="center" style="letter-spacing:3px; font-size:26px; font-weight:bold; background-color: #a11a20; color:#fefefe;">
						내가쓴글
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<%
String table_name[] = new String[] {"jayu","ungwon","jarang","jungko"};


/////////////////////////////////////////////////////////////////////////////
/////////////////////////////// 총 게시물 수 ///////////////////////////////
int total_record = 0;

for(int i=0; i<table_name.length; i++){
	String sql = "select count(*) from "+table_name[i]+" where gongji != '1' and id='"+session_id+"'";
		// 테이블의 총 게시글을 가져와 카운트(*)로 숫자를 보여준다 

	Connection con = DriverManager.getConnection(url, user, password);
	Statement stmt = con.createStatement();
	ResultSet rs = stmt.executeQuery(sql);
		//jsp에서 select사용시 필수로 같이 가는애들

	if(rs.next()){
		total_record += rs.getInt(1);
		//갯수 카운트 후 전역변수에 총 갯수 업데이트
	}
		
	rs.close();
	stmt.close();
	con.close();
		//부하들 닫기
}
%>

<center>
<br>
<table width="800" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="250" style="font-size:12px;">
		총 게시물 : <%=total_record %>
		</td>
	</tr>
</table>
<table width="800" border="0" cellpadding="0" cellspacing="0" style="margin-bottom:75px;">
	<tr bgcolor=#A11A20 height="30" style="color:#fefefe;">
		<td width="60" align="center" id="bbsLabel">게시판</td>
		<td width="440" id="bbsLabel">제목</td>
		<td width="100" align="center" id="bbsLabel">글쓴이</td>
		<td width="100" align="center" id="bbsLabel">날짜</td>
	</tr>

<%
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////// 일반, 비밀글 반복문 ///////////////////////////////

for(int i=0; i<table_name.length; i++){

	String s_normal = "select * from "+table_name[i]+" where id = '"+session_id+"' order by uid desc";
	
	Connection c_normal = DriverManager.getConnection(url, user, password);
	Statement st_normal = c_normal.createStatement();
	ResultSet rs_normal = st_normal.executeQuery(s_normal);
	
	int num = total_record; //넘버링 처리
	
	while(rs_normal.next()){
		int uid = rs_normal.getInt("uid");
		
		String signdate = rs_normal.getString("signdate");
		String file1 = rs_normal.getString("file1");
		String gongji = rs_normal.getString("gongji");
		String id = rs_normal.getString("id");
		String subject = rs_normal.getString("subject");
	
		//길이값 구하기
		int len_num = subject.length();
		
		//길이값에 따라 ...처리
		if(len_num > 20){
			subject = subject.substring(0, 20)+"...";
		}
		
		Date signdate2, day2;
	
		Date today = new java.util.Date(); //현재 날짜
	
		Date day_22 = new java.util.Date(today.getTime() - (long)(1000*60*60*24*2)); //현재 날짜 - 2일
		SimpleDateFormat bbb = new SimpleDateFormat("yyyy-MM-dd"); //년-월-일 변경
		String day_2 = bbb.format(day_22); //2일전 날짜를 문자열 변수에 대입
	
		day2 = new SimpleDateFormat("yyyy-MM-dd").parse(day_2); //2일전
		signdate2 = new SimpleDateFormat("yyyy-MM-dd").parse(signdate); //작성일
	
%>
	<tr height=22>
		<%if(table_name[i] == "jayu"){ %>
			<td align=center style="font-size:12px;">
			자유방
			</td>
		<%}else if(table_name[i] == "ungwon"){ %>
			<td align=center style="font-size:12px;">
			응원방
			</td>
		<%}else if(table_name[i] == "jarang"){ %>
			<td align=center style="font-size:12px;">
			자랑방
			</td>
		<%}else if(table_name[i] == "jungko"){ %>
			<td align=center style="font-size:12px;">
			중고방
			</td>
		<%} %>
		<td>
			<%if(table_name[i] == "jayu"){ %>
				<a href="/bbs4/view.jsp?code=<%=table_name[i]%>&uid=<%=uid%>&field=&search=&page_now=1"><%=subject %></a>
				
			<%}else if(table_name[i] == "ungwon"){%>
				<a href="/bbs/view.jsp?code=<%=table_name[i]%>&uid=<%=uid%>&field=&search=&page_now=1"><%=subject %></a>
				
			<%}else if(table_name[i] == "jarang"){%>
				<a href="/bbs3/view.jsp?code=<%=table_name[i]%>&uid=<%=uid%>&field=&search=&page_now=1"><%=subject %></a>
				
			<%}else if(table_name[i] == "jungko"){%>
				<a href="/bbs2/view.jsp?code=<%=table_name[i]%>&uid=<%=uid%>&field=&search=&page_now=1"><%=subject %></a>
			<%}%>
			
			
			
			<!-- 파일첨부시 아이콘 -->
			<%if(!file1.equals("")){%>
			<img src="img/icon_file.gif">
			<%}%>
			
			<!-- 비밀글일때 아이콘 -->
			<%if(gongji.equals("3")){ %>
				<img src="img/icon_secret.gif">
			<%}%>
			
			<!-- 최신글일때 아이콘 -->
			<%if(signdate2.getTime() >= day2.getTime()){%>
				<img src="img/main_new.gif">
			<%}%>
		</td>
			<%if(rs_normal.getString("id").equals(session_id)){ %>
				<td align=center style="font-size:14px; font-weight:bold;"><%=rs_normal.getString("name") %></td>
			<%}%>
		<!-- 별명 같을 때 볼드체 -->
		<td align=center style="font-size:12px;">
			<%=signdate %>
		</td>
	</tr>
	<tr><td colsapn=4></td></tr>
<%
	num--;
	} //while
		
	rs_normal.close();
	st_normal.close();
	c_normal.close();

} //for

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////// 게시글이 없을 때 ///////////////////////////////
if(total_record == 0){
	out.print("<tr><td colspan=4 height=150 align=center>게시물이 없습니다.</td></tr>");
}
%>
	
	</tr>
</table>
<br>
</center>

<%@ include file="/include/footer.jsp" %>
