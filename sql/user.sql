/*
Navicat MySQL Data Transfer

Source Server         : zhangjq
Source Server Version : 50720
Source Host           : 127.0.0.1:3306
Source Database       : hospital

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2020-03-11 18:17:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `status` int(255) DEFAULT NULL,
  `sex` int(255) DEFAULT NULL,
  `age` int(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL COMMENT '验证码',
  `type` varchar(255) DEFAULT NULL COMMENT '类型',
  `code_time` datetime DEFAULT NULL,
  `is_del` int(255) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT NULL,
  `create_user_id` int(11) DEFAULT NULL,
  `update_user_id` int(11) DEFAULT NULL,
  `doctor_work` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('29', 'zhang', '203495441@qq.com', '17836174110', '14202fef785f063dcf80e7a8db67dcf3', '8b130fb496fbf2dbd712f81087c591fc', '1', '1', '25', '637735', '1', '2020-03-11 17:16:01', '1', '2020-03-11 17:15:00', null, null, null, '内科');
INSERT INTO `user` VALUES ('59', '汤正', '12@qq.com', '15033523498', '4ce99e97e60c371e16d792c6b4f1479c', '1705c129ed495a4d873c5417e27fc5ab', '1', '1', '54', null, '2', null, '1', '2020-03-11 16:58:00', null, null, null, '内科');
INSERT INTO `user` VALUES ('60', '张', '43@qq.com', '17032423498', '9ea164c4d5784f28c8961598c26f4ed6', '7b3848161894bf023f0c4c494ffa07ed', '1', '1', '21', null, '2', null, '1', '2020-03-11 17:13:45', null, null, null, '外科');
INSERT INTO `user` VALUES ('62', 'yonghu', '2034514@qq.com', '15321321332', 'f5c080192919057c3c67e15033a61fd4', '60cb9db254141c1fd999d5322d1a81ff', '1', '1', '28', null, '3', null, '1', '2020-03-11 17:09:41', null, null, null, '内科');
INSERT INTO `user` VALUES ('63', 'zhan', '203454414@qq.com', '15033523433', 'e063dcdf1fb66d4cb1acb9e926469d37', '73957f378c737e1e328c4f65bdafc097', '-1', '1', '21', null, '1', null, '0', '2020-03-11 17:11:03', null, null, null, null);
INSERT INTO `user` VALUES ('64', 'aa', 'zjq2034954414@163.com', '15033523439', '2facbf1860fef6698d18a8dab693fc04', 'f587701d203a04bb11c3932dc8d1f502', '1', '1', '21', null, '3', null, '1', '2020-03-11 17:11:45', null, null, null, '内科');
