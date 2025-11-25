package com.mybookstore.bookstore.service;

import com.mybookstore.bookstore.model.DailyReport;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.List;

public class ExcelExportService {

    public void exportReport(List<DailyReport> reports, double totalRevenue, int totalOrders, int totalBooksSold, OutputStream out) throws IOException {
        // 1. Tạo Workbook (File Excel mới)
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Báo Cáo Doanh Thu");

            // --- TẠO STYLE ---
            // Style cho Tiêu đề cột (Header)
            CellStyle headerStyle = workbook.createCellStyle();
            headerStyle.setFillForegroundColor(IndexedColors.LIGHT_BLUE.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerStyle.setAlignment(HorizontalAlignment.CENTER);
            
            XSSFFont headerFont = ((XSSFWorkbook) workbook).createFont();
            headerFont.setFontName("Arial");
            headerFont.setFontHeightInPoints((short) 12);
            headerFont.setBold(true);
            headerFont.setColor(IndexedColors.WHITE.getIndex());
            headerStyle.setFont(headerFont);

            // Style cho tiền tệ (Currency)
            CellStyle currencyStyle = workbook.createCellStyle();
            DataFormat format = workbook.createDataFormat();
            currencyStyle.setDataFormat(format.getFormat("#,##0 ₫"));

            // --- PHẦN 1: THÔNG TIN TỔNG HỢP (KPI) ---
            Row kpiTitleRow = sheet.createRow(0);
            Cell kpiTitleCell = kpiTitleRow.createCell(0);
            kpiTitleCell.setCellValue("TỔNG QUAN BÁO CÁO");
            // (Có thể merge cell nếu muốn đẹp hơn, nhưng để đơn giản ta ghi thẳng)

            Row kpiRow = sheet.createRow(1);
            kpiRow.createCell(0).setCellValue("Tổng Doanh Thu:");
            Cell revCell = kpiRow.createCell(1);
            revCell.setCellValue(totalRevenue);
            revCell.setCellStyle(currencyStyle);

            Row kpiRow2 = sheet.createRow(2);
            kpiRow2.createCell(0).setCellValue("Tổng Đơn Hàng:");
            kpiRow2.createCell(1).setCellValue(totalOrders);

            Row kpiRow3 = sheet.createRow(3);
            kpiRow3.createCell(0).setCellValue("Tổng Sách Bán:");
            kpiRow3.createCell(1).setCellValue(totalBooksSold);

            // --- PHẦN 2: BẢNG CHI TIẾT ---
            
            // Tạo dòng Header bảng (Dòng thứ 5)
            Row headerRow = sheet.createRow(5);
            String[] columns = {"Ngày", "Số Đơn Hàng", "Doanh Thu", "Sách Bán Chạy Nhất", "Khách Mới", "Tỷ Lệ Chuyển Đổi (%)"};

            for (int i = 0; i < columns.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(columns[i]);
                cell.setCellStyle(headerStyle);
            }

            // Đổ dữ liệu vào bảng
            int rowNum = 6;
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

            for (DailyReport report : reports) {
                Row row = sheet.createRow(rowNum++);

                // Cột 0: Ngày
                if (report.getDate() != null) {
                    row.createCell(0).setCellValue(dateFormat.format(report.getDate()));
                } else {
                    row.createCell(0).setCellValue("");
                }

                // Cột 1: Số đơn
                row.createCell(1).setCellValue(report.getOrderCount());

                // Cột 2: Doanh thu (Format tiền)
                Cell revenueCell = row.createCell(2);
                revenueCell.setCellValue(report.getRevenue());
                revenueCell.setCellStyle(currencyStyle);

                // Cột 3: Top sách
                row.createCell(3).setCellValue(report.getTopBook());

                // Cột 4: Khách mới
                row.createCell(4).setCellValue(report.getNewCustomers());

                // Cột 5: Tỷ lệ chuyển đổi
                row.createCell(5).setCellValue(report.getConversionRate());
            }

            // Tự động điều chỉnh độ rộng cột cho đẹp
            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }

            // Ghi dữ liệu ra luồng Output (để trình duyệt tải về)
            workbook.write(out);
        }
    }
}