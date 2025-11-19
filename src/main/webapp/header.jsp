<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/header.css">
<header class="main-header">
    <div class="header-container">

        <!-- Logo -->
        <div class="header-left">
            <a href="${pageContext.request.contextPath}/home" class="brand-link">
                <span class="brand-title">BookWorld</span>
            </a>
        </div>

        <!-- Menu -->
        <div class="header-center">
            <ul class="nav-menu">
                <li><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/books">Sản Phẩm</a></li>
            </ul>
        </div>

        <!-- Right -->
        <div class="header-right">

            <!-- CART ICON -->
            <a href="${pageContext.request.contextPath}/cart.jsp" class="cart-icon">
                <i class="fas fa-shopping-cart"></i>
                <span class="cart-count">
                    <c:set var="totalQty" value="0" />

                    <c:if test="${not empty sessionScope.cart}">
                        <c:forEach var="item" items="${sessionScope.cart.values()}">
                            <c:set var="totalQty" value="${totalQty + item.quantity}" />
                        </c:forEach>
                    </c:if>

                    ${totalQty}
                </span>
            </a>

            <!-- USER -->
            <c:choose>
                <c:when test="${not empty sessionScope.loggedInUser}">
                    <div class="user-dropdown">
                        <div class="user-trigger">
                            <i class="fas fa-user-circle user-icon"></i>
                            <span>Xin chào, <strong>${sessionScope.loggedInUser.fullname}</strong></span>
                        </div>

                        <ul class="dropdown-menu">
                            <li><a href="${pageContext.request.contextPath}/order-history">Lịch sử mua hàng</a></li>

                            <c:if test="${sessionScope.loggedInUser.admin}">
                                <li><a href="${pageContext.request.contextPath}/admin/dashboard">Quản trị</a></li>
                            </c:if>

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
                        </ul>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </div>
    
</header>
<script>
document.addEventListener("DOMContentLoaded", function () {

    const dropdown = document.querySelector(".user-dropdown");
    const menu = document.querySelector(".dropdown-menu");

    // Click để mở/đóng menu
    dropdown.addEventListener("click", function (e) {
        e.stopPropagation();
        menu.classList.toggle("show");
    });

    // Click ra ngoài để đóng
    document.addEventListener("click", function () {
        menu.classList.remove("show");
    });

});
</script>

