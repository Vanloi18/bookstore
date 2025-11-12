<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Người Dùng Mới</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/admin-layout.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body class="admin-body">

    <jsp:include page="admin-sidebar.jsp">
        <jsp:param name="activePage" value="users"/>
    </jsp:include>

    <div class="admin-main-content">
        <jsp:include page="admin-header.jsp" />

        <div class="admin-page-content">
            <h1>Thêm Người Dùng Mới</h1>
            
            <div class="form-container-large">
                <%-- Hiển thị thông báo lỗi nếu có (từ AddUserServlet) --%>
                <c:if test="${not empty errorMessage}">
                    <p class="error-message">${errorMessage}</p>
                </c:if>
            
                <form action="${pageContext.request.contextPath}/admin/add-user" method="post">
                    
                    <div class="form-group">
                        <label for="username">Tên đăng nhập:</label>
                        <input type="text" id="username" name="username" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Mật khẩu:</label>
                        <input type="password" id="password" name="password" required>
                    </div>

                    <div class="form-group">
                        <label for="fullname">Họ và tên:</label>
                        <input type="text" id="fullname" name="fullname">
                    </div>

                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" required>
                    </div>

                    <div class="form-group">
                        <label for="address">Địa chỉ:</label>
                        <input type="text" id="address" name="address">
                    </div>

                    <div class="form-group">
                        <label for="phone">Số điện thoại:</label>
                        <input type="text" id="phone" name="phone">
                    </div>
                    
                    <%-- Thêm Checkbox để chọn vai trò --%>
                    <div class="form-group-checkbox">
                        <input type="checkbox" id="isAdmin" name="isAdmin" value="true">
                        <label for="isAdmin">Đặt làm Quản trị viên (Admin)?</label>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Thêm Người Dùng</button>
                </form>
                 <p style="margin-top: 20px;"><a href="${pageContext.request.contextPath}/admin/manage-users">Quay lại danh sách</a></p>
            </div>
        </div>
    </div>
</body>
</html>