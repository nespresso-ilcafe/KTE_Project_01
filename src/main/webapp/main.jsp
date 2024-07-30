<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<center>

<table width=900 border="0" style="margin-top:78px; height:1000px;">
	<tr>
		<td valign="top">
		<table cellpadding="0" cellspacing="0" style="color:#3D195B; font-weight:bold;">
			<tr>
				<td valign="top">
					<img src="/img/liverpool/ynwa3.png" >
				</td>
			</tr>
		</table>
		</td>
		<td valign="top">
		<table border="0" width="280" height=1000 style="border:1px solid #3D195B;color:#3D195B; font-weight:bold;">
			<tr>
				<td>
				<table>
					<tr>
						<td width="15%" width="40" height="45" align="center" valign="middle" bgcolor="#fefefe">
							<img src="/img/league/epl.png" style="width:40px; height:40px;">
						</td>
						<td align="center" style="letter-spacing:3px; font-size:20px; font-weight:bold;">Premier league</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr><td height=1 bgcolor=#3D195B></td></tr>
			<tr>
				<td colspan="2">
				<table border="0" width="280" height="100%">
					<%
					String sql_notice = "select * from pl order by winpoint desc";
		
					Connection c_notice = DriverManager.getConnection(url, user, password);
					Statement st_notice = c_notice.createStatement();
					ResultSet rs_notice = st_notice.executeQuery(sql_notice);	
					
					%>
					<tr height="30">
						<td width=50 align ="center">순위</td>
						<td colspan="2"width=100 align ="center">팀</td>
						<td width=50 align ="center">승점</td>
						<td width=50 align ="center">승</td>
						<td width=50 align ="center">무</td>
						<td width=50 align ="center">패</td>
					</tr>
					<%
					int i=1;
					
					while(rs_notice.next()){
						String tname = rs_notice.getString("teamname");
						int point = rs_notice.getInt("winpoint");
						int win = rs_notice.getInt("win");
						int lose = rs_notice.getInt("lose");
						int draw = rs_notice.getInt("draw");
					%>
						<%if(tname.equals("LIV")){ %>
						<tr height="35" style="color:red;">
							<td align ="center">
								<%=i %><br>
							</td>
							<td align ="center" bgcolor="#fefefe">
								<img src = "/img/logos/<%=tname%>.png" style="width:35px; height:35px; text-align:center;">
							</td>
							<td align ="center"><%=tname %></td>
							<td align ="center"><%=point %></td>
							<td align ="center"><%=win %></td>
							<td align ="center"><%=draw %></td>
							<td align ="center"><%=lose %></td>
						</tr>
						<%}else{ %>
						<tr height="35">
							<td align ="center">
								<%=i %><br>
							</td>
							<td align ="center" bgcolor="#fefefe">
								<img src = "/img/logos/<%=tname%>.png" style="width:35px; height:35px; text-align:center;">
							</td>
							<td align ="center"><%=tname %></td>
							<td align ="center"><%=point %></td>
							<td align ="center"><%=win %></td>
							<td align ="center"><%=draw %></td>
							<td align ="center"><%=lose %></td>
						<%} %>
						</tr>
					<%
						i++;
					}
					
					rs_notice.close();
					st_notice.close();
					c_notice.close();
					%>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
		<td valign="top">
		<table width="150" height=1000 bgcolor="#A11A20">
			<tr>
				<td height=135  valign="top">
				<table width="100%" bgcolor=white style="margin-top:10px;">
					<tr><td height=1 bgcolor="#A11A20"></td></tr>
					<tr height=25 style="font-weight:bold;">
						<td align=center colspan=2  style="font-size:14px;font-weight:bold;"><%=session_name %> <font style="font-size:12px;">님<br>반갑습니다!</font></td>
					</tr>
					<tr><td height=1 bgcolor="#A11A20"></td></tr>
					<tr height=25>
						<td align=center colspan=2>
							<a href="/member/join_up.jsp" id=memberTab style="font-size:14px; font-weight:bold;">회원수정</a>
						</td>
					</tr>
					<tr><td height=1 bgcolor="#A11A20"></td></tr>
					<tr height=25>
						<td align=center colspan=2>
							<%
							if(session_level != null && session_level.equals("10")){ //관리자라면
								out.print("<a href='/admin.jsp' style='font-size:14px; font-weight:bold;'>[관리자]<a>"); //관리자 페이지가 보일 수 있도록
							}else{%>
							<a href="/mylist/mylist.jsp" id=memberTab>내게시물</a>
							<%
							}
							%>
						</td>
					</tr>
					<tr><td height=1 bgcolor="#A11A20"></td></tr>
					<tr height=25>
						<td align=center colspan=2>
							<a href="/member/logout.jsp" style="color:red; font-size:14px; font-weight:bold;" id=memberTab>로그아웃</a>
						</td>
					</tr>
					<tr><td height=1 bgcolor="#A11A20"></td></tr>
				</table>
				</td>
			</tr>
			<tr>
				<td height=800 valign="top">
				<table border="0" width="100%" style="font-weight:bold;">
					<tr>
						<td align=center colspan=2 height=30 bgcolor=white style="font-weight:bold;">잔여일정</td>
					</tr>
					<%
			        // API에서 데이터를 가져오기 위한 URL
			        String apiUrl = "https://api.football-data.org/v4/teams/64/matches?status=SCHEDULED";
			
			        // API에 요청을 보내고 응답 받기
			        java.net.URL url1 = new java.net.URL(apiUrl);
			        java.net.HttpURLConnection conn = (java.net.HttpURLConnection) url1.openConnection();
			        conn.setRequestMethod("GET");
			        conn.setRequestProperty("X-Auth-Token", "731b93c98f47406496f845ddca7ae683"); // 여기에 본인의 API 키를 넣어주세요
			        conn.setRequestProperty("Accept", "application/json");
			        java.io.BufferedReader br = new java.io.BufferedReader(new java.io.InputStreamReader(conn.getInputStream()));
					
			        // 응답 내용 읽기
			        StringBuilder responseBuilder = new StringBuilder();
			        String line;
			        while ((line = br.readLine()) != null) {
			            responseBuilder.append(line);
			        }
			        br.close();
			
			        // JSON 형태의 응답 내용을 파싱하여 화면에 출력
			        org.json.JSONObject jsonResponse = new org.json.JSONObject(responseBuilder.toString());
			        org.json.JSONArray matches = jsonResponse.getJSONArray("matches");

					SimpleDateFormat sdfUTC = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
					sdfUTC.setTimeZone(TimeZone.getTimeZone("UTC"));
					
					// 서울 시간으로 설정된 SimpleDateFormat 생성
					SimpleDateFormat sdfSeoul = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					sdfSeoul.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
					
					
				    int count = 0; // 출력된 일정의 수를 세는 카운터
				    
				    for (int j = 0; j < matches.length() && count < 10; j++) {
				        org.json.JSONObject match = matches.getJSONObject(j);
				        String homeTeam = match.getJSONObject("homeTeam").optString("name", "Unknown");
				        String homeTeamCrest = match.getJSONObject("homeTeam").optString("crest", "Unknown");
				        String awayTeam = match.getJSONObject("awayTeam").optString("name", "Unknown");
				        String awayTeamCrest = match.getJSONObject("awayTeam").optString("crest", "Unknown");
				        String time_1 = match.optString("utcDate", "");
				        String utcDateString = match.optString("utcDate", "");
				        Date utcDate = sdfUTC.parse(utcDateString);
				        String seoulTimeString = sdfSeoul.format(new Date(utcDate.getTime() + (9 * 60 * 60 * 1000)));
				        				        
				        if(homeTeam.equals("Liverpool FC")){
					%>
				            <tr>
				                <td width="50" height="10" rowspan="2" align="center">
				                    <img style="width:40px; height:40px" src="<%=awayTeamCrest%>">
				                </td>
				                <td align=center height="20" style="color:white; font-size:14px; font-weight:bold;">ANFIELD</td>
				            </tr>
				            <tr>
				                <td align=center style="color:white; font-size:12px"><%=seoulTimeString %></td>
				            </tr>
					<%
				        } else if(awayTeam.equals("Liverpool FC")) {
					%>
				            <tr>
				                <td width="50" height="10" rowspan="2" align="center">
				                    <img style="width:40px; height:40px" src="<%=homeTeamCrest%>">
				                </td>
				                <td align=center height="10" style="color:#dedede; font-size:14px;" >AWAY</td>
				            </tr>
				            <tr>
				                <td align=center height="20" style="color:#dedede; font-size:12px"><%=seoulTimeString %></td>
				            </tr>
					<%
				        }
				        count++; // 출력된 일정의 수 증가
				    }
					%>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</center>
<%@ include file="/include/footer.jsp" %>