<%-- File: header.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="main-header">
    <div class="brand">
        <a href="${pageContext.request.contextPath}/home"><h1>Nhà Sách Online</h1></a>
    </div>
    
    <nav>
        <c:set var="loggedInUser" value="${sessionScope.loggedInUser}" />

        <%-- Nếu người dùng đã đăng nhập --%>
        <c:if test="${not empty loggedInUser}">
            <span>Xin chào, <strong>${loggedInUser.fullname}</strong>!</span>
            <a href="${pageContext.request.contextPath}/order-history">Lịch sử mua hàng</a>
           
            <c:if test="${loggedInUser.isAdmin()}">
                <a href="${pageContext.request.contextPath}/admin/manage-books"><strong>Trang Quản Trị</strong></a>
            </c:if>

            <a href="${pageContext.request.contextPath}/cart.jsp">Giỏ hàng</a>
            <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
        </c:if>

        <%-- Nếu người dùng chưa đăng nhập --%>
        <c:if test="${empty loggedInUser}">
            <a href="${pageContext.request.contextPath}/cart.jsp">Giỏ hàng</a>
            <a href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a>
            <a href="${pageContext.request.contextPath}/register.jsp">Đăng ký</a>
        </c:if>
    </nav>
</header>