<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bảng Điều Khiển</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

    
</head>
<script>
window.addEventListener("scroll", () => {
    const header = document.querySelector(".main-header");
    if (window.scrollY > 10) header.classList.add("scrolled");
    else header.classList.remove("scrolled");
});
</script>
<body>
    <div class="container admin-container">
        <header class="main-header">
    <div class="logo-section">
         <a href="${pageContext.request.contextPath}/home" class="logo-text">
        <span class="b-part">Book</span><span class="s-part">Store</span>
            <img src="${pageContext.request.contextPath}/images/logo_icon.jpg" alt="icon" class="logo-icon">
        </a>
    </div>

    <nav class="nav-links">
        <a href="${pageContext.request.contextPath}/admin/dashboard">🧑‍💻TRANG ADMIN</a>
        <a href="${pageContext.request.contextPath}/admin/manage-books">📚 QUẢN LÝ SÁCH</a>
        <a href="${pageContext.request.contextPath}/admin/manage-categories">🏷️ QUẢN LÝ THỂ LOẠI</a>
        <a href="${pageContext.request.contextPath}/admin/manage-orders">🛒 QUẢN LÝ ĐƠN HÀNG</a>
        <a href="${pageContext.request.contextPath}/home">🏠Trang chủ</a>
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
