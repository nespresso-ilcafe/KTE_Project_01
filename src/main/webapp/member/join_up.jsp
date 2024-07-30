<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>


<%
//////////////////////////////회원수정//////////////////////////////

String sql = "select * from member where id = '"+session_id+"'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

if(rs.next()){
%>
<script>
	function joinUp(){
		if(id.value == null){
			alert("아이디를 입력하세요");
			id.focus;
			return false;
		}
		
		if(pass.value != pass2.value){
			alert("비밀번호를 확인하세요");
			pass.focus;
			return false;
		}
	}
</script>


<table width="100%" height=50 border=0>
	<tr>
		<td align=center>
			<form action="join_update.jsp" method="post" onsubmit="return joinUp()">
			<table border="0" width="600" style="text-align: center; border:3px solid #A11A20;border-spacing:0px; margin-top:75px;margin-bottom:1px;"">
					<tr>
						<td height="75"><img src="../img/liverpool/joinpage_anf_top.png"></td>
					</tr>
					<tr>
                        <td align="center" >
                        	<table border="0" width="450" >
								<tr>
									<td class="joinPageLabel" style="color:white">회원수정</td>
								</tr>
			                    <tr>
			                    	<td height="5"></td>
			                    </tr>
								<tr>
									<td align="center">
										<table border="0" >
											<tr>
						                        <td colspan="3" align="center" >
						                        	<input value="<%=rs.getString("name")%>" name="name" class="joinPageinputSt">
						                        </td>
						                    </tr>
						                    <tr>
						                    	<td height="5"></td>
						                    </tr>
						                    <tr>
						                        <td colspan="3" align="center" >
						                        	<input class="joinPageinputSt" name="id" value="<%=rs.getString("id")%>" readonly>
						                        </td>
						                    <tr>
						                    <tr>
						                    	<td height="5"></td>
						                    </tr>
						                    <tr>
						                        <td colspan="3" align="center" >
						                        <input type="password" placeholder="비밀번호를 입력하세요" name="pass" class="joinPageinputSt" >
						                        </td>
						                    </tr>
						                    <tr>
						                        <td colspan="3" align="center" >
						                        <input type="password" placeholder="비밀번호를 다시 입력하세요" name="joinPagePassChk" class="joinPageinputSt" >
						                        </td>
				                    		</tr>
						                    <tr>
						                    	<td height="5"></td>
						                    </tr>
										</table>
									</td>
								</tr>
                        	</table>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <table border="0" width="450">
                                <tr>
                            		<td align=center class="joinPad">주소</td>
                            	</tr>
			                    <tr>
			                    	<td height="5"></td>
			                    </tr>
                                <tr>
                                    <td align="center">
	                                    <table border="0">
	                                    	<tr>
	                                    		<td>
		                                    		<input type="text" id="sample4_postcode" value="<%=rs.getString("zc")%>" name="zipcode" class="joinPageAd">
		                                    	</td>
		                                    	<td>
		                                    		<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="joinPageAdBt">
	                                    		</td>
	                                    	</tr>
	                                    	<tr>
	                                    		<td>
	                                    			<input type="text" id="sample4_roadAddress"  value="<%=rs.getString("zc1")%>" name="zipcode1" class="joinPageAd">
		                                    	</td>
		                                    	<td>
													<input type="text" id="sample4_jibunAddress"  value="<%=rs.getString("zc2")%>" name="zipcode2" class="joinPageAd">
													<span id="guide" style="color:#999;display:none"></span>
	                                    		</td>
	                                    	</tr>
	                                    	<tr>
	                                    		<td>
	                                    			<input type="text" id="sample4_extraAddress"  value="<%=rs.getString("zc3")%>" name="zipcode3" class="joinPageAd">
		                                    	</td>
		                                    	<td>
													<input type="text" id="sample4_detailAddress"  value="<%=rs.getString("zc4")%>" name="zipcode4" class="joinPageAd">
	                                    		</td>
	                                    	</tr>
	                                    	
	                                   </table>
									</td>
                                </tr>
			                    <tr>
			                    	<td height="5"></td>
			                    </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                    	<td align="center">
                            <table  width="450" border="0">
                                <tr>
                                    <td align=center class="joinPpn">전화번호</td>
                                </tr>
			                    <tr>
			                    	<td height="5"></td>
			                    </tr>
                                <tr>
                                    <td>
                                        <table border="0">
                                            <tr>
                                            	<td width="40"></td>
                                                <td align="right" width="125">
                                                    <select class="joinPagePhoneFirst" name="pn1">
                                                        <option value="010">010</option>
                                                        <option value="011">011</option>
                                                        <option value="016">016</option>
                                                    </select>
                                                </td>
                                                <td align="center" width="10">-</td>
                                                <td align="center" width="50">
                                            	    <input value="<%=rs.getString("pn2")%>"   class="joinPagePhoneNum" name="pn2">
                                                </td>
                                                <td align="center" width="10">-</td>
                                                <td align="left" width="125">
                                              	  <input value="<%=rs.getString("pn3")%>" class="joinPagePhoneNum" name="pn3">
                                                </td>
                                            	<td width="40" height="5"></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                    	<td align="center">
                            <table border="0"width="450">
                                <tr>
                                    <td align="center" class="joinPgen">성별</td>
                                </tr>
			                    <tr>
			                    	<td height="5"></td>
                                </tr>
                                <tr>
                                	<td>
                                        <table border="0">
                                            <tr>
                                            	<td width="200"></td>
                                                <td width="100"  align="center">
                                                    <label><input style="width: 100px; font-size: 16px;" type="radio" name="gender" value="M" checked>남성</label>
                                                </td>
                                                <td width="100"  align="center">
                                                    <label><input style="width: 100px; font-size: 16px;" type="radio" name="gender" value="F">여성</label>
                                                </td>
                                            	<td width="200"></td>
                                            </tr>
						                    <tr>
						                    	<td height="5"></td>
						                    </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                    	<td align="center">
                            <table  width="450">
                            	<tr>
                            		<td align=center class="joinPmail">메일</td>
                            	</tr>
				                    <tr>
				                    	<td height="5"></td>
				                    </tr>
                                <tr>
                                    <td align="center"><input value="<%=rs.getString("email")%>" class="joinPageinputSt" name="email"></td>
                                </tr>
				                    <tr>
				                    	<td height="5"></td>
				                    </tr>
                            </table>
                        </td>
                    <tr>
                    	<td height="5"></td>
                    </tr>
                    <tr>
                        <td colspan="4">
                        	<button class="joinUpBt">회원수정</button>
                        </td>
                    </tr>
                    <tr>
                    	<td height="20"></td>
                    </tr>
					<tr>
						<td colspan="4" style="line-height:0px">
							<img src="../img/liverpool/joinpage_anf_bot.png">
						</td>
					</tr>
                </table>
			</form>
		</td>
	</tr>
</table>
<%
}

rs.close();
stmt.close();
conn.close();
%>
<%@ include file="/include/footer.jsp" %>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>


