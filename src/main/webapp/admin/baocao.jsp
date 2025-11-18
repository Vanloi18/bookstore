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

  
            <!-- KPI Cards -->
            <div class="row kpi-row">
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="card kpi-card">
                        <div class="card-body">
                            <div class="kpi-icon"><i class="fas fa-shopping-cart"></i></div>
                            <div class="kpi-detail">
                                <h4 id="kpi-total-orders">0</h4>
                                <p>Tổng đơn hàng</p>
                             
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
                              
                            </div>
                        </div>
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


        <jsp:include page="admin-footer.jsp" />
    </div>

    <!-- JS -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="${pageContext.request.contextPath}/js/report-charts.js"></script>
</body>
</html>
