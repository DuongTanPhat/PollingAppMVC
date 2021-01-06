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
				<a class="item" href="admin.htm">
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
				</a> <a class="active item" href="usermanager.htm">
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
					<a href="user/info.htm" class="item"> <i class="info circle icon"></i>
						Profile
					</a> <a href="#" class="item"> <i class="wrench icon"></i> Settings
					</a> <a href="logoff.htm" class="item"> <i class="sign-out icon"></i> Logout
					</a>
				</div>
			</div>
		</div>
	</nav>

	<!-- top nav -->
	<div class="pusher">
		<div class="main-content">
			<div class="ui grid stackable padded">
				<div class="column">
					<table class="ui celled striped table">
						<thead>
							<tr>
								<th colspan="4">Danh sách thành viên</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="u" items="${listUserA}">
								<tr>
									<td><img class="ui avatar image"
										src=${u.photo == null||u.photo == ''?'"images/noimage.jpg"':u.photo}>
										<a class="content"
										style="color: black;"> ${u.fullname} </a></td>
									<td>${u.email}</td>
									<td class="right aligned collapsing"><a
										href="admin/edit/${u.email}.htm"><button
												class="ui green button">Sửa</button></a> </td>
												<td class="right aligned collapsing"><c:if test="${u.ban==false}"><a
										href="admin/ban/${u.email}.htm"><button
												class="ui red button">Ban</button></a></c:if>
												<c:if test="${u.ban==true}"><a
										href="admin/unban/${u.email}.htm"><button
												class="ui red button">UnBan</button></a></c:if>
												</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
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

