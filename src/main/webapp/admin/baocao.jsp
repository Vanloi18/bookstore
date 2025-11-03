<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Báo cáo thống kê | Bookstore Admin</title>

    <!-- Font và Icon -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- CSS Layout & Component -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/admin-layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components/button.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components/table.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/report-styles.css">

    <style>
        /* Đảm bảo layout không bị trôi */
        .admin-main-content {
            margin-left: 250px;
            padding: 20px;
        }
        .admin-page-content {
            background: #fff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            min-height: 100vh;
        }
        .filter-actions {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        }
        .chart-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        canvas {
            width: 100% !important;
            height: auto !important;
        }
    </style>
</head>

<body class="admin-body">
    <!-- Sidebar -->
    <jsp:include page="admin-sidebar.jsp">
        <jsp:param name="activePage" value="baocao" />
    </jsp:include>

    <!-- Main Content -->
    <div class="admin-main-content">
        <jsp:include page="admin-header.jsp" />

        <div class="admin-page-content">
            <h2><i class="fas fa-chart-line"></i> Báo cáo / Thống kê</h2>
            <p>Tổng quan và phân tích dữ liệu bán hàng</p>

            <!-- Bộ lọc -->
            <div class="filter-actions">
                <select class="form-control filter-select">
                    <option>30 ngày gần nhất</option>
                    <option>7 ngày gần nhất</option>
                    <option>90 ngày gần nhất</option>
                </select>
                <select class="form-control filter-select">
                    <option>Tất cả thể loại</option>
                </select>
                <button class="btn btn-success btn-export excel"><i class="fas fa-file-excel"></i> Xuất Excel</button>
                <button class="btn btn-danger btn-export pdf"><i class="fas fa-file-pdf"></i> Xuất PDF</button>
            </div>

            <!-- KPI Cards -->
            <div class="row kpi-row">
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card kpi-card">
                        <div class="card-body">
                            <div class="kpi-icon"><i class="fas fa-shopping-cart"></i></div>
                            <div class="kpi-detail">
                                <h4 id="kpi-total-orders">0</h4>
                                <p>Tổng đơn hàng</p>
                                <span class="change-rate text-success">+0%</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card kpi-card">
                        <div class="card-body">
                            <div class="kpi-icon"><i class="fas fa-dollar-sign"></i></div>
                            <div class="kpi-detail">
                                <h4 id="kpi-total-revenue">0</h4>
                                <p>Tổng doanh thu (30 ngày)</p>
                                <span class="change-rate text-success">+0%</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card kpi-card">
                        <div class="card-body">
                            <div class="kpi-icon"><i class="fas fa-book"></i></div>
                            <div class="kpi-detail">
                                <h4 id="kpi-books-sold">0</h4>
                                <p>Sách đã bán</p>
                                <span class="change-rate text-success">+0%</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card kpi-card">
                        <div class="card-body">
                            <div class="kpi-icon"><i class="fas fa-percent"></i></div>
                            <div class="kpi-detail">
                                <h4 id="kpi-conversion-rate">0%</h4>
                                <p>Tỷ lệ chuyển đổi</p>
                                <span class="change-rate text-success">+0%</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Charts -->
            <div class="row charts-row">
                <div class="col-lg-6 mb-4">
                    <div class="card chart-card">
                        <div class="card-header">Xu hướng Doanh thu (7 ngày gần nhất)</div>
                        <div class="card-body">
                            <canvas id="revenueTrendChart"></canvas>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6 mb-4">
                    <div class="card chart-card">
                        <div class="card-header">Phân bổ Doanh thu theo Thể loại</div>
                        <div class="card-body row">
                            <div class="col-8" id="category-list"></div>
                            <div class="col-4 d-flex align-items-center justify-content-center">
                                <canvas id="categoryDistributionChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stats -->
            <div class="row stats-row">
                <div class="col-lg-6 mb-4">
                    <div class="card chart-card">
                        <div class="card-header">Thống kê Trạng thái Đơn hàng</div>
                        <div class="card-body">
                            <canvas id="orderStatusChart"></canvas>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6 mb-4">
                    <div class="card list-card">
                        <div class="card-header">Đơn hàng gần đây</div>
                        <div class="card-body" id="recent-orders-list">
                            <p class="text-center text-muted">Đang tải...</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="admin-footer.jsp" />
    </div>

    <!-- JS -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="${pageContext.request.contextPath}/js/report-charts.js"></script>
</body>
</html>
