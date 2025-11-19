<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sửa Tên Thể Loại</title>
    
    <%-- SỬA: ĐỒNG BỘ CSS với các trang ADMIN khác --%>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/admin-layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components/button.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components/form.css">
</head>
<body class="admin-body">
    
    <jsp:include page="admin-sidebar.jsp">
        <jsp:param name="activePage" value="categories"/>
    </jsp:include>
    
    <div class="admin-main-content">
        <jsp:include page="admin-header.jsp" />

        <main class="admin-page-content">
            <div class="card form-container" style="max-width: 500px; margin: 0 auto;">
                <h2 class="card-header"><i class="fas fa-edit"></i> Sửa Tên Thể Loại</h2>
                
                <div class="card-body">
                    <c:if test="${not empty category}">
                        <form action="${pageContext.request.contextPath}/admin/edit-category" method="post" class="standard-form">
                            <input type="hidden" name="id" value="${category.id}">
                            
                            <div class="form-group">
                                <label for="name">Tên Thể loại:</label>
                                <input type="text" id="name" name="name" value="${category.name}" class="form-input" required>
                            </div>
                            
                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Lưu Thay Đổi</button>
                            </div>
                        </form>
                    </c:if>
                    
                    <c:if test="${empty category}">
                        <p class="error-message">Không tìm thấy thể loại cần sửa hoặc ID không hợp lệ.</p>
                    </c:if>
                </div>
            </div>
            
            <p style="margin-top: 20px;"><a href="${pageContext.request.contextPath}/admin/manage-categories">← Quay lại danh sách</a></p>
        </main>
        
        <jsp:include page="admin-footer.jsp" />
    </div>
</body>
</html>