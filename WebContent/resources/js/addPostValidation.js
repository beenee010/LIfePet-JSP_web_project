function CheckFormData() {

	var form = document.newPost;
	var title = form.postName;
	var text = form.postText;
	var category = form.postCategory;

	if (!checkBlank(title, "제목")) return;
	else if (!(title.value.length >= 1 && title.value.length <= 50)) {
		alert("[제목]\n제목은 2~50자까지의 문자로 입력하세요.");
		title.select();
		title.focus();
		return;
	}

	if (!checkBlank(text, "내용")) return;
	if (!checkBlank(category, "분류")) return;

	if (checkSpecial(title, "제목")) return;
	if (checkSpecial(text, "내용")) return;
	if (checkSpecial(category, "분류")) return;

//	if (!checkSearchedWord(title, title.value)) return;
//	if (!checkSearchedWord(text, text.value)) return;
//	if (!checkSearchedWord(category, category.value)) return;

	function checkBlank(e, name) {
		if (e.value == "") {
			alert("[" + name + "]\n" + name + "을 입력해주세요.");
			e.select();
			e.focus();
			return false;
		}
		else
			return true;
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

	var result = confirm("게시글을 등록 하시겠습니까?");

	if (result)
		form.submit();
	else
		return;

}
