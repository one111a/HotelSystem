/*
Navicat MySQL Data Transfer

Source Server         : 本地连接
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : db_hotel_sys

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2019-01-22 13:58:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `authinfo`
-- ----------------------------
DROP TABLE IF EXISTS `authinfo`;
CREATE TABLE `authinfo` (
  `authId` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限编号',
  `authItem` varchar(45) DEFAULT NULL COMMENT '权限项',
  `isRead` varchar(45) DEFAULT NULL COMMENT '可读',
  `isWrite` varchar(45) DEFAULT NULL COMMENT '可写',
  `isChange` varchar(45) DEFAULT NULL COMMENT '可改',
  `isDelete` varchar(45) DEFAULT NULL COMMENT '可删',
  PRIMARY KEY (`authId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of authinfo
-- ----------------------------

-- ----------------------------
-- Table structure for `billinfo`
-- ----------------------------
DROP TABLE IF EXISTS `billinfo`;
CREATE TABLE `billinfo` (
  `billId` int(11) NOT NULL AUTO_INCREMENT COMMENT '账单编号',
  `checkId` varchar(45) NOT NULL COMMENT '入住单号',
  `costMoney` varchar(20) DEFAULT NULL COMMENT '消费金额',
  `costDate` varchar(45) DEFAULT NULL COMMENT '消费时间',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`billId`),
  KEY `fk_billInfo_1_idx` (`checkId`),
  CONSTRAINT `fk_billInfo_1` FOREIGN KEY (`checkId`) REFERENCES `checkinfo` (`checkId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of billinfo
-- ----------------------------
INSERT INTO `billinfo` VALUES ('1', 'CK1547628261109', '300', '2019-01-22', '生成账单，入住订单：CK1547628261109');
INSERT INTO `billinfo` VALUES ('2', 'CK1547627533278', '270', '2019-01-18', '账单');

-- ----------------------------
-- Table structure for `checkinfo`
-- ----------------------------
DROP TABLE IF EXISTS `checkinfo`;
CREATE TABLE `checkinfo` (
  `checkId` varchar(45) NOT NULL COMMENT '入住单号',
  `orderId` varchar(45) DEFAULT NULL COMMENT '预定单号',
  `checkName` varchar(45) DEFAULT NULL COMMENT '入住人',
  `checkPhone` varchar(45) DEFAULT NULL COMMENT '联系电话',
  `checkIDcard` varchar(18) DEFAULT NULL COMMENT '身份证号',
  `typeId` varchar(45) NOT NULL COMMENT '客房类型',
  `arrireTime` varchar(45) DEFAULT NULL COMMENT '抵店时间',
  `leaveTime` varchar(45) DEFAULT NULL COMMENT '离店时间',
  `checkState` varchar(20) DEFAULT NULL COMMENT '单据状态',
  `checkNum` int(11) DEFAULT NULL COMMENT '入住人数',
  `roomId` varchar(45) NOT NULL COMMENT '客房编号',
  `price` varchar(20) DEFAULT NULL COMMENT '客房价格',
  `checkPrice` varchar(20) DEFAULT NULL COMMENT '入住价格',
  `discount` int(11) DEFAULT NULL COMMENT '折扣',
  `discountReason` varchar(60) DEFAULT NULL COMMENT '折扣原因',
  `addBed` varchar(10) DEFAULT 'N' COMMENT '是否加床',
  `addBedPrice` varchar(20) DEFAULT '0' COMMENT '加床价格',
  `orderMoney` varchar(20) DEFAULT NULL COMMENT '预收款',
  `money` varchar(20) DEFAULT NULL COMMENT '应收账款',
  `isCheck` varchar(10) DEFAULT NULL COMMENT '是否结账',
  `checkMoney` varchar(20) DEFAULT NULL COMMENT '结账金额',
  `checkDate` varchar(45) DEFAULT NULL COMMENT '结账日期',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `operatorId` varchar(45) DEFAULT NULL COMMENT '操作员',
  PRIMARY KEY (`checkId`),
  KEY `fk_checkInfo_1_idx` (`typeId`),
  KEY `fk_checkInfo_2_idx` (`roomId`),
  CONSTRAINT `fk_checkInfo_1` FOREIGN KEY (`typeId`) REFERENCES `roomtype` (`typeId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_checkInfo_2` FOREIGN KEY (`roomId`) REFERENCES `roominfo` (`roomId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of checkinfo
-- ----------------------------
INSERT INTO `checkinfo` VALUES ('CK1547627533278', 'OD1547104937692', '猿来入此', '13656565656', '622921199005222625', 'RT190110150639', '2019-01-17 00:00:00', '2019-01-18 00:00:00', '结算', '1', '1001', '300', '270', '9', '搞活动', 'N', '0', '300', '270', 'Y', '270', '2019-01-17', '入住备注', 'admin');
INSERT INTO `checkinfo` VALUES ('CK1547628261109', 'OD1547107470223', '张三丰', '15565623369', '320103199003232654', 'RT190110150639', '2019-01-11 00:00:00', '2019-01-13 00:00:00', '结算', '1', '1002', '300', '300', '0', '', 'N', '0', '300', '300', 'Y', '300', '2019-01-22', '网上预定订单', 'admin');
INSERT INTO `checkinfo` VALUES ('CK1548126393776', 'OD1548125474350', '猿来入此', '13316886188', '622921188705099852', 'RT190110150652', '2019-01-24 00:00:00', '2019-01-26 00:00:00', '入住', '2', '1004', '500', '450', '9', '站长驾到', 'N', '', '450', '450', 'N', null, null, '站长操作', 'admin');

-- ----------------------------
-- Table structure for `floorinfo`
-- ----------------------------
DROP TABLE IF EXISTS `floorinfo`;
CREATE TABLE `floorinfo` (
  `floorId` int(11) NOT NULL AUTO_INCREMENT COMMENT '楼层编号',
  `floorName` varchar(45) DEFAULT NULL COMMENT '楼层名称',
  PRIMARY KEY (`floorId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of floorinfo
-- ----------------------------
INSERT INTO `floorinfo` VALUES ('1', '1楼');
INSERT INTO `floorinfo` VALUES ('2', '2楼');
INSERT INTO `floorinfo` VALUES ('3', '3楼');

-- ----------------------------
-- Table structure for `login`
-- ----------------------------
DROP TABLE IF EXISTS `login`;
CREATE TABLE `login` (
  `loginId` int(11) NOT NULL AUTO_INCREMENT COMMENT '登录内部标示，主键、自动增长。',
  `loginName` varchar(45) NOT NULL COMMENT '登录用户名，前台唯一性的标识。不能重复。',
  `loginPwd` varchar(45) NOT NULL COMMENT '登录用户的密码，不能为空。',
  `loginNickName` varchar(45) DEFAULT NULL COMMENT '登录用户的昵称',
  `loginAdmin` int(11) DEFAULT NULL COMMENT '权限，默认最高权限是0',
  PRIMARY KEY (`loginId`),
  UNIQUE KEY `loginName_UNIQUE` (`loginName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of login
-- ----------------------------
INSERT INTO `login` VALUES ('1', 'root', 'ICy5YqxZB1uWSwcVLSNLcA==', '管理员', '0');
INSERT INTO `login` VALUES ('2', 'admin', '4QrcOUm6Wau+VuBX8g+IPg==', '猿来入此', '-1');

-- ----------------------------
-- Table structure for `loginfo`
-- ----------------------------
DROP TABLE IF EXISTS `loginfo`;
CREATE TABLE `loginfo` (
  `logId` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志，主键、自动增长。',
  `logName` varchar(45) NOT NULL COMMENT '日志项目',
  `loginId` int(11) NOT NULL COMMENT '用户 外键 login表字段值',
  `loginName` varchar(45) DEFAULT NULL COMMENT '用户名称',
  `logDate` varchar(45) DEFAULT NULL COMMENT '日志时间',
  PRIMARY KEY (`logId`),
  KEY `fk_logInfo_1` (`loginId`),
  CONSTRAINT `fk_logInfo_1` FOREIGN KEY (`loginId`) REFERENCES `login` (`loginId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of loginfo
-- ----------------------------
INSERT INTO `loginfo` VALUES ('3', '登录', '1', 'root', '2019-01-10 14:02:30');
INSERT INTO `loginfo` VALUES ('4', '登录', '1', 'root', '2019-01-10 14:24:42');
INSERT INTO `loginfo` VALUES ('5', '登录', '1', 'root', '2019-01-10 14:34:43');
INSERT INTO `loginfo` VALUES ('6', '登录', '1', 'root', '2019-01-10 14:37:00');
INSERT INTO `loginfo` VALUES ('7', '登录', '1', 'root', '2019-01-10 14:48:49');
INSERT INTO `loginfo` VALUES ('8', '登录', '2', 'admin', '2019-01-10 15:10:44');
INSERT INTO `loginfo` VALUES ('9', '登录', '2', 'admin', '2019-01-10 16:04:03');
INSERT INTO `loginfo` VALUES ('10', '登录', '2', 'admin', '2019-01-11 10:15:01');
INSERT INTO `loginfo` VALUES ('11', '登录', '2', 'admin', '2019-01-11 14:34:30');
INSERT INTO `loginfo` VALUES ('12', '登录', '2', 'admin', '2019-01-11 15:46:39');
INSERT INTO `loginfo` VALUES ('13', '登录', '2', 'admin', '2019-01-14 08:55:27');
INSERT INTO `loginfo` VALUES ('14', '登录', '2', 'admin', '2019-01-14 09:44:52');
INSERT INTO `loginfo` VALUES ('15', '登录', '2', 'admin', '2019-01-14 10:34:31');
INSERT INTO `loginfo` VALUES ('16', '登录', '2', 'admin', '2019-01-14 14:37:45');
INSERT INTO `loginfo` VALUES ('17', '登录', '2', 'admin', '2019-01-14 14:42:14');
INSERT INTO `loginfo` VALUES ('18', '登录', '2', 'admin', '2019-01-14 14:54:35');
INSERT INTO `loginfo` VALUES ('19', '登录', '2', 'admin', '2019-01-14 15:00:43');
INSERT INTO `loginfo` VALUES ('20', '登录', '2', 'admin', '2019-01-14 15:14:13');
INSERT INTO `loginfo` VALUES ('21', '登录', '2', 'admin', '2019-01-14 15:23:08');
INSERT INTO `loginfo` VALUES ('22', '登录', '2', 'admin', '2019-01-14 15:29:34');
INSERT INTO `loginfo` VALUES ('23', '登录', '2', 'admin', '2019-01-14 16:42:42');
INSERT INTO `loginfo` VALUES ('24', '登录', '2', 'admin', '2019-01-15 08:49:52');
INSERT INTO `loginfo` VALUES ('25', '登录', '2', 'admin', '2019-01-15 16:43:50');
INSERT INTO `loginfo` VALUES ('26', '登录', '2', 'admin', '2019-01-16 08:56:38');
INSERT INTO `loginfo` VALUES ('27', '登录', '2', 'admin', '2019-01-16 09:54:16');
INSERT INTO `loginfo` VALUES ('28', '登录', '2', 'admin', '2019-01-16 10:44:30');
INSERT INTO `loginfo` VALUES ('29', '登录', '2', 'admin', '2019-01-16 13:49:02');
INSERT INTO `loginfo` VALUES ('30', '登录', '2', 'admin', '2019-01-16 15:11:07');
INSERT INTO `loginfo` VALUES ('31', '登录', '2', 'admin', '2019-01-16 15:24:08');
INSERT INTO `loginfo` VALUES ('32', '登录', '2', 'admin', '2019-01-16 16:15:28');
INSERT INTO `loginfo` VALUES ('33', '登录', '2', 'admin', '2019-01-16 16:32:08');
INSERT INTO `loginfo` VALUES ('34', '登录', '2', 'admin', '2019-01-16 16:44:16');
INSERT INTO `loginfo` VALUES ('35', '登录', '2', 'admin', '2019-01-17 09:11:08');
INSERT INTO `loginfo` VALUES ('36', '登录', '2', 'admin', '2019-01-17 09:32:38');
INSERT INTO `loginfo` VALUES ('37', '登录', '2', 'admin', '2019-01-17 09:33:42');
INSERT INTO `loginfo` VALUES ('38', '登录', '2', 'admin', '2019-01-17 09:40:41');
INSERT INTO `loginfo` VALUES ('39', '登录', '2', 'admin', '2019-01-17 10:08:21');
INSERT INTO `loginfo` VALUES ('40', '登录', '2', 'admin', '2019-01-17 13:58:29');
INSERT INTO `loginfo` VALUES ('41', '登录', '2', 'admin', '2019-01-17 15:08:07');
INSERT INTO `loginfo` VALUES ('42', '登录', '2', 'admin', '2019-01-17 16:40:52');
INSERT INTO `loginfo` VALUES ('43', '登录', '2', 'admin', '2019-01-22 10:11:41');
INSERT INTO `loginfo` VALUES ('44', '登录', '2', 'admin', '2019-01-22 10:25:42');
INSERT INTO `loginfo` VALUES ('45', '登录', '2', 'admin', '2019-01-22 13:52:39');
INSERT INTO `loginfo` VALUES ('46', '登录', '2', 'admin', '2019-01-22 13:55:13');
INSERT INTO `loginfo` VALUES ('47', '退出', '2', 'admin', '2019-01-22 13:56:42');

-- ----------------------------
-- Table structure for `orderinfo`
-- ----------------------------
DROP TABLE IF EXISTS `orderinfo`;
CREATE TABLE `orderinfo` (
  `orderId` varchar(45) NOT NULL COMMENT '预定单号',
  `orderName` varchar(45) DEFAULT NULL COMMENT '预定人',
  `orderPhone` varchar(45) DEFAULT NULL COMMENT '联系电话',
  `orderIDcard` varchar(18) DEFAULT NULL COMMENT '身份证号',
  `typeId` varchar(45) NOT NULL COMMENT '客房类型',
  `arrireDate` varchar(45) DEFAULT NULL COMMENT '抵店时间',
  `leaveDate` varchar(45) DEFAULT NULL COMMENT '离店时间',
  `orderState` varchar(20) DEFAULT NULL COMMENT '单据状态',
  `checkNum` varchar(45) DEFAULT NULL COMMENT '入住人数',
  `roomId` varchar(45) DEFAULT NULL COMMENT '客房编号',
  `price` varchar(20) DEFAULT NULL COMMENT '客房价格',
  `checkPrice` varchar(20) DEFAULT NULL COMMENT '入住价格',
  `discount` int(11) DEFAULT NULL COMMENT '折扣',
  `discountReason` varchar(60) DEFAULT NULL COMMENT '折扣原因',
  `addBed` varchar(10) DEFAULT NULL COMMENT '是否加床',
  `addBedPrice` varchar(20) DEFAULT NULL COMMENT '加床价格',
  `orderMoney` varchar(20) DEFAULT NULL COMMENT '预收款',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `operatorId` varchar(45) DEFAULT NULL COMMENT '操作员',
  PRIMARY KEY (`orderId`),
  KEY `fk_orderInfo_1_idx` (`typeId`),
  CONSTRAINT `fk_orderInfo_1` FOREIGN KEY (`typeId`) REFERENCES `roomtype` (`typeId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orderinfo
-- ----------------------------
INSERT INTO `orderinfo` VALUES ('OD1547104937692', '猿来入此', '13656565656', '622921199005222625', 'RT190110150639', '2019-01-10 00:00:00', '2019-01-11 00:00:00', '结算', '1', '', '300', '270', '9', '搞活动', 'false', '', '500', '猿来入此入住', 'admin');
INSERT INTO `orderinfo` VALUES ('OD1547107470223', '张三丰', '15565623369', '320103199003232654', 'RT190110150652', '2019-01-11 00:00:00', '2019-01-13 00:00:00', '结算', '1', '', '500', '500', '0', '', 'false', '', '1000', '张三丰', 'admin');
INSERT INTO `orderinfo` VALUES ('OD1547714985605', '张三', '13578963654', '310120199802052654', 'RT190110150652', '2019-01-17 00:00:00', '2019-01-18 00:00:00', '预定', '1', '', '500', '500', '0', '', 'false', '', '500', '预定', 'admin');
INSERT INTO `orderinfo` VALUES ('OD1548125474350', '猿来入此', '13316886188', '622921188705099852', 'RT190110150652', '2019-01-24 00:00:00', '2019-01-26 00:00:00', '入住', '2', '', '500', '500', '0', '', 'true', '', '500', '猿来入此站长预定', 'admin');

-- ----------------------------
-- Table structure for `roominfo`
-- ----------------------------
DROP TABLE IF EXISTS `roominfo`;
CREATE TABLE `roominfo` (
  `roomId` varchar(45) NOT NULL COMMENT '客房编号',
  `typeId` varchar(45) NOT NULL COMMENT '类型编号',
  `typeName` varchar(64) NOT NULL,
  `floorId` int(11) NOT NULL COMMENT '楼层编号',
  `ratedNum` int(11) DEFAULT NULL COMMENT '额定人数',
  `bedNum` int(11) DEFAULT NULL COMMENT '床数',
  `roomDescription` varchar(45) DEFAULT NULL COMMENT '客房描述',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `status` varchar(10) DEFAULT NULL COMMENT '状态',
  `isSplice` varchar(10) DEFAULT NULL COMMENT '是否可拼房',
  PRIMARY KEY (`roomId`),
  KEY `fk_roomInfo_1_idx` (`typeId`),
  KEY `fk_roomInfo_2_idx` (`floorId`),
  CONSTRAINT `fk_roomInfo_1` FOREIGN KEY (`typeId`) REFERENCES `roomtype` (`typeId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_roomInfo_2` FOREIGN KEY (`floorId`) REFERENCES `floorinfo` (`floorId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of roominfo
-- ----------------------------
INSERT INTO `roominfo` VALUES ('1001', 'RT190110150639', '普通大床房', '1', '2', '1', '普通大床房', '普通大床房', '可入住', 'N');
INSERT INTO `roominfo` VALUES ('1002', 'RT190110150639', '普通大床房', '1', '2', '1', '普通大床房', '一楼普通大床房', '打扫中', 'N');
INSERT INTO `roominfo` VALUES ('1003', 'RT190110150639', '普通大床房', '1', '2', '1', '普通大床房', '一楼层普通大床房', '可入住', 'N');
INSERT INTO `roominfo` VALUES ('1004', 'RT190110150723', '普通标准间', '1', '2', '2', '普通标准间', '普通标准间', '已入住', 'N');
INSERT INTO `roominfo` VALUES ('2001', 'RT190110150652', '豪华大床房', '2', '2', '1', '豪华大床房', '豪华大床房', '可入住', 'N');
INSERT INTO `roominfo` VALUES ('2002', 'RT190110150652', '豪华大床房', '2', '2', '1', '豪华大床房', '豪华大床房', '可入住', 'N');
INSERT INTO `roominfo` VALUES ('3001', 'RT190110150723', '普通标准间', '3', '2', '2', '普通标准间', '普通标准间', '可入住', 'Y');

-- ----------------------------
-- Table structure for `roomtype`
-- ----------------------------
DROP TABLE IF EXISTS `roomtype`;
CREATE TABLE `roomtype` (
  `typeId` varchar(45) NOT NULL COMMENT '类型编号',
  `typeName` varchar(45) DEFAULT NULL COMMENT '类型名称',
  `price` varchar(20) DEFAULT NULL COMMENT '价格',
  `splicPrice` varchar(20) DEFAULT NULL COMMENT '拼房价格',
  `exceedance` int(11) DEFAULT NULL COMMENT '可超预定数',
  `isSplice` varchar(10) DEFAULT NULL COMMENT '是否可拼房',
  PRIMARY KEY (`typeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of roomtype
-- ----------------------------
INSERT INTO `roomtype` VALUES ('RT190110150639', '普通大床房', '300', '300', '5', 'N');
INSERT INTO `roomtype` VALUES ('RT190110150652', '豪华大床房', '500', '500', '5', 'N');
INSERT INTO `roomtype` VALUES ('RT190110150723', '普通标准间', '198', '155', '4', 'Y');
