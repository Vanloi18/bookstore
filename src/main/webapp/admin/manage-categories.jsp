<%-- File: manage-categories.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Thể Loại</title>
    
    <%-- ⚠️ SỬA LỖI FONT & ICON: Đồng bộ Font Open Sans và Font Awesome --%>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

    <%-- ⚠️ SỬA LỖI CSS: Nhúng các file CSS chuyên biệt --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/admin-layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components/button.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components/table.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components/form.css"> <%-- Thêm Form CSS --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/categories.css"> 
</head>
<body class="admin-body"> 
    
    <jsp:include page="admin-sidebar.jsp">
        <jsp:param name="activePage" value="categories"/>
    </jsp:include>
    
    <div class="admin-main-content">
        <jsp:include page="admin-header.jsp" />

        <div class="admin-page-content">
            <h2><i class="fas fa-folder-open"></i> Quản lý Thể loại</h2>
            
            <%-- 1. FORM THÊM MỚI --%>
            <div class="card add-form-card">
                <h3>Thêm Thể loại mới</h3>
                <form action="${pageContext.request.contextPath}/admin/add-category" method="post" class="standard-form">
                    <div class="form-group">
                        <input type="text" name="categoryName" placeholder="Nhập tên thể loại..." class="form-input" required>
                        <button type="submit" class="btn btn-primary"><i class="fas fa-plus"></i> Thêm</button>
                    </div>
                </form>
            </div>
            
            <%-- 2. DANH SÁCH BẢNG --%>
            <h2 class="table-heading">Danh sách Thể loại hiện có</h2>
            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th style="width: 10%;">ID</th>
                            <th>Tên Thể loại</th>
                            <th style="width: 25%;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${categoryList}" var="cat">
                            <tr>
                                <td>${cat.id}</td>
                                <td>${cat.name}</td>
                                <td class="action-cell">
                                    <%-- ⚠️ SỬA LỖI URL: Thêm context path --%>
                                    <a href="${pageContext.request.contextPath}/admin/edit-category?id=${cat.id}" class="btn btn-sm btn-info"><i class="fas fa-pen"></i> Sửa</a>
                                    <a href="${pageContext.request.contextPath}/admin/delete-category?id=${cat.id}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa?')"><i class="fas fa-trash-alt"></i> Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                         <c:if test="${empty categoryList}">
                            <tr><td colspan="3" class="text-center-empty">Chưa có thể loại nào được thêm.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        
        <jsp:include page="admin-footer.jsp" />
    </div>
</body>
</html>