package com.mybookstore.bookstore.service;
import com.mybookstore.bookstore.model.DailyReport;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.List;

public class CSVExportService {
    public void exportReport(List<DailyReport> reports, OutputStream out) {
        try {
            String header = "Ngày,Số đơn,Doanh thu\n";
            out.write(header.getBytes(StandardCharsets.UTF_8));
            for(DailyReport r : reports) {
                String line = r.getDate() + "," + r.getOrderCount() + "," + r.getRevenue() + "\n";
                out.write(line.getBytes(StandardCharsets.UTF_8));
            }
        } catch(Exception e) {}
    }
}