<%-- File: admin-sidebar.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<aside class="admin-sidebar">
    <h2>Bookstore Admin</h2>
    <nav>
        <ul>
            <%-- Dùng param.activePage để highlight link --%>
            <li><a href="${pageContext.request.contextPath}/admin/dashboard" 
                   class="${param.activePage == 'dashboard' ? 'active' : ''}">Tổng quan</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/manage-books" 
                   class="${param.activePage == 'books' ? 'active' : ''}">Quản lý Sách</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/manage-categories" 
                   class="${param.activePage == 'categories' ? 'active' : ''}">Quản lý Thể loại</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/manage-orders" 
                   class="${param.activePage == 'orders' ? 'active' : ''}">Quản lý Đơn hàng</a></li>
             <li><a href="${pageContext.request.contextPath}/admin/manage-users" 
                   class="${param.activePage == 'users' ? 'active' : ''}">Quản lý Người dùng</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
        </ul>
    </nav>
</aside>
