# LIfePet (라이펫)

## [LIfePet](http://3.35.4.148:8080/welcome.jsp) - http://3.35.4.148:8080/welcome.jsp


## 개요
### 해당 웹 사이트는 반려동물 관련 포스팅, 상품구매, 중고거래, 반려동물 목록 관리 등을 하기 위한 사이트입니다.


## Version
### - Java openjdk-11
### - Mysql-5.7.31
### - Eclipse
### - Tomcat 9.37


## 프로젝트 구조
Java와 JS, CSS 등을 활용하여 제작하였습니다.
Database는 MySQL을 사용하였고, Tomcat-9로 호스팅 하였습니다.
호스팅 서버는 AWS 우분투 입니다. 개인정보는 이용하지 않으며 허위 정보를 사용하셔도 됩니다.
실제로 판매나 구매가 이루어지지 않으며 데모 버전임을 알려드립니다.  
  
## 디렉터리 구조
```
|----WebContent  
|    |----META-INF  
|    |----WEB-INF
|    |    |--web.xml
|    |    |--...
|    |----assets         // bootstrap
|    |    |--...
|    |----board          // 게시판
|    |    |--...
|    |----exeption       // 예외처리
|    |    |--...
|    |----fleaMarket     // 중고 거래
|    |    |--...
|    |----main           // 로그인, 회원가입, 마이페이지 등
|    |    |--...
|    |----resources      // 저장된 이미지, js, css, ..
|    |    |----...
|    |----shop           // 상점
|    |    |--...
|    |--dbconn.jsp         // JDBC 연결 코드
|    |--processWelcome.jsp // welcome 페이지 처리
|    |--welcome.jsp          // 메인 페이지
|----build/classes  
|----src
|    |----bundle          // 다국어 처리
|    |    |--...
|    |----dao           // Repository: Post, Item, Flea 등의 데이터 처리 및 회원가입 처리
|    |    |--...
|    |----dto           // Class (Object): Post, Item, Flea 등의 객체 클래스
|    |    |--...
|    |----utils         // 페이징 처리를 위한 유틸
|    |    |--...
|--LIfePet_Sources.war  
|--README.md  
```
  
## 이용방법

### 1. 위의 링크로 접속한다.

