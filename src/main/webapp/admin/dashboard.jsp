<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Bookstore</title>
    <%-- Sử dụng CSS riêng cho layout admin --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-layout.css">
    <%-- Nhúng thư viện Chart.js từ CDN --%>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* CSS bổ sung cho dashboard nếu cần */
        .chart-container { margin-top: 30px; background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
    </style>
</head>
<body class="admin-body">

    <%-- Sidebar dùng chung cho admin --%>
    <jsp:include page="admin-sidebar.jsp">
        <jsp:param name="activePage" value="dashboard"/>
    </jsp:include>

    <%-- Khu vực nội dung chính của trang admin --%>
    <div class="admin-main-content">
        <%-- Header dùng chung cho admin --%>
        <jsp:include page="admin-header.jsp" />

        <%-- Nội dung riêng của trang dashboard --%>
        <div class="admin-page-content">
            <h1>Bảng điều khiển</h1>

            <%-- Thẻ thống kê --%>
            <div class="dashboard-cards">
                <div class="card">
                    <h3>Đơn hàng mới</h3>
                    <p class="card-number">${newOrdersCount}</p>
                </div>
                <div class="card revenue">
                    <h3>Doanh thu tháng này</h3>
                    <p class="card-number"><fmt:formatNumber type="number" value="${monthlyRevenue}" pattern="#,##0"/> VNĐ</p>
                </div>
                <div class="card users">
                    <h3>Khách hàng mới (tháng)</h3>
                    <p class="card-number">${newUsersCount}</p>
                </div>
                <div class="card books">
                    <h3>Tổng số sách</h3>
                    <p class="card-number">${totalBooksCount}</p>
                </div>
            </div>

            <%-- Biểu đồ doanh thu --%>
            <div class="chart-container">
                 <h2>Doanh thu 7 ngày gần nhất</h2>
                 <canvas id="revenueChart"></canvas>
            </div>

        </div>

        <%-- Footer dùng chung cho admin --%>
        <jsp:include page="admin-footer.jsp" />
    </div>

    <%-- Script để vẽ biểu đồ (lấy dữ liệu từ AdminDashboardServlet) --%>
    <script>
        const ctx = document.getElementById('revenueChart').getContext('2d');
        const revenueChart = new Chart(ctx, {
            type: 'line', // Kiểu biểu đồ đường
            data: {
                labels: ${chartLabels}, // Nhãn trục X (ngày tháng) từ Servlet
                datasets: [{
                    label: 'Doanh thu (VNĐ)',
                    data: ${chartData}, // Dữ liệu doanh thu từ Servlet
                    borderColor: 'rgb(75, 192, 192)', // Màu đường line
                    backgroundColor: 'rgba(75, 192, 192, 0.2)', // Màu nền dưới đường line
                    fill: true, // Tô màu nền
                    tension: 0.1 // Độ cong của đường line
                }]
            },
            options: {
                responsive: true, // Biểu đồ tự điều chỉnh kích thước
                maintainAspectRatio: false, // Cho phép thay đổi tỷ lệ
                scales: {
                    y: {
                        beginAtZero: true // Bắt đầu trục Y từ 0
                    }
                }
            }
        });
    </script>

</body>
</html>

