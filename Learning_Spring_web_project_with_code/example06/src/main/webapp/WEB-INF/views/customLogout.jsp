<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Logout Page</h1>
	<form action="/customLogout" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<a href="index.html" class="btn btn-lg btn-success btn-block">로그아웃</a>
	</form>

    <!-- Bootstrap core JavaScript-->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/js/sb-admin-2.min.js"></script>
    
    <script>
	    $(".btn-success").on("click", function(e) {
	    	e.preventDefault();
	    	$("form").submit();
	    });
    </script>
    <c:if test="${param.logout != null}">
    <script>
    	$(document).ready(function() {
    		alert("로그아웃하였습니다.");
    	})
    </script>
    </c:if>
</body>
</html>