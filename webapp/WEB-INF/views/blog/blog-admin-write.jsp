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
				<c:param name="blogAdminMenu" value="write" />
			</c:import>
			<form:form modelAttribute="blogVo" method="post" 
			action="${pageContext.request.contextPath}/${authuser.id }/admin/write">
				<table class="admin-cat-write">
				<input type="hidden" name="title" value="null"/>
					<tr>
						<td class="t">제목</td>
						<td>
							<form:input  path="postTitle" size="60"/> 
							<form:errors path="postTitle"/>
						
							<select name="category">
									<option value="미분류">미분류</option>
									<option value="자바">자바</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="t">내용</td>
						<td>
							<form:textarea path="contents" id="content"/>
							<form:errors path="contents"/>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td class="s"><input type="submit" value="포스트하기"></td>
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