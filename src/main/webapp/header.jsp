<%-- File: header.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css"> 
</head>

<header class="main-header">
    <!-- Logo / Thương hiệu -->
    <div class="brand">
        <a href="${pageContext.request.contextPath}/home" class="logo-text">
            <img src="${pageContext.request.contextPath}/images/logo.jpg" 
                 alt="logo" class="logo-icon">
        </a>
    </div>

    <!-- Thanh điều hướng -->
    <nav>
        <c:set var="loggedInUser" value="${sessionScope.loggedInUser}" />

        <!-- Nếu người dùng đã đăng nhập -->
        <c:if test="${not empty loggedInUser}">
            <span class="user-greeting">Xin chào, <strong>${loggedInUser.fullname}</strong>!</span>
            
            <a href="${pageContext.request.contextPath}/home" 
               class="${param.currentPage == 'home' ? 'active' : ''}">Trang chủ</a>
            
            <a href="${pageContext.request.contextPath}/order-history" 
               class="${param.currentPage == 'order-history' ? 'active' : ''}">Lịch sử mua hàng</a>

            <a href="${pageContext.request.contextPath}/cart.jsp" 
               class="cart-icon ${param.currentPage == 'cart' ? 'active' : ''}">
                <i class="fa-solid fa-cart-shopping"></i>
                <c:if test="${not empty cart}">
                    <span class="cart-count">${cart.size()}</span>
                </c:if>
            </a>

            <c:if test="${loggedInUser.isAdmin()}">
                <a href="${pageContext.request.contextPath}/admin/dashboard">Quản trị</a>
            </c:if>

            <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
        </c:if>

        <!-- Nếu người dùng chưa đăng nhập -->
        <c:if test="${empty loggedInUser}">
            <a href="${pageContext.request.contextPath}/home" 
               class="${param.currentPage == 'home' ? 'active' : ''}">Trang chủ</a>

            <a href="${pageContext.request.contextPath}/cart.jsp" 
               class="cart-icon ${param.currentPage == 'cart' ? 'active' : ''}">
                <i class="fa-solid fa-cart-shopping"></i>
            </a>

            <a href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a>
            <a href="${pageContext.request.contextPath}/register.jsp">Đăng ký</a>
        </c:if>
    </nav>
</header>
