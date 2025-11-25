package com.mybookstore.bookstore.model;

public class CategoryRevenue {
    private String categoryName;
    private double revenue;

    public CategoryRevenue(String categoryName, double revenue) {
        this.categoryName = categoryName;
        this.revenue = revenue;
    }
    public String getCategoryName() { return categoryName; }
    public double getRevenue() { return revenue; }
}