### 2. 메인 페이지가 보이고, 우측 상단에 로그인 버튼을 클릭한다.
![pc_photo (2)](https://user-images.githubusercontent.com/65976572/101276004-5d7a3900-37ed-11eb-9eea-e0c6eb083cd2.png)
![pc_photo (8)](https://user-images.githubusercontent.com/65976572/101276011-5f43fc80-37ed-11eb-8392-8dcb12f44b08.png)

### 3. 회원가입을 진행한다. (이때, 아이디 중복 확인은 필수적이며, 개인정보 동의도 필수적이다.)
![pc_photo (9)](https://user-images.githubusercontent.com/65976572/101276012-5fdc9300-37ed-11eb-8d0f-23262fd659b7.png)

![pc_photo (10)](https://user-images.githubusercontent.com/65976572/101276013-5fdc9300-37ed-11eb-902a-dcaf56c07e81.png)
![pc_photo (11)](https://user-images.githubusercontent.com/65976572/101276014-60752980-37ed-11eb-8129-9ff2dd47a301.png)
![pc_photo (12)](https://user-images.githubusercontent.com/65976572/101276015-610dc000-37ed-11eb-9391-278fe949682a.png)

### 4. 반려동물 등록은 스킵해도 추후 등록이 가능하다.
![pc_photo (15)](https://user-images.githubusercontent.com/65976572/101276018-623eed00-37ed-11eb-8db7-3bb0f91ca467.png)

### 5. 등록페이지를 지나가면 로그인 페이지로 리다이렉트된다.
![pc_photo (8)](https://user-images.githubusercontent.com/65976572/101276011-5f43fc80-37ed-11eb-8392-8dcb12f44b08.png)

### 6. 회원가입을 완료한 아이디와 비밀번호를 입력하고 로그인을 한다.
### 7. 로그인이 성공하면 메인 페이지로 리다이렉트된다.
### 8. 좌측 상단에 좌측부터 메인페이지, 게시판, 쇼핑, 중고거래 순으로 나열되어있다.
### 9. 먼저 Board를 클릭하면 게시판으로 이동되며 그 곳에서 게시글을 확인할 수 있다.
![pc_photo (1)](https://user-images.githubusercontent.com/65976572/101275944-20ae4200-37ed-11eb-8867-f525b8439093.png)

### 10. 보고싶은 게시글을 골라 상세정보를 클릭하면 해당 게시물의 전체 내용과 상제 정보를 확인할 수 있다.
![pc_photo (5)](https://user-images.githubusercontent.com/65976572/101276008-5e12cf80-37ed-11eb-9215-92df8a4d4f80.png)

### 11. 게시글을 작성하기 위해서는 게시판에서 상단에 존재하는 게시글 등록 버튼을 클릭한다.
![pc_photo (33)](https://user-images.githubusercontent.com/65976572/101275996-5a7f4880-37ed-11eb-84c2-df239629f099.png)

### 12. 게시글을 작성할 수 있는 페이지로 이동하고, 원하는 게시글을 작성할 수 있다.
### 13. 입력 폼에서는 유효성 검사를 진행하기때문에 SQL 인젝션이나 xss 공격등을 방어할 수 있다. (사진은 무조건 입력해야한다.)
![pc_photo (21)](https://user-images.githubusercontent.com/65976572/101275982-56532b00-37ed-11eb-86f5-92f80cadeddd.png)

### 14. 게시글 작성이 완료되면, 게시판에서 자신이 작성한 게시글을 확인할 수 있다.
### 15. 자신이 작성한 게시물은 작성자 본인만 삭제 및 수정이 가능하다.
![pc_photo (22)](https://user-images.githubusercontent.com/65976572/101275984-56532b00-37ed-11eb-9a2e-c8e89508a803.png)


### 16. 좌측 상단에 Shop을 클릭하면 상점으로 이동이 된다.
### 17. 상품은 사이트 관리자만 글을 업로드할 수 있기 때문에 일반 사용자는 불가능하다.
![pc_photo (3)](https://user-images.githubusercontent.com/65976572/101276005-5d7a3900-37ed-11eb-8606-1ee9b1ceda20.png)


### 18. 상품을 주문하기 위해서 상품을 골라 상세 보기를 클릭한다.
### 19. 재고가 남아있을 경우에는 주문이 가능하지만, 재고가 없는 경우에느 주문하기 버튼이 비활성화 되어 있다.
![pc_photo (6)](https://user-images.githubusercontent.com/65976572/101276009-5eab6600-37ed-11eb-8df8-292f7a89d227.png)


### 20. 주문을 클릭하면 장바구니에 상품이 담겨있다.
### 21. 장바구니에서 우측에 주문하기를 클릭하면 배송정보를 입력할 수 있다.
![pc_photo (26)](https://user-images.githubusercontent.com/65976572/101275988-581cee80-37ed-11eb-94cb-bbd7fca67577.png)
![pc_photo (28)](https://user-images.githubusercontent.com/65976572/101275991-58b58500-37ed-11eb-90a5-467df71df4f4.png)


### 22. 배송정보를 입력하고 주문을 클릭하면 영수증페이지가 나타나며, 정말 주문을 할 것인지 선택한다.
![pc_photo (29)](https://user-images.githubusercontent.com/65976572/101275992-594e1b80-37ed-11eb-8e17-bcceb9ca5dc1.png)


### 23. 주문완료를 클릭하면 주문이 성공하고, 주문한 상품의 재고수가 줄어들며, 주문하 내역은 마이페이지에서 확인할 수 있다.
![pc_photo (30)](https://user-images.githubusercontent.com/65976572/101275993-594e1b80-37ed-11eb-89fc-744a5219c61f.png)


### 24. Flea Market 에서는 각 이용자들이 게시글을 작성할 수 있다. (Shop과는 다른 점)
![pc_photo (4)](https://user-images.githubusercontent.com/65976572/101276007-5e12cf80-37ed-11eb-8669-0714b96c4119.png)

### 25. 상단에 상품 등록을 클릭하면 새로운 중고 상품을 등록할 수 있다. 중고 상품 또한 게시글과 마찬가지로 작성자만 삭제하거나 수정할 수 있다.
![pc_photo (36)](https://user-images.githubusercontent.com/65976572/101275999-5bb07580-37ed-11eb-900f-fa466b691ac6.png)

### 26. 중고 거래는 사이트에서 직접 주문을 관리하는 것이 아니라 이용자들 끼리의 자유로운 주문의 형식이다. 즉, 개인적인 주문이다.
![pc_photo (7)](https://user-images.githubusercontent.com/65976572/101276010-5f43fc80-37ed-11eb-9748-356807491b3e.png)

### 27. PC 환경 기준으로 우측 상단에 자신이 로그인한 아이디가 나타난다. 그 옆에는 로그아웃 버튼이 존재한다.
### 28. 자신의 아이디 버튼을 클릭하면 마이페이지로 이동된다.
### 29. 마이페이지에서는 자신의 정보를 수정할 수 있으며, 장바구니, 주문목록, 반려동물 관리 등을 할 수 있다.
![pc_photo (23)](https://user-images.githubusercontent.com/65976572/101275985-56ebc180-37ed-11eb-8352-baefef5522da.png)


### 30. 주문 목록을 확인하면 자신이 주문한 내역을 확인할 수 있으며, 배송정보, 상세정보도 확인이 가능하다.
![pc_photo (31)](https://user-images.githubusercontent.com/65976572/101275994-59e6b200-37ed-11eb-8dff-10ace9e86ce4.png)



### 31. 반려동물 목록에서는 자신이 등록한 반려동물의 목록을 확인할 수 있다. 삭제 및 추가가 가능하다.
![pc_photo (24)](https://user-images.githubusercontent.com/65976572/101275986-57845800-37ed-11eb-9a2f-5e8d58c30ebe.png)



## 관리자 이용방법

### 1. 관리자는 서버에서 권한을 부여한 상태이다. 따라서 관리자는 관리자만 할 수 있는 배송 관리 업무와 상품 등록을 수행할 수 있다.
### 2. 상품을 등록하기 위해서는 관리자로 로그인한 상태에서 좌측 상단에 Shop을 클릭한다.
### 3. 상단에 상품 등록을 클릭하면 상품 등록할 수 있는 페이지가 나오며 폼 형식에 따라 입력하고 상품을 등록한다.
![pc_photo (35)](https://user-images.githubusercontent.com/65976572/101275998-5b17df00-37ed-11eb-9f58-ee8d132ded55.png)

### 4. 등록한 상품을 관리하기 위해서는 각 상품의 상세정보를 클릭하여 수정 및 삭제를 할 수 있다. 재고가 없으면 주문하기 버튼이 비활성화 되어 있다.
![pc_photo (40)](https://user-images.githubusercontent.com/65976572/101276003-5ce1a280-37ed-11eb-9a66-4af13bd42b16.png)

### 5. 우측 상단에 관리자의 아이디를 클릭하면 마이페이지로 이동된다.
### 6. 주문 목록을 클릭하면 다른 이용자들이 주문한 목록의 전체가 나타나게 된다.
### 7. 배송정보를 수정할 수 있으며, 주문을 삭제하기 위해서는 처음 로그인할 때 사용한 관리자의 비밀번호를 입력해야 한다.
![pc_photo (34)](https://user-images.githubusercontent.com/65976572/101275997-5b17df00-37ed-11eb-8c93-7503cae00a6b.png)

