<%-- File: admin-header.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="admin-header">
    <div class="user-info">
        <c:set var="loggedInUser" value="${sessionScope.loggedInUser}" />
        <c:if test="${not empty loggedInUser}">
            <span>Xin chào, <strong>${loggedInUser.fullname}!</strong></span>
            <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
        </c:if>
         <c:if test="${empty loggedInUser}">
            <span>(Chưa đăng nhập)</span>
            <a href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a>
        </c:if>
    </div>
</header>

