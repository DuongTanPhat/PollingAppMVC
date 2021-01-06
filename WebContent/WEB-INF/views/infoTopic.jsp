<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<base href="${pageContext.servletContext.contextPath}/">
<link href="images/favicon1.png" rel="icon">
<meta charset="utf-8">
<script src="assets/library/jquery.min.js"></script>
<script src="dist/components/semantic.js"></script>
<link rel="stylesheet" href="dist/components/semantic.css">

<title>Bình chọn</title>
<script type="text/javascript">
	function show() {
		var input_1 = document.getElementById("new");
		input_1.setAttribute("type", "text");
		var plus = document.getElementById("plus");
		plus.setAttribute("style", "display: none;");
		var fake = document.getElementById("fake");
		var plusFake = document.createElement("button");
		plusFake.setAttribute("class", "ui button");
		plusFake.innerHTML = "<i class=\"plus icon\"></i>";
		fake.appendChild(plusFake);
	}
</script>
</head>
<body>
	<jsp:include page="welcome.jsp"></jsp:include>
	<div class="ui segment">
		<p>
			<img class="ui medium bordered circular centered image"
				src=${topic.photo == null||topic.photo == ''?'"images/noimage.jpg"':topic.photo}>
		<h2 class="ui center aligned icon header">${topic.name}</h2>
		<h3>${topic.descriptions}</h3>
		<div class="ui two column grid">
			<div class="column">
				<div class="ui read-only toggle checkbox">
					<input type="checkbox" name="public" onclick="return false;"
						${topic.isMany==true?'checked="checked"':''}> <label>Cho
						phép mọi người chọn nhiều câu trả lời</label>
				</div>
			</div>
			<div class="column">
				<div class="ui read-only toggle checkbox">
					<input type="checkbox" name="public1" onclick="return false;"
						${topic.isCreate==true?'checked="checked"':''}> <label>Cho
						phép mọi người thêm tùy chọn</label>
				</div>
			</div>
		</div>
		<div class="ui fluid vertical menu">
			<c:choose>
				<c:when test="${user.email==topic.user.email||user.email=='admin@admin'}">
					<c:forEach var="u" items="${topic.selection}">
						<a
							href="${pageContext.servletContext.contextPath}/delete/${topic.id}/${u.id}.htm"><button
								class="ui compact icon button" style="float: right; width: 5%;">
								<i class="trash icon"></i>
							</button></a>
						<a class="item" style="width: 95%;"
							href="${pageContext.servletContext.contextPath}/select/${topic.id}/${u.id}.htm">${u.name}</a>
					</c:forEach>
				</c:when>
				<c:when test="${user.email!=topic.user.email}">
					<c:forEach var="k" items="${topic.selection}">
						<a class="item"
							href="${pageContext.servletContext.contextPath}/select/${topic.id}/${k.id}.htm">${k.name}</a>
					</c:forEach>
				</c:when>
			</c:choose>

			<c:choose>
				<c:when test="${user.email==topic.user.email||topic.isCreate==true||user.email=='admin@admin'}">
					<form:form action="vote/${topic.id}.htm?insertSelect"
						class="ui form" modelAttribute="select" method="post">
						<form:input path="name" type="hidden" id="new" />
						<div class="ui button" onclick="show()" id="plus">
							<i class="plus icon"></i>
						</div>
						<div id="fake"></div>
					</form:form>
				</c:when>
			</c:choose>
		</div>
	</div>
</body>
</html>