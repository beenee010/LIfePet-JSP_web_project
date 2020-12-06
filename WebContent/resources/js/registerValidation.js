function CheckRegister() {
	
	var form = document.getElementById("registerForm");
	var name = document.getElementById("name");
	var phone1 = document.getElementById("phone1");
	var phone2 = document.getElementById("phone2");
	var phone3 = document.getElementById("phone3");
	var id = document.getElementById("id");
	var pass = document.getElementById("password");
	var passc = document.getElementById("passwordc");
	var email1 = document.getElementById("email1");
	var email2 = document.getElementById("email2");
	var address = document.getElementById("address");
	var checkAgree = document.getElementById("privacyAgree");
	var checkId = document.getElementById("checkId");
	
	// 빈칸인지 확인 && 특수문자 사용 여부 확인
	
	if(!checkBlank(name, "이름")) return;
	if(checkSpecial(name)) return;
	
	if(!checkBlank(phone1, "전화번호1")) return;
	if(!checkBlank(phone2, "전화번호2")) return;
	if(checkNumber(phone2)) return;
	
	if(!checkBlank(phone3, "전화번호3")) return;
	if(checkNumber(phone3)) return;
	
	if(!checkBlank(id, "아이디")) return;
	if(checkSpecial(id)) return;
	
	if(!checkBlank(pass, "비밀번호")) return;
	if(!checkBlank(passc, "비밀번호 확인")) return;
	
	if(!checkPasswordPattern(pass)) return;
	if(!checkPasswordPattern(passc)) return;
	
	if(pass.value != passc.value){
		alert("[비밀번호]\n비밀번호가 일치하지 않습니다.");
		pass.select();
		pass.focus();
		return;
	}
	
	if(!checkBlank(email1, "이메일1")) return;
	if(checkSpecial(email1)) return;
	if(!checkBlank(email2, "이메일2")) return;
	if(checkSpecial(email2)) return;
	
	if(!checkBlank(address, "주소")) return;
	if(checkSpecial(address)) return;
	
	
	// 개인정보 수집 동의
	if(!checkAgree.checked){
		alert("[개인정보 수집 동의]\n개인정보 수집에 동의해 주세요.");
		checkAgree.select();
		checkAgree.focus();
		return;
	}
	
	if(!checkId.checked){
		alert("[아이디]\n아이디 중복 검사를 해주세요.");
		id.select();
		id.focus();
		return;
	}
	
	// 빈칸 탐지
	function checkBlank(e, name){
		if(e.value == ""){
			alert("[" + name + "]\n" + name + "을 입력해주세요.");
			e.select();
			e.focus();
			return false;
		}
		else
			return true;
	}
	
	// 특수문자 탐지 (SQL 인젝션)
	function checkSpecial(str) {
		var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?<>]/gi;
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
	
	function checkNumber(str){
		if(isNaN(str.value)){
			alert("["+ str.value +"]\n숫자만 입력해 주세요.");
			str.select();
			str.focus();
			return true;
		}
		else
			return false;
	}
	
	
	var result = confirm("회원가입을 완료하시겠습니까?");
	
	if(result)
		form.submit();
	else
		return;
}

function CheckDuplicate(){
	var id = document.registerForm.id;
	if(id.value == ""){
		alert("[ID]\n아이디를 입력해주세요.");
		return;
	}
	
	var xPos = (document.body.offsetWidth/2) - (500/2); // 가운데 정렬
	xPos += window.screenLeft; // 듀얼 모니터일 때
	var yPos = (document.body.offsetHeight/2) - (300/2);
	
	var url = "idCheck.jsp?id=" + id.value;
	window.open(url, "confirm", 
	"toolbar=no, location=no, status=no, menubar=no, scrollbars=no, resizable=no, width=500, height=300, left="+ xPos +", top=" + yPos);
}
function idCheck(){ //새창 만들기 
	window.open("/main/idCheck.jsp", "idwin", "width=400, height=350"); 
}




