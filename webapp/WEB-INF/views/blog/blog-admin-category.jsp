<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<Link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/jblog.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.9.0.js"></script>

<script type="text/javascript">
	var render = function(vo, mode) {
		// 현업에 가면 이렇게안한다 -> template
		// ex) ejs, underscore, mustache
	
		var htmls = 
			"<tr>" + 
				"<td>" + vo.no + "</td>" + 
				"<td>" + vo.name + "</td>" +
				"<td>" + 0 + "</td>" +
				"<td>" + vo.description + "</td>" +
				"<td>" + "<img src='${pageContext.request.contextPath}/assets/images/deletes.jpg'>" + "</td>" + 
			"</tr>";
		/*var htmls =*/ 
		
		$("#admin-cat").append(htmls);	
		
	};
		$(function(){
			
			$.ajax({
				url: "/jblog/" + ${authuser.id} + "/admin/category",
				type: "POST",
				dataType: "json",
				data: "&name=" + name +
					  "&description=" + desc,
				
				success: function(response){
					console.log(response);
					render(response.data, true);
					
				},
				error: function(xhr, status, e) {
					console.error("error : " + e);
				}
			});
			
			$("#submit").click( function () {
				var name = $("#name").val();
				var desc = $("#desc").val();
				
				console.log("클릭");
				console.log(name);
				console.log(desc);
				
				$.ajax({
					url: "/jblog/" + ${authuser.id} + "/admin/category",
					type: "POST",
					dataType: "json",
					data: "&name=" + name +
						  "&description=" + desc,
					
					success: function(response){
						console.log(response);
						render(response.data, true);
						
					},
					error: function(xhr, status, e) {
						console.error("error : " + e);
					}
				})
			});
		});
	</script>
</head>
<body>
	<div id="container">
		<c:import url="/WEB-INF/views/includes/Blogheader.jsp" />

		<div id="wrapper">
			<c:import url="/WEB-INF/views/includes/BlogAdminheader.jsp">
				<c:param name="blogAdminMenu" value="category" />
			</c:import>
			<table id="admin-cat" class="admin-cat">
				<tr>
					<th>번호</th>
					<th>카테고리명</th>
					<th>포스트 수</th>
					<th>설명</th>
					<th>삭제</th>
				</tr>
				<c:forEach items="${categoryList }" var="vo" varStatus="status">
					<tr>
						<td>${vo.no }</td>
						<td>${vo.name }</td>
						<td>${vo.postCount }</td>
						<td>${vo.description }</td>
						<td><img
							src="${pageContext.request.contextPath}/assets/images/delete.jpg"></td>
					</tr>
				</c:forEach>

			</table>

			<h4 class="n-c">새로운 카테고리 추가</h4>
			<table id="admin-cat-add">
				<tr>
					<td class="t">카테고리명</td>
					<td><input id="name" type="text" name="name"></td>
				</tr>
				<tr>
					<td class="t">설명</td>
					<td><input id="desc" type="text" name="desc"></td>
				</tr>
				<tr>
					<td class="s">&nbsp;</td>
					<td><input id="submit" type="submit" value="카테고리 추가"></td>
				</tr>
			</table>
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