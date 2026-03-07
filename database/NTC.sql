-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Mar 07, 2026 at 04:01 PM
-- Server version: 9.6.0
-- PHP Version: 8.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `NTC`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_commit`
--

CREATE TABLE `tb_commit` (
  `id_commit` int NOT NULL,
  `id_member` int NOT NULL,
  `id_eva` int NOT NULL,
  `status_commit` varchar(1) NOT NULL,
  `level_commit` varchar(100) NOT NULL,
  `detail_commit` text,
  `signature` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_commit`
--

INSERT INTO `tb_commit` (`id_commit`, `id_member`, `id_eva`, `status_commit`, `level_commit`, `detail_commit`, `signature`) VALUES
(4, 2, 2, 'y', 'ประธาน', 'ดีมาก', '1770968301747.png'),
(5, 3, 2, 'y', 'เลขา', 'ไม่มี', '1770968325799.png'),
(6, 4, 2, 'y', 'กรรมการ', 'good', '1770968286759.png'),
(7, 2, 3, 'n', 'เลขา', NULL, NULL),
(8, 3, 3, 'n', 'กรรมการ', NULL, NULL),
(9, 4, 3, 'n', 'ประธาน', NULL, NULL),
(10, 2, 4, 'y', 'เลขา', 'good goodeee', '1770969198586.png'),
(11, 4, 4, 'n', 'กรรมการ', NULL, NULL),
(12, 3, 4, 'n', 'ประธาน', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tb_doc`
--

CREATE TABLE `tb_doc` (
  `id_doc` int NOT NULL,
  `name_doc` varchar(100) NOT NULL,
  `day_doc` date NOT NULL,
  `file` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_doc`
--

INSERT INTO `tb_doc` (`id_doc`, `name_doc`, `day_doc`, `file`) VALUES
(10, 'การอบรม AI', '2026-02-13', '1770968875251.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `tb_eva`
--

CREATE TABLE `tb_eva` (
  `id_eva` int NOT NULL,
  `id_member` int NOT NULL,
  `id_sys` int NOT NULL,
  `status_eva` int NOT NULL,
  `day_eva` date NOT NULL,
  `total_eva` double(10,2) DEFAULT NULL,
  `total_commit` double(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_eva`
--

INSERT INTO `tb_eva` (`id_eva`, `id_member`, `id_sys`, `status_eva`, `day_eva`, `total_eva`, `total_commit`) VALUES
(2, 11, 2, 3, '2026-02-13', 58.00, 125.00),
(3, 10, 2, 1, '2026-02-13', NULL, NULL),
(4, 9, 2, 2, '2026-02-13', 36.00, 39.00);

-- --------------------------------------------------------

--
-- Table structure for table `tb_evadetail`
--

CREATE TABLE `tb_evadetail` (
  `id_eva` int NOT NULL,
  `id_indicate` int NOT NULL,
  `status_eva` int NOT NULL,
  `score_member` int DEFAULT NULL,
  `score_commit` int DEFAULT NULL,
  `detail_eva` text,
  `file_eva` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_evadetail`
--

INSERT INTO `tb_evadetail` (`id_eva`, `id_indicate`, `status_eva`, `score_member`, `score_commit`, `detail_eva`, `file_eva`) VALUES
(2, 8, 1, 4, NULL, NULL, '1770967860928wxrq64dyg3g.png'),
(2, 6, 1, 4, NULL, 'ดูแลได้ดี', NULL),
(2, 7, 1, 3, NULL, NULL, '17709678609318a4tuas11u.pdf'),
(2, 5, 1, 3, NULL, NULL, NULL),
(2, 8, 2, NULL, 1, NULL, NULL),
(2, 6, 2, NULL, 3, NULL, NULL),
(2, 7, 2, NULL, 2, NULL, NULL),
(2, 5, 2, NULL, 4, NULL, NULL),
(2, 8, 4, NULL, 1, NULL, NULL),
(2, 6, 4, NULL, 1, NULL, NULL),
(2, 7, 4, NULL, 2, NULL, NULL),
(2, 5, 4, NULL, 2, NULL, NULL),
(2, 8, 3, NULL, 4, NULL, NULL),
(2, 6, 3, NULL, 4, NULL, NULL),
(2, 7, 3, NULL, 3, NULL, NULL),
(2, 5, 3, NULL, 2, NULL, NULL),
(4, 8, 1, 3, NULL, 'game', '1770969137674xbflhqhtee.png'),
(4, 6, 1, 3, NULL, NULL, NULL),
(4, 7, 1, 2, NULL, NULL, NULL),
(4, 5, 1, 1, NULL, NULL, '1770969137674nqdiriani4a.pdf'),
(4, 8, 4, NULL, 2, NULL, NULL),
(4, 6, 4, NULL, 2, NULL, NULL),
(4, 7, 4, NULL, 3, NULL, NULL),
(4, 5, 4, NULL, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tb_his`
--

CREATE TABLE `tb_his` (
  `id_his` int NOT NULL,
  `id_edit` int NOT NULL,
  `id_member` int NOT NULL,
  `detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_his`
--

INSERT INTO `tb_his` (`id_his`, `id_edit`, `id_member`, `detail`, `date`) VALUES
(8, 5, 11, 'edit', '2026-02-27'),
(9, 5, 7, 'Delete', '2026-02-27'),
(10, 5, 4, 'edit', '2026-03-04');

-- --------------------------------------------------------

--
-- Table structure for table `tb_indicate`
--

CREATE TABLE `tb_indicate` (
  `id_indicate` int NOT NULL,
  `id_topic` int NOT NULL,
  `name_indicate` varchar(100) NOT NULL,
  `detail_indicate` text NOT NULL,
  `point_indicate` int NOT NULL,
  `check_indicate` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_indicate`
--

INSERT INTO `tb_indicate` (`id_indicate`, `id_topic`, `name_indicate`, `detail_indicate`, `point_indicate`, `check_indicate`) VALUES
(1, 1, 'SSS', 'DDD', 5, 'n'),
(2, 1, 'NNN', 'MMM', 5, 'y'),
(3, 2, 'FFF', 'GGG', 5, 'y'),
(4, 2, 'VVV', 'CCC', 5, 'n'),
(5, 5, 'ผู้รับการประเมินทำหน้าที่พิธีกรได้อย่างเหมาะสม', 'กรุณาแนบหลักฐาน', 5, 'y'),
(6, 4, 'ผู้ถูกประเมินสามารถควบคุมดูแลนักเรียนนักศึกษา', 'ไม่ต้องแนบหลักฐาน', 4, 'n'),
(7, 4, 'ทำหน้าที่ผู้นำได้อย่างเหมาะสม', 'ไม่ต้องแนบหลักฐาน', 5, 'y'),
(8, 3, 'พิธีกรแต่งตัวเหมาะสม', 'ไม่ต้องแนบหลักฐาน', 3, 'n');

-- --------------------------------------------------------

--
-- Table structure for table `tb_log`
--

CREATE TABLE `tb_log` (
  `id_log` int NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `user_agent` text,
  `access_date` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_log`
--

INSERT INTO `tb_log` (`id_log`, `username`, `ip_address`, `status`, `user_agent`, `access_date`) VALUES
(2, 'admin', '::ffff:192.168.65.1', 'success', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2026-02-27 10:42:05'),
(3, 'admin', '::ffff:192.168.65.1', 'success', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.5 Mobile/15E148 Safari/604.1', '2026-02-27 21:31:01'),
(4, 'admin', '::ffff:192.168.65.1', 'success', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-02-27 22:16:29'),
(5, 'admin', '::ffff:172.19.0.1', 'success', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-02 08:58:39'),
(6, 'seen', '::ffff:172.19.0.1', 'success', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-02 08:59:00'),
(7, 'zeen', '::ffff:172.19.0.1', 'success', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-02 08:59:18'),
(8, 'admin', '::ffff:172.19.0.1', 'success', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-02 09:03:33'),
(9, 'zeen', '::ffff:172.19.0.1', 'success', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-02 09:03:55'),
(10, 'seen', '::ffff:172.19.0.1', 'success', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-02 09:04:12'),
(11, 'zeen', '::ffff:172.19.0.1', 'success', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-02 09:23:27'),
(12, 'admin', '::ffff:172.19.0.1', 'success', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-04 14:42:45'),
(13, 'admin', '::ffff:172.19.0.1', 'success', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-05 14:23:53'),
(14, 'admin', '::ffff:172.19.0.1', 'success', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-07 05:30:11'),
(15, 'neem', '::ffff:172.18.0.1', 'success', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-07 13:28:12'),
(16, 'meet', '::ffff:172.18.0.1', 'success', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-07 13:28:28'),
(17, 'seen', '::ffff:172.18.0.1', 'success', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-07 13:39:51'),
(18, 'deen', '::ffff:172.18.0.1', 'success', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-07 13:40:13'),
(19, 'admin', '::ffff:172.18.0.1', 'success', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-07 13:40:37'),
(20, 'suchat', '::ffff:172.18.0.1', 'success', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-07 15:01:37'),
(21, 'suchat', '::ffff:172.18.0.1', 'failed', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-07 15:50:49'),
(22, 'suchat', '::ffff:172.18.0.1', 'success', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-07 15:52:59'),
(23, 'suchat', '::ffff:172.18.0.1', 'success', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-07 15:54:45'),
(24, 'meet', '::ffff:172.18.0.1', 'success', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-07 15:55:20'),
(25, 'suchat', '::ffff:172.18.0.1', 'success', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-07 15:56:42'),
(26, 'meet', '::ffff:172.18.0.1', 'success', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-07 15:57:00'),
(27, 'meet', '::ffff:172.18.0.1', 'success', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-07 15:58:21'),
(28, 'suchat', '::ffff:172.18.0.1', 'success', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '2026-03-07 15:58:36');

-- --------------------------------------------------------

--
-- Table structure for table `tb_member`
--

CREATE TABLE `tb_member` (
  `id_member` int NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` enum('ฝ่ายบุคลากร','กรรมการประเมิน','ผู้รับการประเมินผล') NOT NULL,
  `pic_user` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_member`
--

INSERT INTO `tb_member` (`id_member`, `first_name`, `last_name`, `email`, `username`, `password`, `role`, `pic_user`) VALUES
(2, 'seen', 'seen', 'seen@gmail.com', 'seen', '$2b$10$IPIUy/hNt7s8nVAieSrR1.IwQ37bc4baM2MgQQ3peJrRTYySggFMC', 'กรรมการประเมิน', ''),
(3, 'deen', 'deen', 'deen@gmail.com', 'deen', '$2b$10$3wLi9HLC9nV8.jKEUU4IFuLdUohgYMuDqrktnsMZYbhqSqoydJ//i', 'กรรมการประเมิน', ''),
(4, 'feen1', 'feen', 'feen@gmail.com', 'feen', '$2b$10$VStMS3Uw/NDebLK1Gi7iRulcO60ojwDAA4LWgtIRDsTkdPWXwwRRq', 'กรรมการประเมิน', ''),
(5, 'Admin', '1', 'admin@gamil.com', 'admin', '$2b$10$fVgEnlUvihigQwqTapO0HOh6qjFtEIxS3aho2xVbJYf3TNKQC8i2K', 'ฝ่ายบุคลากร', ''),
(6, 'admin', '2', 'admin2@gmail.com', 'admin2', '$2b$10$IfKZvM38X5mf4vT8bHirkeb9vJBIjZNeAqNuasqFUNYYdhcCDluiy', 'ฝ่ายบุคลากร', ''),
(8, 'neem', 'neem', 'neem@gmail.com', 'neem', '$2b$10$EGJE1JJA/1TAERfz92JTUOsN1MXZN10jseKgaDtkhLTYgqVkth1Im', 'ผู้รับการประเมินผล', ''),
(9, 'meet1', 'meet', 'meet@gmail.com', 'meet', '$2b$10$Foah9Dk9J3/c9IhgXoKfo.KRu3TfaZ9pSXgS1cD1IPgq5UTQuXUle', 'ผู้รับการประเมินผล', '1772899093301.png'),
(10, 'ceen', 'ceen', 'ceen@gmail.com', 'ceen', '$2b$10$t.Dj1izpgiMQHnDMKAXUquqiIlvDjCNRLnbVu8rMBJZDWhBPMhSQi', 'ผู้รับการประเมินผล', ''),
(11, 'zeen1', 'zeen1', 'zeen@gmail.com', 'zeen', '$2b$10$rP7j7XqhIYsc/Tk3SBUc0eE9Hc3bFxhFttORaSkefvfkUcL7ZlmEe', 'ผู้รับการประเมินผล', ''),
(12, 'geen', 'geen', 'geen@gmail.com', 'geen', '$2b$10$zEgLlThHOKyRjVVwGZnlXOOJp4n9nHhwjX9f3aiahBfIVlfG40YK6', 'กรรมการประเมิน', ''),
(13, 'jeen', 'jeen', 'jeen@gmail.com', 'jeen', '$2b$10$mDiXozSsLU2yR127ngYegO6oLMEqfepXqnGLltZM3xRes99.OeSKG', 'กรรมการประเมิน', ''),
(14, 'suchat1', 'rattanawiwte1', 'hi@gmail.com', 'suchat', '$2b$10$Z3NA7fQLH8IuTu30sNTXSOF9/IlLAphxrYtiRX6rWPOlPqrwmTm7u', 'ผู้รับการประเมินผล', '1772898874435.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `tb_system`
--

CREATE TABLE `tb_system` (
  `id_sys` int NOT NULL,
  `day_open` date NOT NULL,
  `day_out` date NOT NULL,
  `round_sys` varchar(2) NOT NULL,
  `year_sys` varchar(4) NOT NULL,
  `status_sys` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_system`
--

INSERT INTO `tb_system` (`id_sys`, `day_open`, `day_out`, `round_sys`, `year_sys`, `status_sys`) VALUES
(2, '2026-02-13', '2026-02-13', '1', '2569', 'y');

-- --------------------------------------------------------

--
-- Table structure for table `tb_topic`
--

CREATE TABLE `tb_topic` (
  `id_topic` int NOT NULL,
  `name_topic` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_topic`
--

INSERT INTO `tb_topic` (`id_topic`, `name_topic`) VALUES
(3, 'การอบรม AI'),
(4, 'กิจกรรมเดินทางไกล'),
(5, 'กิจกรรมประกวดร้องเพลง');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_commit`
--
ALTER TABLE `tb_commit`
  ADD PRIMARY KEY (`id_commit`);

--
-- Indexes for table `tb_doc`
--
ALTER TABLE `tb_doc`
  ADD PRIMARY KEY (`id_doc`);

--
-- Indexes for table `tb_eva`
--
ALTER TABLE `tb_eva`
  ADD PRIMARY KEY (`id_eva`);

--
-- Indexes for table `tb_his`
--
ALTER TABLE `tb_his`
  ADD PRIMARY KEY (`id_his`);

--
-- Indexes for table `tb_indicate`
--
ALTER TABLE `tb_indicate`
  ADD PRIMARY KEY (`id_indicate`);

--
-- Indexes for table `tb_log`
--
ALTER TABLE `tb_log`
  ADD PRIMARY KEY (`id_log`);

--
-- Indexes for table `tb_member`
--
ALTER TABLE `tb_member`
  ADD PRIMARY KEY (`id_member`);

--
-- Indexes for table `tb_system`
--
ALTER TABLE `tb_system`
  ADD PRIMARY KEY (`id_sys`);

--
-- Indexes for table `tb_topic`
--
ALTER TABLE `tb_topic`
  ADD PRIMARY KEY (`id_topic`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_commit`
--
ALTER TABLE `tb_commit`
  MODIFY `id_commit` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `tb_doc`
--
ALTER TABLE `tb_doc`
  MODIFY `id_doc` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tb_eva`
--
ALTER TABLE `tb_eva`
  MODIFY `id_eva` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tb_his`
--
ALTER TABLE `tb_his`
  MODIFY `id_his` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tb_indicate`
--
ALTER TABLE `tb_indicate`
  MODIFY `id_indicate` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tb_log`
--
ALTER TABLE `tb_log`
  MODIFY `id_log` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `tb_member`
--
ALTER TABLE `tb_member`
  MODIFY `id_member` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `tb_system`
--
ALTER TABLE `tb_system`
  MODIFY `id_sys` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tb_topic`
--
ALTER TABLE `tb_topic`
  MODIFY `id_topic` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
