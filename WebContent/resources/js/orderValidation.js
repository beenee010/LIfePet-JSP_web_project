function OrderCheck(){
	
	var form = document.orderForm;
	var id = form.id;
	var name = form.name;
	var country = form.country;
	var zip = form.zip;
	var address = form.address;
	var memo = form.memo;
	
	if(!emptyCheck(name, "이름")) return;
	if(!emptyCheck(country, "국가")) return;
	if(!emptyCheck(zip, "우편번호")) return;
	if(!emptyCheck(address, "주소")) return;
	
	if(checkSpecial(name, "이름")) return;
	if(checkSpecial(country, "국가")) return;
	if(checkSpecial(zip, "우편번호")) return;
	if(checkSpecial(address, "주소")) return;
	if(memo.value != null)
		if(checkSpecial(memo, "메모")) return;
	
	if(!checkSearchedWord(name, name.value)) return;
	if(!checkSearchedWord(country, country.value)) return;
	if(!checkSearchedWord(zip, zip.value)) return;
	if(!checkSearchedWord(address, address.value)) return;
	if(!checkSearchedWord(memo, memo.value)) return;
	
	
	/*------------------------Function-------------------------*/
	
	function emptyCheck(e, name) {
		if (e.value == "") {
			alert("[" + name + "]\n" + name + "을(를) 입력해주세요.");
			e.select();
			e.focus();
			return false;
		}
		else {
			return true;
		}
	}

	function checkSpecial(str, name) {
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
				alert("\"" + sqlArray[i] + "\"와(과) 같은 특정문자를 입력할 수 없습니다.");
				//obj = obj.replace(regex, "");
				return false;
			}
		}
		return true;
	}
	
	var res = confirm("주문을 완료하시겠습니까?");
	
	if(res)
		form.submit();
	else
		return;
	
}


