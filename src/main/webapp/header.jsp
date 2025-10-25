<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="main-header glass-header">
    <div class="header-container">
        <!-- Logo / Thương hiệu -->
        <div class="brand">
            <a href="${pageContext.request.contextPath}/home" class="brand-link">
                <h1 class="brand-title">Nhà Sách Online</h1>
            </a>
        </div>

        <!-- Nút menu mobile -->
        <button class="menu-toggle" id="menuToggle" aria-label="Mở menu">
            <i class="fas fa-bars"></i>
        </button>

        <!-- Thanh điều hướng -->
        <nav class="nav-links" id="navLinks">
            <c:set var="loggedInUser" value="${sessionScope.loggedInUser}" />

            <c:if test="${not empty loggedInUser}">
                <span class="user-greeting">
                    Xin chào, <strong>${loggedInUser.fullname}</strong>!
                </span>
                <a href="${pageContext.request.contextPath}/books"
               class="${param.currentPage == 'books' ? 'active' : ''}">Cửa Hàng</a>
                <a href="${pageContext.request.contextPath}/order-history"
                   class="${param.currentPage == 'order-history' ? 'active' : ''}">Lịch sử mua hàng</a>

                <c:if test="${loggedInUser.isAdmin()}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard"
                       class="${param.currentPage == 'admin' ? 'active' : ''}"><strong>Quản Trị</strong></a>
                </c:if>

                <a href="${pageContext.request.contextPath}/cart.jsp"
                   class="${param.currentPage == 'cart' ? 'active' : ''}">Giỏ hàng</a>

                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Đăng xuất</a>
            </c:if>

            <c:if test="${empty loggedInUser}">
                <a href="${pageContext.request.contextPath}/cart.jsp"
                   class="${param.currentPage == 'cart' ? 'active' : ''}">Giỏ hàng</a>
                <a href="${pageContext.request.contextPath}/login.jsp"
                   class="${param.currentPage == 'login' ? 'active' : ''}">Đăng nhập</a>
                <a href="${pageContext.request.contextPath}/register.jsp"
                   class="${param.currentPage == 'register' ? 'active' : ''}">Đăng ký</a>
            </c:if>
        </nav>
    </div>
</header>
