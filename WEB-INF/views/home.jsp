<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link href="images/favicon1.png" rel="icon">
<script src="assets/library/jquery.min.js"></script>
<script src="dist/components/semantic.js"></script>
<link href="assets/vendor/aos/aos.css" rel="stylesheet">
</head>
<link rel="stylesheet" type="text/css"
	href="dist/components/semantic.css">
<meta charset="utf-8">
<title>Home</title>
<style>
div.test {
	white-space: nowrap;
	width: 100%;
	overflow: hidden;
	text-overflow: ellipsis;
}

div.test:hover {
	overflow: visible;
}
</style>
<script>
	$(document).ready(function() {
		$('.card').popup({
			inline : true
		});
		$('.ui.rating').rating({
			maxRating : 5
		}).rating('disable');
	});
</script>

</head>
<body>
	<jsp:include page="welcome.jsp"></jsp:include>
	<div class="ui segment">
		<p>
		<div class="ui stackable four column grid">
			<c:forEach var="u" items="${topics}">
				<div class="four wide column">
					<div data-aos="zoom-in" data-aos-delay="200">
						<div class="ui link card">

							<a class="image" href="vote/${u.topic.id}.htm"> <c:choose>
									<c:when test="${u.ex<0}">
										<div class="ui black ribbon label">
											<i class="stopwatch icon"></i> Đã đóng
										</div>
									</c:when>
									<c:when test="${u.ex==null}">
										<div class="ui orange ribbon label">
											<i class="stopwatch icon"></i> Còn vĩnh viễn
										</div>
									</c:when>
									<c:when test="${u.ex>=0}">
										<div class="ui red ribbon label">
											<i class="stopwatch icon"></i> Còn ${u.ex} ngày
										</div>
									</c:when>
								</c:choose> <img style="height: 300px;"
								src=${u.topic.photo == null||u.topic.photo == ''?'"images/noimage.jpg"':u.topic.photo}>
							</a>
							<div class="content">

								<a class="header" href="vote/${u.topic.id}.htm"><div
										class="test">${u.topic.name}</div></a> <a class="description"
									href="vote/${u.topic.id}.htm"><div class="test">${u.topic.descriptions}</div></a>
							</div>
							<div class="extra content">
								<div class="right floated author">
									<img class="ui avatar circular bordered image"
										class="ui medium circular image"
										src=${u.topic.user.photo == null?'"images/noimage.jpg"':u.topic.user.photo}>
									${u.topic.user.fullname}
								</div>
							</div>
							<div class="ui two bottom attached buttons">
								<div class="ui labeled button" tabindex="0">
									<div class="ui red button">
										<i class="heart icon"></i> Voted
									</div>

									<a class="ui basic red left pointing label"><div
											class="count-box">
											<span data-toggle="counter-up">${u.countVote}</span>
										</div> </a>

								</div>
								<a class="ui primary button" href="vote/${u.topic.id}.htm">
									<i class="play icon"></i> Play
								</a>
							</div>
							<!-- 	</div> -->
						</div>
						<div class="ui popup">
							<div class="header">User Rating</div>
							<div class="ui star rating" data-rating="${u.rate}"></div>
						</div>
					</div>
				</div>
			</c:forEach>

		</div>
		<div class="ui pagination right floated menu">
			<c:if test="${page==1}">
				<a class="disabled item"> <i class="angle left icon"></i>
				</a>
			</c:if>
			<c:if test="${page!=1}">
				<a class="item" href="welcome.htm?page=${page-1}"> <i
					class="angle left icon"></i>
				</a>
			</c:if>
			<c:if test="${page==maxpage}">
				<a class="disabled item"> <i class="angle right icon"></i>
				</a>
			</c:if>
			<c:if test="${page!=maxpage}">
				<a class="item" href="welcome.htm?page=${page+1}"> <i
					class="angle right icon"></i>
				</a>
			</c:if>

		</div>
		</p>

	</div>

	<div id="preloader"></div>
	<!--  <script src="assets/vendor/jquery/jquery.min.js"></script> -->
	<script src="assets/vendor/waypoints/jquery.waypoints.min.js"></script>
	<script src="assets/vendor/counterup/counterup.min.js"></script>
	<script src="assets/vendor/venobox/venobox.min.js"></script>
	<script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	<script src="assets/vendor/aos/aos.js"></script>
	<script src="assets/js/main.js"></script>
</body>
</html>