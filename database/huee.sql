-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bookstore_db
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` double NOT NULL,
  `stock` int DEFAULT '0',
  `publicationYear` int DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `coverImage` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `categoryId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categoryId` (`categoryId`),
  CONSTRAINT `books_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'Đắc Nhân Tâm','Dale Carnegie',89000,50,2019,'Cuốn sách kinh điển về nghệ thuật giao tiếp và thấu hiểu con người.','images/dnt.jpg',3),(2,'Tuổi Trẻ Đáng Giá Bao Nhiêu','Rosie Nguyễn',75000,40,2020,'Truyền cảm hứng cho giới trẻ về việc sống có mục tiêu và dấn thân.','images/ttdgbn.jpg',3),(3,'Lập Trình Java Cơ Bản','Nguyễn Văn Nam',120000,30,2021,'Giới thiệu cơ bản về ngôn ngữ lập trình Java.','images/java.jpg',4),(4,'Harry Potter và Hòn Đá Phù Thủy','J.K. Rowling',150000,20,2018,'Phần đầu tiên trong loạt truyện nổi tiếng Harry Potter.','images/hp1.jpg\n',1),(5,'Vũ Trụ Trong Vỏ Hạt Dẻ','Stephen Hawking',180000,15,2016,'Cuốn sách khoa học nổi tiếng giúp bạn hiểu về vũ trụ theo cách đơn giản.','images/vutru.jpg',2),(6,'Tư Duy Nhanh và Chậm','Daniel Kahneman',250000,25,2011,'Khám phá hai hệ thống tư duy định hình cách chúng ta ra quyết định và nhìn nhận thế giới.','images/tu-duy-nhanh-va-cham.jpg',1),(7,'Sapiens: Lược Sử Loài Người','Yuval Noah Harari',299000,30,2015,'Một cái nhìn toàn cảnh về lịch sử nhân loại, từ thời kỳ đồ đá đến cuộc cách mạng công nghệ.','images/luoc-su-loai-nguoi.jpg',2),(8,'Steve Jobs','Walter Isaacson',320000,20,2011,'Cuốn tiểu sử đầy đủ và chân thực duy nhất về cuộc đời của thiên tài sáng tạo Steve Jobs.','images/steve-jobs.jpg',3),(9,'Mật Mã Da Vinci','Dan Brown',180000,45,2003,'Một cuộc phiêu lưu nghẹt thở của giáo sư Robert Langdon đi tìm những bí mật bị che giấu hàng thế kỷ.','images/mat-ma-da-vinci.jpg',7),(10,'Rừng Na Uy','Haruki Murakami',155000,50,1987,'Một câu chuyện hoài niệm về tình yêu, sự mất mát và những lựa chọn của tuổi trẻ trong bối cảnh Tokyo những năm 1960.','images/rung-na-uy.jpg',6),(11,'Atomic Habits','James Clear',135000,70,2018,'Một khuôn khổ đã được chứng minh để cải thiện mỗi ngày. Cuốn sách chỉ ra cách xây dựng thói quen tốt và phá bỏ thói quen xấu.','images/atomic-habits.jpg\n',5),(12,'Súng, Vi Trùng và Thép','Jared Diamond',280000,18,1997,'Lý giải tại sao các xã hội khác nhau trên thế giới lại có những con đường phát triển khác biệt.','images/sung-vi-trung-va-thep.jpg',2),(13,'Từ Tốt Đến Vĩ Đại','Jim Collins',180000,22,2001,'Nghiên cứu về các yếu tố giúp một công ty có thể nhảy vọt từ tốt lên vị thế vĩ đại và duy trì thành công.','images/tu-tot-den-vi-dai.jpg',1),(14,'Khi Hơi Thở Hóa Thinh Không','Paul Kalanithi',110000,35,2016,'Cuốn hồi ký đầy xúc động của một bác sĩ phẫu thuật thần kinh đối mặt với căn bệnh ung thư giai đoạn cuối.','images/khi-hoi-tho-hoa-thinh-khong.jpg',3),(15,'Sự Im Lặng Của Bầy Cừu','Thomas Harris',165000,28,1988,'Cuộc đấu trí kinh điển giữa thực tập sinh FBI Clarice Starling và kẻ ăn thịt người tài ba Hannibal Lecter.','images/su-im-lang-cua-bay-cuu.jpg',7),(16,'Kiêu Hãnh và Định Kiến','Jane Austen',95000,60,1813,'Câu chuyện tình yêu kinh điển vượt qua những rào cản về định kiến xã hội và sự kiêu hãnh cá nhân.','images/kieu-hanh-va-dinh-kien.jpg',6),(17,'Nghệ Thuật Tinh Tế Của Việc \"Đếch\" Quan Tâm','Mark Manson',125000,55,2016,'Một cách tiếp cận thẳng thắn, thực tế để sống một cuộc đời tốt đẹp hơn bằng cách tập trung vào những gì thực sự quan trọng.','images/nghe-thuat-tinh-te.jpg',5),(18,'Quốc Gia Khởi Nghiệp','Dan Senor & Saul Singer',199000,25,2009,'Khám phá những bí mật đằng sau sự thành công thần kỳ của nền kinh tế công nghệ cao Israel.','images/quoc-gia-khoi-nghiep.jpg',1),(19,'Steal Like an Artist','Austin Kleon',90000,40,2012,'10 điều không ai nói với bạn về sáng tạo. Một cuốn sách ngắn gọn và đầy cảm hứng cho bất kỳ ai làm trong ngành sáng tạo.','images/steal-like-an-artist.jpg',4),(20,'Việt Nam Sử Lược','Trần Trọng Kim',210000,30,1920,'Một trong những cuốn sách tổng hợp lịch sử Việt Nam bằng chữ quốc ngữ đầu tiên, có giá trị tham khảo cao.','images/viet-nam-su-luoc.jpg',2);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cartId` int NOT NULL,
  `bookId` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `cartId` (`cartId`),
  KEY `bookId` (`bookId`),
  CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`cartId`) REFERENCES `carts` (`id`),
  CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`bookId`) REFERENCES `books` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
INSERT INTO `cart_items` VALUES (1,1,1,2),(2,1,3,1),(3,2,2,1),(4,3,4,1),(5,3,5,2);
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userId` (`userId`),
  CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` VALUES (1,2,'2025-10-09 01:56:29'),(2,3,'2025-10-09 01:56:29'),(3,4,'2025-10-09 01:56:29');
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (4,'Công nghệ thông tin'),(2,'Khoa học'),(6,'Kinh tế'),(7,'Lịch sử'),(9,'Nghệ thuật & Nhiếp ảnh'),(10,'Sức khỏe & Đời sống'),(3,'Tâm lý - Kỹ năng sống'),(5,'Thiếu nhi'),(8,'Tiểu sử & Hồi ký'),(12,'Trinh thám & Kinh dị'),(1,'Văn học'),(11,'Văn học Lãng mạn');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orderId` int NOT NULL,
  `bookId` int NOT NULL,
  `quantity` int NOT NULL,
  `pricePerUnit` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orderId` (`orderId`),
  KEY `bookId` (`bookId`),
  CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `orders` (`id`),
  CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`bookId`) REFERENCES `books` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

LOCK TABLES `order_details` WRITE;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
INSERT INTO `order_details` VALUES (1,1,1,2,89000),(2,2,3,1,120000),(3,2,2,2,75000),(4,3,5,1,180000),(5,3,4,1,150000),(6,4,1,6,89000),(7,5,1,2,89000),(8,6,1,10,89000),(9,7,1,1,89000),(10,7,3,1,120000),(11,7,5,1,180000),(12,8,1,2,89000),(13,9,1,1,89000),(14,10,6,1,250000),(15,10,9,2,180000),(16,10,12,1,280000),(17,11,1,1,89000),(18,11,3,1,120000),(19,12,1,1,89000);
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `orderDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `totalAmount` double NOT NULL,
  `shippingAddress` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'Pending',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,2,'2025-10-09 01:56:40',178000,'123 Lê Lợi, Đà Nẵng','Cancelled'),(2,3,'2025-10-09 01:56:40',270000,'45 Nguyễn Huệ, TP.HCM','Cancelled'),(3,4,'2025-10-09 01:56:40',330000,'78 Cầu Giấy, Hà Nội','Cancelled'),(4,1,'2025-10-09 06:12:23',534000,'123 Đường Chính, TP. Sách','Cancelled'),(5,1,'2025-10-09 06:47:49',178000,'123 Đường Chính, TP. Sách','Cancelled'),(6,1,'2025-10-09 06:48:11',890000,'123 Đường Chính, TP. Sách','Cancelled'),(7,2,'2025-10-09 19:11:55',389000,'hehe','Cancelled'),(8,1,'2025-10-09 20:57:07',178000,'123 Đường Chính, TP. Sách','Pending'),(9,1,'2025-10-11 17:47:29',89000,'123 Đường Chính, TP. Sách','Completed'),(10,7,'2025-10-13 07:29:08',890000,'Ha Noi','Cancelled'),(11,1,'2025-10-13 14:13:12',209000,'123 Đường Chính, TP. Sách','Shipping'),(12,7,'2025-10-13 19:37:25',89000,'Đông Cương ','Completed');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bookId` int NOT NULL,
  `userId` int NOT NULL,
  `rating` int DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `bookId` (`bookId`),
  KEY `userId` (`userId`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`bookId`) REFERENCES `books` (`id`),
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`),
  CONSTRAINT `reviews_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,1,2,5,'Sách rất hay và hữu ích.','2025-10-09 01:56:51'),(2,2,3,4,'Khá hay, nhưng hơi dài.','2025-10-09 01:56:51'),(3,3,4,5,'Hướng dẫn chi tiết, dễ hiểu cho người mới.','2025-10-09 01:56:51'),(4,4,3,5,'Truyện tuyệt vời, cuốn hút từ đầu đến cuối.','2025-10-09 01:56:51'),(5,5,2,4,'Kiến thức chuyên sâu, nên đọc chậm để hiểu hết.','2025-10-09 01:56:51');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fullname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isAdmin` tinyint(1) DEFAULT '0',
  `createdAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2a$12$YSZzDWMLHiY0VozdjVK34OcqTNeDBcsF9OWm4dDqFz20WmeEOCjnq','Quản Trị Viên','admin@bookstore.com','123 Đường Chính, TP. Sách','0987654321',1,'2025-10-08 12:48:26'),(2,'vananh','1$2a$12$YSZzDWMLHiY0VozdjVK34OcqTNeDBcsF9OWm4dDqFz20WmeEOCjnq','Nguyễn Thị Vân Anh','vananh.nguyen@email.com','456 Đường Phụ, Quận Sách','0123456789',0,'2025-10-08 12:48:26'),(3,'baotrung','$2a$12$YSZzDWMLHiY0VozdjVK34OcqTNeDBcsF9OWm4dDqFz20WmeEOCjnq','Trần Bảo Trung','trung.tran@email.com','789 Ngõ Hẻm, Phố Tri Thức','0912345678',0,'2025-10-08 12:48:26'),(4,'minhhanh','$2a$12$YSZzDWMLHiY0VozdjVK34OcqTNeDBcsF9OWm4dDqFz20WmeEOCjnq','Lê Minh Hạnh','hanh.le@email.com','101 Chung Cư Con Chữ, TP. Văn Hóa','0905123456',0,'2025-10-08 12:48:26'),(5,'Vanloi205','$2a$12$YSZzDWMLHiY0VozdjVK34OcqTNeDBcsF9OWm4dDqFz20WmeEOCjnq','Lê Văn Lợi','levanloi11nmt@gmail.com','Đông Cương','0932366523',0,'2025-10-09 07:28:50'),(7,'hehe','$2a$12$YSZzDWMLHiY0VozdjVK34OcqTNeDBcsF9OWm4dDqFz20WmeEOCjnq','le van thang','levanloi12nmt@gmail.com','Đông Cương ','0932366524',0,'2025-10-09 19:31:12'),(8,'congacon','$2a$12$YSZzDWMLHiY0VozdjVK34OcqTNeDBcsF9OWm4dDqFz20WmeEOCjnq','con ga con','congacon@gmail.com','con ga con','0912345678',0,'2025-10-09 20:20:53');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-14 23:16:25
