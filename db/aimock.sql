/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80100 (8.1.0)
 Source Host           : localhost:3306
 Source Schema         : aimock

 Target Server Type    : MySQL
 Target Server Version : 80100 (8.1.0)
 File Encoding         : 65001

 Date: 16/10/2023 14:06:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for APIAccessLogs
-- ----------------------------
DROP TABLE IF EXISTS `APIAccessLogs`;
CREATE TABLE `APIAccessLogs`  (
  `LogID` int NOT NULL AUTO_INCREMENT,
  `APIID` int NOT NULL,
  `UserID` int NULL DEFAULT NULL,
  `AccessTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `IPAddress` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ResponseTime` int NULL DEFAULT NULL,
  `HttpStatus` int NULL DEFAULT NULL,
  PRIMARY KEY (`LogID`) USING BTREE,
  INDEX `APIID`(`APIID` ASC) USING BTREE,
  INDEX `UserID`(`UserID` ASC) USING BTREE,
  CONSTRAINT `apiaccesslogs_ibfk_1` FOREIGN KEY (`APIID`) REFERENCES `MockDataAPIs` (`APIID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `apiaccesslogs_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of APIAccessLogs
-- ----------------------------

-- ----------------------------
-- Table structure for MockDataAPIs
-- ----------------------------
DROP TABLE IF EXISTS `MockDataAPIs`;
CREATE TABLE `MockDataAPIs`  (
  `APIID` int NOT NULL AUTO_INCREMENT,
  `ConfigID` int NOT NULL,
  `APIEndpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `APIStatus` int NOT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`APIID`) USING BTREE,
  UNIQUE INDEX `APIEndpoint`(`APIEndpoint` ASC) USING BTREE,
  INDEX `ConfigID`(`ConfigID` ASC) USING BTREE,
  CONSTRAINT `mockdataapis_ibfk_1` FOREIGN KEY (`ConfigID`) REFERENCES `MockDataConfigs` (`ConfigID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MockDataAPIs
-- ----------------------------

-- ----------------------------
-- Table structure for MockDataConfigs
-- ----------------------------
DROP TABLE IF EXISTS `MockDataConfigs`;
CREATE TABLE `MockDataConfigs`  (
  `ConfigID` int NOT NULL AUTO_INCREMENT,
  `UserID` int NOT NULL,
  `DataType` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `DataTemplate` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ConfigID`) USING BTREE,
  INDEX `UserID`(`UserID` ASC) USING BTREE,
  CONSTRAINT `mockdataconfigs_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MockDataConfigs
-- ----------------------------

-- ----------------------------
-- Table structure for OAuthClients
-- ----------------------------
DROP TABLE IF EXISTS `OAuthClients`;
CREATE TABLE `OAuthClients`  (
  `ClientID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '客户端ID',
  `ClientSecret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '客户端密钥',
  `ClientName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '客户端名称',
  `GrantTypes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '授权类型',
  `RedirectURIs` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '重定向URI',
  `Scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '权限范围',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `UpdatedAt` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ClientID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'OAuth2客户端信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of OAuthClients
-- ----------------------------

-- ----------------------------
-- Table structure for OAuthTokens
-- ----------------------------
DROP TABLE IF EXISTS `OAuthTokens`;
CREATE TABLE `OAuthTokens`  (
  `TokenID` int NOT NULL AUTO_INCREMENT COMMENT '令牌ID',
  `AccessToken` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '访问令牌',
  `RefreshToken` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '刷新令牌',
  `UserID` int NOT NULL COMMENT '用户ID',
  `ClientID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '客户端ID',
  `ExpiryTime` timestamp NOT NULL COMMENT '过期时间',
  `Scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '权限范围',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `UpdatedAt` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`TokenID`) USING BTREE,
  UNIQUE INDEX `AccessToken`(`AccessToken` ASC) USING BTREE,
  INDEX `UserID`(`UserID` ASC) USING BTREE,
  INDEX `ClientID`(`ClientID` ASC) USING BTREE,
  CONSTRAINT `oauthtokens_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `oauthtokens_ibfk_2` FOREIGN KEY (`ClientID`) REFERENCES `OAuthClients` (`ClientID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = 'OAuth2令牌信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of OAuthTokens
-- ----------------------------

-- ----------------------------
-- Table structure for Users
-- ----------------------------
DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users`  (
  `UserID` int NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `Username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户名',
  `Password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '密码',
  `Email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '邮箱',
  `ActiveStatus` tinyint(1) NULL DEFAULT 1 COMMENT '活动状态',
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `UpdatedAt` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`UserID`) USING BTREE,
  UNIQUE INDEX `Username`(`Username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of Users
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
