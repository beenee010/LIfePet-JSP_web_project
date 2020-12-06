function CheckLogin() {
	
	var id = document.getElementById("id");
	var pass = document.getElementById("passwd");
	
	if(id.value == ""){
		alert("[아이디]\n아이디를 입력해 주세요.");
		id.select();
		id.focus();
		return false;
	}
	
	if(pass.value == ""){
		alert("[비밀번호]\n비밀번호를 입력해 주세요.");
		pass.select();
		pass.focus();
		return false;
	}
	
	if(checkSpecial(id)) return;
	if(!checkPasswordPattern(pass)) return;
	
	// 특수문자 탐지 (SQL 인젝션)
	function checkSpecial(str) {
		var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
		if(special_pattern.test(str.value) == true) {
			alert("[" + str.value + "]\n" + "특수문자를 사용할 수 없습니다.")
			str.select();
			str.focus();
			return true;
		}
		else
			return false;
	}
	
	function checkPasswordPattern(str) {
		var pattern1 = /[0-9]/; // 숫자 
		var pattern2 = /[a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣]/; // 문자 
		var pattern3 = /[~!@#$%^&*()_+|?:{}]/; // 특수문자
		if(!pattern1.test(str.value) || !pattern2.test(str.value) || !pattern3.test(str.value) || str.length < 8 || str.length > 20) {
			alert("[비밀번호]\n비밀번호는 8-20자리 문자, 숫자, 특수문자(<, > 제외)로 구성하여야 합니다.");
			str.select();
			str.focus();
			return false;
		} 
		else
			return true; 
	}

	document.getElementById("loginForm").submit();
}
function findPassword(){ //새창 만들기 
	window.open("/main/findPassword.jsp", "passwin", "width=400, height=400"); 
}