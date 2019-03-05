<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!-- 메세지 form 태그 spring message보다 편함 -->
​​

<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<Link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/jblog.css">
</head>
<script type="text/javascript"
	src="${pageContext.servletContext.contextPath }/assets/js/jquery/jquery-1.9.0.js"></script>

<script type="text/javascript">
	$(function() {
		$("#join-form").submit(function() {

			// 1. 이름 체크
			if ($("#name").val() == "") {
				alert("이름은 필수 입력 항목입니다");
				$("#name").focus();
				return false;
			}

			// 2-1. 아이디가 비어있는지 확인
			if ($("#blog-id").val() == "") {
				alert("아이디는 필수 입력 항목입니다");
				$("#blog-id").focus();
				return false;
			}

			// 2-2. 아이디 중복체크 유무
			if (!$("#img-checkid").is(":visible")) {
				alert("아이디 중복 체크를 해야 합니다.");
				return false;
			}

			// 3. 비밀번호 확인
			if ($("password").val() == "") {
				alert("비밀번호는 필수 입력 항목입니다");
				$("password").focus();
				return false;
			}

			// 4. 약관동의
			if (!$("#agree-prov").is(":checked")) {
				alert("약관 동의를 해야 합니다.");
				return false;
			}

			return true;
		});

		$("#blog-id").change(function() {
			$("#btn-checkid").show();
			$("#img-checkid").hide();
		});

		$("#btn-checkid")
				.click(
						function() {
							var id = $("#blog-id").val();

							if (id == "") {
								return;
							}

							$
									.ajax({
										url : "${pageContext.servletContext.contextPath }/user/idcheck?id="
												+ id,
										type : "GET",
										datatype : "json",
										data : "",

										success : function(response) {
											console.log(response);

											if (response.result == "fail") {
												console.error(response.message);
												return;
											}
											if (response.data != null) {
												alert("이미 존재하는 아이디입니다. 다른 아이디를 사용해주세요");
												$("#blog-id").val("").focus();

												return;
											}

											// 사용가능한 이메일
											$("#btn-checkid").hide();
											$("#img-checkid").show();
										}
									})
						});
	});
</script>
<body>

	<c:import url="/WEB-INF/views/includes/Mainheader.jsp" />
	<form:form modelAttribute="userVo" class="join-form" id="join-form"
		method="post" action="${pageContext.request.contextPath}/user/join">

		<label class="block-label" for="name">이름</label>
		<form:input path="name" />
		<form:errors path="name" />

		<label class="block-label" for="blog-id">아이디</label>
		<form:input path="id" id="blog-id" />
		<form:errors path="id" />

		<input id="btn-checkid" type="button" value="id 중복체크" />

		<img id="img-checkid" style="display: none;"
			src="${pageContext.request.contextPath}/assets/images/check.png">

		<label class="block-label" for="password">패스워드</label>
		<form:input path="password" type="password" />
		<form:errors path="password" />

		<fieldset>
			<legend>약관동의</legend>
			<input id="agree-prov" type="checkbox" name="agreeProv" value="y">
			<label class="l-float">서비스 약관에 동의합니다.</label>
		</fieldset>

		<input type="submit" value="가입하기">

	</form:form>
	</div>
</body>
</html>
