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
</head>

<body>
	<div id="container">

		<c:import url="/WEB-INF/views/includes/Blogheader.jsp" />


		<div id="wrapper">
			<c:import url="/WEB-INF/views/includes/BlogAdminheader.jsp">
				<c:param name="blogAdminMenu" value="default" />
			</c:import>
			<form:form modelAttribute="blogVo"
				action="${pageContext.request.contextPath}/${authuser.id }/admin" method="post"
				enctype="multipart/form-data">
				<input type="hidden" name="contents" value="null" />
				<input type="hidden" name="postTitle" value="null" />
				
				<table class="admin-config">
					<tr>
						<td class="t">블로그 제목</td>
						<td>
							<form:input path="title" size="40" value="${blogVo.title }"/> 
							<form:errors path="title"/>
						</td>
					</tr>
					<tr>
						<td class="t">로고이미지</td>
						<td><img
							src="${pageContext.request.contextPath}${blogVo.logo }"></td>
					</tr>
					<tr>
						<td class="t">&nbsp;</td>
						<td><input type="file" id="logo-file" name="logo-file" value="${pageContext.request.contextPath}${blogVo.logo }"></td>
					</tr>
					<tr>
						<td class="t">&nbsp;</td>
						<td class="s"><input type="submit" value="기본설정 변경"></td>
					</tr>
				</table>
			</form:form>
		</div>
	</div>
	<div id="footer">
		<p>
			<strong>Spring 이야기</strong> is powered by JBlog (c)2016
		</p>
	</div>
	</div>
</body>
</html>