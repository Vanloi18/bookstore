<%-- File: header.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <link rel="stylesheet" 
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@700&display=swap" rel="stylesheet">

</head>


<header class="main-header">
    <div class="brand">
    <a href="${pageContext.request.contextPath}/home" class="logo-text">
        <span class="b-part">Book</span><span class="s-part">Store</span>
        <img src="${pageContext.request.contextPath}/images/logo_icon.jpg" alt="icon" class="logo-icon">
    </a>
</div>


    
    <nav>
        <c:set var="loggedInUser" value="${sessionScope.loggedInUser}" />

        <%-- Nếu người dùng đã đăng nhập --%>
        <c:if test="${not empty loggedInUser}">
            <span>Xin chào, <strong>${loggedInUser.fullname}</strong>!</span>
            <a href="${pageContext.request.contextPath}/order-history">Lịch sử mua hàng</a>
           
            <c:if test="${loggedInUser.isAdmin()}">
                <a href="${pageContext.request.contextPath}/admin/manage-books">Trang quản trị</a>
            </c:if>
 <!-- Icon giỏ hàng -->
            <a href="${pageContext.request.contextPath}/cart.jsp" class="cart-icon">
                <i class="fa-solid fa-cart-shopping"></i>
                <c:if test="${not empty cart}">
                    <span class="cart-count">${cart.size()}</span>
                </c:if>
            </a>
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

.