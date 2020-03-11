/*
Navicat MySQL Data Transfer

Source Server         : zhangjq
Source Server Version : 50720
Source Host           : 127.0.0.1:3306
Source Database       : hospital

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2020-03-11 18:17:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for drug
-- ----------------------------
DROP TABLE IF EXISTS `drug`;
CREATE TABLE `drug` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `drug_name` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `is_del` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of drug
-- ----------------------------
INSERT INTO `drug` VALUES ('1', '阿莫西林', '100', '10.00', '1');
INSERT INTO `drug` VALUES ('2', '健胃消食片', '100', '20.00', '1');
INSERT INTO `drug` VALUES ('3', '保和丸', '133', '11.00', '1');
INSERT INTO `drug` VALUES ('11', 'qq', '20', '29.00', '0');
