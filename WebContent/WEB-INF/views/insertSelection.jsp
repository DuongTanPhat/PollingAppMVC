<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="images/favicon1.png" rel="icon">
<title>Insert title here</title>
</head>
<body>
	<form:form action="insertSelect.htm" class="ui form"
		modelAttribute="list" method="post">
		<form:input path="" />
		<div class="field">
			<div id="input_1"></div>
		</div>
		<div class="ui button" onclick="readOnly()">
			<i class="plus icon"></i>
		</div>
		<script type="text/javascript">
			function readOnly() {
				var input_1 = document.getElementById("input_1")
				var input2 = document.createElement("input")
				var label = document.createElement("label")
				input2.setAttribute("path", "")
				label.innerHTML = "Lựa chọn"
				input_1.appendChild(label)
				input_1.appendChild(input2)

			}
		</script>
		<form:button></form:button>
	</form:form>
</body>
</html>