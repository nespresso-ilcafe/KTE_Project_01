<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%@ include file="/include/header.jsp" %>


<%
if(request.getParameter("team_win") != null && request.getParameter("team_lose") != null){
	String team_win = request.getParameter("team_win");
	String team_lose = request.getParameter("team_lose");
	int win_num = Integer.parseInt(request.getParameter("win_num"));
	int lose_num = Integer.parseInt(request.getParameter("lose_num"));
	int aaa = win_num - lose_num;//득실차
	
	//승리팀 패배팀
	String sql_win = "update pl set gamecount=gamecount+1, winpoint=winpoint+3,win = win+1, goal=goal+"+win_num+" , loss=loss+"+lose_num+" , goalloss = goalloss + "+aaa+" where teamname='"+team_win+"'"; //이긴팀
	String sql_lose = "update pl set gamecount=gamecount+1, lose=lose+1, goal=goal+"+lose_num+" , loss=loss+"+win_num+" , goalloss = goalloss - "+aaa+" where teamname='"+team_lose+"'"; //진팀
	
	//무승부
	String sql_draw1 = "update pl set gamecount=gamecount+1, winpoint=winpoint + 1, goal=goal+"+lose_num+" , loss=loss+"+win_num+" where teamname='"+team_win+"'";
	String sql_draw2 = "update pl set gamecount=gamecount+1, winpoint=winpoint + 1, goal=goal+"+win_num+" , loss=loss+"+lose_num+" where teamname='"+team_lose+"'";
	
	
	if(win_num == lose_num){
		//무승부
		Connection conn1 = DriverManager.getConnection(url, user, password);
		Statement st1 = conn1.createStatement();
		st1.executeUpdate(sql_draw1);
		
		Connection conn2 = DriverManager.getConnection(url, user, password);
		Statement stmt4 = conn2.createStatement();
		stmt4.executeUpdate(sql_draw2);
	}else{
		//승패
		Connection con1 = DriverManager.getConnection(url, user, password);
		Statement st2 = con1.createStatement();
		st2.executeUpdate(sql_win);
		
		Connection con2 = DriverManager.getConnection(url, user, password);
		Statement stmt2 = con2.createStatement();
		stmt2.executeUpdate(sql_lose);
	}
	
	
}
%>
<script>
function number_change(){
	if(team_win.value == team_lose.value){
		alert("같은팀이다");
		return false;
	}
}
</script>
<center>
<table style="margin-top:100px">
	<tr>
		<td colspan=3 align=center style="font-size:22px; font-weight:bold; height:50px;" valign="top">경기결과 입력</td>
	</tr>
</table>
<form method="post" onsubmit="return number_change()">
<table width=600 border=1 style="height:50px;" valign="top">
	<tr>
		<td width=200 height=100>
			<table>
				<tr>
					<td align=center style="font-size:25px; font-weight:bold">승리팀<br>
						<select id="team_win" name="team_win" style="text-align:center; width:200px; hright:150px; font-size:18px;">
							<option value="LIV">리버풀</option>
							<option value="ASN">아스날</option>
							<option value="MCI">맨시티</option>
							<option value="AV">아스톤빌라</option>
							<option value="TOT">토트넘</option>
							<option value="MCU">맨유</option>
							<option value="WHU">웨스트햄</option>
							<option value="NC">뉴캐슬</option>
							<option value="BRI">브라이튼</option>
							<option value="WOL">울버햄튼</option>
							<option value="CHE">첼시</option>
							<option value="FUL">풀럼</option>
							<option value="BON">본머스</option>
							<option value="CRF">팰리스</option>
							<option value="BRN">브렌트포드</option>
							<option value="EVR">에버튼</option>
							<option value="NHF">노팅엄</option>
							<option value="RUT">루턴타운</option>
							<option value="BUR">번리</option>
							<option value="SHE">셰필드</option>
						</select>
					</td>
				</tr>
			</table>
		</td>
		<td>
			<table align=center >
				<tr>
					<td colspan=2 align=center style="font-size:18px; font-weight:bold">스코어</td>
				</tr>
				<tr>
					<td>
						<input style="text-align:center; width:100px; height:75px; font-size:30px; font-weight:bold" id="win_num" name="win_num" required>
					</td>
					<td>
						<input style="text-align:center; width:100px; height:75px; font-size:30px; font-weight:bold" id="lose_num" name="lose_num" required>
					</td>
				</tr>
			</table>
		</td>
		<td width=200>
			<table>
				<tr>
					<td align=center style="font-size:25px; font-weight:bold">패배팀<br>
						<select id="team_lose" name="team_lose" style="text-align:center; width:200px; hright:150px; font-size:18px;">
							<option value="LIV">리버풀</option>
							<option value="ASN">아스날</option>
							<option value="MCI">맨시티</option>
							<option value="AV">아스톤빌라</option>
							<option value="TOT">토트넘</option>
							<option value="MCU">맨유</option>
							<option value="WHU">웨스트햄</option>
							<option value="NC">뉴캐슬</option>
							<option value="BRI">브라이튼</option>
							<option value="WOL">울버햄튼</option>
							<option value="CHE">첼시</option>
							<option value="FUL">풀럼</option>
							<option value="BON">본머스</option>
							<option value="CRF">팰리스</option>
							<option value="BRN">브렌트포드</option>
							<option value="EVR">에버튼</option>
							<option value="NHF">노팅엄</option>
							<option value="RUT">루턴타운</option>
							<option value="BUR">번리</option>
							<option value="SHE">셰필드</option>
						</select>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan=3 align=center><button>입력완료</button></td>
	</tr>
</table>
</form>

<%
String sql = "select * from pl";

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);
%>
<table border=1 width=600 height=150 style="margin-top:50px;">
	<tr>
		<td align=center valign=top height=15 colspan=10>경기 결과</td>
	</tr>
	<tr>
		<td>teamcode</td>
		<td>teamname</td>
		<td>gamecount</td>
		<td>winpoint</td>
		<td>win</td>
		<td>draw</td>
		<td>lose</td>
		<td>goal</td>
		<td>loss</td>
		<td>goalloss</td>
	</tr>
	<%while(rs.next()){ %>
	<tr>
		<td><%=rs.getInt("teamcode") %></td>
		<td><%=rs.getString("teamname") %></td>
		<td><%=rs.getInt("gamecount") %></td>
		<td><%=rs.getInt("winpoint") %></td>
		<td><%=rs.getInt("win") %></td>
		<td><%=rs.getInt("draw") %></td>
		<td><%=rs.getInt("lose") %></td>
		<td><%=rs.getInt("goal") %></td>
		<td><%=rs.getInt("loss") %></td>
		<td><%=rs.getInt("goalloss") %></td>
	</tr>
	<%} %>
</table>
</center>