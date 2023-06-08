<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/custom.css">
<title>인연 만들기</title>
</head>
<body>
	<script>
		<%
			String userID = null;
			if (session.getAttribute("userID") != null){
				userID = (String) session.getAttribute("userID");
			}
		%>
		<%
			if(userID == null){
		%>
			location.href = 'login.jsp';
		<%
			} else{
		%>
			location.href = 'main.jsp';
		<%
			}
		%>

	</script>
</body>
</html>