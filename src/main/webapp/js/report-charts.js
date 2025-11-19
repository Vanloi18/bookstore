// ==========================
// report-charts.js (Hoàn chỉnh)
// ==========================


// 1️⃣ Hàm gọi API chung
async function fetchData(action) {
    // Xây dựng URL API dựa trên context path hiện tại
    const url = new URL(window.location.href);
    url.searchParams.set('action', action);

    try {
        const response = await fetch(url);
        if (!response.ok) {
            console.error(`Lỗi HTTP status: ${response.status} khi gọi ${action}`);
            return null;
        }
        return await response.json();
    } catch (error) {
        console.error(`Lỗi khi gọi API ${action}:`, error);
        return null;
    }
}

// 2️⃣ Hàm format tiền tệ (VD: 1234500 -> 1.234.500₫)
function formatCurrency(amount) {
    if (isNaN(amount)) return "0₫";
    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' })
        .format(parseFloat(amount));
}

// ==========================
// 3️⃣ Cập nhật KPI Cards
// ==========================
async function updateKpiCards() {
    const data = await fetchData('kpis');
    if (!data) return;

    document.getElementById('kpi-total-orders').innerText = data.totalOrders?.toLocaleString('vi-VN') || '0';
    document.getElementById('kpi-total-revenue').innerText = formatCurrency(data.totalRevenue);
    document.getElementById('kpi-books-sold').innerText = data.totalBooksSold?.toLocaleString('vi-VN') || '0';
    document.getElementById('kpi-conversion-rate').innerText = (data.conversionRate || 0) + '%';
}

// ==========================
// 4️⃣ Biểu đồ Xu hướng Doanh thu (Bar Chart)
// ==========================
let revenueChart;
async function drawRevenueTrendChart() {
    const data = await fetchData('trend');
    const canvas = document.getElementById('revenueTrendChart');
    if (!canvas || !data || !data.labels || data.labels.length === 0) return;

    const ctx = canvas.getContext('2d');
    if (revenueChart) revenueChart.destroy();

    revenueChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: data.labels,
            datasets: [{
                label: 'Doanh thu (VNĐ)',
                data: data.values,
                backgroundColor: '#007bff'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: { y: { beginAtZero: true } },
            plugins: { legend: { display: false } }
        }
    });
}

// ==========================
// 5️⃣ Biểu đồ Phân bổ Thể loại (Doughnut Chart)
// ==========================
let categoryChart;
async function drawCategoryDistributionChart() {
    const listData = await fetchData('distribution');
    const canvas = document.getElementById('categoryDistributionChart');
    const categoryListElement = document.getElementById('category-list');
    if (!canvas || !listData || listData.length === 0) return;

    const labels = listData.map(item => item.category);
    const values = listData.map(item => item.revenue);
    const backgroundColors = ['#007bff', '#17a2b8', '#ffc107', '#dc3545', '#6c757d', '#28a745'];

	categoryListElement.innerHTML = listData.map((item, index) => 
	    '<div class="department-item">' +
	        '<p>' + item.category + ' <span>' + item.percentage.toFixed(1) + '%</span></p>' +
	        '<div class="progress">' +
	            '<div class="progress-bar" style="width:' + item.percentage + '%;"></div>' +
	        '</div>' +
	    '</div>'
	).join('');


    const ctx = canvas.getContext('2d');
    if (categoryChart) categoryChart.destroy();

    categoryChart = new Chart(ctx, {
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
            maintainAspectRatio: false,
            plugins: { legend: { display: false } }
        }
    });
}

// ==========================
// 6️⃣ Biểu đồ Trạng thái Đơn hàng (Horizontal Bar Chart)
// ==========================
let orderStatusChart;
async function drawOrderStatusChart() {
    const data = await fetchData('status');
    const canvas = document.getElementById('orderStatusChart');
    
    // SỬA LỖI: Bỏ kiểm tra data.labels vì data trả về là Map
    if (!canvas || !data) return; 

    const ctx = canvas.getContext('2d');
    if (orderStatusChart) orderStatusChart.destroy();

    // CHUYỂN ĐỔI DỮ LIỆU TỪ MAP SANG ARRAY
    // Backend trả về: {"Pending": 5, "Completed": 2}
    const labels = Object.keys(data);   // -> ["Pending", "Completed"]
    const values = Object.values(data); // -> [5, 2]

    orderStatusChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels, // Dùng biến labels vừa tạo
            datasets: [{
                label: 'Số lượng đơn hàng',
                data: values, // Dùng biến values vừa tạo
                backgroundColor: '#28a745'
            }]
        },
        options: {
            indexAxis: 'y',
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: { x: { beginAtZero: true } }
        }
    });
}

// ==========================
// 7️⃣ Danh sách Đơn hàng gần đây
// ==========================
async function updateRecentOrders() {
    const listData = await fetchData('recent');
    const listElement = document.getElementById('recent-orders-list');
    if (!listElement) return;

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
                    <p class="name-title">Đơn hàng #\${order.id}
                        <span class="badge \${statusClass}">\${order.status}</span>
                    </p>
                    <p class="role-time">Khách hàng ID: \${customerName} | \${formatCurrency(order.totalAmount)}</p>
                    <p class="role-time">Thời gian: \${timeStr} | Ngày \${date.toLocaleDateString('vi-VN')}</p>
                </div>
            `;
        }).join('');
    } else {
        listElement.innerHTML = `<p class="text-center text-muted">Không có đơn hàng gần đây.</p>`;
    }
}

// ==========================
// 8️⃣ Khởi chạy khi DOM load xong
// ==========================
document.addEventListener('DOMContentLoaded', () => {
    updateKpiCards();
    drawRevenueTrendChart();
    drawCategoryDistributionChart();
    drawOrderStatusChart();
    updateRecentOrders();
});
