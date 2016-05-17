/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50155
Source Host           : localhost:3306
Source Database       : searchweb

Target Server Type    : MYSQL
Target Server Version : 50155
File Encoding         : 65001

Date: 2016-05-17 10:13:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `article`
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` varchar(50) COLLATE utf8_bin NOT NULL,
  `title` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `content` text COLLATE utf8_bin,
  `website` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `imgids` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of article
-- ----------------------------

-- ----------------------------
-- Table structure for `img`
-- ----------------------------
DROP TABLE IF EXISTS `img`;
CREATE TABLE `img` (
  `id` varchar(50) COLLATE utf8_bin NOT NULL,
  `url` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of img
-- ----------------------------

-- ----------------------------
-- Table structure for `jubao`
-- ----------------------------
DROP TABLE IF EXISTS `jubao`;
CREATE TABLE `jubao` (
  `id` varchar(50) COLLATE utf8_bin NOT NULL,
  `articleid` varchar(50) COLLATE utf8_bin NOT NULL,
  `content` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `datetime` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of jubao
-- ----------------------------

-- ----------------------------
-- Table structure for `websitconfig`
-- ----------------------------
DROP TABLE IF EXISTS `websitconfig`;
CREATE TABLE `websitconfig` (
  `id` varchar(50) COLLATE utf8_bin NOT NULL,
  `title` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `logourl` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of websitconfig
-- ----------------------------
