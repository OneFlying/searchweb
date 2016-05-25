/*
Navicat MySQL Data Transfer

Source Server         : guo
Source Server Version : 50140
Source Host           : localhost:3306
Source Database       : search_web

Target Server Type    : MYSQL
Target Server Version : 50140
File Encoding         : 65001

Date: 2016-05-25 20:16:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for advert
-- ----------------------------
DROP TABLE IF EXISTS `advert`;
CREATE TABLE `advert` (
  `id` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `logourl` varchar(255) DEFAULT NULL,
  `adurl` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of advert
-- ----------------------------
INSERT INTO `advert` VALUES ('64b7071fa8dd40739ed6004fd07d0c10', '测试就是', '测试广告位的', '1200', '/yfweb/static/upload/20160525172249573845.png', 'http://www.baiduc.com');
