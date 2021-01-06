<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Thông tin</title>
<link href="images/favicon1.png" rel="icon">
</head>
<body>
	<jsp:include page="welcome.jsp"></jsp:include>
	<div class="ui segment">
		<p>
		<div class="ui medium bordered circular centered rotate reveal image">
			<img class="visible content"
				src=${user.photo == null||user.photo == ''?'"images/noimage.jpg"':user.photo}>
			<img
				src=${user.photo == null||user.photo == ''?'"images/noimage.jpg"':user.photo}
				class="hidden content">
		</div>
		<%-- <img class="ui medium bordered circular centered image" src=${user.photo == null||user.photo == ''?'"images/noimage.jpg"':user.photo}> --%>

		<h2 class="ui center aligned icon header">${user.fullname}</h2>
		<div class="ui list">
			<div class="item">
				<i class="user icon"></i>
				<div class="content">
					Name: ${user.fullname}<a href="user/edit.htm"><button
							class="mini ui compact icon button" style="display: inline;">
							<i class="edit icon"></i>
						</button></a>
				</div>
			</div>
			<div class="item">
				<i class="venus mars icon"></i>
				<div class="content">Gender: ${user.gender==true?'Nam':'Nữ'}</div>
			</div>
			<div class="item">
				<i class="mail icon"></i>
				<div class="content">
					<a href="mailto:${user.email}">Email: ${user.email}</a>
				</div>
			</div>
			<div class="item">
				<i class="phone icon"></i>
				<div class="content">Phone: ${user.phone}</div>
			</div>
			<div class="item">
				<i class="calendar alternate outline icon"></i>
				<div class="content">Birthday: ${user.birthday}</div>
			</div>
			<div class="item">
				<i class="key icon"></i> <a class="content"
					href="changepassword.htm"> Đổi mật khẩu </a>
			</div>
		</div>
		</p>
	</div>
</body>
</html>