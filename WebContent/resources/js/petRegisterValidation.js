function CheckRegister() {

	var form = document.petRegisterForm;
	var name = document.getElementById("petName");
	var breed = document.getElementById("petBreed");

	if (!check(name, "이름")) return;
	if (!check(breed, "품종")) return;

	if(checkScript(name, "이름")) return;
	if(checkScript(breed, "품종")) return;
	
	if(!checkSearchedWord(name, name.value)) return;
	if(!checkSearchedWord(breed, breed.value)) return;
	
	function check(e, name) {
		if (e.value == "") {
			alert("[" + name + "]\n" + name + "을 입력해주세요.");
			e.select();
			e.focus();
			return false;
		}
		else {
			return true;
		}
	}

	function checkScript(str, name) {
		var special_pattern = /<script>/gi;
		if (special_pattern.test(str.value) == true) {
			alert("[" + name + "]\n" + "<script>특수문자를 사용할 수 없습니다.")
			str.select();
			str.focus();
			return true;
		}
		else
			return false;
	}

	function checkSearchedWord(obj, val) {
		var sqlArray = new Array( //sql 예약어 
			"OR", "SELECT", "INSERT", "DELETE", "UPDATE", "CREATE", "DROP", "EXEC", "UNION", "FETCH", "DECLARE", "TRUNCATE");
		var regex;
		for (var i = 0; i < sqlArray.length; i++) {
			regex = new RegExp(sqlArray[i], "gi");
			if (regex.test(val)) {
				alert("\"" + sqlArray[i] + "\"와(과) 같은 특정문자로 검색할 수 없습니다.");
				//obj = obj.replace(regex, "");
				return false;
			}
		}
		return true;
	}

	var result = confirm("반려동물 등록 완료하시겠습니까?");

	if (result)
		form.submit();
	else
		return;

}

function skip(){
	var con = confirm("넘어가시겠습니까?\n마이페이지에서 추후 수정 가능합니다.");
	if(con)
		location.href='/main/login.jsp';
	else
		return;
}