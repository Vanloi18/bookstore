package com.mybookstore.bookstore.dao;

import com.mybookstore.bookstore.model.OrderDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailDAO {

	/**
	 * Thêm chi tiết một đơn hàng vào CSDL.
	 * 
	 * @param detail Đối tượng OrderDetail chứa thông tin sản phẩm trong đơn hàng.
	 */
	public void addOrderDetail(OrderDetail detail) {
		String sql = "INSERT INTO order_details (orderId, bookId, quantity, pricePerUnit) VALUES (?, ?, ?, ?)";

		try (Connection connection = DatabaseConnection.getConnection();
				PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setInt(1, detail.getOrderId());
			ps.setInt(2, detail.getBookId());
			ps.setInt(3, detail.getQuantity());
			ps.setDouble(4, detail.getPricePerUnit());

			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<OrderDetail> getOrderDetailsByOrderId(int orderId) {
		List<OrderDetail> detailList = new ArrayList<>();
		String sql = "SELECT * FROM order_details WHERE orderId = ?";

		try (Connection connection = DatabaseConnection.getConnection();
				PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setInt(1, orderId);

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					OrderDetail detail = new OrderDetail();
					detail.setId(rs.getInt("id"));
					detail.setOrderId(rs.getInt("orderId"));
					detail.setBookId(rs.getInt("bookId"));
					detail.setQuantity(rs.getInt("quantity"));
					detail.setPricePerUnit(rs.getDouble("pricePerUnit"));
					detailList.add(detail);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return detailList;
	}
}