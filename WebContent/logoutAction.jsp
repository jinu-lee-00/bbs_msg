<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인연 만들기</title>
</head>
<body>
	<%
		session.invalidate();
	%>
	<script>
		location.href = 'login.jsp';
	</script>
<hr>
전남대학교 소프트웨어공학과 데이타베이스
</body>
</html>