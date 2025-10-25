<%-- File: manage-books.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Sách</title>
    
    <%-- ⚠️ SỬA LỖI FONT: Đồng bộ font với Open Sans/Roboto --%>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

    <%-- ⚠️ SỬA LỖI CSS: Nhúng các file CSS chuyên biệt theo cấu trúc Admin --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/admin-layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components/button.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components/table.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/books.css"> 
</head>
<body class="admin-body"> <%-- Thêm admin-body để áp dụng style layout --%>
    <%-- Chỉ nhúng nội dung chính, layout đã được quản lý bởi admin-layout.css --%>
    
    <jsp:include page="admin-sidebar.jsp">
        <jsp:param name="activePage" value="books"/>
    </jsp:include>
    
    <div class="admin-main-content">
        <jsp:include page="admin-header.jsp" />

        <div class="admin-page-content">
            <h2><i class="fas fa-book"></i> Quản lý Sách</h2>

            <%-- Khu vực tìm kiếm và thêm mới --%>
            <div class="action-bar"> 
                 <a href="${pageContext.request.contextPath}/admin/add-book" class="btn btn-primary"><i class="fas fa-plus"></i> Thêm Sách Mới</a>
                 
                 <div class="search-filter">
                    <input type="text" placeholder="Tìm kiếm sách..." class="input-search">
                    <%-- Dropdown lọc (tùy chọn) --%>
                 </div>
            </div>

            <div class="table-responsive">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tiêu đề</th>
                            <th>Tác giả</th>
                            <th>Giá</th>
                            <th>Tồn kho</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${bookList}" var="book">
                            <tr>
                                <td>${book.id}</td>
                                <td>${book.title}</td>
                                <td class="text-secondary">${book.author}</td>
                                <td class="text-price"><fmt:formatNumber type="number" value="${book.price}" /> VNĐ</td>
                                <td class="text-stock">${book.stock}</td>
                                <td class="action-cell">
                                    <a href="${pageContext.request.contextPath}/admin/edit-book?id=${book.id}" class="btn btn-sm btn-info">Sửa</a>
                                    <a href="${pageContext.request.contextPath}/admin/delete-book?id=${book.id}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa sách có ID ${book.id} không?')">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty bookList}">
                            <tr><td colspan="6" class="text-center-empty">Chưa có sách nào trong hệ thống.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
            
        </div>
        
        <jsp:include page="admin-footer.jsp" />
    </div>
</body>
</html>