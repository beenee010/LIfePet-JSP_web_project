function CheckFormData() {

	var form = document.newItem;
	var name = form.name;
	var description = form.description;
	var category = form.category;
	var price = form.unitPrice;
	var stocks = form.unitsInStock;


	if (!emptyCheck(name, "상품명")) return;
	else if (!(name.value.length >= 4 && name.value.length <= 20)) {
		alert("[상품명]\n상품명은 4~20자까지의 문자로 입력하세요.");
		name.select();
		name.focus();
		return;
	}

	if (!emptyCheck(price, "가격")) return;
	else if (price.value < 0) {
		alert("[가격]\n가격은 음수가 될 수 없습니다.");
		price.select();
		price.focus();
		return;
	}
	else if (isNaN(price.value)) {
		alert("[가격]\n가격은 숫자만 입력해야 합니다.");
		price.select();
		price.focus();
		return;
	}

	if (!emptyCheck(description, "상세 정보")) return;
	if (!emptyCheck(category, "분류")) return;
	if (!emptyCheck(stocks, "재고수")) return;
	else if (stocks.value < 0) {
		alert("[재고수]\n재고수는 음수가 될 수 없습니다.");
		stocks.select();
		stocks.focus();
		return;
	}
	else if (isNaN(stocks.value)) {
		alert("[재고수]\n재고수는 숫자만 입력해야 합니다.");
		stocks.select();
		stocks.focus();
		return;
	}

	if (checkSpecial(name, "상품명")) return;
	if (checkSpecial(description, "상세 정보")) return;
	if (checkSpecial(category, "분류")) return;

//	if (!checkSearchedWord(name, name.value)) return;
//	if (!checkSearchedWord(description, description.value)) return;
//	if (!checkSearchedWord(category, category.value)) return;

	/*-----------Function------------*/

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
				alert("\"" + sqlArray[i] + "\"와(과) 같은 특정문자로 검색할 수 없습니다.");
				//obj = obj.replace(regex, "");
				return false;
			}
		}
		return true;
	}

	var imgFile = form.filename.value;
	var fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/;
	var maxSize = 5 * 1024 * 1024;
	var fileSize;

	if (!imgFile) {
		alert("첨부파일은 필수!");
		form.filename.focus();
		return;
	}

	if (imgFile != "" && imgFile != null) {
		fileSize = document.getElementById("filename").files[0].size;

		if (!imgFile.match(fileForm)) {
			alert("이미지 파일만 업로드 가능");
			return;
		} else if (fileSize > maxSize) {
			alert("파일 사이즈는 5MB까지 가능");
			return;
		}
	}

	var result = confirm("상품을 등록 하시겠습니까?");

	if (result)
		form.submit();
	else
		return;
}
