<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="msg.MsgDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="msg" class="msg.Msg" scope="page" />
<jsp:setProperty name="msg" property="msgTitle" />
<jsp:setProperty name="msg" property="msgContent" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지보내기</title>
</head>
<body>
<%
	String userID = null;
	if (session.getAttribute("userID") != null){ // 유저 세션 얻기
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){ // 로그인 안 돼 있을 경우
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('쪽지를 전송하려면 로그인하세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	} else{ // 로그인 되어있을 경우
		if(msg.getMsgTitle() == null || msg.getMsgContent() == null){ // 제목 또는 내용이 입력 안 된 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else{ // 제목과 내용이 입력된 경우
			MsgDAO msgDAO = new MsgDAO();
			int result = msgDAO.write(msg.getMsgTitle(), userID, (String)request.getParameter("toUserID"), msg.getMsgContent());
			if (result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('쪽지 전송에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'message.jsp'");
				script.println("</script>");
			}
		}
	}
%>
</body>
</html>