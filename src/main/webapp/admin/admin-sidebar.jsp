<%-- File: admin-sidebar.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<aside class="admin-sidebar">
    <div class="sidebar-header">
        <i class="fas fa-book logo-icon"></i>
        <h2>Bookstore Admin</h2>
    </div>

    <%-- 2. Menu chính --%>
    <ul class="main-menu">

            <%-- Đặt class 'active' lên thẻ <li> để dễ dàng style toàn bộ dòng --%>
            <li class="${param.activePage == 'dashboard' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-tachometer-alt"></i> Tổng quan
                </a>
            </li>
            <li class="${param.activePage == 'books' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/admin/manage-books">
                    <i class="fas fa-book"></i> Quản lý Sách
                </a>
            </li>
            <li class="${param.activePage == 'categories' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/admin/manage-categories">
                    <i class="fas fa-folder-open"></i> Quản lý Thể loại
                </a>
            </li>
            <li class="${param.activePage == 'orders' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/admin/manage-orders">
                    <i class="fas fa-shopping-cart"></i> Quản lý Đơn hàng
                </a>
            </li>
             <li class="${param.activePage == 'users' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/admin/manage-users">
                    <i class="fas fa-users"></i> Quản lý Người dùng
                </a>
            </li>
             <li class="${param.activePage == 'reports' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/admin/baocao">
                    <i class="fas fa-chart-bar"></i> Báo cáo / Thống kê
                </a>
            </li>
             <li class="${param.activePage == 'settings' ? 'active' : ''}">
                <a href="${pageContext.request.contextPath}/home">
                    <i class="fas fa-cog"></i> Về home
                </a>
            </li>
        </ul>
    
    <%-- 3. Mục hành động phụ (Đăng xuất) --%>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout">
            <i class="fas fa-sign-out-alt"></i> Đăng xuất
        </a>
    </div>
</aside>