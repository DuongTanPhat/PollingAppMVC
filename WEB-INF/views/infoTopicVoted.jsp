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
	function showRate() {
		var input_1 = document.getElementById("formAddRate");
		if (input_1.getAttribute("style") == "display: none;") {
			input_1.setAttribute("style", "display: block;");
		} else {
			input_1.setAttribute("style", "display: none;");
		}
	}
</script>
<script>
	$(document).ready(function() {
		$('.card').popup({
			inline : true
		});
		$('.ui.rating').rating({
			maxRating : 5,
		}).rating('disable');
	});
</script>
</head>
<body>
	<jsp:include page="welcome.jsp"></jsp:include>
	</div>
	<div class="ui segment">
		<img class="ui medium bordered circular centered image"
			src=${topic.photo == null||topic.photo == ''?'"images/noimage.jpg"':topic.photo}>
		<h2 class="ui center aligned icon header">${topic.name}</h2>
		<h3>${topic.descriptions}</h3>
		<div class="ui two column grid">
			<div class="column">
				<div class="ui toggle checkbox">
					<input type="checkbox" name="public" onclick="return false;"
						${topic.isMany==true?'checked="checked"':''}> <label>Cho
						phép mọi người chọn nhiều câu trả lời</label>
				</div>
			</div>
			<div class="column">
				<div class="ui grid">
					<div class="ten wide column">
						<div class="ui toggle checkbox">
							<input type="checkbox" name="public1" onclick="return false;"
								${topic.isCreate==true?'checked="checked"':''}> <label>Cho
								phép mọi người thêm tùy chọn</label>
						</div>
					</div>
					<div class="six wide column">
						<div class="ui primary button" onclick="showRate()"
							style="float: right;">Đánh giá</div>
					</div>
				</div>
			</div>

		</div>
		<div class="ui fluid vertical menu">
			<c:choose>
				<c:when test="${user.email==topic.user.email||user.email=='admin@admin'}">
					<c:forEach var="u" items="${countSelect}">
						<c:choose>
							<c:when test="${u.voted == true}">
							<div class="right floated content">
								<a
									href="${pageContext.servletContext.contextPath}/delete/${topic.id}/${u.select.id}.htm"><button
										class="ui compact icon button"
										style="float: right; width: 5%;">
										<i class="trash icon"></i>
									</button></a></div>
								<a class="item" style="width: 95%;"
									href="${pageContext.servletContext.contextPath}/select/${topic.id}/${u.select.id}.htm">${u.select.name}<div
										class="ui teal left pointing label">${u.countVote}</div>

								</a>
							</c:when>
							<c:when test="${u.voted == false }">
								<a
									href="${pageContext.servletContext.contextPath}/delete/${topic.id}/${u.select.id}.htm"><button
										class="ui compact icon button"
										style="float: right; width: 5%;">
										<i class="trash icon"></i>
									</button></a>
								<a class="item" style="width: 95%;"
									href="${pageContext.servletContext.contextPath}/select/${topic.id}/${u.select.id}.htm">${u.select.name}
									<div class="ui label">${u.countVote}</div>

								</a>

							</c:when>
						</c:choose>

					</c:forEach>
				</c:when>
				<c:when test="${user.email!=topic.user.email}">
					<c:forEach var="u" items="${countSelect}">
						<c:choose>
							<c:when test="${u.voted == true}">
								<a class="item" style="width: 100%;"
									href="${pageContext.servletContext.contextPath}/select/${topic.id}/${u.select.id}.htm">${u.select.name}<div
										class="ui teal left pointing label">${u.countVote}</div>

								</a>
							</c:when>
							<c:when test="${u.voted == false }">
								<a class="item" style="width: 100%;"
									href="${pageContext.servletContext.contextPath}/select/${topic.id}/${u.select.id}.htm">${u.select.name}
									<div class="ui label">${u.countVote}</div>

								</a>

							</c:when>
						</c:choose>

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
	<div class="ui segment" id="formAddRate" style="display: none;">
		<jsp:include page="rate.jsp"></jsp:include>
	</div>
	<div class="ui segment">
		<div class="ui middle aligned animated list">
			<c:forEach var="i" items="${listEvaluate}">
				<hr>
				<div class="item">
					<img class="ui bordered avatar image"
						src=${i.user.photo == null||i.user.photo == ''?'"images/noimage.jpg"':i.user.photo}>
					<div class="content">
						<c:if test="${i.user.email==user.email||user.email=='admin@admin'}">
							<a href="delete/evaluate/${i.id}.htm"><button
									class="ui compact icon button"
									style="position: absolute; right: 5%;">
									<i class="trash icon"></i>
								</button></a>
						</c:if>
						<a class="header">${i.user.fullname}</a>
						<div class="ui star rating" data-rating="${i.rate}"></div>
						<div class="description">${i.descriptions}</div>

					</div>
				</div>
			</c:forEach>

		</div>
	</div>
</body>
</html>