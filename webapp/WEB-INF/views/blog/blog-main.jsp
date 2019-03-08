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
</head>
<body>
	<div id="container">
		<c:import url="/WEB-INF/views/includes/Blogheader.jsp" />
		<div id="wrapper">
			<div id="content">
				<div class="blog-content">
					
						<h4>${mainPost.title }</h4> <!-- 포스트 제목 내용 보여줌 -->
						<p>
							${mainPost.contents }
						</p>
					
					
				</div>
				<ul class="blog-list">
					<c:forEach items="${postList }" var="vo"> <!-- 포스트 리스트 -->
						
						<li>
							<c:choose>
								<c:when test="${vo.title == mainPost.title }">
									<a href="${pageContext.request.contextPath}/${visitant.id}/${vo.categoryNo}/${vo.no}" style="color:red">${vo.title }</a> 
									<span  style="color: red">${vo.regDate }</span>
								</c:when>
								
								<c:otherwise>
									<a href="${pageContext.request.contextPath}/${visitant.id}/${vo.categoryNo}/${vo.no}">${vo.title }</a> 
									<span>${vo.regDate }</span>
								</c:otherwise>
							</c:choose>
						</li>
						
					</c:forEach>

				</ul>
			</div>
		</div>

		<div id="extra">
			<div class="blog-logo">
				<img src="${pageContext.request.contextPath}${blogVo.logo}">
			</div>
		</div>

		<div id="navigation">
			<h2>카테고리</h2> <!-- 카테고리 리스트 -->
			<ul>
				<li>
					<a href="${pageContext.request.contextPath}/${visitant.id}/${allPostLook.no}">${allPostLook.name }</a>
					<span>(${allPostLook.postCount})</span>
				</li>
				
				<c:forEach items="${categoryNameList }" var="vo" varStatus="status">
				
					<c:if test="${status.index > 0 }">
					
						<li>
							<a href="${pageContext.request.contextPath}/${visitant.id}/${vo.no}">${vo.name }</a>
						
							<c:forEach items="${postCountList}" var="vo" varStatus="postStatus">
							
									<span>
										<c:if test="${status.index == postStatus.index }">
											(${vo.postCount })
										</c:if>
									</span>
									
							</c:forEach>
						</li>
						
					</c:if>
					
				</c:forEach>
			</ul>
		</div>

		<div id="footer">
			<p>
				<strong>Spring 이야기</strong> is powered by JBlog (c)2016
			</p>
		</div>
	</div>
</body>
</html>