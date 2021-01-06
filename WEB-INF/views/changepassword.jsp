<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Sign-up</title>
<link href="images/favicon1.png" rel="icon">
<script src="assets/library/jquery.min.js"></script>
<script
	src="${pageContext.servletContext.contextPath}/dist/components/semantic.js"></script>
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/dist/components/semantic.css">
</head>
<style type="text/css">
body {
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
				password : {
					identifier : 'password',
					rules : [ {
						type : 'empty',
						prompt : 'Please enter your current password'
					} ]
				},
				password1 : {
					identifier : 'password1',
					rules : [ {
						type : 'empty',
						prompt : 'Please enter your new password'
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
				<div class="content">Change your password</div>
			</h2>
			<form class="ui large form" action="changepassword.htm?${_csrf.parameterName}=${_csrf.token}" method="post" id="formid">
				<div class="ui stacked segment">
					<div class="field" id="fieldpassword">
						<div class="ui left icon input">
							<i class="lock icon"></i> <input value="${password}"
								type="password" name="password" id="password"
								placeholder="Old Password"/>
						</div>

					</div>
					<div class="field" id="fieldpassword1">
						<div class="ui left icon input">
							<i class="lock icon"></i>
							<input value="${password1}" type="password" name="password1"
								placeholder="New Password" />
						</div>
					</div>
					<div class="field">
						<div class="ui left icon input">
							<i class="lock icon"></i> <input value="${password2}"
								type="password" name="password2" id="password2"
								placeholder="Confirm New Password"/>
						</div>
					</div>
					<button class="ui fluid large teal submit button">Đổi mật khẩu</button>
				</div>
				<div class="ui error message" id="err">
					<ul class="list">
						<li id="passwordDot"><div id="passworderr">${passworderr}</div></li>
						<li id="password1Dot"><div id="password1err">${password1err}</div></li>
					</ul>

				</div>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
			<script type="text/javascript">
				var info_password = document.getElementById("passworderr");
				try{
					if (info_password.innerHTML != "") {
						var input_form = document.getElementById("formid");
						input_form.setAttribute("class", "ui large form error");
						var input_pass = document.getElementById("fieldpassword");
						input_pass.setAttribute("class", "field error");
					}
					else{
						var input = document.getElementById("passwordDot");
						input.setAttribute("style", "display: none;");
					}
				}
				catch{
					var input = document.getElementById("passwordDot");
					input.setAttribute("style", "display: none;");
				}
			</script>
			<script type="text/javascript">
				var info_password = document.getElementById("password1err");
				try{
					if (info_password.innerHTML != "") {
						var input_form = document.getElementById("formid");
						input_form.setAttribute("class", "ui large form error");
						var input_pass = document.getElementById("fieldpassword1");
						input_pass.setAttribute("class", "field error");
					}
					else{
						var input = document.getElementById("password1Dot");
						input.setAttribute("style", "display: none;");
					}
				}
				catch{
					var input = document.getElementById("password1Dot");
					input.setAttribute("style", "display: none;");
				}
			</script>
		</div>
	</div>
</body>
</html>