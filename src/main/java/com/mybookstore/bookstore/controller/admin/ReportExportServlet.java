package com.mybookstore.bookstore.controller.admin;

import com.mybookstore.bookstore.dao.ReportDAO;
import com.mybookstore.bookstore.model.DailyReport;
import com.mybookstore.bookstore.model.ReportFilter;
import com.mybookstore.bookstore.service.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/report/export") // URL riêng để xuất file
public class ReportExportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ReportDAO reportDAO;
    private ExcelExportService excelService;
    private PDFExportService pdfService;
    private CSVExportService csvService;
    
    @Override
    public void init() {
        reportDAO = new ReportDAO();
        excelService = new ExcelExportService();
        pdfService = new PDFExportService();
        csvService = new CSVExportService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String format = request.getParameter("format"); // excel, pdf, csv
            
            // Lấy lại Filter y hệt như lúc xem báo cáo
            ReportFilter filter = new ReportFilter();
            String from = request.getParameter("fromDate");
            String to = request.getParameter("toDate");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            
            if (from != null && !from.isEmpty()) filter.setFromDate(sdf.parse(from));
            else {
                Calendar c = Calendar.getInstance(); c.add(Calendar.DATE, -30);
                filter.setFromDate(c.getTime());
            }
            
            if (to != null && !to.isEmpty()) filter.setToDate(sdf.parse(to));
            else filter.setToDate(new Date());
            
            // Lấy dữ liệu cần xuất
            List<DailyReport> reports = reportDAO.getDailyReports(filter);
            double totalRevenue = reportDAO.getTotalRevenue(filter);
            int totalOrders = reportDAO.getTotalOrders(filter);
            int totalBooksSold = reportDAO.getTotalBooksSold(filter);
            
            String timestamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
            String filename = "BaoCao_" + timestamp;
            
            // Chọn định dạng xuất
            if ("excel".equalsIgnoreCase(format)) {
                response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                response.setHeader("Content-Disposition", "attachment; filename=" + filename + ".xlsx");
                try (OutputStream out = response.getOutputStream()) {
                    excelService.exportReport(reports, totalRevenue, totalOrders, totalBooksSold, out);
                }
            } else if ("pdf".equalsIgnoreCase(format)) {
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "attachment; filename=" + filename + ".pdf");
                try (OutputStream out = response.getOutputStream()) {
                    pdfService.exportReport(reports, totalRevenue, totalOrders, totalBooksSold, out);
                }
            } else if ("csv".equalsIgnoreCase(format)) {
                response.setContentType("text/csv; charset=UTF-8");
                response.setHeader("Content-Disposition", "attachment; filename=" + filename + ".csv");
                try (OutputStream out = response.getOutputStream()) {
                    csvService.exportReport(reports, out);
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Định dạng không hỗ trợ");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi xuất báo cáo");
        }
    }
}