<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userNickname" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="userSmoke" />
<jsp:setProperty name="user" property="userMarried" />
<jsp:setProperty name="user" property="userEdu" />
<jsp:setProperty name="user" property="userIncome" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사랑</title>
</head>
<body>
<%
// 	String userID = null;
// 	if (session.getAttribute("userID") != null){
// 		userID = (String) session.getAttribute("userID");
// 	}
// 	if(userID != null){
// 		PrintWriter script = response.getWriter();
// 		script.println("<script>");
// 		script.println("alert('이미 로그인되어 있습니다.')");
// 		script.println("location.href = 'main.jsp'");
// 		script.println("</script>");
// 	}
	if(user.getUserID()==null||user.getUserPassword()==null||user.getUserName()==null||user.getUserNickname()==null
	||user.getUserGender()==null||user.getUserEmail()==null||user.getUserSmoke()==null
	||user.getUserMarried()==null||user.getUserEdu()==null||user.getUserIncome()==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력되지 않은 항목이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else{
		UserDAO userDAO = new UserDAO();
		int result = userDAO.join(user);
		if (result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('바람피지 마세요 기혼말고 다른거고르세요')");
			script.println("history.back()");
			script.println("</script>");
		}
		if(result == -3){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 닉네임입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
			
		}
	}
%>
</body>
</html>