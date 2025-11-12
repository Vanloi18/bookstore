<%-- File: add-book.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Sách Mới</title>

    <%-- ⚙️ Font + Icons + CSS đồng bộ với manage-books.jsp --%>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

    <%-- CSS Layout & Components --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/admin-layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components/button.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components/form.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/books.css">
</head>

<body class="admin-body">
    <%-- Sidebar trái --%>
    <jsp:include page="admin-sidebar.jsp">
        <jsp:param name="activePage" value="books"/>
    </jsp:include>

    <%-- Nội dung chính --%>
    <div class="admin-main-content">
        <jsp:include page="admin-header.jsp" />

        <div class="admin-page-content">
            <h2><i class="fas fa-plus-circle"></i> Thêm Sách Mới</h2>

            <div class="form-container form-container-large">
                <form action="${pageContext.request.contextPath}/admin/add-book" method="post">
                    <div class="form-group">
                        <label for="title">Tiêu đề:</label>
                        <input type="text" id="title" name="title" required>
                    </div>

                    <div class="form-group">
                        <label for="author">Tác giả:</label>
                        <input type="text" id="author" name="author">
                    </div>

                    <div class="form-group">
                        <label for="price">Giá:</label>
                        <input type="number" id="price" name="price" step="0.01" required>
                    </div>

                    <div class="form-group">
                        <label for="stock">Tồn kho:</label>
                        <input type="number" id="stock" name="stock" value="0">
                    </div>

                    <div class="form-group">
                        <label for="publicationYear">Năm xuất bản:</label>
                        <input type="number" id="publicationYear" name="publicationYear">
                    </div>

                    <div class="form-group">
                        <label for="categoryId">Thể loại:</label>
                        <select name="categoryId" id="categoryId" required>
                            <option value="">-- Chọn thể loại --</option>
                            <c:forEach items="${categoryList}" var="category">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="coverImage">Link ảnh bìa:</label>
                        <input type="text" id="coverImage" name="coverImage" placeholder="images/ten_sach.jpg">
                    </div>

                    <div class="form-group">
                        <label for="description">Mô tả:</label>
                        <textarea id="description" name="description" rows="5"></textarea>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Thêm Sách</button>
                        <a href="${pageContext.request.contextPath}/admin/manage-books" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Quay lại
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="admin-footer.jsp" />
    </div>
</body>
</html>
