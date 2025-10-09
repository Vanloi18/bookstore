package com.mybookstore.bookstore.model;

public class CartItem {
    // Chỉ cần 2 thuộc tính này để quản lý giỏ hàng trong Session
    private Book book;
    private int quantity;

    public CartItem() {
        // Constructor rỗng là cần thiết
    }
    
    public CartItem(Book book, int quantity) {
        this.book = book;
        this.quantity = quantity;
    }
    
    /**
     * Phương thức tính thành tiền cho sản phẩm này.
     * Cần kiểm tra book khác null để tránh lỗi.
     * @return thành tiền (price * quantity)
     */
    public double getSubtotal() {
        if (book != null) {
            return book.getPrice() * quantity;
        }
        return 0;
    }

    // Getters and Setters đầy đủ
    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}