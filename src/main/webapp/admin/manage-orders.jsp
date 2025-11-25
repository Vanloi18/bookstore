<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Đơn Hàng | Admin Dashboard</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/admin-layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components/button.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/orders.css">
</head>
<body class="admin-body">

    <jsp:include page="admin-sidebar.jsp">
        <jsp:param name="activePage" value="orders" />
    </jsp:include>

    <div class="admin-main-content">
        <jsp:include page="admin-header.jsp" />

        <div class="admin-page-content">
            
            <div class="page-header">
                <div class="header-title">
                    <h2>Quản Lý Đơn Hàng</h2>
                    <span class="badge-count">${orderList.size()} đơn hàng</span>
                </div>
            </div>

            <div class="filter-toolbar">
                <form action="${pageContext.request.contextPath}/admin/manage-orders" method="get" class="filter-form">
                    
                    <div class="search-group">
                        <i class="fas fa-search search-icon"></i>
                        <input type="text" name="keyword" value="${keyword}" placeholder="Mã đơn, tên khách, số điện thoại..." class="modern-input">
                    </div>

                    <div class="select-group">
                        <select name="status" class="modern-select" onchange="this.form.submit()">
                            <option value="">Tất cả trạng thái</option>
                            <option value="Pending" ${status == 'Pending' ? 'selected' : ''}>⏳ Chờ xử lý</option>
                            <option value="Shipping" ${status == 'Shipping' ? 'selected' : ''}>🚚 Đang giao</option>
                            <option value="Completed" ${status == 'Completed' ? 'selected' : ''}>✅ Hoàn thành</option>
                            <option value="Cancelled" ${status == 'Cancelled' ? 'selected' : ''}>❌ Đã hủy</option>
                        </select>
                        <i class="fas fa-chevron-down select-arrow"></i>
                    </div>

                    <button type="submit" class="btn btn-primary btn-filter">Lọc</button>
                </form>
            </div>

            <div class="table-card">
                <table class="modern-table">
                    <thead>
                        <tr>
                            <th width="12%">Mã đơn</th>
                            <th width="20%">Khách hàng</th>
                            <th width="25%">Địa chỉ giao nhận</th>
                            <th width="15%">Tổng tiền</th>
                            <th width="15%">Trạng thái</th>
                            <th width="13%" class="text-right">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orderList}" var="order">
                            <tr>
                                <td>
                                    <div class="order-id-group">
                                        <span class="id-hash">#${order.id}</span>
                                        <span class="order-date">
                                            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM HH:mm"/>
                                        </span>
                                    </div>
                                </td>

                                <td>
								    <div class="user-info">
								        <div class="avatar-mini">
								            <i class="fas fa-user"></i>
								        </div>
								        <div class="user-details">
								            <span class="user-name">${order.userName}</span>
								            <span class="user-sub-id">ID: ${order.userId}</span>
								        </div>
								    </div>
								</td>

                                <td>
                                    <div class="address-text" title="${order.shippingAddress}">
                                        <i class="fas fa-map-marker-alt"></i> 
                                        ${fn:substring(order.shippingAddress, 0, 40)}${fn:length(order.shippingAddress) > 40 ? '...' : ''}
                                    </div>
                                </td>

                                <td>
                                    <span class="price-tag">
                                        <fmt:formatNumber type="number" value="${order.totalAmount}" /> ₫
                                    </span>
                                </td>

                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/update-order-status" method="post" id="form-${order.id}">
                                        <input type="hidden" name="orderId" value="${order.id}">
                                        
                                        <div class="status-wrapper">
                                            <select name="status" 
                                                class="status-badge status-${order.status}" 
                                                onchange="document.getElementById('form-${order.id}').submit()">
                                                <option value="Pending" ${order.status == 'Pending' ? 'selected' : ''}>Chờ xử lý</option>
                                                <option value="Shipping" ${order.status == 'Shipping' ? 'selected' : ''}>Đang giao</option>
                                                <option value="Completed" ${order.status == 'Completed' ? 'selected' : ''}>Hoàn thành</option>
                                                <option value="Cancelled" ${order.status == 'Cancelled' ? 'selected' : ''}>Đã hủy</option>
                                            </select>
                                        </div>
                                    </form>
                                </td>

                                <td class="text-right">
                                    <a href="${pageContext.request.contextPath}/admin/view-order-detail?id=${order.id}" class="btn-view-detail">
                                        Chi tiết <i class="fas fa-arrow-right"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty orderList}">
                            <tr>
                                <td colspan="6" class="empty-state">
                                    <div class="empty-content">
                                        <img src="${pageContext.request.contextPath}/images/empty-box.png" alt="No orders" style="width: 60px; opacity: 0.5;">
                                        <p>Chưa có dữ liệu đơn hàng nào.</p>
                                    </div>
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