<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - Nhà Sách Online</title>
    
    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/login.css">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="main-content">
        <div class="form-container">
            <!-- Logo -->
            <div class="form-logo">
                <i class="fa-solid fa-book"></i>
            </div>
            
            <!-- Title -->
            <h2>Đăng nhập</h2>
            <p class="form-subtitle">Nhập thông tin tài khoản của bạn để tiếp tục</p>
            
            <!-- Error Message -->
            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>
            
            <!-- Success Message -->
            <c:if test="${not empty successMessage}">
                <div class="success-message">${successMessage}</div>
            </c:if>

            <!-- Login Form -->
            <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">
                <!-- Username Field -->
                <div class="form-group">
                    <label for="username">Tên đăng nhập</label>
                    <input 
                        type="text" 
                        id="username" 
                        name="username" 
                        placeholder="Nhập tên đăng nhập"
                        value="${param.username}"
                        required
                        autocomplete="username"
                    >
                    <span class="field-error" id="usernameError"></span>
                </div>
                
                <!-- Password Field -->
                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <input 
                        type="password" 
                        id="password" 
                        name="password" 
                        placeholder="Nhập mật khẩu"
                        required
                        autocomplete="current-password"
                    >
                    <span class="field-error" id="passwordError"></span>
                </div>
                
                <!-- Remember Me Checkbox -->
                <div class="form-group checkbox-group">
                    <input 
                        type="checkbox" 
                        id="remember" 
                        name="remember" 
                        value="on"
                        ${param.remember == 'on' ? 'checked' : ''}
                    >
                    <label for="remember">Ghi nhớ đăng nhập</label>
                </div>

                <!-- Submit Button -->
                <button type="submit" id="submitBtn">Đăng nhập</button>
            </form>
            
            <!-- Forgot Password -->
            <div class="forgot-password">
                <a href="${pageContext.request.contextPath}/forgot-password.jsp">Quên mật khẩu?</a>
            </div>
            
            <!-- Divider -->
            <div class="divider">hoặc</div>
            
            <!-- Register Link -->
            <p>
                Chưa có tài khoản? 
                <a href="${pageContext.request.contextPath}/register.jsp">Đăng ký ngay</a>
            </p>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
    
    <!-- JavaScript -->
    <script>
        // Form validation
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value.trim();
            let isValid = true;
            
            // Clear previous errors
            document.getElementById('usernameError').textContent = '';
            document.getElementById('passwordError').textContent = '';
            document.getElementById('username').classList.remove('error', 'success');
            document.getElementById('password').classList.remove('error', 'success');
            
            // Validate username
            if (username.length < 3) {
                document.getElementById('usernameError').textContent = 'Tên đăng nhập phải có ít nhất 3 ký tự';
                document.getElementById('username').classList.add('error');
                isValid = false;
            } else {
                document.getElementById('username').classList.add('success');
            }
            
            // Validate password
            if (password.length < 6) {
                document.getElementById('passwordError').textContent = 'Mật khẩu phải có ít nhất 6 ký tự';
                document.getElementById('password').classList.add('error');
                isValid = false;
            } else {
                document.getElementById('password').classList.add('success');
            }
            
            // Prevent submission if invalid
            if (!isValid) {
                e.preventDefault();
                return false;
            }
            
            // Add loading state
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.classList.add('loading');
            submitBtn.disabled = true;
        });
        
        // Auto-hide messages after 5 seconds
        setTimeout(function() {
            const errorMsg = document.querySelector('.error-message');
            const successMsg = document.querySelector('.success-message');
            
            if (errorMsg) {
                errorMsg.style.transition = 'all 0.3s ease';
                errorMsg.style.opacity = '0';
                errorMsg.style.transform = 'translateY(-10px)';
                setTimeout(() => errorMsg.remove(), 300);
            }
            
            if (successMsg) {
                successMsg.style.transition = 'all 0.3s ease';
                successMsg.style.opacity = '0';
                successMsg.style.transform = 'translateY(-10px)';
                setTimeout(() => successMsg.remove(), 300);
            }
        }, 5000);
        
        // Show password toggle (optional enhancement)
        const passwordField = document.getElementById('password');
        const togglePassword = document.createElement('button');
        togglePassword.type = 'button';
        togglePassword.innerHTML = '<i class="fa-solid fa-eye"></i>';
        togglePassword.style.cssText = `
            position: absolute;
            right: 16px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #86868b;
            cursor: pointer;
            font-size: 16px;
        `;
        
        // Add toggle button to password field (optional)
        // Uncomment if you want this feature
        /*
        const passwordGroup = passwordField.closest('.form-group');
        passwordGroup.style.position = 'relative';
        passwordGroup.appendChild(togglePassword);
        
        togglePassword.addEventListener('click', function() {
            const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordField.setAttribute('type', type);
            this.innerHTML = type === 'password' ? '<i class="fa-solid fa-eye"></i>' : '<i class="fa-solid fa-eye-slash"></i>';
        });
        */
    </script>
</body>
</html>