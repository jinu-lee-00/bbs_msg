<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="msg.MsgDAO" %>
<%@ page import="msg.Msg" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="java.util.ArrayList" %>
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
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">보낸사람</th>
						<th style="background-color: #eeeeee; text-align: center;">받는사람</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						int size = 0;
						int cnt2 = 0;
						int pagecnt = 0;
						MsgDAO msgDAO = new MsgDAO();
						BbsDAO bbsDAO = new BbsDAO();
						
						ArrayList<Msg> list = msgDAO.getList(pageNumber);
						


						for(int i = 0; i < list.size(); i++){
							if(!list.get(i).getToUserID().equals(userID) && !list.get(i).getFromUserID().equals(userID)){continue;}else{size++;}
						}
						for(int i = 0; i < list.size(); i++){
							if(!list.get(i).getToUserID().equals(userID) && !list.get(i).getFromUserID().equals(userID)){continue;}else{cnt2++;}
					%>
					<tr>
						<td><%= (size - cnt2 + 1)%></td>
						<td><a href="msgview.jsp?msgID=<%= list.get(i).getMsgID() %>"><%= list.get(i).getMsgTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
						<td>
						<%
						if(list.get(i).getFromUserID().equals(userID)){
						%>
						나
						<%
						}else{User user = new UserDAO().getUser(list.get(i).getFromUserID());
						%>
						<%= user.getUserNickname() %>
						<%
						}
						%>
						</td>
						
						<td>
						<% if(list.get(i).getToUserID().equals(userID)){ %>
						나 <%}else{User user = new UserDAO().getUser(list.get(i).getToUserID());
						%>
						<%= user.getUserNickname() %>
						<%
						}
						%>
						
						</td>
						
						<td><%= list.get(i).getMsgDate().substring(0, 11)+list.get(i).getMsgDate().substring(11, 13)+"시"+list.get(i).getMsgDate().substring(14,16)+"분"%></td>
					</tr>					
					<%
						}
					%>
					
				</tbody>
			</table>
			<% if(size==0){ %>
				<div class="container">
					<div class="jumbotron">
						<h1>아직 주고받은 쪽지가 없어요!</h1>
						<p>게시판에서 원하는 사람을 찾고 쪽지를 보내거나,</p>
						<p>게시판에서 소개글을 올린 뒤 쪽지를 기다려 봐요.</p>
					</div>
				</div>
			<%} %>
			<%
				if(pageNumber != 1){
			%>
					<a href="message.jsp?pageNumber=<%=pageNumber - 1 %>" class="btn btn-success btn-arrow-left">이전</a>
			<%
				}				
				if (msgDAO.nextPage(pageNumber + 1)){
			%>
					<a href="message.jsp?pageNumber=<%=pageNumber + 1 %>" class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>