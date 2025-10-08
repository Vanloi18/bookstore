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
        } catch (SQLException e) { e.printStackTrace(); }
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
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
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
        } catch (SQLException e) { e.printStackTrace(); }
        return books;
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
        } catch (SQLException e) { e.printStackTrace(); }
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
        } catch (SQLException e) { e.printStackTrace(); }
    }

    // Xóa sách
    public void deleteBook(int bookId) {
        String sql = "DELETE FROM books WHERE id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookId);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
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
}