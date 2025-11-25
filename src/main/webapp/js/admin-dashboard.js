/* ========================================================= 
   admin-dashboard.js - Logic xử lý biểu đồ và sự kiện
   ========================================================= */

function initDashboardCharts(revenueData, orderLabels, orderData) {
    // 1. REVENUE CHART (LINE CHART)
    const ctxRev = document.getElementById('revenueChart').getContext('2d');
    new Chart(ctxRev, {
        type: 'line',
        data: {
            labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'],
            datasets: [{
                label: 'Doanh thu (VNĐ)',
                data: revenueData,
                borderColor: '#2ecc71',
                backgroundColor: 'rgba(46, 204, 113, 0.1)',
                borderWidth: 3,
                fill: true,
                tension: 0.4,
                pointRadius: 4,
                pointHoverRadius: 6,
                pointBackgroundColor: '#2ecc71',
                pointBorderColor: '#fff',
                pointBorderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false, // Để chart co giãn tốt hơn
            plugins: { 
                legend: { display: false },
                tooltip: {
                    backgroundColor: 'rgba(0,0,0,0.8)',
                    padding: 12,
                    titleFont: { size: 14, weight: 'bold' },
                    bodyFont: { size: 13 },
                    callbacks: {
                        label: function(context) {
                            return 'Doanh thu: ' + context.parsed.y.toLocaleString('vi-VN') + '₫';
                        }
                    }
                }
            },
            scales: { 
                y: { 
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            // Rút gọn số liệu nếu quá lớn (ví dụ: 1tr -> 1M)
                            if(value >= 1000000) return (value/1000000).toFixed(1) + 'M';
                            return value.toLocaleString('vi-VN') + '₫';
                        }
                    },
                    grid: { color: 'rgba(0,0,0,0.05)' }
                },
                x: { grid: { display: false } }
            }
        }
    });

    // 2. ORDERS CHART (BAR CHART)
    const ctxOrd = document.getElementById('ordersChart').getContext('2d');
    new Chart(ctxOrd, {
        type: 'bar',
        data: {
            labels: orderLabels,
            datasets: [{
                label: 'Số đơn',
                data: orderData,
                backgroundColor: '#3498db',
                borderRadius: 6,
                hoverBackgroundColor: '#2980b9'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false },
                tooltip: {
                    backgroundColor: 'rgba(0,0,0,0.8)',
                    padding: 12,
                    titleFont: { size: 14, weight: 'bold' },
                    bodyFont: { size: 13 }
                }
            },
            scales: { 
                y: { 
                    beginAtZero: true,
                    ticks: { stepSize: 1, precision: 0 },
                    grid: { color: 'rgba(0,0,0,0.05)' }
                },
                x: { grid: { display: false } }
            }
        }
    });
}

// 3. SIDEBAR TOGGLE FUNCTION (Cho Mobile)
function toggleSidebar() {
    document.body.classList.toggle('sidebar-toggled');
}

// Close sidebar when clicking outside on mobile
document.addEventListener('click', function(event) {
    const sidebar = document.querySelector('.admin-sidebar');
    const toggleBtn = document.querySelector('.mobile-menu-toggle');
    
    if (window.innerWidth <= 992 && 
        document.body.classList.contains('sidebar-toggled') &&
        !sidebar.contains(event.target) && 
        !toggleBtn.contains(event.target)) {
        document.body.classList.remove('sidebar-toggled');
    }
});