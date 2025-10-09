<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bảng Điều Khiển</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container admin-container">
        <header class="admin-header">
            <h1>Trang Quản Trị</h1>
            <nav class="admin-nav">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="active">Bảng điều khiển</a>
                <a href="${pageContext.request.contextPath}/admin/manage-books">Quản lý sách</a>
                <a href="${pageContext.request.contextPath}/admin/manage-categories">Quản lý thể loại</a>
                <a href="${pageContext.request.contextPath}/admin/manage-orders">Quản lý đơn hàng</a>
                <a href="${pageContext.request.contextPath}/home">Về trang chủ</a>
            </nav>
        </header>

        <main>
            <h2>Tổng quan</h2>
            <div class="dashboard-cards">
                <div class="card">
                    <h3>Tổng số sách</h3>
                    <p class="card-number">${bookCount}</p>
                </div>
                <div class="card">
                    <h3>Tổng số đơn hàng</h3>
                    <p class="card-number">${orderCount}</p>
                </div>
                <div class="card">
                    <h3>Tổng số khách hàng</h3>
                    <p class="card-number">${userCount}</p>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
