<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Người Dùng | Admin Dashboard</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/admin-layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components/button.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/users.css">
</head>
<body class="admin-body">

    <jsp:include page="admin-sidebar.jsp">
        <jsp:param name="activePage" value="users" />
    </jsp:include>

    <div class="admin-main-content">
        <jsp:include page="admin-header.jsp" />

        <div class="admin-page-content">
            
            <div class="page-header">
                <div class="header-title">
                    <h2>Quản Lý Người Dùng</h2>
                    <span class="badge-count">${userList.size()} thành viên</span>
                </div>
                
                <div class="header-actions">
                    <form action="${pageContext.request.contextPath}/admin/manage-users" method="get" class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" name="keyword" placeholder="Tìm tên, email..." value="${param.keyword}">
                    </form>

                    <a href="${pageContext.request.contextPath}/admin/add-user" class="btn btn-primary btn-add">
                        <i class="fas fa-plus"></i> <span>Thêm mới</span>
                    </a>
                </div>
            </div>

            <div class="table-card">
                <table class="modern-table">
                    <thead>
                        <tr>
                            <th width="5%">ID</th>
                            <th width="25%">Người dùng</th> <th width="15%">Liên hệ</th>
                            <th width="15%">Ngày tham gia</th>
                            <th width="15%">Vai trò</th>
                            <th width="10%" class="text-right">Tác vụ</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${userList}" var="user">
                            <tr>
                                <td><span class="id-hash">#${user.id}</span></td>
                                
                                <td>
                                    <div class="user-info">
                                        <div class="avatar-circle">
                                            ${fn:substring(user.fullname, 0, 1)}
                                        </div>
                                        <div class="user-details">
                                            <span class="user-name">${user.fullname}</span>
                                            <span class="user-email">${user.email}</span>
                                        </div>
                                    </div>
                                </td>

                                <td>
                                    <div class="contact-info">
                                        <span class="phone"><i class="fas fa-phone-alt"></i> ${user.phone}</span>
                                        <span class="address" title="${user.address}"><i class="fas fa-map-marker-alt"></i> ${fn:substring(user.address, 0, 20)}...</span>
                                    </div>
                                </td>

                                <td>
                                    <span class="date-text">
                                        <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy"/>
                                    </span>
                                </td>

                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/update-user-role" method="post" id="role-form-${user.id}">
                                        <input type="hidden" name="userId" value="${user.id}">
                                        <div class="select-wrapper">
                                            <select name="isAdmin" 
                                                class="role-badge ${user.isAdmin() ? 'role-admin' : 'role-user'}"
                                                onchange="this.form.submit()">
                                                <option value="false" ${!user.isAdmin() ? 'selected' : ''}>Khách hàng</option>
                                                <option value="true" ${user.isAdmin() ? 'selected' : ''}>Quản trị viên</option>
                                            </select>
                                            <i class="fas fa-chevron-down select-icon"></i>
                                        </div>
                                    </form>
                                </td>

                                <td class="text-right">
                                    <a href="${pageContext.request.contextPath}/admin/delete-user?id=${user.id}" 
                                       class="btn-icon delete"
                                       onclick="return confirm('Cảnh báo: Hành động này không thể hoàn tác. Xóa user ${user.username}?')">
                                        <i class="far fa-trash-alt"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty userList}">
                            <tr>
                                <td colspan="6" class="empty-state">
                                    <img src="${pageContext.request.contextPath}/images/empty-user.png" alt="No data">
                                    <p>Không tìm thấy người dùng nào.</p>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
            
        </div>
        <jsp:include page="admin-footer.jsp" />
    </div>
</body>
</html>