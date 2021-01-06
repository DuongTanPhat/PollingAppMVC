<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="${pageContext.servletContext.contextPath}/">
<link href="images/favicon1.png" rel="icon">
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>Admin Dashboard</title>
<script src="assets/library/jquery.min.js"></script>
<script
	src="${pageContext.servletContext.contextPath}/dist/components/semantic.js"></script>
<link rel="stylesheet" type="text/css"
	href="dist/components/semantic.css">

<link rel="stylesheet" href="css/style.css" />
<script>
	$(document).ready(function() {
		$('.ui.form').form({
			fields : {
				fullname : {
					identifier : 'fullname',
					rules : [ {
						type : 'empty',
						prompt : 'Please enter your name'
					} ]
				},
				phone : {
					identifier : 'phone',
					rules : [ {
						type : 'number',
						prompt : 'Please enter your phone'
					} ]
				}
			}
		});
	});
</script>
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
					<form class="ui large form" action="admin/edit/${userEdit.email}.htm?${_csrf.parameterName}=${_csrf.token}"
						method="post" enctype="multipart/form-data" id="formid">
						<div class="ui stacked segment">
							<div class="field" id="fieldemail">
								<div class="ui left icon input">
									<i class="envelope icon"></i>
									<form:input path="userEdit.email" type="text" name="email"
										placeholder="E-mail address" disabled="true" />
								</div>

							</div>
							<div class="field">
								<div class="ui left icon input">
									<i class="id card icon"></i>
									<form:input path="userEdit.fullname" type="text"
										name="fullname" placeholder="Name" />

								</div>
							</div>
							<div class="field">
								<form:select path="userEdit.gender"
									class="ui selection dropdown">
									<form:option value="true">Male</form:option>
									<form:option value="false">Female</form:option>
								</form:select>

							</div>
							<div class="field">
								<div class="ui left icon input">
									<i class="calendar alternate icon"></i>
									<form:input path="userEdit.birthday" type="date"
										name="birthday" placeholder="Birthday" />

								</div>
							</div>
							<div class="field">
								<div class="ui left icon input">
									<i class="phone icon"></i>
									<form:input path="userEdit.phone" type="text" name="phone"
										placeholder="Phone Number" />
								</div>
							</div>
							<img class="ui medium bordered right spaced image"
								src=${userEdit.photo == null||userEdit.photo == ''?'"images/noimage.jpg"':userEdit.photo}>
							<div class="field" id="fieldfile">
								<label>Avatar</label> <input type="file" name="photo2"
									class="ui button" id="photo" />

							</div>
							<button class="ui large teal submit button">Update</button>
						</div>
						<div class="ui error message" id="err">
							<ul class="list">
								<li><form:errors path="userEdit.photo" /></li>
							</ul>

						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
		var info_photo = document.getElementById("photo.errors");
		if (info_photo.innerHTML != "") {
			var input_form = document.getElementById("formid");
			input_form.setAttribute("class", "ui large form error");
			var input_email = document.getElementById("fieldfile");
			input_email.setAttribute("class", "field error");
		}
	</script>
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

