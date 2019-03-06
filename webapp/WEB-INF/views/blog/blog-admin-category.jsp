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
		
		var htmls = 
				"<tr>" + 
					"<td>" + vo.no + "</td>" + 
					"<td>" + vo.name + "</td>" +
					"<td>" + vo.postCount + "</td>" +
					"<td>" + vo.description + "</td>" +
					"<td>" +  
						  "<img src ='${pageContext.request.contextPath}/assets/images/delete.jpg' data-no='"+ vo.no + "'>" + 
					"</td>" + 
				"</tr>";
			
				$("#admin-cat").append(htmls);
		
	};
	
	var submitClick = function () {
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
				render(response.data, false);
				
			},
			error: function(xhr, status, e) {
				console.error("error : " + e);
			}
		})
	};
	
	var init = function () 
	{
		console.log("init 실행");
		$.ajax({
			url: "/jblog/" + ${authuser.id} + "/admin/category/ajax",
			type: "GET",
			dataType: "json",
			data: "",
			
			success: function(response){
				console.log(response);
				
				$.each( response.data, function(index, vo) {
					//console.log(vo);
					render(vo, false);
				});
				
			},
			error: function(xhr, status, e) {
				console.error("error : " + e);
			}
		});
	};
	
	var categoryDelete = function(event){
		
		console.log("clicked!!" + $(this).data("no"));
		
		$.ajax({
			url: "/jblog/" + ${authuser.id} + "/admin/category/delete/" + $(this).data("no"),
			type: "GET",
			dataType: "json",
			data: "",
			
			success: function(response){
				// 리턴값으로 카테고리번호를 받아와서 그것을 없애준다
				$("#admin-cat tr td img[data-no='" + response.data +"']").parent().parent().remove();
				
			},
			error: function(xhr, status, e) {
				console.error("error : " + e);
			}
		});
	};
	
	$(function(){
			
		init(); // 처음 실행되서 로그인한 유저의 카테고리 리스트를 뿌려준다
		$("#submit").click( submitClick); // 카테고리 추가
		$(document).on("click", "#admin-cat tr td img", categoryDelete); // 카테고리 제거
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