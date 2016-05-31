/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50614
Source Host           : localhost:3306
Source Database       : searchweb

Target Server Type    : MYSQL
Target Server Version : 50614
File Encoding         : 65001

Date: 2016-05-31 23:33:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `websitconfig`
-- ----------------------------
DROP TABLE IF EXISTS `websitconfig`;
CREATE TABLE `websitconfig` (
  `id` varchar(50) COLLATE utf8_bin NOT NULL,
  `title` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `logourl` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `keywords` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `beianhao` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `qitalogo` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of websitconfig
-- ----------------------------
INSERT INTO `websitconfig` VALUES ('1212', '剑三搜索', '/upload/20160531230244209360.png', '剑三，测试', '沪21备20303', null);
