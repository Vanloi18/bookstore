<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - BookStore</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/admin-dashboard.css">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body class="admin-body">

    <jsp:include page="admin-sidebar.jsp">
        <jsp:param name="activePage" value="dashboard"/>
    </jsp:include>

    <div class="admin-header">
        <button class="mobile-menu-toggle" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i>
        </button>
        
        <jsp:include page="admin-header.jsp" />
    </div>

    <main class="admin-main-content">
        <div class="admin-page-content">
            
            <div class="page-title-area">
                <h1 class="page-title"><i class="fas fa-tachometer-alt"></i> Tổng quan hệ thống</h1>
                <p class="text-muted">Chào mừng trở lại, quản trị viên!</p>
            </div>

            <div class="dashboard-grid">
                <div class="card green">
                    <div class="card-info">
                        <h3><fmt:formatNumber value="${totalRevenue}" type="number" maxFractionDigits="0"/>₫</h3>
                        <p>Tổng doanh thu</p>
                    </div>
                    <div class="card-icon"><i class="fas fa-coins"></i></div>
                </div>

                <div class="card blue">
                    <div class="card-info">
                        <h3>${totalOrders}</h3>
                        <p>Tổng đơn hàng</p>
                    </div>
                    <div class="card-icon"><i class="fas fa-shopping-cart"></i></div>
                </div>

                <div class="card orange">
                    <div class="card-info">
                        <h3>${pendingOrders}</h3>
                        <p>Đơn chờ xử lý</p>
                    </div>
                    <div class="card-icon"><i class="fas fa-clock"></i></div>
                </div>

                <div class="card red">
                    <div class="card-info">
                        <h3>${lowStockBooks}</h3>
                        <p>Sách sắp hết (<5)</p>
                    </div>
                    <div class="card-icon"><i class="fas fa-exclamation-triangle"></i></div>
                </div>
            </div>

            <div class="charts-container">
                <div class="chart-box">
                    <h3><i class="fas fa-chart-line" style="color:#2ecc71"></i> Doanh thu năm nay</h3>
                    <div class="chart-wrapper">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>

                <div class="chart-box">
                    <h3><i class="fas fa-box" style="color:#3498db"></i> Đơn hàng tuần qua</h3>
                    <div class="chart-wrapper">
                        <canvas id="ordersChart"></canvas>
                    </div>
                </div>
            </div>

        </div>
        
        <jsp:include page="admin-footer.jsp" />
    </main>

    <script>
        // 1. Toggle Sidebar Mobile
        function toggleSidebar() {
            document.body.classList.toggle('sidebar-open');
        }

        // 2. Dữ liệu biểu đồ từ Servlet
        const revenueData = ${not empty revenueChartData ? revenueChartData : '[0,0,0,0,0,0,0,0,0,0,0,0]'};
        const orderLabels = ${not empty orderLabels ? orderLabels : '["T2","T3","T4","T5","T6","T7","CN"]'};
        const orderData = ${not empty orderData ? orderData : '[0,0,0,0,0,0,0]'};

        // 3. Vẽ Chart Doanh thu
        new Chart(document.getElementById('revenueChart'), {
            type: 'line',
            data: {
                labels: ['T1','T2','T3','T4','T5','T6','T7','T8','T9','T10','T11','T12'],
                datasets: [{
                    label: 'Doanh thu (VNĐ)',
                    data: revenueData,
                    borderColor: '#2ecc71',
                    backgroundColor: 'rgba(46, 204, 113, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });

        // 4. Vẽ Chart Đơn hàng
        new Chart(document.getElementById('ordersChart'), {
            type: 'bar',
            data: {
                labels: orderLabels,
                datasets: [{
                    label: 'Số đơn hàng',
                    data: orderData,
                    backgroundColor: '#3498db',
                    borderRadius: 4
                }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });
    </script>
</body>
</html>