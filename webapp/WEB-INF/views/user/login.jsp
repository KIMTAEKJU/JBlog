<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<Link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/jblog.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.9.0.js"></script>
</head>
<body>
	<c:import url="/WEB-INF/views/includes/Mainheader.jsp" />
	<form:form modelAttribute="userVo" class="login-form" method="post"
		action="${pageContext.request.contextPath}/user/auth">
		<label>아이디</label>
		<form:input path="id" />
		<form:errors path="id" />

		<label>패스워드</label>
		<form:input path="password" type="password" />
		<form:errors path="password" />

		<c:set var="fail" value="fail"></c:set>
		<c:if test='${fail == param.result}'>
			<p>로그인이 실패 했습니다.</p>
		</c:if>

		<input type="submit" value="로그인">
	</form:form>
	</div>
</body>
</html>
