<%-- /WEB-INF/views/admin/common/admin_header.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- 
    Sử dụng một biến 'pageName' được truyền từ trang cha 
    để xác định link nào đang active.
--%>
<header class="main-header">
    <div class="logo-section">
        <a href="${pageContext.request.contextPath}/home" class="logo-text">
            <span class="b-part">Book</span><span class="s-part">Store</span>
            <img src="${pageContext.request.contextPath}/images/logo_icon.jpg" alt="icon" class="logo-icon">
        </a>
    </div>

    <nav class="nav-links">
        <a href="${pageContext.request.contextPath}/admin/dashboard" 
           class="${param.currentPage == 'dashboard' ? 'active' : ''}">🧑‍💻TRANG ADMIN</a>
           
        <a href="${pageContext.request.contextPath}/admin/manage-books" 
           class="${param.currentPage == 'books' ? 'active' : ''}">📚 QUẢN LÝ SÁCH</a>
           
        <a href="${pageContext.request.contextPath}/admin/manage-categories" 
           class="${param.currentPage == 'categories' ? 'active' : ''}">🏷️ QUẢN LÝ THỂ LOẠI</a>
           
        <a href="${pageContext.request.contextPath}/admin/manage-orders" 
           class="${param.currentPage == 'orders' ? 'active' : ''}">🛒 QUẢN LÝ ĐƠN HÀNG</a>
           
        <a href="${pageContext.request.contextPath}/home">🏠Trang chủ</a>
    </nav>
</header>