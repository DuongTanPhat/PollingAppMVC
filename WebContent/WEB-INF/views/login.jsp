<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="images/favicon1.png" rel="icon">
<title>Login</title>
<script src="https://apis.google.com/js/platform.js" async defer></script>

<script src="assets/library/jquery.min.js"></script>
<script src="dist/components/semantic.js"></script>
<link rel="stylesheet" href="dist/components/semantic.css">
</head>
<style type="text/css">
body {
	background: url("assets/img/backgroundW.png") top center;
	background-color: #DADADA;
}

body>.grid {
	height: 100%;
}

.image {
	margin-top: -100px;
}

.column {
	max-width: 450px;
}
</style>
<script>
	$(document).ready(function() {
		$('.ui.form').form({
			fields : {
				username : {
					identifier : 'username',
					rules : [ {
						type : 'empty',
						prompt : 'Please enter your e-mail'
					}, {
						type : 'email',
						prompt : 'Please enter a valid e-mail'
					} ]
				},
				password : {
					identifier : 'password',
					rules : [ {
						type : 'empty',
						prompt : 'Please enter your password'
					} ]
				}
			}
		});
	});
</script>
</head>
<body>
	<div class="ui middle aligned center aligned grid">
		<div class="column">
			<h2 class="ui teal image header">
				<i class="icons"> <i class="user icon"></i>
				</i>
				<div class="content">Log-in to your account</div>
			</h2>
			<form class="ui large form"
				action="<c:url value='j_spring_security_login.htm' />" method="post"
				id="formid">
				<div class="ui stacked segment">
					<div class="field" id="fieldemail">
						<div class="ui left icon input">
							<i class="user icon"></i> <input value="${email}" type="text"
								name="username" placeholder="E-mail address">
						</div>
					</div>
					<div class="field">
						<div class="ui left icon input">
							<i class="lock icon"></i> <input value="${password}"
								type="password" name="password" placeholder="Password">
						</div>
					</div>
					<button class="ui fluid large teal submit button">Login</button>
				</div>
				<div class="ui error message" id="mess">${message}</div>
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form>
			<a
				href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile&redirect_uri=http://localhost:8080/Test/logingg.htm&response_type=code
    &client_id=108366822800-t2j50teo3eu4adf4ct5n0msggtsvvjmq.apps.googleusercontent.com&approval_prompt=force"><button
					class="ui google plus button">
					<i class="google plus icon"></i>Login With Google
				</button></a>

			<script type="text/javascript">
				var info_email = document.getElementById("mess");
				if (info_email.innerHTML != "") {
					var input_form = document.getElementById("formid");
					input_form.setAttribute("class", "ui large form error");
					var input_email = document.getElementById("fieldemail");
					input_email.setAttribute("class", "field error");
				}
			</script>
			<div class="ui message">
				New to us? <a href="signup.htm">Sign Up</a>
			</div>
		</div>
	</div>
</body>
</html>