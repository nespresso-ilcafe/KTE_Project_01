<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>This is Anfield.kr</title>
<!-- 이미지만 넣으면 끝 -->
<style>
		*{
			padding: 0px;
			margin: 0px;
		}
		#logo_st{
			width: 1280px;
			height: 580px;
		}
		#cup_img{
			width: 100px;
			height:100px;
		}
		#join_st{
			width: 200px;
			height: 50px;
			border-radius: 25px;
			border: 5px solid white;
			background-color: black;
			font-weight:bold;
			font-size: 20px;
			color: white;
			cursor: pointer;
		}
		.loginJoin{
			width: 150px;
			height: 30px;
			border: 2px solid #A11A20;
			border-radius: 10px;
			background-color: #A11A20;
			text-align: center;
			font-size: 16px;
			font-weight: bold;
			color: white;
		}
		.idPs{
			width: 150px;
			height: 30px;
			border: 2px solid #A11A20;
			border-radius: 10px;
			background-color: white;
			text-align: center;
			font-size: 16px;
			font-weight: bold;
			color: black;
		}
/*팝업레이어 영역------------------------------ */
		
		#popup_layer{
        position: fixed;
        left:0;
        top:0;
        width:100%;
        height:100%;
        background-color:rgba(0,0,0,0.6);
        margin:0 auto;
    	}
		#popup_layer_1{
			background-color:white;
			text-align: center;
			border-radius: 10px;
		}
		#popup_layer_2{
			background-color: #A11A20;
			text-align: center;
			border-radius: 10px;
		}

	

</style>

</head>
<body>
<!-- 메인페이지 -->
	<table width=100% height=100% bgcolor=black style="margin-top:50px">
		<tr>
			<td align ="center">
				<table>
					<tr>
						<td>
							<table width=100% style="font-size:12px;"">
								<tr align="center">
									<td>
									<img src = "/img/liverpool/champ4.png" style="width:1280px;">
									</td>
								</tr>
							</table>

							<table width="100%" height="100" style="color:white; font-weight:bold; font-size: 16px;;">
								<tr>
									<td align="center" valign="top"><button id="join_st" onclick="openPopup()">JOIN</button></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

	
	<script>
	//팝업 띄우기
	function openPopup(){
		document.getElementById("popup_layer").style.display = "block";
	}
	//팝업 닫기
	function closePopup(){
		document.getElementById("id").value = "";
		document.getElementById("pass").value = "";
		document.getElementById("popup_layer").style.display = "none";
		
	}
	//로그인 유효성검사
	function login(){
		if(id.value == ""){
			alert("아이디를 입력하세요");
			id.focus();
			return false;
		}
		if(pass.value == ""){
			alert("비밀번호를 입력하세요");
			pass.focus();
			return false;
		}
	}
		
	//회원가입페이지 이동
	function goJoin(){
		location.href='member/join.jsp';
	}
	</script>

<div id="popup_layer" style="display:none;">
<div style="height:218px;"></div>
<center>
<table id="popup_layer_1">
	<tr>
		<td height="455" width="450" >
			<table width="100%" height="100%" id="popup_layer_2">
				<tr>
					<td height="10" style="border-radius: 10px;"></td>
				</tr>
				<tr>
					<td height="67" id="popup_layer_2"><img src="/img/liverpool/this_is.png"></td>
				</tr>
				<tr>
					<td align="center">
						<table width="300" id="popup_layer_1">
							<form action="/member/login_update.jsp" method="post">
								<tr height="25">
									<td></td>
								</tr>
								<tr height="40">
									<td><input placeholder="아이디" id="id" name="id" class="idPs"></td>
								</tr>
								<tr height="40">
									<td><input placeholder="비밀번호" id="pass" name="pass" class="idPs" type="password"></td>
								</tr>
								<tr height="40">
									<td><button id="btLogin" class="loginJoin" style="cursor: pointer;">로그인</button></td>
								</tr>
								<tr height="40" align="center">
									<td><p id="btJoin" class="loginJoin" onclick="goJoin()" style="cursor: pointer;">회원가입</p></td>
								</tr>
								<tr height="40"align="center">
									<td><p onclick="closePopup()" style="font-size: 18px;cursor: pointer;"><b>EXIT</b></p></td>
								</tr>
								<tr height="25">
									<td></td>
								</tr>
							</form>
						</table>
					</td>
				<tr>
					<td height="67" id="popup_layer_2"><img src="../img/liverpool/anfield.png"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</center>
</div>

</body>
</html>