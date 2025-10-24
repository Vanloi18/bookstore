<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Người Dùng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-layout.css">
</head>
<body class="admin-body">

    <jsp:include page="admin-sidebar.jsp">
        <jsp:param name="activePage" value="users"/>
    </jsp:include>

    <div class="admin-main-content">
        <jsp:include page="admin-header.jsp" />

        <div class="admin-page-content">
            <h1>Quản Lý Người Dùng</h1>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Họ tên</th>
                        <th>Email</th>
                        <th>Địa chỉ</th>
                        <th>Điện thoại</th>
                        <th>Ngày tạo</th>
                        <th>Vai trò</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${userList}" var="user">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.username}</td>
                            <td>${user.fullname}</td>
                            <td>${user.email}</td>
                            <td>${user.address}</td>
                            <td>${user.phone}</td>
                            <td><fmt:formatDate value="${user.createdAt}" pattern="dd-MM-yyyy"/></td>
                            <td>
                                <%-- Form để thay đổi vai trò --%>
                                <form action="${pageContext.request.contextPath}/admin/update-user-role" method="post" style="display:inline;">
                                    <input type="hidden" name="userId" value="${user.id}">
                                    <select name="isAdmin" onchange="this.form.submit()">
                                        <option value="false" ${!user.isAdmin() ? 'selected' : ''}>User</option>
                                        <option value="true" ${user.isAdmin() ? 'selected' : ''}>Admin</option>
                                    </select>
                                    <%-- Thêm nút ẩn để submit form khi chọn select --%>
                                     <button type="submit" style="display:none;"></button>
                                </form>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/delete-user?id=${user.id}"
                                   class="btn-action btn-delete"
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này? Hành động này không thể hoàn tác.')">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty userList}">
                        <tr>
                            <td colspan="9" style="text-align: center;">Không có người dùng nào.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <jsp:include page="admin-footer.jsp" />
    </div>
</body>
</html>
