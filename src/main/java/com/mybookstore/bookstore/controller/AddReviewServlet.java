package com.mybookstore.bookstore.controller;

import com.mybookstore.bookstore.dao.ReviewDAO;
import com.mybookstore.bookstore.model.Review;
import com.mybookstore.bookstore.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/add-review")
public class AddReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ReviewDAO reviewDAO;

	public void init() {
		reviewDAO = new ReviewDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); // Hỗ trợ tiếng Việt
		HttpSession session = request.getSession(false);
		User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

		// --- Bắt buộc đăng nhập ---
		if (loggedInUser == null) {
			response.sendRedirect(request.getContextPath() + "/login.jsp");
			return;
		}

		try {
			// --- Lấy dữ liệu từ form ---
			int bookId = Integer.parseInt(request.getParameter("bookId"));
			int rating = Integer.parseInt(request.getParameter("rating"));
			String comment = request.getParameter("comment");

			// --- Validate dữ liệu ---
			// Đảm bảo rating nằm trong khoảng 1-5
			if (rating < 1 || rating > 5) {
				// Có thể thêm thông báo lỗi vào session nếu muốn
				// session.setAttribute("reviewError", "Điểm đánh giá phải từ 1 đến 5 sao.");
				// Chuyển hướng lại trang chi tiết sách
				response.sendRedirect(request.getContextPath() + "/product-detail?id=" + bookId);
				return;
			}

			// --- Tạo đối tượng Review ---
			Review newReview = new Review();
			newReview.setBookId(bookId);
			newReview.setUserId(loggedInUser.getId()); // Lấy ID từ user đang đăng nhập
			newReview.setRating(rating);
			newReview.setComment(comment);

			// --- Lưu vào CSDL ---
			reviewDAO.addReview(newReview);

			// --- Chuyển hướng người dùng về lại trang chi tiết sách ---
			// Thêm một tham số để có thể hiển thị thông báo thành công (tùy chọn)
			// session.setAttribute("reviewSuccess", "Cảm ơn bạn đã gửi đánh giá!");
			response.sendRedirect(request.getContextPath() + "/product-detail?id=" + bookId);

		} catch (NumberFormatException e) {
			// Xử lý nếu bookId hoặc rating không phải là số
			e.printStackTrace(); // Nên ghi log lỗi
			// Chuyển hướng về trang chủ hoặc trang lỗi
			response.sendRedirect(request.getContextPath() + "/home");
		}
	}
}
