// report-charts.js

// Hàm gọi API chung
async function fetchData(action) {
    // Xây dựng URL API dựa trên context path hiện tại
    const url = `${window.location.origin}${window.location.pathname}?action=${action}`;
    try {
        const response = await fetch(url);
        if (!response.ok) {
            console.error(`Lỗi HTTP status: ${response.status} khi gọi ${action}`);
            return null;
        }
        return await response.json();
    } catch (error) {
        // Đã sửa lỗi cú pháp Template Literal tại đây
        console.error(`Lỗi khi gọi API ${action}:`, error);
        return null;
    }
}

// Hàm format tiền tệ (Ví dụ: 1234500 -> 1.234.500₫)
function formatCurrency(amount) {
    // Đảm bảo amount là số trước khi format
    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' })
        .format(parseFloat(amount));
}

// 1. Cập nhật KPI Cards
async function updateKpiCards() {
    const data = await fetchData('kpis');

    if (data) {
        document.getElementById('kpi-total-orders').innerText = data.totalOrders.toLocaleString('vi-VN');
        document.getElementById('kpi-total-revenue').innerText = formatCurrency(data.totalRevenue);
        document.getElementById('kpi-books-sold').innerText = data.totalBooksSold.toLocaleString('vi-VN');
        document.getElementById('kpi-conversion-rate').innerText = data.conversionRate + '%';
    }
}

// 2. Vẽ Biểu đồ Xu hướng Doanh thu (Bar Chart)
async function drawRevenueTrendChart() {
    const data = await fetchData('trend');

	if (data && data.values.length > 0) {
	        const ctx = document.getElementById('revenueTrendChart').getContext('2d');
	        new Chart(ctx, {
	            type: 'bar',
	            data: { /* ... */ },
	            options: {
	                responsive: true,
	                maintainAspectRatio: false, // <-- ĐÃ THÊM: Cho phép co giãn theo chiều cao cố định
	                scales: { y: { beginAtZero: true } },
	                plugins: { legend: { display: false } }
	            }
	        });
	    }
	}

// 3. Vẽ Biểu đồ Phân bổ Thể loại (Doughnut Chart)
async function drawCategoryDistributionChart() {
    const listData = await fetchData('distribution');

    if (listData && listData.length > 0) {
        const labels = listData.map(item => item.category);
        const values = listData.map(item => item.revenue);
        const backgroundColors = ['#007bff', '#17a2b8', '#ffc107', '#dc3545', '#6c757d', '#28a745'];

        const categoryListElement = document.getElementById('category-list');

        // Đã sửa lỗi Template Literal trong hàm map() này
        categoryListElement.innerHTML = listData.map((item, index) => `
            <div class="department-item">
                <p>${item.category} <span>${item.percentage.toFixed(1)}%</span></p>
                <div class="progress">
                    <div class="progress-bar"
                        style="width: ${item.percentage}%; background-color: ${backgroundColors[index % backgroundColors.length]} !important;"
                        aria-valuenow="${item.percentage}">
                    </div>
                </div>
            </div>
        `).join('');

        // Vẽ biểu đồ Doughnut
		// Vẽ biểu đồ Doughnut
		        const ctx = document.getElementById('categoryDistributionChart').getContext('2d');
		        new Chart(ctx, {
		            type: 'doughnut',
		            data: {
		                labels: labels,
		                datasets: [{
		                    data: values,
		                    backgroundColor: backgroundColors,
		                    hoverOffset: 4
		                }]
		            },
		            options: { 
		                responsive: true, 
		                maintainAspectRatio: false, // <-- THAY ĐỔI QUAN TRỌNG
		                plugins: { legend: { display: false } } 
		            }
		        });
		    }
}

// 4. Vẽ Biểu đồ Trạng thái Đơn hàng (Horizontal Bar Chart)
async function drawOrderStatusChart() {
    const data = await fetchData('status');

	if (data) {
	        const ctx = document.getElementById('orderStatusChart').getContext('2d');
	        new Chart(ctx, {
	            type: 'bar',
	            data: { /* ... */ },
	            options: {
	                indexAxis: 'y',
	                responsive: true,
	                maintainAspectRatio: false, // <-- ĐÃ THÊM: Cho phép co giãn theo chiều cao cố định
	                plugins: { legend: { display: false } },
	                scales: { x: { beginAtZero: true } }
	            }
	        });
	    }
	}


// 5. Cập nhật Danh sách Đơn hàng Gần đây
async function updateRecentOrders() {
    const listData = await fetchData('recent');
    const listElement = document.getElementById('recent-orders-list');

    if (listData && listData.length > 0) {
        listElement.innerHTML = listData.map(order => {
            const statusClass = {
                'Completed': 'bg-success',
                'Pending': 'bg-warning',
                'Shipped': 'bg-info',
                'Cancelled': 'bg-danger'
            }[order.status] || 'bg-secondary';

            const date = new Date(order.orderDate);
            const timeStr = date.toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' });
            const customerName = order.userId;

            return `
                <div class="interview-item">
                    <p class="name-title">Đơn hàng #${order.id}
                        <span class="badge ${statusClass}">${order.status}</span>
                    </p>
                    <p class="role-time">Khách hàng ID: ${customerName} | ${formatCurrency(order.totalAmount)}</p>
                    <p class="role-time">Thời gian: ${timeStr} | Ngày ${date.toLocaleDateString('vi-VN')}</p>
                </div>
            `;
        }).join('');
    } else {
        listElement.innerHTML = `<p class="text-center text-muted">Không có đơn hàng gần đây.</p>`;
    }
}

// Khởi chạy tất cả các hàm khi DOM load xong
document.addEventListener('DOMContentLoaded', () => {
    updateKpiCards();
    drawRevenueTrendChart();
    drawCategoryDistributionChart();
    drawOrderStatusChart();
    updateRecentOrders();
});
