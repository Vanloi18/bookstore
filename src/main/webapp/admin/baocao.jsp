<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Báo cáo & Thống kê</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/report-styles.css">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body class="admin-body">
    
    <jsp:include page="admin-sidebar.jsp">
        <jsp:param name="activePage" value="reports" />
    </jsp:include>
    
    <div class="admin-header">
        <button class="mobile-menu-toggle" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i>
        </button>
        <jsp:include page="admin-header.jsp" />
    </div>

    <main class="admin-main-content">
        <div class="admin-page-content">
            
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-chart-pie"></i> Performance Overview
                </h1>
                <div class="export-buttons">
                    <a href="report/export?format=excel" class="btn-export">
                        <i class="fas fa-file-excel"></i> Excel
                    </a>
                    <a href="report/export?format=pdf" class="btn-export">
                        <i class="fas fa-file-pdf"></i> PDF
                    </a>
                </div>
            </div>

            <div class="filter-section">
                <form action="baocao" method="get">
                    <div class="filter-grid">
                        <div class="filter-group">
                            <label>Từ ngày</label>
                            <input type="date" name="fromDate" value="${param.fromDate}">
                        </div>
                        <div class="filter-group">
                            <label>Đến ngày</label>
                            <input type="date" name="toDate" value="${param.toDate}">
                        </div>
                        <div class="filter-group">
                            <label>Thể loại sách</label>
                            <select name="categoryId">
                                <option value="">Tất cả danh mục</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}" ${param.categoryId == cat.id ? 'selected' : ''}>
                                        ${cat.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="filter-group">
                            <label>&nbsp;</label> <button type="submit" class="btn-filter btn-apply">
                                Cập nhật dữ liệu
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="kpi-grid">
                <div class="kpi-card revenue">
                    <div class="kpi-icon"><i class="fas fa-dollar-sign"></i></div>
                    <div class="kpi-content">
                        <h3><fmt:formatNumber value="${totalRevenue}" type="number" maxFractionDigits="0" />₫</h3>
                        <p>Tổng doanh thu</p>
                        <div class="kpi-trend ${revenueTrend >= 0 ? 'up' : 'down'}">
                            <i class="fas fa-arrow-${revenueTrend >= 0 ? 'up' : 'down'}"></i> ${revenueTrend}%
                        </div>
                    </div>
                </div>

                <div class="kpi-card orders">
                    <div class="kpi-icon"><i class="fas fa-shopping-cart"></i></div>
                    <div class="kpi-content">
                        <h3>${totalOrders}</h3>
                        <p>Tổng đơn hàng</p>
                        <div class="kpi-trend ${ordersTrend >= 0 ? 'up' : 'down'}">
                            <i class="fas fa-arrow-${ordersTrend >= 0 ? 'up' : 'down'}"></i> ${ordersTrend}%
                        </div>
                    </div>
                </div>

                <div class="kpi-card books">
                    <div class="kpi-icon"><i class="fas fa-book-open"></i></div>
                    <div class="kpi-content">
                        <h3>${totalBooksSold}</h3>
                        <p>Sách đã bán</p>
                        <div class="kpi-trend up" style="background-color: transparent; padding-left: 0;">
                            <span style="color: #9e9e9e; font-weight: normal; font-size: 0.8rem;">Top: </span>
                            <span style="color: #242424;">${topBook}</span>
                        </div>
                    </div>
                </div>

                <div class="kpi-card customers">
                    <div class="kpi-icon"><i class="fas fa-user-plus"></i></div>
                    <div class="kpi-content">
                        <h3>${newCustomers}</h3>
                        <p>Khách hàng mới</p>
                        <div class="kpi-trend ${customerTrend >= 0 ? 'up' : 'down'}">
                            <i class="fas fa-arrow-${customerTrend >= 0 ? 'up' : 'down'}"></i> ${customerTrend}%
                        </div>
                    </div>
                </div>
            </div>

            <div class="charts-grid">
                <div class="chart-card">
                    <h3>Doanh thu theo thời gian</h3>
                    <div class="chart-container">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
                
                <div class="chart-card">
                    <h3>Tỷ trọng danh mục</h3>
                    <div class="chart-container small">
                        <canvas id="categoryChart"></canvas>
                    </div>
                </div>
            </div>
            
            <div class="chart-card" style="margin-bottom: 40px;">
                <h3>Số lượng đơn hàng</h3>
                <div class="chart-container" style="height: 300px;">
                    <canvas id="ordersChart"></canvas>
                </div>
            </div>
            
            <div class="table-section">
                <h3>Chi tiết báo cáo hàng ngày</h3>
                <table id="reportTable" class="display">
                    <thead>
                        <tr>
                            <th>Ngày báo cáo</th>
                            <th>Đơn hàng</th>
                            <th>Doanh thu (VNĐ)</th>
                            <th>Sách bán chạy nhất</th>
                            <th>Khách mới</th>
                            <th>Hiệu suất</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="daily" items="${dailyReports}">
                            <tr>
                                <td><fmt:formatDate value="${daily.date}" pattern="dd/MM/yyyy" /></td>
                                <td style="font-weight: 600;">${daily.orderCount}</td>
                                <td style="color: #10b981; font-family: monospace; font-size: 1rem;">
                                    <fmt:formatNumber value="${daily.revenue}" type="number" maxFractionDigits="0" />
                                </td>
                                <td>${daily.topBook}</td>
                                <td>${daily.newCustomers}</td>
                                <td>
                                    <span class="kpi-trend up" style="margin:0;">${daily.conversionRate}%</span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
        </div> <jsp:include page="admin-footer.jsp" />
    </main>
    
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    
    <script>
        // Toggle Sidebar
        function toggleSidebar() { document.body.classList.toggle('sidebar-open'); }
        
        // Reset Filter
        function resetFilters() {
            window.location.href = '${pageContext.request.contextPath}/admin/baocao';
        }
        
        // Init DataTable with minimalist settings
        $(document).ready(function() {
            $('#reportTable').DataTable({
                language: { url: '//cdn.datatables.net/plug-ins/1.13.6/i18n/vi.json' },
                order: [[0, 'desc']],
                pageLength: 10,
                lengthChange: false, // Ẩn dropdown chọn số dòng cho gọn
                searching: false     // Ẩn ô search mặc định cho gọn (đã có filter trên)
            });
        });

        /* ================= CHART CONFIGURATION ================= */
        
        // Common Options for clean look
        const commonOptions = {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false // Ẩn legend mặc định để chart thoáng hơn
                },
                tooltip: {
                    backgroundColor: '#242424',
                    padding: 12,
                    cornerRadius: 8,
                    titleFont: { family: "'Inter', sans-serif", size: 13 },
                    bodyFont: { family: "'Inter', sans-serif", size: 13 }
                }
            },
            scales: {
                x: { grid: { display: false }, ticks: { font: { family: "'Inter', sans-serif" } } },
                y: { 
                    border: { display: false }, 
                    grid: { color: '#f0f0f0' },
                    ticks: { font: { family: "'Inter', sans-serif" } }
                }
            },
            elements: {
                line: { tension: 0.4 }, // Smooth curves
                point: { radius: 0, hitRadius: 10, hoverRadius: 4 } // Hide points until hover
            }
        };

        // 1. Revenue Chart (Line - Green)
        new Chart(document.getElementById('revenueChart'), {
            type: 'line',
            data: {
                labels: ${revenueLabels},
                datasets: [{
                    label: 'Doanh thu',
                    data: ${revenueChartData},
                    borderColor: '#10b981', // Green Emerald
                    backgroundColor: 'rgba(16, 185, 129, 0.05)', // Very subtle fill
                    borderWidth: 2,
                    fill: true
                }]
            },
            options: commonOptions
        });

        // 2. Orders Chart (Bar - Blue)
        new Chart(document.getElementById('ordersChart'), {
            type: 'bar',
            data: {
                labels: ${ordersLabels},
                datasets: [{
                    label: 'Số đơn hàng',
                    data: ${ordersChartData},
                    backgroundColor: '#3b82f6', // Blue 500
                    borderRadius: 4,
                    barPercentage: 0.6
                }]
            },
            options: commonOptions
        });

        // 3. Category Chart (Doughnut)
        new Chart(document.getElementById('categoryChart'), {
            type: 'doughnut',
            data: {
                labels: ${categoryLabels},
                datasets: [{
                    data: ${categoryChartData},
                    backgroundColor: ['#3b82f6', '#10b981', '#f59e0b', '#8b5cf6', '#ef4444'],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '75%', // Mỏng hơn cho tinh tế
                plugins: {
                    legend: {
                        position: 'right',
                        labels: { font: { family: "'Inter', sans-serif", size: 12 }, boxWidth: 12 }
                    }
                }
            }
        });
    </script>
</body>
</html>