<%-- File: header.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div style="display: flex; justify-content: space-between; align-items: center; padding: 10px; background-color: #f8f8f8; border-bottom: 1px solid #ddd;">
    <div>
        <a href="${pageContext.request.contextPath}/home" style="text-decoration: none; color: black; font-weight: bold;">Nhà Sách Online</a>
    </div>
    
    <div>
        <c:set var="loggedInUser" value="${sessionScope.loggedInUser}" />

        <%-- Nếu người dùng đã đăng nhập --%>
        <c:if test="${not empty loggedInUser}">
            <span>Xin chào, <strong>${loggedInUser.fullname}</strong>!</span> &nbsp;|&nbsp;
            
            <%-- Nếu là admin thì hiển thị link trang quản trị --%>
            <c:if test="${loggedInUser.isAdmin()}">
                <a href="${pageContext.request.contextPath}/admin/manage-books"><strong>Trang Quản Trị</strong></a> &nbsp;|&nbsp;
            </c:if>

            <a href="${pageContext.request.contextPath}/cart.jsp">Giỏ hàng</a> &nbsp;|&nbsp;
            <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
        </c:if>

        <%-- Nếu người dùng chưa đăng nhập --%>
        <c:if test="${empty loggedInUser}">
            <a href="${pageContext.request.contextPath}/cart.jsp">Giỏ hàng</a> &nbsp;|&nbsp;
            <a href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a> &nbsp;|&nbsp;
            <a href="${pageContext.request.contextPath}/register.jsp">Đăng ký</a>
        </c:if>
    </div>
</div>