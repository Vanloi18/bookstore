package com.mybookstore.bookstore.dao;

import com.mybookstore.bookstore.model.Book;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {

	// Lấy tất cả sách
	public List<Book> getAllBooks() {
		List<Book> books = new ArrayList<>();
		String sql = "SELECT * FROM books";
		try (Connection connection = DatabaseConnection.getConnection();
				PreparedStatement ps = connection.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				books.add(mapResultSetToBook(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return books;
	}

	// Lấy sách theo ID
	public Book getBookById(int bookId) {
		String sql = "SELECT * FROM books WHERE id = ?";
		try (Connection connection = DatabaseConnection.getConnection();
				PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setInt(1, bookId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					return mapResultSetToBook(rs);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * Tìm kiếm sách theo tiêu đề.
	 * 
	 * @param keyword Từ khóa tìm kiếm.
	 * @return Danh sách các cuốn sách có tiêu đề chứa từ khóa.
	 */
	public List<Book> searchBooksByTitle(String keyword) {
		List<Book> books = new ArrayList<>();
		// Dùng LIKE và % để tìm kiếm gần đúng
		String sql = "SELECT * FROM books WHERE title LIKE ?";
		try (Connection connection = DatabaseConnection.getConnection();
				PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setString(1, "%" + keyword + "%");

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					books.add(mapResultSetToBook(rs));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return books;
	}

	// Lấy sách theo Category ID
	public List<Book> getBooksByCategoryId(int categoryId) {
		List<Book> books = new ArrayList<>();
		String sql = "SELECT * FROM books WHERE categoryId = ?";
		try (Connection connection = DatabaseConnection.getConnection();
				PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setInt(1, categoryId);

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					books.add(mapResultSetToBook(rs));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return books;
	}

	public int countBooks() {
		String sql = "SELECT COUNT(*) FROM books";
		try (Connection connection = DatabaseConnection.getConnection();
				PreparedStatement ps = connection.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	// Thêm sách mới
	public void addBook(Book book) {
		String sql = "INSERT INTO books (title, author, price, stock, publicationYear, description, coverImage, categoryId) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		try (Connection connection = DatabaseConnection.getConnection();
				PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setString(1, book.getTitle());
			ps.setString(2, book.getAuthor());
			ps.setDouble(3, book.getPrice());
			ps.setInt(4, book.getStock());
			ps.setInt(5, book.getPublicationYear());
			ps.setString(6, book.getDescription());
			ps.setString(7, book.getCoverImage());
			ps.setInt(8, book.getCategoryId());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Cập nhật sách
	public void updateBook(Book book) {
		String sql = "UPDATE books SET title = ?, author = ?, price = ?, stock = ?, publicationYear = ?, description = ?, coverImage = ?, categoryId = ? WHERE id = ?";
		try (Connection connection = DatabaseConnection.getConnection();
				PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setString(1, book.getTitle());
			ps.setString(2, book.getAuthor());
			// ... (điền các tham số còn lại tương tự)
			ps.setInt(8, book.getCategoryId());
			ps.setInt(9, book.getId());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Xóa sách
	public void deleteBook(int bookId) {
		String sql = "DELETE FROM books WHERE id = ?";
		try (Connection connection = DatabaseConnection.getConnection();
				PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setInt(1, bookId);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// Phương thức private helper để tránh lặp code
	private Book mapResultSetToBook(ResultSet rs) throws SQLException {
		Book book = new Book();
		book.setId(rs.getInt("id"));
		book.setTitle(rs.getString("title"));
		book.setAuthor(rs.getString("author"));
		book.setPrice(rs.getDouble("price"));
		book.setStock(rs.getInt("stock"));
		book.setPublicationYear(rs.getInt("publicationYear"));
		book.setDescription(rs.getString("description"));
		book.setCoverImage(rs.getString("coverImage"));
		book.setCategoryId(rs.getInt("categoryId"));
		return book;
	}

	// Thêm vào BookDAO.java
	public int countTotalBooks() {
		String sql = "SELECT COUNT(*) FROM books";
		try (Connection connection = DatabaseConnection.getConnection();
				PreparedStatement ps = connection.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	
	/**
     * Đếm tổng số sách (có thể lọc theo category hoặc tìm kiếm).
     * @param categoryId ID thể loại (0 nếu không lọc).
     * @param keyword Từ khóa tìm kiếm (null hoặc rỗng nếu không tìm kiếm).
     * @return Tổng số sách thỏa mãn điều kiện.
     */
    public int countTotalBooks(int categoryId, String keyword) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM books WHERE 1=1 "); // WHERE 1=1 để dễ nối điều kiện
        List<Object> params = new ArrayList<>();

        if (categoryId > 0) {
            sql.append("AND categoryId = ? ");
            params.add(categoryId);
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND title LIKE ? ");
            params.add("%" + keyword.trim() + "%");
        }

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql.toString())) {

            // Set các tham số vào PreparedStatement
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    /**
     * Lấy danh sách sách cho một trang cụ thể, có thể lọc/tìm kiếm.
     * @param categoryId ID thể loại (0 nếu không lọc).
     * @param keyword Từ khóa tìm kiếm (null hoặc rỗng nếu không tìm kiếm).
     * @param pageNumber Trang hiện tại (bắt đầu từ 1).
     * @param pageSize Số lượng sách trên mỗi trang.
     * @return Danh sách sách cho trang đó.
     */
    public List<Book> getBooksPaginated(int categoryId, String keyword, int pageNumber, int pageSize) {
        List<Book> books = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM books WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (categoryId > 0) {
            sql.append("AND categoryId = ? ");
            params.add(categoryId);
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND title LIKE ? ");
            params.add("%" + keyword.trim() + "%");
        }

        sql.append("ORDER BY id DESC LIMIT ? OFFSET ? "); // Sắp xếp sách mới nhất lên đầu

        // Tính toán OFFSET
        int offset = (pageNumber - 1) * pageSize;
        params.add(pageSize);
        params.add(offset);


        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql.toString())) {

            // Set các tham số
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    books.add(mapResultSetToBook(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

}