<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<base href="${pageContext.servletContext.contextPath}/">
<link href="images/favicon1.png" rel="icon">
<meta charset="utf-8">
<script src="assets/library/jquery.min.js"></script>
<script
	src="dist/components/semantic.js"></script>
<link rel="stylesheet"
	href="dist/components/semantic.css">
<title>Chỉnh sửa</title>
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
	color: red;
	font-style: italic;
}
</style>

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
	<jsp:include page="welcome.jsp"></jsp:include>
	</div>
	<form class="ui large form" action="user/edit.htm?${_csrf.parameterName}=${_csrf.token}" method="post"
		enctype="multipart/form-data" id="formid">
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
					<form:input path="userEdit.fullname" type="text" name="fullname"
						placeholder="Name" />

				</div>
			</div>
			<div class="field">
				<form:select path="userEdit.gender" class="ui selection dropdown">
					<form:option value="true">Male</form:option>
					<form:option value="false">Female</form:option>
				</form:select>

			</div>
			<div class="field">
				<div class="ui left icon input">
					<i class="calendar alternate icon"></i>
					<form:input path="userEdit.birthday" type="date" name="birthday"
						placeholder="Birthday" />

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
	<script type="text/javascript">
		var info_photo = document.getElementById("photo.errors");
		try{
			if (info_photo.innerHTML != "") {
				var input_form = document.getElementById("formid");
				input_form.setAttribute("class", "ui large form error");
				var input_email = document.getElementById("fieldfile");
				input_email.setAttribute("class", "field error");
			}
		}
		catch{
			
		}
		
	</script>
</body>
</html>