<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="center-content">
	<h1 class="logo">JBlog</h1>
	<ul class="menu">
		<li><a href="${pageContext.request.contextPath}">메인화면</a></li>
		<c:choose>
			<c:when test="${authuser != null }">
				<li><a href="${pageContext.request.contextPath}/user/logout">로그아웃</a></li>
				<li><a href="${pageContext.request.contextPath}/${authuser.id}">내블로그</a></li>
			</c:when>

			<c:otherwise>
				<li><a href="${pageContext.request.contextPath}/user/login">로그인</a></li>
				<li><a href="${pageContext.request.contextPath}/user/join">회원가입</a></li>
			</c:otherwise>
		</c:choose>
	</ul>