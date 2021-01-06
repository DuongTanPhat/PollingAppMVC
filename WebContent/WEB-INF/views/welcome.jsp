<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<base href="${pageContext.servletContext.contextPath}/">
<title>Spring MVC</title>

<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>OnePage Bootstrap Template - Index</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- Favicons -->
<link href="assets/img/favicon1.png" rel="icon">
<link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">
<link rel="stylesheet" href="dist/components/semantic.css">
</head>
<body>
	<div class="fixed-top">
		<div class="ui pointing menu">
			<c:choose>
				<c:when test="${where==1}">
					<a href="welcome.htm" class="active item"> Home </a>
					<c:if test="${user!=null}">
						<c:if test="${topic!=null}">
							<a href="vote/${topic.id}.htm" class="item"> Vote </a>
						</c:if>
					</c:if>
					<c:if test="${user!=null}">
						<a href="manager.htm?info" class="item"> Info </a>
					</c:if>
				</c:when>
				<c:when test="${where==2}">
					<a href="welcome.htm" class="item"> Home </a>
					<a href="vote/${topic.id}.htm" class="active item"> Vote </a>
					<a href="manager.htm?info" class="item"> Info </a>
				</c:when>
				<c:when test="${where==3}">
					<a href="welcome.htm" class="item"> Home </a>
					<c:if test="${topic!=null}">
						<a href="vote/${topic.id}.htm" class="item"> Vote </a>
					</c:if>
					<a href="manager.htm?info" class="active item"> Info </a>
				</c:when>
				<c:when test="${where==4}">
					<a href="welcome.htm" class="item"> Home </a>
					<a href="manager.htm?info" class="item"> Info </a>
				</c:when>
				<c:when test="${where==5}">
					<a href="welcome.htm" class="item"> Home </a>
					<c:if test="${topic!=null}">
						<a href="vote/${topic.id}.htm" class="item"> Vote </a>
					</c:if>
					<a href="manager.htm?info" class="item"> Info </a>
				</c:when>
			</c:choose>
			<div class="right menu">
				<c:choose>
					<c:when test="${user==null}">
						<div class="item">
							<a href="signup.htm" class="ui primary button">Sign up</a>
						</div>
						<div class="item">
							<a href="login.htm" class="ui button">Log-in</a>
						</div>
					</c:when>
					<c:when test="${user!=null&&where==5}">
						<div class="item">
							<a href="topic/insert.htm"><h2>
									<i class="plus icon"></i>
								</h2></a>
						</div>
						<div class="active item">
							<c:choose>
								<c:when test="${user.photo == null||user.photo==''}">
									<img class="ui avatar circular bordered image"
										class="ui medium circular image"
										src="${pageContext.servletContext.contextPath}/images/noimage.jpg">
								</c:when>
								<c:when test="${user.photo != null&&user.photo!=''}">
									<img class="ui avatar circular bordered image"
										class="ui medium circular image" src="${user.photo}">
								</c:when>
							</c:choose>
							<a href="user/info.htm" class="ui primary button">
								${user.fullname}</a>
						</div>
						<div class="item">
							<form action="<c:url value="/j_spring_security_logout.htm" />"
								method="post">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <input type="submit"
									class="ui button" value="Log-out" />
							</form>
						</div>
					</c:when>
					<c:when test="${user!=null&&where!=5&&where!=4}">
						<div class="item">
							<a href="topic/insert.htm"><h2>
									<i class="plus icon"></i>
								</h2></a>
						</div>
						<div class="item">
							<c:choose>
								<c:when test="${user.photo == null||user.photo==''}">
									<img class="ui avatar circular bordered image"
										class="ui medium circular image"
										src="${pageContext.servletContext.contextPath}/images/noimage.jpg">
								</c:when>
								<c:when test="${user.photo != null&&user.photo!=''}">
									<img class="ui avatar circular bordered image"
										class="ui medium circular image" src="${user.photo}">
								</c:when>
							</c:choose>
							<a href="user/info.htm" class="ui primary button">
								${user.fullname}</a>
						</div>
						<div class="item">
							<form action="<c:url value="/j_spring_security_logout.htm" />"
								method="post">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <input type="submit"
									class="ui button" value="Log-out" />
							</form>
						</div>
					</c:when>
					<c:when test="${user!=null&&where==4}">
						<div class="active item">
							<a href="topic/insert.htm"><h2>
									<i class="plus icon"></i>
								</h2></a>
						</div>

						<div class="item">
							<c:choose>
								<c:when test="${user.photo == null||user.photo==''}">
									<img class="ui avatar circular bordered image"
										class="ui medium circular image"
										src="${pageContext.servletContext.contextPath}/images/noimage.jpg">
								</c:when>
								<c:when test="${user.photo != null&&user.photo!=''}">
									<img class="ui avatar circular bordered image"
										class="ui medium circular image" src="${user.photo}">
								</c:when>
							</c:choose>
							<a href="user/info.htm" class="ui primary button">${user.fullname}</a>
						</div>
						<div class="item">
							<form action="<c:url value="/j_spring_security_logout.htm" />"
								method="post">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" /> <input type="submit"
									class="ui button" value="Log-out" />
							</form>

						</div>
					</c:when>
				</c:choose>
				<c:if test="${user.email=='admin@admin'}">
					<div class="item">
						<a href="admin.htm" class="ui button">Admin Dashboard</a>
					</div>
				</c:if>

				<div class="item">
					<div class="ui transparent icon input">
						<form class="ui form" action="welcome.htm">
							<div class="ui action input">
								<input type="text" name="name" placeholder="Search..."
									style="width: 80%">
								<button class="ui icon button">
									<i class="search icon"></i>
								</button>
							</div>
						</form>
					</div>
				</div>

			</div>
		</div>
	</div>
	<!-- 	</header> -->
</body>
</html>