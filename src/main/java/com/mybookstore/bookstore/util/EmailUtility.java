package com.mybookstore.bookstore.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailUtility {
    
    // Cấu hình SMTP (Ví dụ dùng Gmail)
    private static final String HOST = "smtp.gmail.com";
    private static final String PORT = "587";
    // Thay đổi 2 dòng dưới thành email và App Password của bạn
    private static final String EMAIL_FROM = "anhphandoan553@gmail.com"; 
    private static final String PASSWORD = "bvhm wubf bbjf cnen"; 

    public static void sendEmail(String toAddress, String subject, String messageContent) throws MessagingException {
        Properties properties = new Properties();
        properties.put("mail.smtp.host", HOST);
        properties.put("mail.smtp.port", PORT);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_FROM, PASSWORD);
            }
        };

        Session session = Session.getInstance(properties, auth);

        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(EMAIL_FROM));
        msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toAddress));
        msg.setSubject(subject);
        msg.setSentDate(new java.util.Date());
        msg.setContent(messageContent, "text/html; charset=UTF-8");

        Transport.send(msg);
    }
}