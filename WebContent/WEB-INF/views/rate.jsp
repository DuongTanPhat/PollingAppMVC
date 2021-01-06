<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="${pageContext.servletContext.contextPath}/assets/library/jquery.min.js"></script>
<script src="${pageContext.servletContext.contextPath}/dist/components/semantic.js"></script>
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/dist/components/semantic.css">
<title>Insert title here</title>
</head>
<script>
$(document).ready(function() {
	$('.ui.rating.disable')
	  .rating({
	    maxRating: 5,
	  })
	  .rating('setting', 'onRate', function(value) {
		  var input = document.getElementById("rate");
		  input.setAttribute("value", value);
  	});
	;
});
</script>
<body>
<form:form action="vote/${topic.id}.htm?insertEvaluate"
						class="ui form" modelAttribute="evaluate" method="post">
						<div class="ui custom star rating disable" data-rating="0"></div>
						<form:input path="rate" type="hidden" value="0"/>
						<form:textarea path="descriptions" rows="2" type="text" placeholder="Descriptions"/>
						<form:button class="ui button">Gửi</form:button>
					</form:form>
</body>
</html>