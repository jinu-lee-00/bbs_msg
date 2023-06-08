<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">


<title>회원가입</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
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
							<li><a href="message.jsp">쪽지</a></li>
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
							<li><a href="message.jsp">쪽지</a></li>
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
				<li><a href="message.jsp">쪽지</a></li>
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
			<div class="col-lg-4"></div>
				<div class="col-lg-4">
					<div class="jumbotron" style="padding-top: 20px;">
						<form method="post" action="joinAction.jsp">
							<h3 sytle="text-align: center;">회원가입 화면</h3>
							<div class="form-group">
								<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
							</div>
							
							<div class="form-group">
								<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
							</div>
							<div class="form-group">
								<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
							</div>
							
							<div class="form-group">
								<input type="text" class="form-control" placeholder="닉네임" name="userNickname" maxlength="20">
							</div>
							
							<div class="form-group" style="text-align: center;"> <%--userGender --%>
								<div class="btn-group" data-toggle="buttons">
									<label class="btn btn-primary active">
										<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
									</label>
									<label class="btn btn-primary">
										<input type="radio" name="userGender" autocomplete="off" value="여자">여자
									</label>
								</div>
							</div>
		
							<div class="form-group">
								<input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="50">
							</div>
							
							<h4 style="text-align: center;">흡연여부</h4>
							<div class="form-group" style="text-align: center;"> <%-- userSmoke --%>
								<div class="btn-group" data-toggle="buttons">
									<label class="btn btn-primary active">
										<input type="radio" name="userSmoke" autocomplete="off" value="비흡연자" checked>비흡연자
									</label>
									<label class="btn btn-primary">
										<input type="radio" name="userSmoke" autocomplete="off" value="흡연자">흡연자
									</label>
								</div>
							</div>
							
							<h4 style="text-align: center;">당신은 현재?</h4>
							<div class="form-group" style="text-align: center;">
								<div class="btn-group" data-toggle="buttons">
									<label class="btn btn-primary active">
										<input type="radio" name="userMarried" autocomplete="off" value="초혼" checked>초혼
									</label>
									<label class="btn btn-primary">
										<input type="radio" name="userMarried" autocomplete="off" value="재혼">재혼
									</label>
									<label class="btn btn-primary">
										<input type="radio" name="userMarried" autocomplete="off" value="기혼">기혼
									</label>
								</div>
							</div>
							
							<h4 style="text-align: center;">학력</h4>
 							 <div class="container" style="margin-bottom: 10px">
								 <select name="userEdu" class="form-control">
	   							 	<option value="중졸">중졸</option>
	   							 	<option value="고졸">고졸</option>
	   							 	<option value="초대졸">초대졸</option>
	   							 	<option value="대졸">대졸</option>
	   							 	<option value="석사">석사</option>
	   							 	<option value="박사">박사</option>
	 							 </select>
 							 </div>
 							 
 							 <h4 style="text-align: center;">연봉</h4>
 							 <div class="container" style="margin-bottom: 10px">
								 <select name="userIncome" class="form-control">
	   							 	<option value="3천만원 이하">3천만원 이하</option>
	   							 	<option value="3천만원 ~ 5천만원">3천만원 ~ 5천만원</option>
	   							 	<option value="5천만원 ~ 7천만원">5천만원 ~ 7천만원</option>
	   							 	<option value="7천만원 ~ 1억원">7천만원 ~ 1억원</option>
	   							 	<option value="1억 이상">1억 이상</option>
	 							 </select>
 							 </div>
​
					<input type="submit" class="btn btn-primary form-control" value="회원가입">
				</form>
			</div>
		</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>