<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div id="content" class="full-screen">
	<ul class="admin-menu">
		<c:choose>
			<c:when test='${param.blogAdminMenu == "category" }'>
				<li><a href="${pageContext.request.contextPath}/${authuser.id}/admin">기본설정</a></li>
				<li class="selected"><a
					href="${pageContext.request.contextPath}/${authuser.id}/admin/category">카테고리</a></li>
				<li><a
					href="${pageContext.request.contextPath}/${authuser.id}/admin/write">글작성</a></li>
			</c:when>

			<c:when test='${param.blogAdminMenu == "write" }'>
				<li><a href="${pageContext.request.contextPath}/${authuser.id}/admin">기본설정</a></li>
				<li><a
					href="${pageContext.request.contextPath}/${authuser.id}/admin/category">카테고리</a></li>
				<li class="selected"><a
					href="${pageContext.request.contextPath}/${authuser.id}/admin/write">글작성</a></li>
			</c:when>

			<c:otherwise>
				<li class="selected"><a href="${pageContext.request.contextPath}/${authuser.id}/admin">기본설정</a></li>
				<li><a
					href="${pageContext.request.contextPath}/${authuser.id}/admin/category">카테고리</a></li>
				<li><a
					href="${pageContext.request.contextPath}/${authuser.id}/admin/write">글작성</a></li>
			</c:otherwise>
		</c:choose>
	</ul>