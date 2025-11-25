package com.mybookstore.bookstore.model;
import java.util.Date;

public class DailyReport {
    private Date date;
    private int orderCount;
    private double revenue;
    private String topBook;
    private int newCustomers;
    private double conversionRate;

    // Getters & Setters
    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }
    public int getOrderCount() { return orderCount; }
    public void setOrderCount(int orderCount) { this.orderCount = orderCount; }
    public double getRevenue() { return revenue; }
    public void setRevenue(double revenue) { this.revenue = revenue; }
    public String getTopBook() { return topBook; }
    public void setTopBook(String topBook) { this.topBook = topBook; }
    public int getNewCustomers() { return newCustomers; }
    public void setNewCustomers(int newCustomers) { this.newCustomers = newCustomers; }
    public double getConversionRate() { return conversionRate; }
    public void setConversionRate(double conversionRate) { this.conversionRate = conversionRate; }
}