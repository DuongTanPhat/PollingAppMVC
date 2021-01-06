<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>Admin Dashboard</title>
<link href="images/favicon1.png" rel="icon">
<link rel="stylesheet" type="text/css"
	href="dist/components/semantic.css">

<link rel="stylesheet" href="css/style.css" />
</head>

<body>
	<div class="ui sidebar inverted vertical menu sidebar-menu"
		id="sidebar">
		<div class="item">
			<div class="header">General</div>
			<div class="menu">
				<a class="active item" href="admin.htm">
					<div>
						<i class="icon tachometer alternate"></i> Dashboard
					</div>
				</a>
			</div>
		</div>
		<div class="item">
			<div class="header">User</div>
			<div class="menu">
				<a class="item" href="signup.htm">
					<div>
						<i class="cogs icon"></i>Thêm
					</div>
				</a> <a class="item" href="usermanager.htm">
					<div>
						<i class="users icon"></i>Quản lí
					</div>
				</a>
			</div>
		</div>
		<div class="item">
			<div class="header">Post</div>
			<div class="menu">
				<a class="item" href="topic/insert.htm">
					<div>
						<i class="cogs icon"></i>Thêm
					</div>
				</a> <a class="item" href="topicmanager.htm">
					<div>
						<i class="users icon"></i>Quản lí
					</div>
				</a>
			</div>
		</div>
		<div class="item">
			<div class="header">Tag</div>
			<div class="menu">
				<a class="item" href="adminInsertTag.htm">
					<div>
						<i class="cogs icon"></i>Thêm
					</div>
				</a> <a class="item" href="tagmanager.htm">
					<div>
						<i class="users icon"></i>Quản lí
					</div>
				</a>
			</div>
		</div>
		<a class="item">
			<div>
				<i class="icon lightbulb"></i> Apps
			</div>
		</a>
		<div class="item">
			<div class="header">Other</div>
			<div class="menu">
				<a href="#" class="item">
					<div>
						<i class="icon envelope"></i> Messages
					</div>
				</a> <a href="#" class="item">
					<div>
						<i class="icon calendar alternate"></i> Calendar
					</div>
				</a>
			</div>
		</div>

		<div class="item">
			<form action="#">
				<div class="ui mini action input">
					<input type="text" placeholder="Search..." />
					<button class="ui mini icon button">
						<i class=" search icon"></i>
					</button>
				</div>
			</form>
		</div>
	</div>

	<!-- sidebar -->
	<!-- top nav -->
