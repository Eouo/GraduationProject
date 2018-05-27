/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50537
Source Host           : localhost:3306
Source Database       : graduation

Target Server Type    : MYSQL
Target Server Version : 50537
File Encoding         : 65001

Date: 2018-05-12 22:31:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `address_detail` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL COMMENT '1:默认',
  `address_name` varchar(255) DEFAULT NULL,
  `address_phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES ('16', '14', '新凯园', '1', '赵琪', '18294062242', '上海市上海市市辖区松江区');
INSERT INTO `address` VALUES ('17', '14', '12弄', '0', '乔治', '16602190060', '浙江省舟山市嵊泗县');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) NOT NULL,
  `price` double(6,2) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `type` int(255) NOT NULL COMMENT '1:在售 0：库存',
  `img_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('2', '豆子', '7.00', '19991', '', '1', 'bean.png');
INSERT INTO `product` VALUES ('5', '花生', '7.79', '56', '新鲜的花生', '1', '1526134427895.png');
INSERT INTO `product` VALUES ('22', '苹果', '3.00', '100', '陕西红富士', '0', 'apple.png');
INSERT INTO `product` VALUES ('28', '橙子', '5.80', '1', '', '1', 'orange.png');
INSERT INTO `product` VALUES ('34', '苦瓜', '3.30', '100', '', '1', 'kuGua.png');
INSERT INTO `product` VALUES ('35', '土豆', '2.50', '100', '', '1', 'potato.png');

-- ----------------------------
-- Table structure for product_record
-- ----------------------------
DROP TABLE IF EXISTS `product_record`;
CREATE TABLE `product_record` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) DEFAULT NULL,
  `price` varchar(6) DEFAULT NULL,
  `count` varchar(11) DEFAULT NULL,
  `user_id` varchar(11) DEFAULT NULL,
  `order_time` datetime DEFAULT NULL,
  `total_money` varchar(255) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `address_name` varchar(255) DEFAULT NULL,
  `address_phone` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL DEFAULT '1' COMMENT '1:正常订单 0：表示用户删除了的，用户不可见',
  `state` varchar(255) DEFAULT NULL COMMENT '订单状态；0：表示未配送，用户可取消；1：表示配送中，用户不能取消；2:失效订单，被用户取消了的订单',
  `product_id` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product_record
-- ----------------------------
INSERT INTO `product_record` VALUES ('39', ',花生', ',7.79', ',1', '14', '2018-05-12 22:25:03', '7.79', '上海市上海市市辖区松江区新凯园', '赵琪', '18294062242', '1', '1', ',5');
INSERT INTO `product_record` VALUES ('40', ',花生', ',7.79', ',1', '14', '2018-05-12 22:30:43', '7.79', '浙江省舟山市嵊泗县12弄', '乔治', '16602190060', '1', '2', ',5');

-- ----------------------------
-- Table structure for shop_card
-- ----------------------------
DROP TABLE IF EXISTS `shop_card`;
CREATE TABLE `shop_card` (
  `shop_card_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT '0:失效商品；1：正常产品',
  PRIMARY KEY (`shop_card_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_card
-- ----------------------------
INSERT INTO `shop_card` VALUES ('11', '14', '30', '1', null);
INSERT INTO `shop_card` VALUES ('13', '14', '28', '3', null);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `e_mail` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `praise_rate` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT '0:admin; 11:user;  12:blackUser',
  `img_url` varchar(255) DEFAULT NULL,
  `user_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'root', '0', '上海徐汇', '16602190060', '25', '2423952682@qq.com', '123456', '100', '0', '1526134268866.jpg', 'admin');
INSERT INTO `user` VALUES ('14', 'iozhaq', '1', '河南焦作', '18294062242', '22', '18294062242@163.com', '123456', '100', '11', '1526133015323.jpg', 'user');
SET FOREIGN_KEY_CHECKS=1;
