/*
Navicat MySQL Data Transfer

Source Server         : zhangjq
Source Server Version : 50720
Source Host           : 127.0.0.1:3306
Source Database       : hospital

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2020-03-11 18:17:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for register
-- ----------------------------
DROP TABLE IF EXISTS `register`;
CREATE TABLE `register` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `order_status` varchar(255) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `is_del` varchar(255) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT NULL,
  `create_user_id` int(11) DEFAULT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `illness_name` varchar(255) DEFAULT NULL,
  `drug_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of register
-- ----------------------------
INSERT INTO `register` VALUES ('28', '64', '3', '45', '1', '2020-03-11 17:13:33', null, null, null, '60', '肚子疼', '健胃消食片');
