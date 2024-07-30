<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<table border="0" width="100%" style="border-spacing:0px; margin-top:75px; margin-bottom:0px;">
	<tr>
		<td align="center">
		<form action="insert.jsp" method="post" onsubmit="return check();">
		<table border="0" width="600" style="text-align: center; border:3px solid #A11A20;">
			<tr>
				<td height="75"><img src="../img/liverpool/joinpage_anf_top.png"></td>
			</tr>
			<tr>
				<td align="center" >
					<table border="0" width="450">
                    	<tr>
                    		<td height="5"></td>
							<table border="0" width=450>
								<tr>
									<td align=center class=joinPtop>로그인정보</td>
								</tr>
								<tr>
		                	        <td colspan="3" align="center" >
									<input placeholder="이름을 입력하세요." id="name2" name="name" class="joinPageinputSt" onkeyup="characterCheck1(this)" onkeydown="characterCheck1(this)" required>
			                        </td>
			                    </tr>
			                    <tr>
		    	                	<td height="5"></td>
		        	            </tr>
		            	        <tr>
									<td colspan="3" align="center" >
										<input type="text" maxlength="20" placeholder="아이디를 입력하세요" id="id" name="id" class="joinPageinputSt" onkeyup="characterCheck2(this)" onkeydown="characterCheck2(this)" pattern="^[a-zA-Z0-9]{5,20}" title="영문과 숫자조합만 가능합니다" required>
		                        	</td>
		                    	</tr>
		                    	<tr>
		                    		<td height="5"></td>
		                    	</tr>
		                    	<tr>
		                        	<td colspan="3" align="center" >
		                      	  	<input type="password" minlength="5" maxlength="20" placeholder="비밀번호를 입력하세요" id="pass1" name="pass" class="joinPageinputSt" pattern="^[a-zA-Z0-9]{5,20}" title="영문과 숫자조합만 가능합니다"  required>
		                        	</td>
		                    	</tr>
		                    	<tr>
		                        	<td colspan="3" align="center" >
		                        	<input type="password" minlength="5" maxlength="20" placeholder="비밀번호를 다시 입력하세요" id="pass2" class="joinPageinputSt" pattern="^[a-zA-Z0-9]{5,20}" title="영문과 숫자조합만 가능합니다"  required>
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
	                                    		<input type="text" id="sample4_postcode" placeholder="우편번호" name="zipcode" class="joinPageAd">
	                                    	</td>
	                                    	<td>
	                                    		<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="joinPageAdBt">
                                    		</td>
                                    	</tr>
                                    	<tr>
                                    		<td>
                                    			<input type="text" id="sample4_roadAddress" placeholder="도로명주소" name="zipcode1" class="joinPageAd">
	                                    	</td>
	                                    	<td>
												<input type="text" id="sample4_jibunAddress" placeholder="지번주소" name="zipcode2" class="joinPageAd">
												<span id="guide" style="color:#999;display:none"></span>
                                    		</td>
                                    	</tr>
                                    	<tr>
                                    		<td>
                                    			<input type="text" id="sample4_extraAddress" placeholder="참고항목" name="zipcode3" class="joinPageAd">
	                                    	</td>
	                                    	<td>
												<input type="text" id="sample4_detailAddress" placeholder="상세주소" name="zipcode4" class="joinPageAd">
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
										<select class="joinPagePhoneFirst" id="pn1" name="pn1">
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
										</select>
            						</td>
                                    <td align="center" width="10">-</td>
                                    <td align="center" width="50">
										<input type="text" maxlength="4" class="joinPagePhoneNum" id="pn2" name="pn2" pattern="^[0-9]{3,4}" title="숫자3~4자리만 가능합니다" required>
                                    </td>
                                    <td align="center" width="10">-</td>
                                    <td align="left" width="125">
										<input type="text" maxlength="4" class="joinPagePhoneNum" id="pn3" name="pn3" pattern="^[0-9]{3,4}" title="숫자3~4자리만 가능합니다" required>
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
							<td align="center">
								<input placeholder="메일주소" class="joinPageinputSt" id="email" name=email title="이메일 형식은 ooo@ooo.ooo입니다!" pattern="[a-z0-9._%+/-]+@[a-z0-9._%+/-]+.[a-z0-9._%+/-]{9,30}$" required>
							</td>
						</tr>
						<tr>
							<td height="5"></td>
						</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td height="5"></td>
				</tr>
	            <tr>
	                <td colspan="4" align="center">
						<button type="submit" class="joinUpBt">회원가입</button>
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

<script>

function characterCheck1(obj){
	var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
	// 허용할 특수문자는 여기서 삭제하면 됨
	// 지금은 띄어쓰기도 특수문자 처리됨 참고하셈
	if( regExp.test(obj.value) ){
		alert("이름에 특수문자가 왜...?");
		obj.value = obj.value.substring( 0 , obj.value.length - 1 ); // 입력한 특수문자 한자리 지움
		//영문만 허용
		$(obj).val(str.replace(/[^a-z]/gi,""));
		obj.value = obj.value.substring( 0 , obj.value.length - 1 ); // 입력한 특수문자 한자리 지움
		return false;
		}
	}
function characterCheck2(obj){
	var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
	// 허용할 특수문자는 여기서 삭제하면 됨
	// 지금은 띄어쓰기도 특수문자 처리됨 참고하셈
	if( regExp.test(obj.value) ){
		alert("아이디는 영어만!");
		obj.value = obj.value.substring( 0 , obj.value.length - 1 ); // 입력한 특수문자 한자리 지움
		//영문만 허용
		$(obj).val(str.replace(/[^a-z]/gi,""));
		obj.value = obj.value.substring( 0 , obj.value.length - 1 ); // 입력한 특수문자 한자리 지움
		return false;
		}
	}
</script>

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