/*
 Navicat Premium Data Transfer

 Source Server         : Taller
 Source Server Type    : MySQL
 Source Server Version : 50130
 Source Host           : localhost:3306
 Source Schema         : sistema

 Target Server Type    : MySQL
 Target Server Version : 50130
 File Encoding         : 65001

 Date: 09/06/2023 23:33:57
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (4, 'CARNE DE CERDO');
INSERT INTO `categories` VALUES (6, 'CARNE DE POLLO ');
INSERT INTO `categories` VALUES (3, 'CARNE DE RES');
INSERT INTO `categories` VALUES (7, 'CARNES FINAS');
INSERT INTO `categories` VALUES (2, 'EMBUTIDOS');

-- ----------------------------
-- Table structure for media
-- ----------------------------
DROP TABLE IF EXISTS `media`;
CREATE TABLE `media`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `file_type` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of media
-- ----------------------------
INSERT INTO `media` VALUES (3, 'pechuga de pollo.jpg', 'image/jpeg');
INSERT INTO `media` VALUES (4, 'longaniza_rz.jpg', 'image/jpeg');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `quantity` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `buy_price` decimal(25, 2) NULL DEFAULT NULL,
  `sale_price` decimal(25, 2) NOT NULL,
  `categorie_id` int(11) UNSIGNED NOT NULL,
  `media_id` int(11) NULL DEFAULT 0,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `categorie_id`(`categorie_id`) USING BTREE,
  INDEX `media_id`(`media_id`) USING BTREE,
  CONSTRAINT `FK_products` FOREIGN KEY (`categorie_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (3, 'Longaniza', '-3', 100.00, 150.00, 2, 4, '2023-05-23 12:44:51');
INSERT INTO `products` VALUES (4, 'CHULETA DE CERDO', '10', 150.00, 200.00, 4, 0, '2023-05-23 16:22:44');
INSERT INTO `products` VALUES (5, 'kilo de bistec', '7', 150.00, 165.00, 3, 4, '2023-05-23 23:43:41');

-- ----------------------------
-- Table structure for sales
-- ----------------------------
DROP TABLE IF EXISTS `sales`;
CREATE TABLE `sales`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` int(11) UNSIGNED NOT NULL,
  `qty` int(11) NOT NULL,
  `price` decimal(25, 2) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  CONSTRAINT `SK` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sales
-- ----------------------------
INSERT INTO `sales` VALUES (2, 3, 3, 450.00, '2023-05-23');
INSERT INTO `sales` VALUES (3, 5, 2, 330.00, '2023-05-23');
INSERT INTO `sales` VALUES (4, 3, 2, 300.00, '2023-05-23');
INSERT INTO `sales` VALUES (5, 3, 3, 450.00, '2023-05-23');
INSERT INTO `sales` VALUES (6, 3, 2, 300.00, '2023-05-23');
INSERT INTO `sales` VALUES (7, 3, 3, 450.00, '2023-05-23');

-- ----------------------------
-- Table structure for user_groups
-- ----------------------------
DROP TABLE IF EXISTS `user_groups`;
CREATE TABLE `user_groups`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `group_level` int(11) NOT NULL,
  `group_status` int(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `group_level`(`group_level`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user_groups
-- ----------------------------
INSERT INTO `user_groups` VALUES (1, 'ADMINISTRADORES', 1, 1);
INSERT INTO `user_groups` VALUES (4, 'USUARIOS', 2, 1);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `username` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `user_level` int(11) NOT NULL,
  `image` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT 'no_image.jpg',
  `status` int(1) NOT NULL,
  `last_login` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  INDEX `user_level`(`user_level`) USING BTREE,
  CONSTRAINT `FK_user` FOREIGN KEY (`user_level`) REFERENCES `user_groups` (`group_level`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'ADMINISTRADOR', 'administrador', 'b94f8849516227c36fdd9ceb6c1670c52fe2b4ab', 1, 'qam87ptx1.png', 1, '2023-06-07 20:36:49');
INSERT INTO `users` VALUES (10, 'Abigail J', 'ABIGAIL', 'daa92556f63357d26c6382a0872cea6d7ae3b111', 2, 'no_image.jpg', 1, '2023-05-23 19:38:32');
INSERT INTO `users` VALUES (11, 'Irving Ventura', 'IRVING', '909468d6963d9bf2d3f9487fca4b684d2dc1f64d', 2, 'no_image.jpg', 1, '2023-05-31 22:06:06');

SET FOREIGN_KEY_CHECKS = 1;
