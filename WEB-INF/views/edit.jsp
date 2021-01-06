<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<base href="${pageContext.servletContext.contextPath}/">
<link href="images/favicon1.png" rel="icon">
<link rel="stylesheet" href="dist/components/semantic.css">
<script src="assets/library/jquery.min.js"></script>
<script src="dist/components/semantic.js"></script>
<title>Chỉnh sửa</title>
<script>
	$(document).ready(function() {
		$('.ui.selection.dropdown').dropdown();
		$('.ui.menu .ui.dropdown').dropdown({
			on : 'hover'
		});
	});
</script>
<script>
	$(document).ready(function() {
		$('.ui.form').form({
			fields : {
				name : {
					identifier : 'name',
					rules : [ {
						type : 'empty',
						prompt : 'Please enter name of topic'
					} ]
				}
			}
		});
	});
</script>
</head>
<body>
	<jsp:include page="welcome.jsp"></jsp:include>
	<div class="ui segment">
		<p>
		<form action="topic/edit/${topic.id}.htm?${_csrf.parameterName}=${_csrf.token}" class="ui form"
			method="post" enctype="multipart/form-data" id="formid">
			<h4 class="ui dividing header">Sửa bầu chọn</h4>
			<div class="field">
				<label>Name</label>
				<form:input path="topic.name" type="text" placeholder="Name" />
			</div>
			<div class="field">
				<label>Tag</label>
				<form:select path="topic.tag.id" class="ui selection dropdown"
					items="${tagList}" itemLabel="name" itemValue="id">
				</form:select>
			</div>
			<div class="field">
				<label>Ngày hết hạn</label>
				<div class="ui left icon input">
					<i class="calendar alternate icon"></i>
					<form:input path="topic.exp" type="date" name="exp" />

				</div>
			</div>
			<div class="field">
				<label>Descriptions</label>
				<form:textarea path="topic.descriptions" rows="2" type="text"
					placeholder="Descriptions" />
			</div>
			<div class="two fields">
				<div class="field">
					<div class="ui toggle checkbox">
						<form:checkbox path="topic.isMany" />
						<label>Cho phép mọi người chọn nhiều câu trả lời</label>
					</div>
				</div>
				<div class="field">
					<div class="ui toggle checkbox">
						<form:checkbox path="topic.isCreate" />
						<label>Cho phép mọi người thêm tùy chọn</label>
					</div>
				</div>
			</div>

			<div class="field" id="fieldfile">
				<img class="ui medium bordered right spaced image"
					src=${topic.photo == null||topic.photo == ''?'"images/noimage.jpg"':topic.photo}>
				<label>Photo</label> <input type="file" name="photo2"
					class="ui button" />
			</div>

			<div class="ui error message" id="err">
				<ul class="list">
					<li><form:errors path="topic.photo" /></li>
				</ul>
			</div>
			<button class="ui button" tabindex="0">Next</button>
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
		</p>
	</div>

</body>
</html>