/*
Navicat MySQL Data Transfer

Source Server         : guo
Source Server Version : 50140
Source Host           : localhost:3306
Source Database       : search_web

Target Server Type    : MYSQL
Target Server Version : 50140
File Encoding         : 65001

Date: 2016-05-25 09:22:44
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for relsearch
-- ----------------------------
DROP TABLE IF EXISTS `relsearch`;
CREATE TABLE `relsearch` (
  `id` varchar(255) NOT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `count` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
