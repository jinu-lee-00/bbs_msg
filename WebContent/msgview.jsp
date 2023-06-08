<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="msg.Msg" %>
<%@ page import="msg.MsgDAO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
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
		int msgID = 0;
		if (request.getParameter("msgID") != null){
			msgID = Integer.parseInt(request.getParameter("msgID"));
		}
		if(msgID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'message.jsp'");
			script.println("</script>");
		}
		Msg msg = new MsgDAO().getMsg(msgID);
		User user = new UserDAO().getUser(msg.getFromUserID());
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
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<%
						if(userID.equals(msg.getFromUserID())){
						%>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">내가 보낸 쪽지</th>
						<%
						}else{
						%>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;"> <%=msg.getFromUserID() %> 님으로부터 온 쪽지</th>
						<%
						}
						%>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= msg.getMsgTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll(" ", "&nbsp").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>발신자 닉네임</td>
						
						<td colspan="2"><%=user.getUserNickname()%></td>
					</tr>
					<tr>
						<td>발신일자</td>
						<td colspan="2"><%= msg.getMsgDate().substring(0, 11)+msg.getMsgDate().substring(11, 13)+"시"+msg.getMsgDate().substring(14,16)+"분" %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%=msg.getMsgContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>

			
			<h4>[상대방 정보]</h4>
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
						<%
						if(userID.equals(msg.getFromUserID())){
						User user2 = new UserDAO().getUser(msg.getToUserID());
						%>
						
						<td><%=user2.getUserGender() %></td>
						<td><%=user2.getUserSmoke() %></td>
						<td><%=user2.getUserMarried() %></td>
						<td><%=user2.getUserEdu() %></td>
						<td><%=user2.getUserIncome() %></td>
						<%
						}else{
						User user2 = new UserDAO().getUser(msg.getFromUserID());
						%>
						
						<td><%=user2.getUserGender() %></td>
						<td><%=user2.getUserSmoke() %></td>
						<td><%=user2.getUserMarried() %></td>
						<td><%=user2.getUserEdu() %></td>
						<td><%=user2.getUserIncome() %></td>
						<%
						}
						%>

					</tr>
				</tbody>
			</table>

			<a href="message.jsp" class="btn btn-primary">목록</a>
			
			<%
				if(userID != null && userID.equals(msg.getFromUserID())){
			%>
				
			<%		
				}else{
			%>
				<a href="msgwrite.jsp?toUserID=<%= msg.getFromUserID()%>" class="btn btn-primary">❤️답장하기❤️</a>
			<%
				}
			%>
			

		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>