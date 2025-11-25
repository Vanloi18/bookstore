package com.mybookstore.bookstore.service;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.mybookstore.bookstore.model.DailyReport;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.List;

public class PDFExportService {

    public void exportReport(List<DailyReport> reports, double totalRevenue, int totalOrders, int totalBooksSold, OutputStream out) {
        try {
            Document document = new Document();
            PdfWriter.getInstance(document, out);
            document.open();

            // 1. Tiêu đề
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18);
            Paragraph title = new Paragraph("BAO CAO DOANH THU", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            title.setSpacingAfter(20);
            document.add(title);

            // 2. KPI Tổng quan
            document.add(new Paragraph("Tong Doanh Thu: " + String.format("%,.0f", totalRevenue) + " VND"));
            document.add(new Paragraph("Tong Don Hang: " + totalOrders));
            document.add(new Paragraph("Tong Sach Ban: " + totalBooksSold));
            document.add(new Paragraph(" ")); // Dòng trống

            // 3. Bảng chi tiết
            PdfPTable table = new PdfPTable(4); // 4 cột
            table.setWidthPercentage(100);
            
            // Header
            addTableHeader(table, "Ngay");
            addTableHeader(table, "Don Hang");
            addTableHeader(table, "Doanh Thu");
            addTableHeader(table, "Sach Ban Chay");

            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

            for (DailyReport r : reports) {
                table.addCell(r.getDate() != null ? sdf.format(r.getDate()) : "");
                table.addCell(String.valueOf(r.getOrderCount()));
                table.addCell(String.format("%,.0f", r.getRevenue()));
                table.addCell(r.getTopBook() != null ? r.getTopBook() : "");
            }

            document.add(table);
            document.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void addTableHeader(PdfPTable table, String headerTitle) {
        PdfPCell header = new PdfPCell();
        header.setBackgroundColor(BaseColor.LIGHT_GRAY);
        header.setPhrase(new Phrase(headerTitle));
        table.addCell(header);
    }
}