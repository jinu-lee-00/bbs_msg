<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>게시판</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		String toUserID;
		toUserID = (String)request.getParameter("toUserID");
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<%
				if(userID == null){
			%>
				<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">로그인 / 회원가입<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li class="active"><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</button>
				<button type="button" class="navbar-toggle collapsed" style="margin-top: 10px"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</a>
						<ul class="dropdown-menu">
							<li><a href="main.jsp">메인</a></li>
							<li><a href="bbs.jsp">게시판</a></li>
							<li class="active"><a href="message.jsp">쪽지</a></li>
							<li><a href="info.jsp">내 정보</a></li>
						</ul>
					</button>
			<%
				} else{ // 모바일 구현
			%>
					<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
						<a href="logoutAction.jsp" class="dropdown-toggle"
							 role="button" aria-expanded="false">로그아웃
						</a>
					</button>
					<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</a>
						<ul class="dropdown-menu">
							<li><a href="main.jsp">메인</a></li>
							<li><a href="bbs.jsp">게시판</a></li>
							<li class="active"><a href="message.jsp">쪽지</a></li>
							<li><a href="info.jsp">내 정보</a></li>
						</ul>
					</button>
			<%
				}
			%>
			<a class="navbar-brand" href="main.jsp">결혼 상대 찾기</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collase-1">
			<ul class ="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
				<li class="active"><a href="message.jsp">쪽지</a></li>
				<li><a href="info.jsp">내 정보</a></li>
			</ul>
			<%
				if(userID == null){
			%>
					<ul class ="nav navbar-nav navbar-right">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle"
								data-toggle="dropdown" role="button" aria-haspopup="true"
								aria-expanded="false">로그인 / 회원가입<span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="login.jsp">로그인</a></li>
								<li><a href="join.jsp">회원가입</a></li>
							</ul>
						</li>
					</ul>
			<%
				} else{
			%>
					<a class ="nav navbar-nav navbar-right" style="padding-top: 15px; padding-right: 15px;" href="logoutAction.jsp">로그아웃</a>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<form method="post" action="msgwriteAction.jsp?toUserID=<%= toUserID%>">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">쪽지 보내기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="제목을 입력하세요" name="msgTitle" maxlength="50"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="내용을 입력하세요" name="msgContent" maxlength="2048" style="height: 350px;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="전송">
			</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>