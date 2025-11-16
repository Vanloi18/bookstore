package com.mybookstore.bookstore.dao;

import com.mybookstore.bookstore.model.Book;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

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

    // Tìm kiếm cả tiêu đề và tác giả
    public List<Book> searchBooks(String keyword) {

        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE title LIKE ? OR author LIKE ?";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            String kw = "%" + keyword + "%";
            ps.setString(1, kw);
            ps.setString(2, kw);

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

    // Lấy sách theo category
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

    // Đếm tổng sách không lọc
    public int countBooks() {
        String sql = "SELECT COUNT(*) FROM books";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Đếm tổng sách có lọc theo category + keyword (title + author)
    public int countTotalBooks(int categoryId, String keyword) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM books WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (categoryId > 0) {
            sql.append("AND categoryId = ? ");
            params.add(categoryId);
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (title LIKE ? OR author LIKE ?) ");
            String kw = "%" + keyword.trim() + "%";
            params.add(kw);
            params.add(kw);
        }

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    // Lấy danh sách sách có phân trang + tìm theo title + author
    public List<Book> getBooksPaginated(int categoryId, String keyword,
                                        int pageNumber, int pageSize) {

        List<Book> books = new ArrayList<>();

        StringBuilder sql = new StringBuilder("SELECT * FROM books WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (categoryId > 0) {
            sql.append("AND categoryId = ? ");
            params.add(categoryId);
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (title LIKE ? OR author LIKE ?) ");
            String kw = "%" + keyword.trim() + "%";
            params.add(kw);
            params.add(kw);
        }

        sql.append("ORDER BY id DESC LIMIT ? OFFSET ?");

        int offset = (pageNumber - 1) * pageSize;
        params.add(pageSize);
        params.add(offset);

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql.toString())) {

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

    // Mapping ResultSet sang Book object
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

    // Fake dữ liệu demo dashboard
    public int countTotalBooksSold() {
        return 5890;
    }

    public Map<String, Double> getRevenueByCategory() {
        Map<String, Double> map = new LinkedHashMap<>();
        map.put("Tiểu thuyết", 3500.00);
        map.put("Kỹ năng", 2800.00);
        return map;
    }
 // ============================
 // THÊM SÁCH MỚI
 // ============================
 public void addBook(Book newBook) {
     String sql = "INSERT INTO books (title, author, price, stock, publicationYear, description, coverImage, categoryId) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

     try (Connection connection = DatabaseConnection.getConnection();
          PreparedStatement ps = connection.prepareStatement(sql)) {

         ps.setString(1, newBook.getTitle());
         ps.setString(2, newBook.getAuthor());
         ps.setDouble(3, newBook.getPrice());
         ps.setInt(4, newBook.getStock());
         ps.setInt(5, newBook.getPublicationYear());
         ps.setString(6, newBook.getDescription());
         ps.setString(7, newBook.getCoverImage());
         ps.setInt(8, newBook.getCategoryId());

         ps.executeUpdate();

     } catch (SQLException e) {
         e.printStackTrace();
     }
 }
//============================
//CẬP NHẬT SÁCH
//============================
public void updateBook(Book book) {
  String sql = "UPDATE books SET title=?, author=?, price=?, stock=?, publicationYear=?, "
             + "description=?, coverImage=?, categoryId=? WHERE id=?";

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
      ps.setInt(9, book.getId());

      ps.executeUpdate();

  } catch (SQLException e) {
      e.printStackTrace();
  }
}
//============================
//XÓA SÁCH THEO ID
//============================
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

}
