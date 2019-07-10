/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50527
 Source Host           : localhost:3306
 Source Schema         : cubtp

 Target Server Type    : MySQL
 Target Server Version : 50527
 File Encoding         : 65001

 Date: 22/05/2019 22:49:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cubtp_book
-- ----------------------------
DROP TABLE IF EXISTS `cubtp_book`;
CREATE TABLE `cubtp_book`  (
  `book_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '书籍ID',
  `book_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '书籍名称',
  `book_cover` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '书籍封面图片地址',
  `book_author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '书籍作者',
  `book_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '书籍类型',
  `book_subject` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '书籍科目',
  `book_press` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '书籍出版社',
  `book_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '书籍描述',
  `book_price` float(11, 2) NOT NULL COMMENT '书籍价格',
  `book_num` int(11) NOT NULL COMMENT '书籍数量',
  `book_degree` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '书籍新旧程度',
  `book_seller_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '卖家ID',
  `book_status` int(11) NULL DEFAULT NULL COMMENT '书籍审核状态(0:未审核 1: 审核通过 2:未通过审核)',
  `book_upload_date` datetime NULL DEFAULT NULL COMMENT '书籍上传时间',
  PRIMARY KEY (`book_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cubtp_book
-- ----------------------------
INSERT INTO `cubtp_book` VALUES (21, '大学英语', 'book_06.jpg', 'jason', '教材', '英语', '人民教育出版社', '这是一本好书！！！！', 32.00, 6, '八成新', '123', 1, '2019-05-07 21:47:59');
INSERT INTO `cubtp_book` VALUES (22, '高等数学', 'book_02.jpg', 'JJL', '教材', '数学与应用数学', '人民出版社', '走过路过别错过！！！', 25.00, 3, '六成新', '123', 1, '2019-05-07 21:59:11');
INSERT INTO `cubtp_book` VALUES (23, '软件工程', 'book_03.jpg', '高尔基', '教材', '软件工程', '人民教育出版社', '程序员必备！！', 56.00, 4, '七成新', '123', 1, '2019-05-07 22:03:39');
INSERT INTO `cubtp_book` VALUES (24, '新华字典', 'book_11.jpg', '众多', '工具书', '其它', '新华出版社', '仅此一本，大甩卖！！！', 101.00, 1, '六成新', '123', 1, '2019-05-07 22:04:41');
INSERT INTO `cubtp_book` VALUES (25, '应用化学', 'book_04.jpg', 'pdd', '教材', '应用化学', '人民教育出版社', '化学相关的书籍，值得拥有！！', 5.50, 9, '六成新', '123', 1, '2019-05-16 09:26:41');
INSERT INTO `cubtp_book` VALUES (26, '星周刊', 'book_01.jpg', 'tony', '娱乐周刊', '其它', '娱乐出版社', '去年到手的，现在贱卖！！', 10.00, 5, '十成新', '123', 1, '2019-05-16 09:28:24');
INSERT INTO `cubtp_book` VALUES (27, '一封家书', 'book_06.jpg', 'xxx', '日记', '其它', '电子科大出版社', '很喜欢的一本书！！！！！', 16.00, 18, '七成新', '123', 1, '2019-05-16 09:31:04');
INSERT INTO `cubtp_book` VALUES (28, 'JavaWeb入门教材', 'book_08.jpg', 'bbc', '教材', '信息与计算科学', '北京邮电大学出版社', '几乎全新，值得拥有！！！！', 50.00, 2, '八成新', '123', 1, '2019-05-16 09:32:40');
INSERT INTO `cubtp_book` VALUES (29, '数据结构', 'book_10.jpg', 'hhh', '教材', '信息与计算科学', '邮电大学出版社', '去年的书，需要的赶快！！！', 15.00, 3, '六成新', 'jason', 1, '2019-05-16 09:37:06');
INSERT INTO `cubtp_book` VALUES (30, '数据库', 'book_05.jpg', 'mmmm', '教材', '信息与计算科学', '清华大学出版社', '大二的学弟学妹，此书必备！！！', 32.00, 4, '九成新', 'jason', 1, '2019-05-16 09:38:18');
INSERT INTO `cubtp_book` VALUES (31, '数字媒体', 'book_09.jpg', 'ggg', '教材', '信息与计算科学', '北京大学出版社', '值得入手！！！', 15.00, 3, '七成新', 'jason', 1, '2019-05-16 09:50:20');
INSERT INTO `cubtp_book` VALUES (32, '大学英语4', 'book_07.jpg', 'tom', '教材', '英语', 'bbc出版社', '出售了啊！！！', 25.00, 5, '九成新', 'jason', 1, '2019-05-16 09:52:19');
INSERT INTO `cubtp_book` VALUES (33, '计算机网络', 'book_12.jpg', 'mml', '教材', '信息与计算科学', '人民教育出版社', '才到手，速来！！', 23.00, 3, '八成新', 'test1', 1, '2019-05-16 09:53:58');

-- ----------------------------
-- Table structure for cubtp_book_subject
-- ----------------------------
DROP TABLE IF EXISTS `cubtp_book_subject`;
CREATE TABLE `cubtp_book_subject`  (
  `id` int(11) NOT NULL,
  `book_subject` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '书籍科目',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cubtp_book_subject
-- ----------------------------
INSERT INTO `cubtp_book_subject` VALUES (1, '英语');
INSERT INTO `cubtp_book_subject` VALUES (2, '软件工程');
INSERT INTO `cubtp_book_subject` VALUES (3, '应用化学');
INSERT INTO `cubtp_book_subject` VALUES (4, '电子信息工程');
INSERT INTO `cubtp_book_subject` VALUES (5, '市场营销');
INSERT INTO `cubtp_book_subject` VALUES (6, '法学');
INSERT INTO `cubtp_book_subject` VALUES (7, '信息与计算科学');
INSERT INTO `cubtp_book_subject` VALUES (8, '广告学');
INSERT INTO `cubtp_book_subject` VALUES (9, '数学与应用数学');
INSERT INTO `cubtp_book_subject` VALUES (10, '美术类');
INSERT INTO `cubtp_book_subject` VALUES (11, '其它');

-- ----------------------------
-- Table structure for cubtp_book_type
-- ----------------------------
DROP TABLE IF EXISTS `cubtp_book_type`;
CREATE TABLE `cubtp_book_type`  (
  `id` int(11) NOT NULL,
  `book_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '书籍类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cubtp_book_type
-- ----------------------------
INSERT INTO `cubtp_book_type` VALUES (1, '教材');
INSERT INTO `cubtp_book_type` VALUES (2, '工具书');
INSERT INTO `cubtp_book_type` VALUES (3, '报告');
INSERT INTO `cubtp_book_type` VALUES (4, '小说');
INSERT INTO `cubtp_book_type` VALUES (5, '日记');
INSERT INTO `cubtp_book_type` VALUES (6, '手册');
INSERT INTO `cubtp_book_type` VALUES (7, '专业书');
INSERT INTO `cubtp_book_type` VALUES (8, '娱乐周刊');
INSERT INTO `cubtp_book_type` VALUES (9, '摄影绘画');
INSERT INTO `cubtp_book_type` VALUES (10, '儿童读物');
INSERT INTO `cubtp_book_type` VALUES (11, '其它');

-- ----------------------------
-- Table structure for cubtp_comment
-- ----------------------------
DROP TABLE IF EXISTS `cubtp_comment`;
CREATE TABLE `cubtp_comment`  (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `comment_user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论用户ID',
  `comment_book_id` int(11) NULL DEFAULT NULL COMMENT '评论书籍ID',
  `comment_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论内容',
  `comment_date` datetime NULL DEFAULT NULL COMMENT '评论时间',
  PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for cubtp_order
-- ----------------------------
DROP TABLE IF EXISTS `cubtp_order`;
CREATE TABLE `cubtp_order`  (
  `order_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单属于那个用户',
  `order_book_id` int(11) NULL DEFAULT NULL COMMENT '订单中的书籍',
  `order_price` float(11, 2) NULL DEFAULT NULL COMMENT '订单价格',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '订单数量',
  `order_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配送地址',
  `order_user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人姓名',
  `order_user_tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人电话',
  `order_user_remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单备注',
  `order_send_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '未发货' COMMENT '发货状态',
  `order_receive_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '待收货' COMMENT '收货状态',
  `order_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '未完成' COMMENT '订单状态（完成与未完成，已取消）',
  `order_date` datetime NULL DEFAULT NULL COMMENT '订单时间',
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cubtp_order
-- ----------------------------
INSERT INTO `cubtp_order` VALUES (1, '123', 32, 75.00, 3, '28-702', '金成', '13022339520', '123456456', '已发货', '已收货', '已完成', '2019-05-16 10:15:07');
INSERT INTO `cubtp_order` VALUES (2, 'jason', 32, 25.00, 1, '28-702', 'jason', '123456789', '佛挡杀佛规范给复读', '未发货', '待收货', '未完成', '2019-05-21 17:21:35');
INSERT INTO `cubtp_order` VALUES (3, 'jason', 21, 32.00, 1, '28-703', 'jason', '12112121', '给复读给复读', '未发货', '待收货', '未完成', '2019-05-21 17:25:15');
INSERT INTO `cubtp_order` VALUES (4, '123', 33, 23.00, 1, '28-231', '123', '12345678', '2222222', '未发货', '待收货', '未完成', '2019-05-21 18:05:40');

-- ----------------------------
-- Table structure for cubtp_user
-- ----------------------------
DROP TABLE IF EXISTS `cubtp_user`;
CREATE TABLE `cubtp_user`  (
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户ID',
  `user_pwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码',
  `user_tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户电话',
  `user_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户邮箱',
  `user_head_img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'default_headImage.jpg' COMMENT '用户头像',
  `user_role` int(2) NULL DEFAULT NULL COMMENT '用户角色(0：普通用户，1：管理员)',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of cubtp_user
-- ----------------------------
INSERT INTO `cubtp_user` VALUES ('123', '202cb962ac59075b964b07152d234b70', '123', '123', '123.jpg', 0);
INSERT INTO `cubtp_user` VALUES ('admin', '698d51a19d8a121ce581499d7b701668', '10086', '123456789@cqupt.com', 'default_headImage.jpg', 1);
INSERT INTO `cubtp_user` VALUES ('jason', 'e10adc3949ba59abbe56e057f20f883e', '13022339520', '535129594@qq.com', 'default_headImage.jpg', 0);
INSERT INTO `cubtp_user` VALUES ('test1', '202cb962ac59075b964b07152d234b70', '123', '123', 'default_headImage.jpg', 0);

SET FOREIGN_KEY_CHECKS = 1;
