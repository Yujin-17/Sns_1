<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="box1 d-flex justify-content-between mt-3">
	<h2>
		<b>회원 가입</b>
	</h2>
</div>
<div class="box2">
	<form id="signUpForm" method="post" action="/user/sign_up">
		<div class="mr-4 pt-4 pl-4 form-group">
			<label class="col-1">ID</label>
			<div class="d-flex col-8">
				<input type="text" id="loginId" name="loginId"
					class="form-control input-lg" placeholder="ID를 입력해주세요">
				<button type="button" id="loginIdCheckBtn" class="btn btn-info ml-3 btn-sm">중복확인</button>
			</div>
			
			<%-- 아이디 체크 결과 --%>
			<div id="idCheckLength" class="ml-3 mt-1 small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
			<div id="idCheckDuplicated" class="ml-3 mt-1 small text-danger d-none">이미 사용중인 ID입니다.</div>
			<div id="idCheckOk" class="ml-3 mt-1 small text-success d-none">사용 가능한 ID입니다.</div>
					
		</div>
		<div class="mr-4 pl-4 form-group">
			<label class="col-1">password</label>
			<div class="d-flex col-5">
				<input type="password" id="password" name="password" class="form-control" placeholder="">
			</div>
		</div>
		<div class="mr-4 pl-4 pb-1 form-group">
			<label class="col-10">confirm password</label>
			<div class="col-5">
				<input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="">
			</div>
		</div>
		<div class="mr-4 pl-4 pb-1 form-group">
			<label class="col-3">이름</label>
			<div class="col-6">
				<input type="text" id="name" name="name" class="form-control" placeholder="이름을 입력해주세요">
			</div>
		</div>
		<div class="mr-4 pl-4 pb-1 form-group">
			<label class="col-3">이메일</label>
			<div class="d-flex col-6">
				<input type="text" id="email" name="email" class="form-control" placeholder="이메일을 입력해주세요">
			</div>
		</div>
		<button type="button" id="signUpBtn" class="btn btn-success float-right mr-4">가입하기</button>



	</form>
</div>


<script>

$(document).ready(function(){
	// 아이디 중복확인
	$('#loginIdCheckBtn').on('click', function(){
		// alert("중복 확인");
		let loginId = $('#loginId').val().trim();
		
		// 경고 문구 초기화
		$('#idCheckLength').addClass('d-none');
		$('#idCheckDuplicated').addClass('d-none');
		$('#idCheckOk').addClass('d-none');
		
		if(loginId.length < 4){
			$('#idCheckLength').removeClass('d-none');
			return;
		}
		
		$.ajax({
			url: "/user/is_duplicated_id"
			, data: {"loginId":loginId}
			, success: function(data){
				if (data.result == true){ // 중복인 경우
					$('#idCheckDuplicated').removeClass('d-none');
				}else { // 사용 가능
					$('#idCheckOk').removeClass('d-none');
				}
			}
			, error: function(e){
				alert("아이디 중복확인에 실패했습니다. 관리자에게 문의해주세요.");
			}
		});
	});
	
	// 회원가입
	$('#signUpBtn').on('click', function(){
		// alert("클릭");
		
		let loginId = $('#loginId').val().trim();
		if(loginId == ""){
			alert("아이디를 입력해주세요.");
			return;
		};
		
		let password = $('#password').val();
		let confirmPassword = $('#confirmPassword').val();
		if(password == "" || confirmPassword == ""){
			alert("비밀번호를 입력해주세요.");
			return;
		};
		if(password != confirmPassword){
			alert("비밀번호가 일치하지 않습니다. 다시 입력하세요.");
			// 텍스트 박스 값 초기화.
			$('#password').val('');
			$('#confirmPassword').val('');
			return;
		};
		
		let name = $('#name').val().trim();
		if(name == ""){
			alert("이름을 입력해주세요.");
			return;
		};
		
		let email = $('#email').val().trim();
		if(email == ""){
			alert("이메일 주소를 입력해주세요.");
			return;
		};
		
		// 아이디 중복확인이 완료 되었는지 확인
		// -- idCheckOk <div> 클래스에 d-none이 없으면 사용 가능
		// d-none이 존재할 시 alert
		if($('#idCheckOk').hasClass('d-none')){
			alert("아이디 중복확인을 다시 해주세요.");
			return;
		}
		
		// 회원가입 서버요청
		// ajax 방식
		let url = $('#signUpForm').attr('action'); // form에 있는 action 주소 가져오기
		let params = $('#signUpForm').serialize(); // 폼태그에 있는 값 한번에 보내기
		console.log(params);
		
		$.post(url, params)
		.done(function(data){
			if(data.result == "success"){
				alert("가입을 환영합니다! 로그인을 해주세요.");
				location.href = "/user/sign_in_view"
			} else{
				alert("가입에 실패했습니다. 다시 시도해주세요.");
			}
		});
	
		
		
	});
	
	
	
});


</script>