<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="msg.Msg" %>
<%@ page import="msg.MsgDAO" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>

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
		int bbsID = 0;
		if (request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		String writeUserID = (String)request.getParameter("writeUserID");
		
		User user = new UserDAO().getUser(writeUserID);
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if(bbs==null || user==null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('다시 시도해 주세요.')");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");
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
							<li class="active"><a href="bbs.jsp">게시판</a></li>
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
							<li class="active"><a href="bbs.jsp">게시판</a></li>
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
				<li class="active"><a href="bbs.jsp">게시판</a></li>
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
		<div class="row">
			<table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="12" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="11"><%= bbs.getBbsTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll(" ", "&nbsp").replaceAll("\n", "<br>") %></td>
					</tr>

					<tr>
						<td>작성일자</td>
						<td colspan="11"><%= bbs.getBbsDate().substring(0, 11)+bbs.getBbsDate().substring(11, 13)+"시"+bbs.getBbsDate().substring(14,16)+"분" %></td>
					</tr>
					
					<tr>
						<td>작성자 닉네임</td>
						<td colspan="11"><%=user.getUserNickname() %></td>
					</tr>

				</tbody>
			</table>
			
			<table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">성별</th>
						<th style="background-color: #eeeeee; text-align: center;">흡연여부</th>
						<th style="background-color: #eeeeee; text-align: center;">초혼/재혼</th>
						<th style="background-color: #eeeeee; text-align: center;">학력</th>
						<th style="background-color: #eeeeee; text-align: center;">연봉</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><%=user.getUserGender() %></td>
						<td><%=user.getUserSmoke() %></td>
						<td><%=user.getUserMarried() %></td>
						<td><%=user.getUserEdu() %></td>
						<td><%=user.getUserIncome() %></td>
					</tr>
				</tbody>
			</table>
			
			<table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="12" style="background-color: #eeeeee; text-align: center;">글 내용</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="min-height: 200px; text-align: left;"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>
			
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			
			<%
				if(userID != null && userID.equals(bbs.getUserID())){
			%>
				<a class="btn btn-primary pull-right" onclick="alert('자신에게는 쪽지를 보낼 수 없습니다!')">❤️쪽지 보내기❤️</a>
			<%		
				}else{
			%>
				<a href="msgwrite.jsp?toUserID=<%= bbs.getUserID()%>" class="btn btn-primary pull-right">❤️쪽지 보내기❤️</a>
			<%
				}
			%>
			
			<%
				if(userID != null && userID.equals(bbs.getUserID())){
			%>
					<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
			<%		
				}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>