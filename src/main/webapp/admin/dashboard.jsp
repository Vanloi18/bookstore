<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard - Bookstore</title>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" 
          integrity="sha512-..." crossorigin="anonymous" />
          
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/admin-layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/admin-dashboard.css">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>

/* ĐÃ SỬA LỖI CÚ PHÁP CSS BỔ SUNG TRONG STYLE TAG */
.chart-container { 
    margin-top: 30px; 
    background: #fff; 
    padding: 20px; 
    border-radius: 8px; 
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    height: 400px; /* Đảm bảo chiều cao tối thiểu cho biểu đồ hiển thị tốt */
}
/* Định kiểu tiêu đề bảng (header) */

.list-card .card-header h2 {

font-size: 1.2em;

font-weight: 600;

margin-top: 0;

margin-bottom: 15px;

padding-bottom: 10px;

border-bottom: 1px solid #f1f1f1;

}

/* Trong admin-dashboard.css (hoặc table.css) */



.list-card .table {

width: 100%;

border-collapse: collapse; /* Gộp các đường viền bảng */

margin-bottom: 0;

}
.list-card .table th,
.list-card .table td {

padding: 10px 0; /* Giảm padding ngang (hoặc thêm nếu cần) */
text-align: left;
/* Phân chia các cột */
width: 50%; /* Có thể dùng để chia đều Tên Sách và Số Lượng Bán */
border-bottom: 1px solid #eee; /* Đường kẻ phân cách hàng */

}

.list-card .table th {

font-weight: 700;
color: #6c757d;
text-transform: uppercase;
font-size: 0.85em;
}

/* ĐÃ SỬA LỖI CÚ PHÁP CSS BỔ SUNG TRONG STYLE TAG */

.chart-container {

margin-top: 30px;
background: #fff;
padding: 20px;
border-radius: 8px;
box-shadow: 0 2px 5px rgba(0,0,0,0.1);
height: 400px; /* Đảm bảo chiều cao tối thiểu cho biểu đồ hiển thị tốt */

}

/* Ví dụ: Thêm vào cuối admin-layout.css hoặc admin-dashboard.css */

/* Đảm bảo nội dung chính nằm sau sidebar */

.admin-main-content {

margin-left: 230px !important; /* Dùng !important nếu bị ghi đè */

padding-top: 60px; /* Đảm bảo không bị chèn bởi Header (height: 60px) */

}

/* Đảm bảo vùng nội dung trang có padding bên trái */

.admin-page-content {

/* ... */

padding: 25px 40px; /* Đảm bảo padding trái lớn hơn 20px */

} 
/* Căn lề phải cho phần Top 5 Sách và Đơn hàng gần đây */
.stats-row {
    display: flex;
    justify-content: space-between;
    margin-left: 250px;   /* 👈 Lùi toàn bộ sang phải bằng với phần nội dung chính */
    margin-right: 40px;
    gap: 30px;            /* Tạo khoảng cách giữa 2 cột */
}

