<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<base href="${pageContext.servletContext.contextPath}/">
<link href="images/favicon1.png" rel="icon">
<link rel="stylesheet" href="assets/css/style.css" />
<link rel="stylesheet" type="text/css"
	href="dist/components/semantic.css">
<script src="assets/library/jquery.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="dist/components/semantic.css">
<script src="dist/components/semantic.js"></script>
<title>Quản lí</title>
</head>
<body>
	<jsp:include page="welcome.jsp"></jsp:include>
	<div class="ui segment">
		<h2 class="ui center aligned icon header">
			<i class="circular users icon"></i> Danh sách các bài đã đăng
		</h2>
		<div class="ui middle aligned divided list">
			<c:forEach var="u" items="${listTopic}">
				<div class="item">
					<div class="right floated content">
						<a href="topic/edit/${u.id}.htm"><button
								class="ui green button">Sửa</button></a>
						<%-- <a
							href="topic/delete/${u.id}.htm"> --%>
						<button class="ui red button" data-modal-target="${u.id}">Xóa</button>
						<!-- </a> -->
					</div>
					<img class="ui avatar image"
						src=${u.photo == null||u.photo == ''?'"images/noimage.jpg"':u.photo}>
					<a class="content" href="vote/${u.id}.htm" style="color: black;">
						${u.name} </a>
				</div>
				<div class="ui mini modal" data-modal="${u.id}">
					<i class="close icon"></i>
					<div class="header">Xác nhận</div>
					<div class="content">
						<p>Bạn có chắn chắn muốn xóa điều này?</p>
					</div>
					<div class="actions">
						<div class="ui red basic cancel button">
							<i class="remove icon"></i> No
						</div>
						<div class="ui green ok button">
							<i class="checkmark icon"></i> Yes
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

</body>
<script type="text/javascript">
	$('[data-modal-target]').on('click', function() {
		var target = $(this).data('modal-target');
		$('[data-modal="' + target + '"]').modal({
			onApprove : function() {
				location.replace('topic/delete/' + target + '.htm');
				return true;
			}
		}).modal('show');
	})
</script>
</html>