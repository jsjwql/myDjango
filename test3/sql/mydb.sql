/*
 Navicat Premium Data Transfer

 Source Server         : test
 Source Server Type    : MySQL
 Source Server Version : 50722
 Source Host           : localhost:3306
 Source Schema         : mydb

 Target Server Type    : MySQL
 Target Server Version : 50722
 File Encoding         : 65001

 Date: 30/06/2018 15:28:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
BEGIN;
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (5, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (8, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (9, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (10, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (11, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (12, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (17, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (18, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (19, 'Can add maker', 7, 'add_maker');
INSERT INTO `auth_permission` VALUES (20, 'Can change maker', 7, 'change_maker');
INSERT INTO `auth_permission` VALUES (21, 'Can delete maker', 7, 'delete_maker');
INSERT INTO `auth_permission` VALUES (22, 'Can add p model', 8, 'add_pmodel');
INSERT INTO `auth_permission` VALUES (23, 'Can change p model', 8, 'change_pmodel');
INSERT INTO `auth_permission` VALUES (24, 'Can delete p model', 8, 'delete_pmodel');
INSERT INTO `auth_permission` VALUES (25, 'Can add p photo', 9, 'add_pphoto');
INSERT INTO `auth_permission` VALUES (26, 'Can change p photo', 9, 'change_pphoto');
INSERT INTO `auth_permission` VALUES (27, 'Can delete p photo', 9, 'delete_pphoto');
INSERT INTO `auth_permission` VALUES (28, 'Can add product', 10, 'add_product');
INSERT INTO `auth_permission` VALUES (29, 'Can change product', 10, 'change_product');
INSERT INTO `auth_permission` VALUES (30, 'Can delete product', 10, 'delete_product');
COMMIT;

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
BEGIN;
INSERT INTO `auth_user` VALUES (1, 'pbkdf2_sha256$100000$eREnpgRjtojZ$XuLBQYxzozJlTInpN2Rz1N5Av7+g8GqcMBce6NB6T8E=', '2018-06-30 07:20:17.359226', 1, 'admin', '', '', 'weixuqinhd@163.com', 1, 1, '2018-06-24 11:09:40.856979');
COMMIT;

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
BEGIN;
INSERT INTO `django_admin_log` VALUES (1, '2018-06-24 11:19:08.152824', '1', 'xiaomi', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (2, '2018-06-24 11:19:24.411686', '2', 'SONY', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (3, '2018-06-24 11:19:40.912975', '3', 'Apple', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (4, '2018-06-24 11:19:47.275615', '4', 'huawei', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (5, '2018-06-24 11:20:26.766406', '1', 'MIX 2S', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (6, '2018-06-24 11:20:57.814823', '2', 'Xperia Z5', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (7, '2018-06-24 11:21:21.473251', '3', 'iPhone X', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (8, '2018-06-24 11:21:42.409798', '4', 'mate 10 pro', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (9, '2018-06-24 11:22:12.424170', '1', '超值二手手机', 1, '[{\"added\": {}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (10, '2018-06-24 11:22:21.642832', '2', '超值二手手机', 1, '[{\"added\": {}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (11, '2018-06-24 11:22:33.688027', '3', '超值二手手机', 1, '[{\"added\": {}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (12, '2018-06-24 11:22:49.112510', '4', '超值二手手机', 1, '[{\"added\": {}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (13, '2018-06-24 11:25:25.182456', '3', 'iPhoneX', 2, '[{\"changed\": {\"fields\": [\"nickname\"]}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (14, '2018-06-24 11:25:34.008264', '4', 'mate 10 pro', 2, '[{\"changed\": {\"fields\": [\"nickname\"]}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (15, '2018-06-24 11:25:45.665044', '1', 'MIX 2S', 2, '[{\"changed\": {\"fields\": [\"nickname\"]}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (16, '2018-06-24 11:25:56.082434', '2', 'Xperia Z5', 2, '[{\"changed\": {\"fields\": [\"nickname\"]}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (17, '2018-06-24 11:26:23.029565', '1', '产品照片', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (18, '2018-06-24 11:26:33.990023', '2', '产品照片', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (19, '2018-06-24 11:26:53.385708', '3', '产品照片', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (20, '2018-06-24 11:27:07.995045', '4', '产品照片', 1, '[{\"added\": {}}]', 9, 1);
COMMIT;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
BEGIN;
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (7, 'mysite', 'maker');
INSERT INTO `django_content_type` VALUES (8, 'mysite', 'pmodel');
INSERT INTO `django_content_type` VALUES (9, 'mysite', 'pphoto');
INSERT INTO `django_content_type` VALUES (10, 'mysite', 'product');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');
COMMIT;

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
BEGIN;
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2018-06-24 11:05:45.284649');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2018-06-24 11:05:45.670041');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2018-06-24 11:05:45.739465');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2018-06-24 11:05:45.750798');
INSERT INTO `django_migrations` VALUES (5, 'contenttypes', '0002_remove_content_type_name', '2018-06-24 11:05:45.820506');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0002_alter_permission_name_max_length', '2018-06-24 11:05:46.087230');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0003_alter_user_email_max_length', '2018-06-24 11:05:46.119680');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0004_alter_user_username_opts', '2018-06-24 11:05:46.133698');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0005_alter_user_last_login_null', '2018-06-24 11:05:46.164336');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0006_require_contenttypes_0002', '2018-06-24 11:05:46.168546');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0007_alter_validators_add_error_messages', '2018-06-24 11:05:46.182610');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0008_alter_user_username_max_length', '2018-06-24 11:05:46.217132');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0009_alter_user_last_name_max_length', '2018-06-24 11:05:46.244499');
INSERT INTO `django_migrations` VALUES (14, 'mysite', '0001_initial', '2018-06-24 11:05:46.412744');
INSERT INTO `django_migrations` VALUES (15, 'mysite', '0002_auto_20180624_1105', '2018-06-24 11:05:46.483202');
INSERT INTO `django_migrations` VALUES (16, 'sessions', '0001_initial', '2018-06-24 11:05:46.521597');
COMMIT;

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
BEGIN;
INSERT INTO `django_session` VALUES ('m2mhq5oiqgt354t2fzpwkdzrypzrj44m', 'MDA4YTU5ZTBkNzBhNzZiMDk5NjUyOGViMmQyZTI4ZjkyMmJmYzM0Mzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwNWYxNTNmYTNjY2Y5MDY2YzQxNTMzZjc0MmU4OTg3YTFjNDFlYTdlIn0=', '2018-07-14 07:20:17.363131');
COMMIT;

-- ----------------------------
-- Table structure for mysite_maker
-- ----------------------------
DROP TABLE IF EXISTS `mysite_maker`;
CREATE TABLE `mysite_maker` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `country` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mysite_maker
-- ----------------------------
BEGIN;
INSERT INTO `mysite_maker` VALUES (1, 'xiaomi', 'China');
INSERT INTO `mysite_maker` VALUES (2, 'SONY', 'Japan');
INSERT INTO `mysite_maker` VALUES (3, 'Apple', 'America');
INSERT INTO `mysite_maker` VALUES (4, 'huawei', 'China');
COMMIT;

-- ----------------------------
-- Table structure for mysite_pmodel
-- ----------------------------
DROP TABLE IF EXISTS `mysite_pmodel`;
CREATE TABLE `mysite_pmodel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `url` varchar(200) NOT NULL,
  `maker_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mysite_pmodel_maker_id_0351a0c8_fk_mysite_maker_id` (`maker_id`),
  CONSTRAINT `mysite_pmodel_maker_id_0351a0c8_fk_mysite_maker_id` FOREIGN KEY (`maker_id`) REFERENCES `mysite_maker` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mysite_pmodel
-- ----------------------------
BEGIN;
INSERT INTO `mysite_pmodel` VALUES (1, 'MIX 2S', 'https://cdn2.gsmarena.com/vv/pics/xiaomi/xiaomi-mi-mix-2s-2.jpg', 1);
INSERT INTO `mysite_pmodel` VALUES (2, 'Xperia Z5', 'https://cdn.shopify.com/s/files/1/2257/9645/products/sony-xperia-z5-gold-best-price-dubai-store-com-riyadh-dammam-jeddah-original-buy_x700.jpg?v=1518437269', 2);
INSERT INTO `mysite_pmodel` VALUES (3, 'iPhone X', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWFoiK3RORMrQlAdOn4ySDFuTckUt9KKAmW3PkrLgISpl0zmghkA', 3);
INSERT INTO `mysite_pmodel` VALUES (4, 'mate 10 pro', 'https://cdn.shopify.com/s/files/1/0259/1735/products/huawei_mate10_template_2048x.jpg?v=1529483129', 4);
COMMIT;

-- ----------------------------
-- Table structure for mysite_pphoto
-- ----------------------------
DROP TABLE IF EXISTS `mysite_pphoto`;
CREATE TABLE `mysite_pphoto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(20) NOT NULL,
  `url` varchar(200) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mysite_pphoto_product_id_8125e426_fk_mysite_product_id` (`product_id`),
  CONSTRAINT `mysite_pphoto_product_id_8125e426_fk_mysite_product_id` FOREIGN KEY (`product_id`) REFERENCES `mysite_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mysite_pphoto
-- ----------------------------
BEGIN;
INSERT INTO `mysite_pphoto` VALUES (1, '产品照片', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWFoiK3RORMrQlAdOn4ySDFuTckUt9KKAmW3PkrLgISpl0zmghkA', 3);
INSERT INTO `mysite_pphoto` VALUES (2, '产品照片', 'https://cdn.shopify.com/s/files/1/0259/1735/products/huawei_mate10_template_2048x.jpg?v=1529483129', 4);
INSERT INTO `mysite_pphoto` VALUES (3, '产品照片', 'https://cdn2.gsmarena.com/vv/pics/xiaomi/xiaomi-mi-mix-2s-2.jpg', 1);
INSERT INTO `mysite_pphoto` VALUES (4, '产品照片', 'https://cdn.shopify.com/s/files/1/2257/9645/products/sony-xperia-z5-gold-best-price-dubai-store-com-riyadh-dammam-jeddah-original-buy_x700.jpg?v=1518437269', 2);
COMMIT;

-- ----------------------------
-- Table structure for mysite_product
-- ----------------------------
DROP TABLE IF EXISTS `mysite_product`;
CREATE TABLE `mysite_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(15) NOT NULL,
  `description` longtext NOT NULL,
  `year` int(10) unsigned NOT NULL,
  `price` int(10) unsigned NOT NULL,
  `pmodel_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mysite_product_pmodel_id_5ac6d1ac_fk_mysite_pmodel_id` (`pmodel_id`),
  CONSTRAINT `mysite_product_pmodel_id_5ac6d1ac_fk_mysite_pmodel_id` FOREIGN KEY (`pmodel_id`) REFERENCES `mysite_pmodel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mysite_product
-- ----------------------------
BEGIN;
INSERT INTO `mysite_product` VALUES (1, 'MIX 2S', '暂无说明', 2017, 4000, 1);
INSERT INTO `mysite_product` VALUES (2, 'Xperia Z5', '暂无说明', 2016, 2000, 2);
INSERT INTO `mysite_product` VALUES (3, 'iPhoneX', '暂无说明', 2017, 7000, 3);
INSERT INTO `mysite_product` VALUES (4, 'mate 10 pro', '暂无说明', 2016, 4500, 4);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
