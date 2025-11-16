<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="main-header">
    <div class="header-container">

        <!-- Logo trái -->
        <div class="header-left">
            <a href="${pageContext.request.contextPath}/home" class="brand-link">
                <span class="brand-title">BookWorld</span>
            </a>
        </div>

        <!-- Menu giữa -->
        <div class="header-center">
            <ul class="nav-menu">
                <li><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/books">Sản Phẩm</a></li>
            </ul>
        </div>

        <!-- User phải -->
        <div class="header-right">

            <c:choose>

                <c:when test="${not empty sessionScope.loggedInUser}">
                    <div class="user-dropdown">
                        <div class="user-trigger">
                            <i class="fas fa-user-circle user-icon"></i>
                            <span>Xin chào, <strong>${sessionScope.loggedInUser.fullname}</strong></span>
                        </div>

                        <ul class="dropdown-menu">
                            <li><a href="${pageContext.request.contextPath}/order-history">Lịch sử mua hàng</a></li>

                            <c:if test="${sessionScope.loggedInUser.isAdmin()}">
                                <li><a href="${pageContext.request.contextPath}/admin/dashboard">Quản trị</a></li>
                            </c:if>

                            <li><a href="${pageContext.request.contextPath}/cart.jsp">Giỏ hàng</a></li>
                            <li><a href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
                        </ul>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="user-dropdown">
                        <div class="user-trigger">
                            <i class="fas fa-user-circle user-icon"></i>
                            <span>Tài khoản</span>
                        </div>

                        <ul class="dropdown-menu">
                            <li><a href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a></li>
                            <li><a href="${pageContext.request.contextPath}/register.jsp">Đăng ký</a></li>
                            <li><a href="${pageContext.request.contextPath}/cart.jsp">Giỏ hàng</a></li>
                        </ul>
                    </div>
                </c:otherwise>

            </c:choose>

        </div>

    </div>
</header>
