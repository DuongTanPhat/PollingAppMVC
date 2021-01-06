<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="images/favicon1.png" rel="icon">
<title>Sign-up</title>
<script src="assets/library/jquery.min.js"></script>
<script
	src="${pageContext.servletContext.contextPath}/dist/components/semantic.js"></script>
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/dist/components/semantic.css">
</head>
<style type="text/css">
body {
    background: url("assets/img/bg.jpg") top center;
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
		$('.ui.selection.dropdown').dropdown();
		$('.ui.menu .ui.dropdown').dropdown({
			on : 'hover'
		});
	});
</script>
<style type="text/css">
*[id$=errors] {
	color: #9F3A38;
	font-style: italic;
}
</style>

<script>
	$(document).ready(function() {
		$('.ui.form').form({
			fields : {
				email : {
					identifier : 'email',
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
				},
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

	<div class="ui middle aligned center aligned grid">
		<div class="column">
			<h2 class="ui teal image header">
				<i class="icons"> <i class="user icon"></i>
				</i>
				<div class="content">Create your account</div>
			</h2>
			<form class="ui large form" action="signup.htm?${_csrf.parameterName}=${_csrf.token}" method="post"
				enctype="multipart/form-data" id="formid">
				<div class="ui stacked segment">
					<div class="field" id="fieldemail">
						<div class="ui left icon input">
							<i class="envelope icon"></i>
							<form:input path="userNew.email" type="text" name="email"
								placeholder="E-mail address" />
						</div>

					</div>
					<div class="field">
						<div class="ui left icon input">
							<i class="lock icon"></i>
							<form:input path="userNew.password" type="password"
								name="password" placeholder="Password" />
						</div>
					</div>
					<div class="field" id="fieldpassword">
						<div class="ui left icon input">
							<i class="lock icon"></i> <input value="${password2}"
								type="password" name="password2" id="password2"
								placeholder="Confirm Password">
						</div>

					</div>
					<div class="field">
						<div class="ui left icon input">
							<i class="id card icon"></i>
							<form:input path="userNew.fullname" type="text" name="fullname"
								placeholder="Name" />

						</div>
					</div>
					<div class="field">
						<form:select path="userNew.gender" class="ui selection dropdown">
							<form:option value="true">Male</form:option>
							<form:option value="false">Female</form:option>
						</form:select>

					</div>
					<div class="field">
						<div class="ui left icon input">
							<i class="calendar alternate icon"></i>
							<form:input path="userNew.birthday" type="date" name="birthday"
								placeholder="Birthday" />

						</div>
					</div>
					<div class="field">
						<div class="ui left icon input">
							<i class="phone icon"></i>
							<form:input path="userNew.phone" type="text" name="phone"
								placeholder="Phone Number" />
						</div>
					</div>
					<div class="field" id="fieldfile">
						<label>Avatar</label> <input type="file" name="photo2"
							class="ui button" id="photo" />

					</div>
					<button class="ui fluid large teal submit button">Sign-up</button>
				</div>
				<div class="ui error message" id="err">
					<ul class="list">
						<li id="passwordDot"><form:errors path="userNew.password" /></li>
						<li id="emailDot"><form:errors path="userNew.email"/></li>

						<li id="photoDot"><form:errors path="userNew.photo" /></li>
					</ul>

				</div>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
			<script type="text/javascript">
				var info_email = document.getElementById("email.errors");
				try{
					if (info_email.innerHTML != "") {
						var input_form = document.getElementById("formid");
						input_form.setAttribute("class", "ui large form error");
						var input_email = document.getElementById("fieldemail");
						input_email.setAttribute("class", "field error");
					}
				}
				catch{
					var input = document.getElementById("emailDot");
					input.setAttribute("style", "display: none;");
				}
			</script>
			<script type="text/javascript">
				var info_password = document.getElementById("password.errors");
				try{
					if (info_password.innerHTML != "") {
						var input_form = document.getElementById("formid");
						input_form.setAttribute("class", "ui large form error");
						var input_pass = document.getElementById("fieldpassword");
						input_pass.setAttribute("class", "field error");
					}
				}
				catch{
					var input = document.getElementById("passwordDot");
					input.setAttribute("style", "display: none;");
				}
			</script>
			<script type="text/javascript">
				var info_photo = document.getElementById("photo.errors");
				try{
					if (info_photo.innerHTML != "") {
						var input_form = document.getElementById("formid");
						input_form.setAttribute("class", "ui large form error");
						var input_photo = document.getElementById("fieldfile");
						input_photo.setAttribute("class", "field error");
					}
				}
				catch{
					var input = document.getElementById("photoDot");
					input.setAttribute("style", "display: none;");
				}
			</script>
			<div class="ui message">
				Already have an account? <a href="login.htm">Sign-in</a>
			</div>
		</div>
	</div>
</body>
</html>