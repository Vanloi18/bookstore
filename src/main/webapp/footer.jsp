<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer class="main-footer">
    <div class="footer-container">

        <!-- Logo & Brand -->
        <div class="footer-logo">
            <img src="${pageContext.request.contextPath}/images/logo-new.png" 
                 alt="Logo Nhà Sách Online" class="footer-logo-img">
            <h3>Nhà Sách Online</h3>
        </div>

        <!-- Navigation Links -->
        <div class="footer-links">
            <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/books">Sản phẩm</a>
            <a href="${pageContext.request.contextPath}/home">Giới thiệu</a>
        </div>

        <!-- Contact -->
        <div class="footer-contact">
            <p>Email: 
                <a href="mailto:contact@nhasachonline.com">
                    contact@nhasachonline.com
                </a>
            </p>
            <p>Hotline: 0123 456 789</p>
        </div>
    </div>

    <div class="footer-bottom">
        <p>© 2025 Nhà Sách Online. Thiết kế bởi <strong>Nhóm 6</strong>.</p>
    </div>
</footer>
