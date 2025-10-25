package com.mybookstore.bookstore.model;

import java.sql.Timestamp;

public class Review {
    private int id;
    private int bookId;
    private int userId;
    private int rating;
    private String comment;
    private Timestamp createdAt;

    // Để hiển thị tên người dùng khi duyệt review
    private User user; // Thêm đối tượng User

    public Review() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    // Getter và Setter cho User
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
}