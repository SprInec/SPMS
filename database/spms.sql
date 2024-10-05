/*
 Navicat Premium Data Transfer

 Source Server         : demo
 Source Server Type    : MySQL
 Source Server Version : 80036
 Source Host           : localhost:3306
 Source Schema         : spms

 Target Server Type    : MySQL
 Target Server Version : 80036
 File Encoding         : 65001

 Date: 14/05/2024 12:30:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accounts
-- ----------------------------
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `userid` int NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `rights` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `account`(`account` ASC) USING BTREE,
  UNIQUE INDEX `userid`(`userid` ASC) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of accounts
-- ----------------------------
INSERT INTO `accounts` VALUES (1, 0, 'SprIne', 'sprine', 'sprine', 'admin');
INSERT INTO `accounts` VALUES (2, 1, '陈致远', 'chen', 'chen', 'normal');
INSERT INTO `accounts` VALUES (3, 8, '李宁宁', 'ning', 'ning', 'normal');
INSERT INTO `accounts` VALUES (5, NULL, NULL, 'test', '11', 'normal');

-- ----------------------------
-- Table structure for applicant_info
-- ----------------------------
DROP TABLE IF EXISTS `applicant_info`;
CREATE TABLE `applicant_info`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `applicantName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `position` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `contactWay` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `introduce` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of applicant_info
-- ----------------------------
INSERT INTO `applicant_info` VALUES (1, '周志勇', '理论物理副教授', '17866569834', '我对贵校的理论物理副教授职位极感兴趣。持有理论物理博士学位，专注于量子信息研究，拥有丰富的研究和教学经验。我在量子计算和通信领域取得了显著成果，期待能将我的知识和热情带到贵校，激发学生兴趣，共同推进物理科学教育和研究。');

-- ----------------------------
-- Table structure for attendance
-- ----------------------------
DROP TABLE IF EXISTS `attendance`;
CREATE TABLE `attendance`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `check_in` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `check_out` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `employee_id`(`employee_id` ASC) USING BTREE,
  CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 205 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of attendance
-- ----------------------------
INSERT INTO `attendance` VALUES (1, 11, '袁睿', '2024-05-13 09:10:00', '2024-05-13 16:00:00', '迟到, 早退');
INSERT INTO `attendance` VALUES (2, 55, '吕致远', '2024-05-13 15:53:35', '2024-05-13 11:10:01', '正常');
INSERT INTO `attendance` VALUES (3, 31, '董晓明', '2024-05-13 18:02:00', '2024-05-13 03:48:39', '早退');
INSERT INTO `attendance` VALUES (4, 6, '向宇宁', '2024-05-13 09:44:25', '2024-05-13 03:32:42', '迟到');
INSERT INTO `attendance` VALUES (5, 65, '郑致远', '2024-05-13 08:52:30', '2024-05-13 12:40:09', '正常');
INSERT INTO `attendance` VALUES (6, 26, '范璐', '2024-05-13 01:16:58', '2024-05-13 14:48:05', '迟到');
INSERT INTO `attendance` VALUES (7, 46, '邓岚', '2024-05-13 11:03:30', '2024-05-13 02:20:17', '迟到');
INSERT INTO `attendance` VALUES (8, 91, '周子异', '2024-05-13 00:00:09', '2024-05-13 00:42:35', '正常');
INSERT INTO `attendance` VALUES (9, 80, '邹致远', '2024-05-13 14:57:26', '2024-05-13 01:50:10', '迟到，早退');
INSERT INTO `attendance` VALUES (10, 70, '郭宇宁', '2024-05-13 07:40:27', '2024-05-13 01:02:04', '正常');
INSERT INTO `attendance` VALUES (11, 42, '丁晓明', '2024-05-13 23:59:29', '2024-05-13 18:01:02', '正常');
INSERT INTO `attendance` VALUES (12, 92, '沈詩涵', '2024-05-13 18:27:17', '2024-05-13 06:40:25', '正常');
INSERT INTO `attendance` VALUES (13, 29, '杜安琪', '2024-05-13 02:30:58', '2024-05-13 14:20:10', '迟到，早退');
INSERT INTO `attendance` VALUES (14, 22, '任宇宁', '2024-05-13 05:00:58', '2024-05-13 10:28:12', '迟到');
INSERT INTO `attendance` VALUES (15, 13, '陆致远', '2024-05-13 23:34:47', '2024-05-13 02:57:55', '迟到，早退');
INSERT INTO `attendance` VALUES (16, 10, '钱岚', '2024-05-13 03:40:41', '2024-05-13 12:45:37', '早退');
INSERT INTO `attendance` VALUES (17, 79, '郑云熙', '2024-05-13 15:26:00', '2024-05-13 20:17:12', '迟到');
INSERT INTO `attendance` VALUES (18, 14, '董子韬', '2024-05-13 04:25:20', '2024-05-13 06:26:00', '迟到，早退');
INSERT INTO `attendance` VALUES (19, 84, '潘岚', '2024-05-13 23:35:18', '2024-05-13 17:32:06', '迟到');
INSERT INTO `attendance` VALUES (20, 34, '姜秀英', '2024-05-13 07:15:54', '2024-05-13 05:50:33', '正常');
INSERT INTO `attendance` VALUES (21, 17, '毛子韬', '2024-05-13 04:52:20', '2024-05-13 15:46:37', '迟到');
INSERT INTO `attendance` VALUES (22, 7, '于宇宁', '2024-05-13 18:47:58', '2024-05-13 15:00:14', '迟到，早退');
INSERT INTO `attendance` VALUES (23, 35, '许震南', '2024-05-13 09:44:43', '2024-05-13 01:39:02', '迟到');
INSERT INTO `attendance` VALUES (24, 54, '罗致远', '2024-05-13 12:45:15', '2024-05-13 19:43:05', '迟到');
INSERT INTO `attendance` VALUES (25, 36, '向子异', '2024-05-13 10:48:30', '2024-05-13 17:20:57', '早退');
INSERT INTO `attendance` VALUES (26, 30, '段云熙', '2024-05-13 23:13:41', '2024-05-13 18:11:03', '正常');
INSERT INTO `attendance` VALUES (27, 50, '严岚', '2024-05-13 15:38:26', '2024-05-13 07:05:17', '迟到，早退');
INSERT INTO `attendance` VALUES (29, 43, '林杰宏', '2024-05-13 20:09:51', '2024-05-13 12:39:02', '正常');
INSERT INTO `attendance` VALUES (30, 67, '叶晓明', '2024-05-13 20:11:28', '2024-05-13 03:51:09', '正常');
INSERT INTO `attendance` VALUES (31, 8, '李宁宁', '2024-05-13 17:26:10', '2024-05-13 05:04:44', '正常');
INSERT INTO `attendance` VALUES (32, 68, '罗嘉伦', '2024-05-13 15:37:07', '2024-05-13 18:32:27', '迟到');
INSERT INTO `attendance` VALUES (33, 75, '史嘉伦', '2024-05-13 21:27:30', '2024-05-13 21:53:41', '正常');
INSERT INTO `attendance` VALUES (34, 72, '陆杰宏', '2024-05-13 16:56:56', '2024-05-13 01:46:08', '迟到，早退');
INSERT INTO `attendance` VALUES (35, 73, '彭岚', '2024-05-13 09:59:26', '2024-05-13 06:33:32', '正常');
INSERT INTO `attendance` VALUES (36, 61, '龙云熙', '2024-05-13 02:36:52', '2024-05-13 21:50:51', '早退');
INSERT INTO `attendance` VALUES (37, 24, '邓詩涵', '2024-05-13 11:11:29', '2024-05-13 22:41:42', '早退');
INSERT INTO `attendance` VALUES (38, 20, '贾秀英', '2024-05-13 00:25:32', '2024-05-13 11:23:10', '早退');
INSERT INTO `attendance` VALUES (39, 94, '段睿', '2024-05-13 16:20:35', '2024-05-13 07:07:17', '迟到，早退');
INSERT INTO `attendance` VALUES (40, 77, '张岚', '2024-05-13 21:06:16', '2024-05-13 23:54:02', '迟到');
INSERT INTO `attendance` VALUES (41, 40, '何云熙', '2024-05-13 05:49:54', '2024-05-13 09:57:09', '迟到，早退');
INSERT INTO `attendance` VALUES (42, 64, '沈子韬', '2024-05-13 00:10:20', '2024-05-13 12:48:35', '迟到');
INSERT INTO `attendance` VALUES (43, 39, '严秀英', '2024-05-13 14:33:19', '2024-05-13 13:02:24', '迟到');
INSERT INTO `attendance` VALUES (44, 63, '戴子韬', '2024-05-13 10:55:16', '2024-05-13 06:05:41', '迟到，早退');
INSERT INTO `attendance` VALUES (45, 47, '周震南', '2024-05-13 00:58:28', '2024-05-13 19:16:43', '迟到');
INSERT INTO `attendance` VALUES (46, 16, '汤宇宁', '2024-05-13 17:36:19', '2024-05-13 08:07:11', '早退');
INSERT INTO `attendance` VALUES (47, 62, '于晓明', '2024-05-13 06:44:13', '2024-05-13 21:10:22', '迟到');
INSERT INTO `attendance` VALUES (48, 45, '龚杰宏', '2024-05-13 16:26:28', '2024-05-13 15:38:41', '早退');
INSERT INTO `attendance` VALUES (49, 49, '孔安琪', '2024-05-13 06:21:47', '2024-05-13 12:44:52', '迟到');
INSERT INTO `attendance` VALUES (50, 71, '董詩涵', '2024-05-13 22:40:27', '2024-05-13 02:41:18', '迟到，早退');
INSERT INTO `attendance` VALUES (51, 9, '魏璐', '2024-05-13 04:21:46', '2024-05-13 10:30:03', '正常');
INSERT INTO `attendance` VALUES (52, 98, '侯子异', '2024-05-13 12:11:25', '2024-05-13 12:53:46', '迟到');
INSERT INTO `attendance` VALUES (53, 90, '丁安琪', '2024-05-13 04:24:35', '2024-05-13 02:43:59', '正常');
INSERT INTO `attendance` VALUES (54, 51, '毛云熙', '2024-05-13 09:20:16', '2024-05-13 01:19:19', '正常');
INSERT INTO `attendance` VALUES (55, 27, '胡睿', '2024-05-13 05:53:03', '2024-05-13 13:32:39', '迟到，早退');
INSERT INTO `attendance` VALUES (56, 59, '宋睿', '2024-05-13 08:19:04', '2024-05-13 10:28:29', '迟到，早退');
INSERT INTO `attendance` VALUES (57, 4, '邹秀英', '2024-05-13 10:25:47', '2024-05-13 12:04:52', '早退');
INSERT INTO `attendance` VALUES (58, 44, '邵云熙', '2024-05-13 07:46:22', '2024-05-13 16:51:20', '迟到');
INSERT INTO `attendance` VALUES (59, 32, '方子韬', '2024-05-13 05:28:35', '2024-05-13 14:19:22', '早退');
INSERT INTO `attendance` VALUES (60, 93, '曾秀英', '2024-05-13 07:06:10', '2024-05-13 00:28:36', '早退');
INSERT INTO `attendance` VALUES (61, 69, '蒋晓明', '2024-05-13 19:10:35', '2024-05-13 11:13:20', '迟到');
INSERT INTO `attendance` VALUES (62, 81, '龙璐', '2024-05-13 20:48:08', '2024-05-13 02:58:09', '迟到，早退');
INSERT INTO `attendance` VALUES (63, 85, '戴秀英', '2024-05-13 11:41:05', '2024-05-13 15:54:53', '正常');
INSERT INTO `attendance` VALUES (64, 96, '林嘉伦', '2024-05-13 12:42:39', '2024-05-13 19:02:52', '正常');
INSERT INTO `attendance` VALUES (65, 25, '曾杰宏', '2024-05-13 03:24:02', '2024-05-13 01:24:09', '早退');
INSERT INTO `attendance` VALUES (66, 89, '熊安琪', '2024-05-13 08:59:25', '2024-05-13 05:02:29', '正常');
INSERT INTO `attendance` VALUES (67, 1, '陈致远', '2024-05-13 10:45:44', '2024-05-13 20:57:13', '迟到');
INSERT INTO `attendance` VALUES (68, 56, '韩秀英', '2024-05-13 18:35:05', '2024-05-13 05:04:08', '迟到，早退');
INSERT INTO `attendance` VALUES (69, 66, '尹致远', '2024-05-13 22:55:14', '2024-05-13 01:05:04', '迟到');
INSERT INTO `attendance` VALUES (70, 41, '黄嘉伦', '2024-05-13 14:35:39', '2024-05-13 02:13:49', '迟到');
INSERT INTO `attendance` VALUES (71, 82, '姚子韬', '2024-05-13 17:55:59', '2024-05-13 18:49:58', '迟到');
INSERT INTO `attendance` VALUES (72, 97, '任云熙', '2024-05-13 03:31:53', '2024-05-13 22:51:32', '迟到，早退');
INSERT INTO `attendance` VALUES (73, 23, '钟云熙', '2024-05-13 19:26:51', '2024-05-13 09:21:48', '正常');
INSERT INTO `attendance` VALUES (74, 87, '曹詩涵', '2024-05-13 19:04:03', '2024-05-13 12:09:52', '早退');
INSERT INTO `attendance` VALUES (75, 83, '汤子韬', '2024-05-13 18:36:11', '2024-05-13 12:41:23', '迟到，早退');
INSERT INTO `attendance` VALUES (76, 33, '程岚', '2024-05-13 12:19:48', '2024-05-13 17:26:29', '迟到');
INSERT INTO `attendance` VALUES (77, 74, '崔云熙', '2024-05-13 17:00:45', '2024-05-13 07:24:32', '早退');
INSERT INTO `attendance` VALUES (78, 58, '曹嘉伦', '2024-05-13 08:22:36', '2024-05-13 16:22:11', '迟到，早退');
INSERT INTO `attendance` VALUES (79, 15, '程致远', '2024-05-13 00:58:34', '2024-05-13 01:55:28', '正常');
INSERT INTO `attendance` VALUES (80, 37, '林秀英', '2024-05-13 19:38:52', '2024-05-13 12:42:13', '早退');
INSERT INTO `attendance` VALUES (81, 76, '汤致远', '2024-05-13 01:57:31', '2024-05-13 23:22:48', '正常');
INSERT INTO `attendance` VALUES (82, 57, '朱云熙', '2024-05-13 18:14:52', '2024-05-13 23:37:50', '早退');
INSERT INTO `attendance` VALUES (83, 52, '陈詩涵', '2024-05-13 19:47:54', '2024-05-13 02:14:39', '迟到');
INSERT INTO `attendance` VALUES (84, 95, '孟致远', '2024-05-13 01:58:51', '2024-05-13 14:11:24', '正常');
INSERT INTO `attendance` VALUES (85, 12, '严致远', '2024-05-13 06:14:15', '2024-05-13 11:40:47', '正常');
INSERT INTO `attendance` VALUES (86, 88, '余子异', '2024-05-13 19:14:08', '2024-05-13 22:22:16', '正常');
INSERT INTO `attendance` VALUES (87, 21, '蒋安琪', '2024-05-13 07:50:48', '2024-05-13 20:56:43', '早退');
INSERT INTO `attendance` VALUES (88, 38, '曹璐', '2024-05-13 19:17:57', '2024-05-13 18:47:15', '迟到，早退');
INSERT INTO `attendance` VALUES (89, 3, '徐宇宁', '2024-05-13 10:56:40', '2024-05-13 07:14:44', '迟到');
INSERT INTO `attendance` VALUES (90, 78, '杜岚', '2024-05-13 10:24:47', '2024-05-13 05:13:07', '早退');
INSERT INTO `attendance` VALUES (91, 19, '余致远', '2024-05-13 18:13:38', '2024-05-13 17:22:55', '迟到');
INSERT INTO `attendance` VALUES (92, 48, '范致远', '2024-05-13 10:19:58', '2024-05-13 16:42:12', '迟到，早退');
INSERT INTO `attendance` VALUES (93, 5, '贾子异', '2024-05-13 22:17:33', '2024-05-13 23:15:53', '迟到，早退');
INSERT INTO `attendance` VALUES (94, 53, '姚杰宏', '2024-05-13 06:01:40', '2024-05-13 10:16:21', '正常');
INSERT INTO `attendance` VALUES (96, 28, '唐岚', '2024-05-13 06:55:41', '2024-05-13 05:44:58', '迟到');
INSERT INTO `attendance` VALUES (97, 2, '金宇宁', '2024-05-13 22:14:08', '2024-05-13 15:13:17', '迟到');
INSERT INTO `attendance` VALUES (98, 60, '郭安琪', '2024-05-13 20:55:51', '2024-05-13 06:33:59', '迟到');
INSERT INTO `attendance` VALUES (99, 18, '郝震南', '2024-05-13 09:50:32', '2024-05-13 08:16:25', '早退');

-- ----------------------------
-- Table structure for employees
-- ----------------------------
DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `sex` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `faculties` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `teaching_years` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `photo_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `photo_filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employees
-- ----------------------------
INSERT INTO `employees` VALUES (1, '陈致远', '男', '助教', '外国语学院', '4', '15799574221', 'zc5@icloud.com', 'http://127.0.0.1:5000/static/uploads/photos/2.jpg', '2.jpg');
INSERT INTO `employees` VALUES (2, '金宇宁', '男', '教授', '电子信息学院', '7', '18597751170', 'yuningjin@163.com', NULL, NULL);
INSERT INTO `employees` VALUES (3, '徐宇宁', '男', '教授', '外国语学院', '15', '17834448118', 'yuning6@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (4, '邹秀英', '女', '教授', '外国语学院', '4', '287982398', 'xzou@163.com', 'http://127.0.0.1:5000/static/uploads/photos/3.jpeg', '3.jpeg');
INSERT INTO `employees` VALUES (5, '贾子异', '男', '研究员', '通信工程学院', '3', '1023019325', 'jiaziyi1@outlook.com', NULL, NULL);
INSERT INTO `employees` VALUES (6, '向宇宁', '男', '助理教授', '自动化与控制学院', '6', '2064029606', 'yuningxian@cuit.edu.com', NULL, NULL);
INSERT INTO `employees` VALUES (7, '于宇宁', '男', '助教', '自动化与控制学院', '6', '75508456387', 'yyuning4@163.com', NULL, NULL);
INSERT INTO `employees` VALUES (8, '李宁宁', '女', '讲师', '通信工程学院', '3', '2035649571', 'dinganqi412@yahoo.com', 'http://127.0.0.1:5000/static/uploads/photos/test.jpg', 'test.jpg');
INSERT INTO `employees` VALUES (9, '魏璐', '女', '副教授', '通信工程学院', '15', '108797289', 'luwei@mail.com', 'http://127.0.0.1:5000/static/uploads/photos/4.jpeg', '4.jpeg');
INSERT INTO `employees` VALUES (10, '钱岚', '女', '副教授', '通信工程学院', '12', '7693568204', 'lqian6@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (11, '袁睿', '男', '研究员', '外国语学院', '12', '15310750654', 'yuanrui@outlook.com', NULL, NULL);
INSERT INTO `employees` VALUES (12, '严致远', '男', '助理教授', '自动化与控制学院', '2', '7601503815', 'zhiyyan@yahoo.com', NULL, NULL);
INSERT INTO `employees` VALUES (13, '陆致远', '男', '助教', '马克思学院', '18', '19284872290', 'lzh@icloud.com', NULL, NULL);
INSERT INTO `employees` VALUES (14, '董子韬', '男', '助教', '外国语学院', '18', '18523178083', 'dong6@163.com', NULL, NULL);
INSERT INTO `employees` VALUES (15, '程致远', '男', '助理教授', '通信工程学院', '7', '18955396078', 'zhicheng104@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (16, '汤宇宁', '男', '讲师', '自动化与控制学院', '12', '2115056561', 'tyun2@hotmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (17, '毛子韬', '男', '教授', '自动化与控制学院', '10', '280968041', 'zitao5@icloud.com', NULL, NULL);
INSERT INTO `employees` VALUES (18, '郝震南', '男', '助理教授', '电子信息学院', '4', '19281394072', 'zhhao@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (19, '余致远', '男', '助教', '马克思学院', '9', '76099515173', 'yuzhiyuan@cuit.edu.com', NULL, NULL);
INSERT INTO `employees` VALUES (20, '贾秀英', '女', '助理教授', '自动化与控制学院', '15', '7558785311', 'jixiu19@cuit.edu.com', NULL, NULL);
INSERT INTO `employees` VALUES (21, '蒋安琪', '女', '研究员', '自动化与控制学院', '19', '15492743922', 'ajiang10@outlook.com', NULL, NULL);
INSERT INTO `employees` VALUES (22, '任宇宁', '男', '讲师', '外国语学院', '4', '14876986983', 'yuningre@outlook.com', NULL, NULL);
INSERT INTO `employees` VALUES (23, '钟云熙', '男', '讲师', '通信工程学院', '6', '19378694992', 'yunxi20@cuit.edu.com', NULL, NULL);
INSERT INTO `employees` VALUES (24, '邓詩涵', '女', '助理教授', '通信工程学院', '5', '18379494603', 'dengshihan627@outlook.com', NULL, NULL);
INSERT INTO `employees` VALUES (25, '曾杰宏', '男', '副教授', '自动化与控制学院', '17', '18618888580', 'zengji2@outlook.com', NULL, NULL);
INSERT INTO `employees` VALUES (26, '范璐', '女', '研究员', '自动化与控制学院', '4', '211529881', 'luf10@icloud.com', NULL, NULL);
INSERT INTO `employees` VALUES (27, '胡睿', '男', '助教', '通信工程学院', '17', '107139583', 'hu6@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (28, '唐岚', '女', '助理教授', '自动化与控制学院', '17', '76943287494', 'tanglan@icloud.com', NULL, NULL);
INSERT INTO `employees` VALUES (29, '杜安琪', '女', '副教授', '马克思学院', '11', '2851945154', 'dua7@cuit.edu.com', NULL, NULL);
INSERT INTO `employees` VALUES (30, '段云熙', '男', '研究员', '通信工程学院', '18', '15371163831', 'duayunxi625@cuit.edu.com', NULL, NULL);
INSERT INTO `employees` VALUES (31, '董晓明', '男', '助教', '外国语学院', '15', '7607066731', 'dong3@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (32, '方子韬', '男', '研究员', '自动化与控制学院', '8', '17326038838', 'fangzit@163.com', NULL, NULL);
INSERT INTO `employees` VALUES (33, '程岚', '女', '助教', '自动化与控制学院', '9', '16052305151', 'lacheng@yahoo.com', NULL, NULL);
INSERT INTO `employees` VALUES (34, '姜秀英', '女', '教授', '电子信息学院', '13', '7606636959', 'xiujiang56@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (35, '许震南', '男', '讲师', '电子信息学院', '19', '17732344126', 'xuz@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (36, '向子异', '男', '研究员', '通信工程学院', '10', '215494916', 'xziyi59@hotmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (37, '林秀英', '女', '研究员', '通信工程学院', '18', '19884952474', 'lin5@icloud.com', NULL, NULL);
INSERT INTO `employees` VALUES (38, '曹璐', '女', '教授', '电子信息学院', '10', '17839518341', 'lu3@yahoo.com', NULL, NULL);
INSERT INTO `employees` VALUES (39, '严秀英', '女', '研究员', '外国语学院', '15', '18630472869', 'xiuyingyan@hotmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (40, '何云熙', '男', '助理教授', '自动化与控制学院', '3', '2095843270', 'yunxihe10@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (41, '黄嘉伦', '男', '助教', '通信工程学院', '14', '17607745286', 'jialun8@icloud.com', NULL, NULL);
INSERT INTO `employees` VALUES (42, '丁晓明', '男', '助理教授', '马克思学院', '17', '7696928980', 'ding9@outlook.com', NULL, NULL);
INSERT INTO `employees` VALUES (43, '林杰宏', '男', '助教', '通信工程学院', '10', '17234029340', 'jili@icloud.com', NULL, NULL);
INSERT INTO `employees` VALUES (44, '邵云熙', '男', '助理教授', '马克思学院', '0', '13913034931', 'shao2@hotmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (45, '龚杰宏', '男', '讲师', '电子信息学院', '4', '7697062944', 'jgon@163.com', NULL, NULL);
INSERT INTO `employees` VALUES (46, '邓岚', '女', '副教授', '电子信息学院', '19', '15790425010', 'lan47@outlook.com', NULL, NULL);
INSERT INTO `employees` VALUES (47, '周震南', '男', '研究员', '电子信息学院', '11', '7554724165', 'zhouzhennan1007@mail.com', NULL, NULL);
INSERT INTO `employees` VALUES (48, '范致远', '男', '助理教授', '自动化与控制学院', '7', '17062047763', 'fan3@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (49, '孔安琪', '女', '研究员', '电子信息学院', '12', '15323371357', 'anqi916@163.com', NULL, NULL);
INSERT INTO `employees` VALUES (50, '严岚', '女', '助教', '外国语学院', '3', '2071687824', 'ly1128@outlook.com', NULL, NULL);
INSERT INTO `employees` VALUES (51, '毛云熙', '男', '讲师', '电子信息学院', '20', '1043010998', 'yunxi1209@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (52, '陈詩涵', '女', '助教', '通信工程学院', '8', '2172870734', 'chsh@cuit.edu.com', NULL, NULL);
INSERT INTO `employees` VALUES (53, '姚杰宏', '男', '副教授', '通信工程学院', '10', '104660946', 'yaojiehong9@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (54, '罗致远', '男', '教授', '外国语学院', '15', '7695889358', 'zhiyuanl@icloud.com', NULL, NULL);
INSERT INTO `employees` VALUES (55, '吕致远', '男', '副教授', '电子信息学院', '5', '211830809', 'lu1228@icloud.com', NULL, NULL);
INSERT INTO `employees` VALUES (56, '韩秀英', '女', '助理教授', '电子信息学院', '18', '18979915078', 'xiuyinghan@mail.com', NULL, NULL);
INSERT INTO `employees` VALUES (57, '朱云熙', '男', '副教授', '电子信息学院', '0', '19221784483', 'yuz1979@163.com', NULL, NULL);
INSERT INTO `employees` VALUES (58, '曹嘉伦', '男', '研究员', '电子信息学院', '8', '76996067482', 'caoj@icloud.com', NULL, NULL);
INSERT INTO `employees` VALUES (59, '宋睿', '男', '讲师', '电子信息学院', '10', '76956718605', 'rusong17@cuit.edu.com', NULL, NULL);
INSERT INTO `employees` VALUES (60, '郭安琪', '女', '研究员', '电子信息学院', '8', '7606200601', 'gan923@icloud.com', NULL, NULL);
INSERT INTO `employees` VALUES (61, '龙云熙', '男', '研究员', '外国语学院', '3', '104835442', 'lyu@outlook.com', NULL, NULL);
INSERT INTO `employees` VALUES (62, '于晓明', '男', '副教授', '马克思学院', '9', '16394997855', 'xiaomyu16@icloud.com', NULL, NULL);
INSERT INTO `employees` VALUES (63, '戴子韬', '男', '讲师', '通信工程学院', '2', '13235638031', 'daizit@yahoo.com', NULL, NULL);
INSERT INTO `employees` VALUES (64, '沈子韬', '男', '研究员', '自动化与控制学院', '19', '2865386716', 'zitaos1229@cuit.edu.com', NULL, NULL);
INSERT INTO `employees` VALUES (65, '郑致远', '男', '教授', '外国语学院', '18', '288317335', 'zhengzh@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (66, '尹致远', '男', '教授', '外国语学院', '8', '15934996467', 'yz1964@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (67, '叶晓明', '男', '助教', '通信工程学院', '3', '17708048454', 'xiaomingye@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (68, '罗嘉伦', '男', '助理教授', '自动化与控制学院', '18', '19224329830', 'jialul@outlook.com', NULL, NULL);
INSERT INTO `employees` VALUES (69, '蒋晓明', '男', '教授', '外国语学院', '13', '15194482413', 'jiax73@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (70, '郭宇宁', '男', '讲师', '马克思学院', '3', '17758910663', 'guyuning@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (71, '董詩涵', '女', '助教', '通信工程学院', '11', '7691318716', 'shidong@cuit.edu.com', NULL, NULL);
INSERT INTO `employees` VALUES (72, '陆杰宏', '男', '教授', '电子信息学院', '2', '75556605075', 'jiehlu81@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (73, '彭岚', '女', '副教授', '自动化与控制学院', '13', '200266466', 'pla1945@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (74, '崔云熙', '男', '讲师', '电子信息学院', '3', '15704139587', 'cuiyu@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (75, '史嘉伦', '男', '助理教授', '通信工程学院', '15', '208021088', 'sjialu@mail.com', NULL, NULL);
INSERT INTO `employees` VALUES (76, '汤致远', '男', '教授', '自动化与控制学院', '14', '13871883452', 'tzhiyuan@cuit.edu.com', NULL, NULL);
INSERT INTO `employees` VALUES (77, '张岚', '女', '副教授', '马克思学院', '6', '17491707877', 'lanzhan@mail.com', NULL, NULL);
INSERT INTO `employees` VALUES (78, '杜岚', '女', '副教授', '通信工程学院', '11', '7607718128', 'ladu@163.com', NULL, NULL);
INSERT INTO `employees` VALUES (79, '郑云熙', '男', '研究员', '通信工程学院', '15', '13374904611', 'yzheng@163.com', NULL, NULL);
INSERT INTO `employees` VALUES (80, '邹致远', '男', '教授', '电子信息学院', '20', '19382248050', 'zhiyuanzou64@163.com', NULL, NULL);
INSERT INTO `employees` VALUES (81, '龙璐', '女', '助理教授', '自动化与控制学院', '9', '281086812', 'long8@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (82, '姚子韬', '男', '助理教授', '外国语学院', '15', '2881579063', 'yao410@cuit.edu.com', NULL, NULL);
INSERT INTO `employees` VALUES (83, '汤子韬', '男', '副教授', '外国语学院', '7', '7559286361', 'zitang@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (84, '潘岚', '女', '助理教授', '电子信息学院', '8', '1029811881', 'lpan@hotmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (85, '戴秀英', '女', '助教', '自动化与控制学院', '19', '16388934335', 'daix1@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (86, '贺宇宁', '男', '副教授', '电子信息学院', '7', '76926788112', 'heyuning101@hotmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (87, '曹詩涵', '女', '助教', '电子信息学院', '4', '19714616260', 'shihc1129@hotmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (88, '余子异', '男', '教授', '外国语学院', '6', '287660909', 'yzi813@cuit.edu.com', NULL, NULL);
INSERT INTO `employees` VALUES (89, '熊安琪', '女', '研究员', '通信工程学院', '19', '13124950139', 'xionanqi@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (90, '丁安琪', '女', '助理教授', '外国语学院', '8', '19190691456', 'dingan@icloud.com', NULL, NULL);
INSERT INTO `employees` VALUES (91, '周子异', '男', '讲师', '马克思学院', '19', '2896307034', 'ziyi307@hotmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (92, '沈詩涵', '女', '教授', '通信工程学院', '9', '19489143735', 'shenshihan07@gmail.com', NULL, NULL);
INSERT INTO `employees` VALUES (93, '曾秀英', '女', '副教授', '自动化与控制学院', '10', '76974995640', 'zx3@cuit.edu.com', NULL, NULL);
INSERT INTO `employees` VALUES (94, '段睿', '男', '副教授', '电子信息学院', '4', '76946502026', 'rui68@outlook.com', NULL, NULL);
INSERT INTO `employees` VALUES (95, '孟致远', '男', '副教授', '外国语学院', '5', '7558492369', 'mengz@163.com', NULL, NULL);
INSERT INTO `employees` VALUES (96, '林嘉伦', '男', '助理教授', '马克思学院', '11', '1073682981', 'linj12@cuit.edu.com', NULL, NULL);
INSERT INTO `employees` VALUES (97, '任云熙', '男', '教授', '马克思学院', '14', '16095222436', 'yunxi10@cuit.edu.com', NULL, NULL);
INSERT INTO `employees` VALUES (98, '侯子异', '男', '副教授', '通信工程学院', '19', '16031437817', 'houz@icloud.com', NULL, NULL);

-- ----------------------------
-- Table structure for feedbacks
-- ----------------------------
DROP TABLE IF EXISTS `feedbacks`;
CREATE TABLE `feedbacks`  (
  `number` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `feedback_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `comments` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `date` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`number`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of feedbacks
-- ----------------------------
INSERT INTO `feedbacks` VALUES (1, '彭岚', '职业发展与培训', 'The first step is as good as half over. There is no way to happiness. Happiness is the way. Anyone who has never made a mistake has never tried anything new. To open a query using an                  ', '2003-03-16 23:02:21');
INSERT INTO `feedbacks` VALUES (2, '戴秀英', '工作环境与文化', 'If opportunity doesn’t knock, build a door. Anyone who has ever made anything of importance was disciplined. Navicat Monitor can be installed on any local computer or virtual machine                ', '2002-11-05 00:10:28');
INSERT INTO `feedbacks` VALUES (3, '韩秀英', '家校合作', 'A man is not old until regrets take the place of dreams. In the middle of winter I at last discovered that there was in me an invincible summer. Navicat allows you to transfer data                    ', '2016-08-10 14:01:10');
INSERT INTO `feedbacks` VALUES (4, '唐岚', '教学质量与方法', 'There is no way to happiness. Happiness is the way. Such sessions are also susceptible to session hijacking, where a malicious user takes over your session once you have authenticated.', '2010-07-03 08:43:52');
INSERT INTO `feedbacks` VALUES (5, '许震南', '政策与程序', 'Creativity is intelligence having fun. You can select any connections, objects or projects, and then select the corresponding buttons on the Information Pane. A man’s best friends                   ', '2009-12-20 04:07:17');
INSERT INTO `feedbacks` VALUES (6, '邵云熙', '学校领导与管理', 'If you wait, all that happens is you get older. Actually it is just in an idea when feel oneself can achieve and cannot achieve.', '2013-08-06 13:36:04');
INSERT INTO `feedbacks` VALUES (7, '于宇宁', '技术整合', 'Difficult circumstances serve as a textbook of life for people. Anyone who has never made a mistake has never tried anything new.', '2018-07-14 15:29:47');
INSERT INTO `feedbacks` VALUES (8, '曾杰宏', '职业发展与培训', 'To clear or reload various internal caches, flush tables, or acquire locks, control-click your connection in the Navigation pane and select Flush and choose the flush option. You must                 ', '2001-04-11 21:16:37');
INSERT INTO `feedbacks` VALUES (9, '董詩涵', '校园设施与资源', 'Sometimes you win, sometimes you learn. Navicat Cloud could not connect and access your databases. By which it means, it could only store your connection settings, queries, model files,               ', '2018-10-21 08:43:33');
INSERT INTO `feedbacks` VALUES (10, '林嘉伦', '教学质量与方法', 'To connect to a database or schema, simply double-click it in the pane. Anyone who has ever made anything of importance was disciplined. Navicat Cloud could not connect and access your                ', '2021-09-06 16:05:36');

-- ----------------------------
-- Table structure for job_info
-- ----------------------------
DROP TABLE IF EXISTS `job_info`;
CREATE TABLE `job_info`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `job` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `requirement` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job_info
-- ----------------------------
INSERT INTO `job_info` VALUES (1, '应用数学助理教授', '本校数学系现寻求一位应用数学助理教授，以加强我们在数据科学和数值分析方面的教学与研究。', '博士学位，专业为应用数学或相关领域；展示出在数据科学领域的研究潜力；至少有一年的大学教学经验。', 'cuitperd@cuit.edu.com');
INSERT INTO `job_info` VALUES (2, '理论物理副教授', '寻找一位专注于量子信息或高能物理研究的理论物理副教授，加入我们的物理系。', '在理论物理领域持有博士学位；具有显著的研究成果和发表在国际期刊上的文章；具备优秀的教学和指导研究生的能力。', 'cuitperd@cuit.edu.com');
INSERT INTO `job_info` VALUES (3, '计算机科学与工程助理教授', '计算机科学与工程系正在寻找一位专长于人工智能、机器学习或软件工程的助理教授。', '在计算机科学、人工智能或相关领域持有博士学位；展现出在所专长领域的研究潜力；具有相关的教学经验和团队合作精神。', 'cuitperd@cuit.edu.com');

-- ----------------------------
-- Table structure for jx_achievement
-- ----------------------------
DROP TABLE IF EXISTS `jx_achievement`;
CREATE TABLE `jx_achievement`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `teacher_id` int NULL DEFAULT NULL,
  `subject` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `average_score` float NULL DEFAULT NULL,
  `passing_rate` float NULL DEFAULT NULL,
  `total_score` float NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `teacher_id`(`teacher_id` ASC) USING BTREE,
  CONSTRAINT `jx_achievement_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `employees` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jx_achievement
-- ----------------------------
INSERT INTO `jx_achievement` VALUES (1, 1, '信号与系统', 7.8, 12.9, 17.55);

-- ----------------------------
-- Table structure for jx_colleague_feedbacks
-- ----------------------------
DROP TABLE IF EXISTS `jx_colleague_feedbacks`;
CREATE TABLE `jx_colleague_feedbacks`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `teacher_id` int NULL DEFAULT NULL,
  `question1_score` float NULL DEFAULT NULL,
  `question2_score` float NULL DEFAULT NULL,
  `question3_score` float NULL DEFAULT NULL,
  `question4_score` float NULL DEFAULT NULL,
  `question5_score` float NULL DEFAULT NULL,
  `question6_score` float NULL DEFAULT NULL,
  `question7_score` float NULL DEFAULT NULL,
  `overall_evaluation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `total_score` float NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `teacher_id`(`teacher_id` ASC) USING BTREE,
  CONSTRAINT `jx_colleague_feedbacks_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `employees` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jx_colleague_feedbacks
-- ----------------------------
INSERT INTO `jx_colleague_feedbacks` VALUES (1, 1, 0.8, 1, 1, 0.8, 1, 0.8, 1, '该同事教学热情、责任心强，能够根据学生需求灵活调整教学方法。他们积极参与教研活动，不断提升专业技能，对学生的成长和学业进步起到了积极作用。', 6.4);

-- ----------------------------
-- Table structure for jx_leader_feedbacks
-- ----------------------------
DROP TABLE IF EXISTS `jx_leader_feedbacks`;
CREATE TABLE `jx_leader_feedbacks`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `teacher_id` int NULL DEFAULT NULL,
  `question1_score` float NULL DEFAULT NULL,
  `question2_score` float NULL DEFAULT NULL,
  `question3_score` float NULL DEFAULT NULL,
  `question4_score` float NULL DEFAULT NULL,
  `question5_score` float NULL DEFAULT NULL,
  `target_completion_score` float NULL DEFAULT NULL,
  `overall_evaluation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `total_score` float NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `teacher_id`(`teacher_id` ASC) USING BTREE,
  CONSTRAINT `jx_leader_feedbacks_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `employees` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jx_leader_feedbacks
-- ----------------------------
INSERT INTO `jx_leader_feedbacks` VALUES (1, 1, 4, 5, 4, 5, 3, 5, '该教师表现出色，具备深厚的专业知识和教学能力。在教学方法和学生互动方面展现创新和热情，深受学生喜爱。积极参与教研活动，对教研组的贡献显著。', 26);

-- ----------------------------
-- Table structure for jx_performance_target
-- ----------------------------
DROP TABLE IF EXISTS `jx_performance_target`;
CREATE TABLE `jx_performance_target`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `teacher_id` int NULL DEFAULT NULL,
  `start_time` datetime NULL DEFAULT NULL,
  `end_time` datetime NULL DEFAULT NULL,
  `target` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `teacher_id`(`teacher_id` ASC) USING BTREE,
  CONSTRAINT `jx_performance_target_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `employees` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jx_performance_target
-- ----------------------------
INSERT INTO `jx_performance_target` VALUES (1, 1, '2024-05-01 00:00:00', '2024-09-27 00:00:00', '本学期，我将致力于提高学生的学习兴趣和成绩，通过创新教学方法和增强互动性来促进学生的全面发展。我计划实施更多的分组讨论和项目式学习，以培养学生的批判性思维和解决问题的能力。同时，我也将加强与家长的沟通，确保学生在家和学校之间能有一个良好的学习环境。');

-- ----------------------------
-- Table structure for jx_self_reviews
-- ----------------------------
DROP TABLE IF EXISTS `jx_self_reviews`;
CREATE TABLE `jx_self_reviews`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `teacher_id` int NULL DEFAULT NULL,
  `session_count` int NULL DEFAULT NULL,
  `session_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `research_result_count` int NULL DEFAULT NULL,
  `research_result_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `review_summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `total_score` float NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `teacher_id`(`teacher_id` ASC) USING BTREE,
  CONSTRAINT `jx_self_reviews_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `employees` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jx_self_reviews
-- ----------------------------
INSERT INTO `jx_self_reviews` VALUES (1, 1, 4, '1. \"全球通信工程与技术研讨会（Global Conference on Communication Engineering and Technology）\"\r\n2. \"智能通信系统与网络研讨会（Intelligent Communication Systems and Networks Symposium）\"\r\n3. \"下一代无线通信研讨会（Next-Generation Wireless Communications Workshop）\"\r\n4. \"通信工程创新与应用国际会议（International Conference on Innovations and Applications in Communication Engineering）\"', 3, '1. \"基于深度学习的5G网络资源管理优化策略\"\r\n2. \"量子通信中的高安全性密钥分配机制研究\"\r\n3. \"利用毫米波技术实现超高速无线通信系统设计\"', '本学期，在教学方面，我深化了课程内容，采用互动式教学法提升学生的学习兴趣和参与度。在科研方面，我成功申请了一项研究项目，并在国际期刊上发表了一篇论文，进一步拓展了我的研究领域。同时，我也积极参与学术交流，与同行分享和探讨最新的研究成果和教学方法，不断提升自我。', 1.8);

-- ----------------------------
-- Table structure for jx_student_feedbacks
-- ----------------------------
DROP TABLE IF EXISTS `jx_student_feedbacks`;
CREATE TABLE `jx_student_feedbacks`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `teacher_id` int NULL DEFAULT NULL,
  `teaching_method` float NULL DEFAULT NULL,
  `class_participation` float NULL DEFAULT NULL,
  `course_content` float NULL DEFAULT NULL,
  `assessment_feedback` float NULL DEFAULT NULL,
  `teacher_attitude` float NULL DEFAULT NULL,
  `additional_comments` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `total_score` float NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `teacher_id`(`teacher_id` ASC) USING BTREE,
  CONSTRAINT `jx_student_feedbacks_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `employees` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jx_student_feedbacks
-- ----------------------------
INSERT INTO `jx_student_feedbacks` VALUES (1, 1, 3, 3, 1.8, 2.4, 3, '李老师的课堂充满活力，深受我们喜爱。建议未来能增加更多互动环节，以提高我们的参与度。同时，希望作业反馈能更细致，以助我们更好地理解和进步。感谢您的辛勤付出！', 13.2);

-- ----------------------------
-- Table structure for jx_teacher_scores
-- ----------------------------
DROP TABLE IF EXISTS `jx_teacher_scores`;
CREATE TABLE `jx_teacher_scores`  (
  `teacher_id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `department` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `score` float NULL DEFAULT NULL,
  PRIMARY KEY (`teacher_id`) USING BTREE,
  CONSTRAINT `jx_teacher_scores_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `employees` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jx_teacher_scores
-- ----------------------------
INSERT INTO `jx_teacher_scores` VALUES (1, '陈致远', '助教', '外国语学院', 84.8);
INSERT INTO `jx_teacher_scores` VALUES (2, '金宇宁', '教授', '电子信息学院', 76.2);
INSERT INTO `jx_teacher_scores` VALUES (3, '徐宇宁', '教授', '外国语学院', 81.2);
INSERT INTO `jx_teacher_scores` VALUES (4, '邹秀英', '教授', '外国语学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (5, '贾子异', '研究员', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (6, '向宇宁', '助理教授', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (7, '于宇宁', '助教', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (8, '李宁宁', '讲师', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (9, '魏璐', '副教授', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (10, '钱岚', '副教授', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (11, '袁睿', '研究员', '外国语学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (12, '严致远', '助理教授', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (13, '陆致远', '助教', '马克思学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (14, '董子韬', '助教', '外国语学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (15, '程致远', '助理教授', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (16, '汤宇宁', '讲师', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (17, '毛子韬', '教授', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (18, '郝震南', '助理教授', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (19, '余致远', '助教', '马克思学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (20, '贾秀英', '助理教授', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (21, '蒋安琪', '研究员', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (22, '任宇宁', '讲师', '外国语学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (23, '钟云熙', '讲师', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (24, '邓詩涵', '助理教授', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (25, '曾杰宏', '副教授', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (26, '范璐', '研究员', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (27, '胡睿', '助教', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (28, '唐岚', '助理教授', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (29, '杜安琪', '副教授', '马克思学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (30, '段云熙', '研究员', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (31, '董晓明', '助教', '外国语学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (32, '方子韬', '研究员', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (33, '程岚', '助教', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (34, '姜秀英', '教授', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (35, '许震南', '讲师', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (36, '向子异', '研究员', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (37, '林秀英', '研究员', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (38, '曹璐', '教授', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (39, '严秀英', '研究员', '外国语学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (40, '何云熙', '助理教授', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (41, '黄嘉伦', '助教', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (42, '丁晓明', '助理教授', '马克思学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (43, '林杰宏', '助教', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (44, '邵云熙', '助理教授', '马克思学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (45, '龚杰宏', '讲师', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (46, '邓岚', '副教授', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (47, '周震南', '研究员', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (48, '范致远', '助理教授', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (49, '孔安琪', '研究员', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (50, '严岚', '助教', '外国语学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (51, '毛云熙', '讲师', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (52, '陈詩涵', '助教', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (53, '姚杰宏', '副教授', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (54, '罗致远', '教授', '外国语学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (55, '吕致远', '副教授', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (56, '韩秀英', '助理教授', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (57, '朱云熙', '副教授', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (58, '曹嘉伦', '研究员', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (59, '宋睿', '讲师', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (60, '郭安琪', '研究员', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (61, '龙云熙', '研究员', '外国语学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (62, '于晓明', '副教授', '马克思学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (63, '戴子韬', '讲师', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (64, '沈子韬', '研究员', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (65, '郑致远', '教授', '外国语学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (66, '尹致远', '教授', '外国语学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (67, '叶晓明', '助教', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (68, '罗嘉伦', '助理教授', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (69, '蒋晓明', '教授', '外国语学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (70, '郭宇宁', '讲师', '马克思学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (71, '董詩涵', '助教', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (72, '陆杰宏', '教授', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (73, '彭岚', '副教授', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (74, '崔云熙', '讲师', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (75, '史嘉伦', '助理教授', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (76, '汤致远', '教授', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (77, '张岚', '副教授', '马克思学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (78, '杜岚', '副教授', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (79, '郑云熙', '研究员', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (80, '邹致远', '教授', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (81, '龙璐', '助理教授', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (82, '姚子韬', '助理教授', '外国语学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (83, '汤子韬', '副教授', '外国语学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (84, '潘岚', '助理教授', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (85, '戴秀英', '助教', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (86, '贺宇宁', '副教授', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (87, '曹詩涵', '助教', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (88, '余子异', '教授', '外国语学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (89, '熊安琪', '研究员', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (90, '丁安琪', '助理教授', '外国语学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (91, '周子异', '讲师', '马克思学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (92, '沈詩涵', '教授', '通信工程学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (93, '曾秀英', '副教授', '自动化与控制学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (94, '段睿', '副教授', '电子信息学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (95, '孟致远', '副教授', '外国语学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (96, '林嘉伦', '助理教授', '马克思学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (97, '任云熙', '教授', '马克思学院', NULL);
INSERT INTO `jx_teacher_scores` VALUES (98, '侯子异', '副教授', '通信工程学院', NULL);

-- ----------------------------
-- Table structure for salaries
-- ----------------------------
DROP TABLE IF EXISTS `salaries`;
CREATE TABLE `salaries`  (
  `employee_id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `basic_salary` float NOT NULL,
  `performance_bonus` float NULL DEFAULT NULL,
  PRIMARY KEY (`employee_id`) USING BTREE,
  CONSTRAINT `salaries_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of salaries
-- ----------------------------
INSERT INTO `salaries` VALUES (1, '陈致远', 20000, 11500);
INSERT INTO `salaries` VALUES (2, '金宇宁', 100, 200);
INSERT INTO `salaries` VALUES (3, '徐宇宁', 18150.7, 15139.1);
INSERT INTO `salaries` VALUES (4, '邹秀英', 8188.62, 3536.61);
INSERT INTO `salaries` VALUES (5, '贾子异', 19189.2, 5306.81);
INSERT INTO `salaries` VALUES (6, '向宇宁', 18589.5, 17993.5);
INSERT INTO `salaries` VALUES (7, '于宇宁', 4387.2, 9730.87);
INSERT INTO `salaries` VALUES (8, '李宁宁', 6758.76, 8099.66);
INSERT INTO `salaries` VALUES (9, '魏璐', 14881.6, 11628.4);
INSERT INTO `salaries` VALUES (10, '钱岚', 17230.1, 17964.3);
INSERT INTO `salaries` VALUES (11, '袁睿', 1721.89, 1485.71);
INSERT INTO `salaries` VALUES (12, '严致远', 4025.72, 7850.13);
INSERT INTO `salaries` VALUES (13, '陆致远', 14402.4, 6061.21);
INSERT INTO `salaries` VALUES (14, '董子韬', 16736.9, 10655.3);
INSERT INTO `salaries` VALUES (15, '程致远', 2509.16, 10420.1);
INSERT INTO `salaries` VALUES (16, '汤宇宁', 8348.3, 3392.64);
INSERT INTO `salaries` VALUES (17, '毛子韬', 13105.3, 13131.5);
INSERT INTO `salaries` VALUES (18, '郝震南', 8084.49, 17459.3);
INSERT INTO `salaries` VALUES (19, '余致远', 7482.64, 10363.1);
INSERT INTO `salaries` VALUES (20, '贾秀英', 17488.1, 4462.73);
INSERT INTO `salaries` VALUES (21, '蒋安琪', 18517.2, 5003.32);
INSERT INTO `salaries` VALUES (22, '任宇宁', 3312.13, 4171.03);
INSERT INTO `salaries` VALUES (23, '钟云熙', 4247.64, 10016.7);
INSERT INTO `salaries` VALUES (24, '邓詩涵', 18185.8, 1270.4);
INSERT INTO `salaries` VALUES (25, '曾杰宏', 1338.85, 4022.41);
INSERT INTO `salaries` VALUES (26, '范璐', 15505.4, 11205.7);
INSERT INTO `salaries` VALUES (27, '胡睿', 18535, 4724.42);
INSERT INTO `salaries` VALUES (28, '唐岚', 17696.5, 11467.6);
INSERT INTO `salaries` VALUES (29, '杜安琪', 4312.46, 3350.11);
INSERT INTO `salaries` VALUES (30, '段云熙', 18149.6, 7875.4);
INSERT INTO `salaries` VALUES (31, '董晓明', 2407.85, 16716.3);
INSERT INTO `salaries` VALUES (32, '方子韬', 17723.6, 17115);
INSERT INTO `salaries` VALUES (33, '程岚', 3837.19, 6577.31);
INSERT INTO `salaries` VALUES (34, '姜秀英', 18966.2, 5188.76);
INSERT INTO `salaries` VALUES (35, '许震南', 4620.62, 3829.66);
INSERT INTO `salaries` VALUES (36, '向子异', 9726.96, 13304);
INSERT INTO `salaries` VALUES (37, '林秀英', 4288.9, 12606.8);
INSERT INTO `salaries` VALUES (38, '曹璐', 7640.14, 16199.6);
INSERT INTO `salaries` VALUES (39, '严秀英', 10697.6, 10491);
INSERT INTO `salaries` VALUES (40, '何云熙', 11360.6, 3190.03);
INSERT INTO `salaries` VALUES (41, '黄嘉伦', 6011.62, 17199.2);
INSERT INTO `salaries` VALUES (42, '丁晓明', 12376.5, 4989.48);
INSERT INTO `salaries` VALUES (43, '林杰宏', 10466.4, 11821);
INSERT INTO `salaries` VALUES (44, '邵云熙', 6060.68, 1278.42);
INSERT INTO `salaries` VALUES (45, '龚杰宏', 14439.2, 18892.8);
INSERT INTO `salaries` VALUES (46, '邓岚', 19200, 8468.66);
INSERT INTO `salaries` VALUES (47, '周震南', 2692.91, 17275.4);
INSERT INTO `salaries` VALUES (48, '范致远', 12937.4, 5795.99);
INSERT INTO `salaries` VALUES (49, '孔安琪', 10985.9, 8353.89);
INSERT INTO `salaries` VALUES (50, '严岚', 18002.4, 6563.34);
INSERT INTO `salaries` VALUES (51, '毛云熙', 16952.7, 12456.7);
INSERT INTO `salaries` VALUES (52, '陈詩涵', 9963.9, 7117.18);
INSERT INTO `salaries` VALUES (53, '姚杰宏', 17377.4, 10966.1);
INSERT INTO `salaries` VALUES (54, '罗致远', 17528.5, 9686.66);
INSERT INTO `salaries` VALUES (55, '吕致远', 9110.54, 3721.44);
INSERT INTO `salaries` VALUES (56, '韩秀英', 13190.4, 15559.3);
INSERT INTO `salaries` VALUES (57, '朱云熙', 17159.2, 17013);
INSERT INTO `salaries` VALUES (58, '曹嘉伦', 13197.4, 2096.58);
INSERT INTO `salaries` VALUES (59, '宋睿', 2106.21, 5058.26);
INSERT INTO `salaries` VALUES (60, '郭安琪', 9432.61, 15219.8);
INSERT INTO `salaries` VALUES (61, '龙云熙', 18966.4, 18049);
INSERT INTO `salaries` VALUES (62, '于晓明', 15890.7, 9888.76);
INSERT INTO `salaries` VALUES (63, '戴子韬', 1271.96, 7749.3);
INSERT INTO `salaries` VALUES (64, '沈子韬', 3230.81, 8686.5);
INSERT INTO `salaries` VALUES (65, '郑致远', 7622.39, 3968.23);
INSERT INTO `salaries` VALUES (66, '尹致远', 13978.4, 16564.9);
INSERT INTO `salaries` VALUES (67, '叶晓明', 9285.76, 15634.3);
INSERT INTO `salaries` VALUES (68, '罗嘉伦', 5329.57, 5698.13);
INSERT INTO `salaries` VALUES (69, '蒋晓明', 18150.8, 8472.63);
INSERT INTO `salaries` VALUES (70, '郭宇宁', 13218.2, 6368.67);
INSERT INTO `salaries` VALUES (71, '董詩涵', 13407.9, 17083.7);
INSERT INTO `salaries` VALUES (72, '陆杰宏', 4294.75, 2561.38);
INSERT INTO `salaries` VALUES (73, '彭岚', 8694.77, 13831.5);
INSERT INTO `salaries` VALUES (74, '崔云熙', 15657.8, 10994.7);
INSERT INTO `salaries` VALUES (75, '史嘉伦', 8427.57, 4779.47);
INSERT INTO `salaries` VALUES (76, '汤致远', 16933.8, 2830.61);
INSERT INTO `salaries` VALUES (77, '张岚', 6012.7, 16770.5);
INSERT INTO `salaries` VALUES (78, '杜岚', 13049.4, 2860.68);
INSERT INTO `salaries` VALUES (79, '郑云熙', 14350.9, 5409.63);
INSERT INTO `salaries` VALUES (80, '邹致远', 9717.07, 10448.9);
INSERT INTO `salaries` VALUES (81, '龙璐', 16986.7, 6405.97);
INSERT INTO `salaries` VALUES (82, '姚子韬', 19346, 14625.4);
INSERT INTO `salaries` VALUES (83, '汤子韬', 19449.2, 3065.78);
INSERT INTO `salaries` VALUES (84, '潘岚', 7512.23, 17163.7);
INSERT INTO `salaries` VALUES (85, '戴秀英', 17555.7, 13891.1);
INSERT INTO `salaries` VALUES (86, '贺宇宁', 7806.34, 17371.7);
INSERT INTO `salaries` VALUES (87, '曹詩涵', 11682.3, 5264.1);
INSERT INTO `salaries` VALUES (88, '余子异', 6032.44, 6923.41);
INSERT INTO `salaries` VALUES (89, '熊安琪', 18867.5, 2543.09);
INSERT INTO `salaries` VALUES (90, '丁安琪', 16846.9, 17443.1);
INSERT INTO `salaries` VALUES (91, '周子异', 5337.8, 4374.11);
INSERT INTO `salaries` VALUES (92, '沈詩涵', 7343.75, 5646.15);
INSERT INTO `salaries` VALUES (93, '曾秀英', 3409.2, 7701.3);
INSERT INTO `salaries` VALUES (94, '段睿', 10341.7, 16333.9);
INSERT INTO `salaries` VALUES (95, '孟致远', 16136, 11007.6);
INSERT INTO `salaries` VALUES (96, '林嘉伦', 17449.1, 2071.18);
INSERT INTO `salaries` VALUES (97, '任云熙', 4152.16, 17794.7);
INSERT INTO `salaries` VALUES (98, '侯子异', 1893.57, 6024.56);

-- ----------------------------
-- Table structure for welfare
-- ----------------------------
DROP TABLE IF EXISTS `welfare`;
CREATE TABLE `welfare`  (
  `id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `health_insurance` int NULL DEFAULT NULL,
  `retirement_plans` int NULL DEFAULT NULL,
  `vacation_policies` int NULL DEFAULT NULL,
  `sick_leave` int NULL DEFAULT NULL,
  `holiday_bonuses` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `welfare_ibfk_1` FOREIGN KEY (`id`) REFERENCES `employees` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of welfare
-- ----------------------------
INSERT INTO `welfare` VALUES (1, '陈致远', 0, 0, 0, 10, 900);
INSERT INTO `welfare` VALUES (2, '金宇宁', 1, 1, 0, 21, 11);
INSERT INTO `welfare` VALUES (3, '徐宇宁', 817, 322, 397, 514, 10);
INSERT INTO `welfare` VALUES (4, '邹秀英', 367, 269, 312, 207, 955);
INSERT INTO `welfare` VALUES (5, '贾子异', 25, 563, 1, 900, 887);
INSERT INTO `welfare` VALUES (6, '向宇宁', 152, 135, 163, 791, 542);
INSERT INTO `welfare` VALUES (7, '于宇宁', 69, 967, 192, 661, 17);
INSERT INTO `welfare` VALUES (8, '李宁宁', 42, 600, 8, 580, 990);
INSERT INTO `welfare` VALUES (9, '魏璐', 790, 841, 285, 510, 319);
INSERT INTO `welfare` VALUES (10, '钱岚', 514, 146, 922, 503, 547);
INSERT INTO `welfare` VALUES (11, '袁睿', 887, 138, 683, 987, 916);
INSERT INTO `welfare` VALUES (12, '严致远', 936, 536, 523, 443, 751);
INSERT INTO `welfare` VALUES (13, '陆致远', 997, 222, 869, 508, 284);
INSERT INTO `welfare` VALUES (14, '董子韬', 379, 546, 975, 323, 826);
INSERT INTO `welfare` VALUES (15, '程致远', 204, 198, 195, 159, 257);
INSERT INTO `welfare` VALUES (16, '汤宇宁', 4, 410, 873, 892, 887);
INSERT INTO `welfare` VALUES (17, '毛子韬', 156, 118, 822, 739, 631);
INSERT INTO `welfare` VALUES (18, '郝震南', 631, 879, 56, 975, 502);
INSERT INTO `welfare` VALUES (19, '余致远', 437, 376, 16, 855, 699);
INSERT INTO `welfare` VALUES (20, '贾秀英', 790, 133, 444, 33, 782);
INSERT INTO `welfare` VALUES (21, '蒋安琪', 109, 525, 450, 3, 446);
INSERT INTO `welfare` VALUES (22, '任宇宁', 835, 618, 246, 222, 96);
INSERT INTO `welfare` VALUES (23, '钟云熙', 401, 862, 422, 15, 278);
INSERT INTO `welfare` VALUES (24, '邓詩涵', 191, 136, 252, 512, 554);
INSERT INTO `welfare` VALUES (25, '曾杰宏', 348, 556, 589, 97, 327);
INSERT INTO `welfare` VALUES (26, '范璐', 327, 22, 883, 916, 679);
INSERT INTO `welfare` VALUES (27, '胡睿', 828, 555, 711, 173, 915);
INSERT INTO `welfare` VALUES (28, '唐岚', 202, 389, 850, 118, 285);
INSERT INTO `welfare` VALUES (29, '杜安琪', 694, 783, 188, 595, 745);
INSERT INTO `welfare` VALUES (30, '段云熙', 271, 26, 485, 199, 434);
INSERT INTO `welfare` VALUES (31, '董晓明', 469, 792, 44, 27, 739);
INSERT INTO `welfare` VALUES (32, '方子韬', 620, 510, 165, 682, 427);
INSERT INTO `welfare` VALUES (33, '程岚', 325, 802, 230, 231, 861);
INSERT INTO `welfare` VALUES (34, '姜秀英', 989, 526, 810, 713, 98);
INSERT INTO `welfare` VALUES (35, '许震南', 773, 587, 23, 374, 41);
INSERT INTO `welfare` VALUES (36, '向子异', 637, 984, 742, 30, 101);
INSERT INTO `welfare` VALUES (37, '林秀英', 242, 825, 377, 15, 82);
INSERT INTO `welfare` VALUES (38, '曹璐', 769, 282, 495, 146, 868);
INSERT INTO `welfare` VALUES (39, '严秀英', 847, 824, 79, 364, 965);
INSERT INTO `welfare` VALUES (40, '何云熙', 979, 893, 846, 779, 237);
INSERT INTO `welfare` VALUES (41, '黄嘉伦', 425, 403, 27, 450, 332);
INSERT INTO `welfare` VALUES (42, '丁晓明', 849, 968, 373, 759, 577);
INSERT INTO `welfare` VALUES (43, '林杰宏', 792, 125, 440, 60, 841);
INSERT INTO `welfare` VALUES (44, '邵云熙', 189, 946, 684, 628, 889);
INSERT INTO `welfare` VALUES (45, '龚杰宏', 957, 705, 662, 994, 6);
INSERT INTO `welfare` VALUES (46, '邓岚', 151, 698, 939, 146, 554);
INSERT INTO `welfare` VALUES (47, '周震南', 979, 205, 830, 954, 946);
INSERT INTO `welfare` VALUES (48, '范致远', 375, 707, 616, 950, 793);
INSERT INTO `welfare` VALUES (49, '孔安琪', 259, 54, 486, 823, 153);
INSERT INTO `welfare` VALUES (50, '严岚', 929, 114, 894, 93, 750);
INSERT INTO `welfare` VALUES (51, '毛云熙', 70, 372, 625, 505, 462);
INSERT INTO `welfare` VALUES (52, '陈詩涵', 582, 814, 558, 314, 711);
INSERT INTO `welfare` VALUES (53, '姚杰宏', 214, 526, 949, 741, 202);
INSERT INTO `welfare` VALUES (54, '罗致远', 863, 841, 203, 62, 297);
INSERT INTO `welfare` VALUES (55, '吕致远', 277, 389, 750, 412, 515);
INSERT INTO `welfare` VALUES (56, '韩秀英', 409, 497, 404, 881, 210);
INSERT INTO `welfare` VALUES (57, '朱云熙', 238, 955, 566, 603, 453);
INSERT INTO `welfare` VALUES (58, '曹嘉伦', 984, 951, 31, 18, 627);
INSERT INTO `welfare` VALUES (59, '宋睿', 568, 203, 5, 987, 492);
INSERT INTO `welfare` VALUES (60, '郭安琪', 163, 187, 462, 310, 988);
INSERT INTO `welfare` VALUES (61, '龙云熙', 683, 732, 423, 839, 332);
INSERT INTO `welfare` VALUES (62, '于晓明', 894, 241, 866, 780, 898);
INSERT INTO `welfare` VALUES (63, '戴子韬', 733, 738, 292, 475, 668);
INSERT INTO `welfare` VALUES (64, '沈子韬', 243, 711, 689, 826, 90);
INSERT INTO `welfare` VALUES (65, '郑致远', 372, 629, 576, 774, 39);
INSERT INTO `welfare` VALUES (66, '尹致远', 915, 771, 362, 793, 707);
INSERT INTO `welfare` VALUES (67, '叶晓明', 619, 83, 115, 877, 647);
INSERT INTO `welfare` VALUES (68, '罗嘉伦', 135, 841, 230, 677, 475);
INSERT INTO `welfare` VALUES (69, '蒋晓明', 417, 901, 600, 626, 273);
INSERT INTO `welfare` VALUES (70, '郭宇宁', 917, 494, 245, 459, 820);
INSERT INTO `welfare` VALUES (71, '董詩涵', 386, 428, 347, 632, 145);
INSERT INTO `welfare` VALUES (72, '陆杰宏', 303, 359, 547, 433, 269);
INSERT INTO `welfare` VALUES (73, '彭岚', 33, 803, 919, 720, 761);
INSERT INTO `welfare` VALUES (74, '崔云熙', 542, 331, 307, 539, 87);
INSERT INTO `welfare` VALUES (75, '史嘉伦', 772, 804, 749, 140, 280);
INSERT INTO `welfare` VALUES (76, '汤致远', 585, 77, 501, 80, 158);
INSERT INTO `welfare` VALUES (77, '张岚', 885, 315, 778, 68, 918);
INSERT INTO `welfare` VALUES (78, '杜岚', 435, 77, 729, 265, 4);
INSERT INTO `welfare` VALUES (79, '郑云熙', 319, 257, 835, 47, 147);
INSERT INTO `welfare` VALUES (80, '邹致远', 614, 702, 414, 60, 795);
INSERT INTO `welfare` VALUES (81, '龙璐', 127, 283, 882, 492, 189);
INSERT INTO `welfare` VALUES (82, '姚子韬', 158, 253, 458, 583, 994);
INSERT INTO `welfare` VALUES (83, '汤子韬', 166, 466, 955, 199, 904);
INSERT INTO `welfare` VALUES (84, '潘岚', 779, 312, 724, 792, 240);
INSERT INTO `welfare` VALUES (85, '戴秀英', 329, 844, 611, 290, 748);
INSERT INTO `welfare` VALUES (86, '贺宇宁', 882, 502, 88, 773, 985);
INSERT INTO `welfare` VALUES (87, '曹詩涵', 233, 982, 489, 237, 866);
INSERT INTO `welfare` VALUES (88, '余子异', 788, 412, 165, 368, 260);
INSERT INTO `welfare` VALUES (89, '熊安琪', 240, 679, 345, 750, 219);
INSERT INTO `welfare` VALUES (90, '丁安琪', 256, 568, 732, 108, 92);
INSERT INTO `welfare` VALUES (91, '周子异', 182, 328, 469, 254, 971);
INSERT INTO `welfare` VALUES (92, '沈詩涵', 289, 556, 869, 874, 616);
INSERT INTO `welfare` VALUES (93, '曾秀英', 850, 2, 598, 9, 847);
INSERT INTO `welfare` VALUES (94, '段睿', 872, 367, 86, 339, 484);
INSERT INTO `welfare` VALUES (95, '孟致远', 502, 615, 361, 204, 62);
INSERT INTO `welfare` VALUES (96, '林嘉伦', 75, 686, 195, 601, 223);
INSERT INTO `welfare` VALUES (97, '任云熙', 284, 156, 846, 570, 254);
INSERT INTO `welfare` VALUES (98, '侯子异', 617, 139, 161, 18, 116);

SET FOREIGN_KEY_CHECKS = 1;
