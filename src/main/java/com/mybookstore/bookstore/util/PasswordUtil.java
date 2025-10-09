package com.mybookstore.bookstore.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Lớp tiện ích để xử lý các tác vụ liên quan đến mật khẩu.
 */
public class PasswordUtil {

    /**
     * Băm một mật khẩu dạng văn bản thuần.
     * @param plainPassword Mật khẩu chưa mã hóa.
     * @return Chuỗi hash của mật khẩu.
     */
    public static String hashPassword(String plainPassword) {
        // Tham số 12 là độ phức tạp của việc băm (workload factor), càng cao càng an toàn nhưng càng chậm.
        // 12 là một giá trị tốt ở thời điểm hiện tại.
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
    }

    /**
     * Kiểm tra một mật khẩu văn bản thuần có khớp với một chuỗi hash hay không.
     * @param plainPassword Mật khẩu người dùng nhập vào.
     * @param hashedPassword Chuỗi hash lấy từ cơ sở dữ liệu.
     * @return true nếu mật khẩu khớp, false nếu không.
     */
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}