/* Cố định độ rộng của mỗi khối */
.stats-row .list-card {
    flex: 1;
    background: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

</style>
</head>
<body class="admin-body">

	<%-- Sidebar dùng chung cho admin --%>
	<jsp:include page="admin-sidebar.jsp">
		<jsp:param name="activePage" value="dashboard" />
	</jsp:include>

	<%-- Khu vực nội dung chính của trang admin --%>
	<div class="admin-main-content">
		<%-- Header dùng chung cho admin --%>
		<jsp:include page="admin-header.jsp" />

		<%-- Nội dung riêng của trang dashboard --%>
		<div class="admin-page-content">
			<h1>Bảng Điều Khiển Chính</h1>

			<%-- Thẻ thống kê --%>
			<div class="dashboard-cards">
			
				<%-- Thẻ 1: Đơn hàng mới (Sử dụng biến newOrdersCount) [cite: 3] --%>
				<div class="card">
					<h3>Đơn hàng mới</h3>
					<p class="card-number">${newOrdersCount}</p>
				</div>
				
				<%-- Thẻ 2: Doanh thu tháng này (Sử dụng biến monthlyRevenue) [cite: 3] --%>
				<div class="card revenue">
					<h3>Doanh thu tháng này</h3>
					<p class="card-number">
						<fmt:formatNumber type="number" value="${monthlyRevenue}"
							pattern="#,##0" />
						VNĐ
					</p>
				</div>
				
				<%-- Thẻ 3: Khách hàng mới (Sử dụng biến newUsersCount) [cite: 3] --%>
				<div class="card users">
					<h3>Khách hàng mới (tháng)</h3>
					<p class="card-number">${newUsersCount}</p>
				</div>
				
				<%-- Thẻ 4: Tổng số sách (Sử dụng biến totalBooksCount) [cite: 3] --%>
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

<%-- Bổ sung khu vực 2 cột dưới biểu đồ --%>
<div class="stats-row">
    
    <%-- Cột 1: Top 5 Sách Bán Chạy --%>
    <div class="list-card" >
        <div class="card-header">
            <h2><i class="fas fa-chart-bar"></i> Top 5 Sách Bán Chạy nhất</h2>
        </div>
        <div class="card-body">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Tên Sách</th>
                        <th>Số Lượng Bán</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- Lặp qua danh sách topSellingBooks --%>
                    <c:forEach var="book" items="${topSellingBooks}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>${book.title}</td>
                            <td>${book.total_sold}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty topSellingBooks}">
                        <tr>
                            <td colspan="3" class="text-center text-muted">Chưa có dữ liệu bán hàng.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    
    <%-- Cột 2: Đơn hàng Gần đây --%>
    <div class="list-card">
        <div class="card-header">
            <h2><i class="fas fa-history"></i> Đơn hàng Gần đây</h2>
        </div>
        <div class="card-body">
            <%-- Cần bổ sung logic lặp qua danh sách đơn hàng gần đây --%>
            <p class="text-center text-muted">Cần bổ sung logic cho Đơn hàng Gần đây</p>
        </div>
    </div>
    
</div>

		<%-- Footer dùng chung cho admin --%>
		<jsp:include page="admin-footer.jsp" />
	</div>


	<%-- Script để vẽ biểu đồ (lấy dữ liệu từ AdminDashboardServlet) [cite: 4] --%>
	<script>
        document.addEventListener('DOMContentLoaded', function() {
            const ctx = document.getElementById('revenueChart').getContext('2d');
            
            // Dữ liệu ${chartLabels} và ${chartData} được Servlet truyền dưới dạng chuỗi JSON Array [cite: 5, 6]
            const labelsData = ${chartLabels};
            const revenueData = ${chartData};

            const revenueChart = new Chart(ctx, {
                type: 'line', // Kiểu biểu đồ đường
                data: {
                    labels: labelsData, // Nhãn trục X (ngày tháng) từ Servlet
                    datasets: [{
                        label: 'Doanh thu (VNĐ)',
                        data: revenueData, // Dữ liệu doanh thu từ Servlet
                        borderColor: 'rgb(75, 192, 192)', // Màu đường line
                        backgroundColor: 'rgba(75, 192, 192, 0.2)', // Màu nền dưới đường line
                        fill: true, // Tô màu nền
                        tension: 0.1 // Độ cong của đường line
                    }]
                },
                options: {
                    responsive: true, // Biểu đồ tự điều chỉnh kích thước [cite: 8]
                    maintainAspectRatio: false, // Cho phép thay đổi tỷ lệ
                    scales: {
                        y: {
                            beginAtZero: true, // Bắt đầu trục Y từ 0 [cite: 9]
                            // Thêm định dạng tiền tệ cho trục Y (tùy chọn)
                            ticks: {
                                callback: function(value) {
                                    return new Intl.NumberFormat('vi-VN').format(value);
                                }
                            }
                        }
                    }
                }
            });
        });
	</script>
</body>
</html>