<form action="<c:url value="/j_spring_security_logout.htm" />"
						method="post">
	<nav class="ui top fixed inverted menu">
		<div class="left menu">
			<a href="#" class="sidebar-menu-toggler item" data-target="#sidebar">
				<i class="sidebar icon"></i>
			</a> <a href="welcome.htm" class="header item"> Polling App </a>
		</div>

		<div class="right menu">
			<a href="#" class="item"> <i class="bell icon"></i>
			</a>
			<div class="ui dropdown item">
				<i class="user cirlce icon"></i>
				<div class="menu">
					<a href="user/info.htm" class="item"> <i
						class="info circle icon"></i> Profile
					</a> <a href="#" class="item"> <i class="wrench icon"></i> Settings
					</a>
					
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
					
					<button type="submit" class="item"><i class="sign-out icon"></i>
						Logout
					</button>
				</div>
			</div>
		</div>
	</nav>
	</form>
	<!-- top nav -->

	<div class="pusher">
		<div class="main-content">
			<div class="ui grid stackable padded">
				<div
					class="four wide computer eight wide tablet sixteen wide mobile column">
					<div class="ui fluid card">
						<div class="content">
							<div class="ui right floated header red">
								<i class="user icon"></i>
							</div>
							<div class="header">
								<div class="ui red header">
									<div class="count-box">
										<span data-toggle="counter-up">${soUser}</span>
									</div>
								</div>
							</div>
							<div class="meta">User</div>
							<div class="description">Tổng số người đăng kí</div>
						</div>
						<div class="extra content">
							<a href="usermanager.htm"><div class="ui two buttons">
									<button class="ui red button">More Info</button>
								</div></a>
						</div>
					</div>
				</div>
				<div
					class="four wide computer eight wide tablet sixteen wide mobile column">
					<div class="ui fluid card">
						<div class="content">
							<div class="ui right floated header green">
								<i class="file alternate icon"></i>
							</div>
							<div class="header">
								<div class="ui header green">
									<div class="count-box">
										<span data-toggle="counter-up">${soTopics}</span>
									</div>
								</div>
							</div>
							<div class="meta">Post</div>
							<div class="description">Tổng số bài đăng</div>
						</div>
						<div class="extra content">
							<a href="topicmanager.htm"><div class="ui two buttons">
									<button class="ui green button">More Info</button>
								</div></a>
						</div>
					</div>
				</div>
				<div
					class="four wide computer eight wide tablet sixteen wide mobile column">
					<div class="ui fluid card">
						<div class="content">
							<div class="ui right floated header teal">
								<i class="check square icon"></i>
							</div>
							<div class="header">
								<div class="ui teal header">
									<div class="count-box">
										<span data-toggle="counter-up">${soVote}</span>
									</div>
								</div>
							</div>
							<div class="meta">Voted</div>
							<div class="description">Tổng số lượt bình chọn</div>
						</div>
						<div class="extra content">
							<div class="ui two buttons">
								<div class="ui teal button">More Info</div>
							</div>
						</div>
					</div>
				</div>
				<div
					class="four wide computer eight wide tablet sixteen wide mobile column">
					<div class="ui fluid card">
						<div class="content">
							<div class="ui right floated header purple">
								<i class="star icon"></i>
							</div>
							<div class="header">
								<div class="ui purple header">
									<div class="count-box">
										<span data-toggle="counter-up">${soRate}</span>
									</div>
								</div>
							</div>
							<div class="meta">Rate</div>
							<div class="description">Tổng số lượt đánh giá</div>
						</div>
						<div class="extra content">
							<div class="ui two buttons">
								<div class="ui purple button">More Info</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="ui grid stackable padded">
				<div class="column">
					<table class="ui celled striped table">
						<thead>
							<tr>
								<th colspan="4">Các bầu chọn gần đây</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="u" items="${listVote}">
								<tr>
									<td><img class="ui avatar image"
										src=${u.user.photo == null||u.user.photo == ''?'"images/noimage.jpg"':u.user.photo}>
										<a class="content" style="color: black;">
											${u.user.fullname} </a></td>
									<td>${u.user.email}</td>
									<td>${u.selection.topic.name}</td>
									<td class="right aligned collapsing">${u.selection.name}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="ui grid stackable padded">
				<div
					class="four wide computer eight wide tablet sixteen wide mobile  center aligned column">
					<div class="ui teal statistic">
						<div class="value">
							<div class="count-box">
								<span data-toggle="counter-up">${soSao}</span>
							</div>
						</div>
						<div class="label">Tổng Số Sao</div>
					</div>
				</div>
				<div
					class="four wide computer eight wide tablet sixteen wide mobile  center aligned column">
					<div class="ui purple statistic">
						<div class="value">
							<div class="count-box">
								<span data-toggle="counter-up">${soLuaChon}</span>
							</div>
						</div>
						<div class="label">Tổng Số Lựa Chọn</div>
					</div>
				</div>
				<div
					class="four wide computer eight wide tablet sixteen wide mobile  center aligned column">
					<div class="ui green statistic">
						<div class="value">
							<div class="count-box">
								<span data-toggle="counter-up">${soTag}</span>
							</div>
						</div>
						<div class="label">Tổng Số Tag</div>
					</div>
				</div>
				<div
					class="four wide computer eight wide tablet sixteen wide mobile  center aligned column">
					<div class="ui purple statistic">
						<div class="value">
							<div class="count-box">
								<span data-toggle="counter-up">359</span>
							</div>
						</div>
						<div class="label">Cups of Coffee</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="assets/library/jquery.min.js"></script>
	<script src="dist/components/semantic.js"></script>
	<script src="./js/script.js"></script>
	<!--  <script src="assets/vendor/jquery/jquery.min.js"></script> -->
	<script src="assets/vendor/waypoints/jquery.waypoints.min.js"></script>
	<script src="assets/vendor/counterup/counterup.min.js"></script>
	<script src="assets/vendor/venobox/venobox.min.js"></script>
	<script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	<script src="assets/vendor/aos/aos.js"></script>
	<script src="assets/js/main.js"></script>
</body>
</html>

