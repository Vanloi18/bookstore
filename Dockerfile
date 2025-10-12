# 1. Sử dụng image Tomcat 9
FROM tomcat:10.1

# 2. Xóa ứng dụng mặc định
RUN rm -rf /usr/local/tomcat/webapps/*

# 3. Copy file WAR bạn vừa build vào Tomcat (đặt làm ROOT)
COPY target/BookstoreProject-1.0.0.war /usr/local/tomcat/webapps/BookstoreProject.war

# 4. Mở cổng web
EXPOSE 8080

# 5. Chạy Tomcat
CMD ["catalina.sh", "run"]
