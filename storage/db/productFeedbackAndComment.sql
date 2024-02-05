/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 8.0.30 : Database - product-feedbacks-and-comments
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`product-feedbacks-and-comments` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `product-feedbacks-and-comments`;

/*Table structure for table `comments` */

DROP TABLE IF EXISTS `comments`;

CREATE TABLE `comments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `comment` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `feedback_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_feedback_id_foreign` (`feedback_id`),
  KEY `comments_user_id_foreign` (`user_id`),
  CONSTRAINT `comments_feedback_id_foreign` FOREIGN KEY (`feedback_id`) REFERENCES `feedbacks` (`id`),
  CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `comments` */

insert  into `comments`(`id`,`comment`,`feedback_id`,`user_id`,`created_at`,`updated_at`) values 
(1,'Yes, that\'s true.',9,1,'2024-02-05 09:56:10','2024-02-05 09:56:10'),
(2,'It is good for health to each early morning',13,1,'2024-02-05 10:09:51','2024-02-05 10:09:51');

/*Table structure for table `failed_jobs` */

DROP TABLE IF EXISTS `failed_jobs`;

CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `failed_jobs` */

/*Table structure for table `feedbacks` */

DROP TABLE IF EXISTS `feedbacks`;

CREATE TABLE `feedbacks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `feedbacks_user_id_foreign` (`user_id`),
  CONSTRAINT `feedbacks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `feedbacks` */

insert  into `feedbacks`(`id`,`title`,`category`,`description`,`user_id`,`created_at`,`updated_at`) values 
(9,'Password Hashing','Improvement','As per wiki, Bcrypt is a password hashing function designed by Niels Provos and David Mazières, based on the Blowfish cipher. Bcrypt uses adaptive hash algorithm to store password which is a one-way hash of the password.',1,'2024-02-05 09:42:49','2024-02-05 09:42:49'),
(10,'BCrypt  Functionality','Feature Request','BCrypt internally generates a random salt while encoding passwords and stores that salt along with the encrypted password. Hence it is obvious to get different encoded results for the same string. But one common thing is that everytime it generates a String of length 60.',2,'2024-02-05 09:43:32','2024-02-05 09:43:32'),
(12,'May indulgence difficulty ham can put especially','Bug Report','May indulgence difficulty ham can put especially. Bringing remember for supplied her why was confined. Middleton principle did she procure extensive believing add. Weather adapted prepare oh is calling. These wrong of he which there smile to my front. He fruits oh enjoy it of whose table. Cultivated occasional old her unpleasing unpleasant. At as do be against pasture covered viewing started. Enjoyed me settled mr respect no spirits civilly.',2,'2024-02-05 09:45:04','2024-02-05 09:45:04'),
(13,'Breakfast','Improvement','Breakfast procuring nay end happiness allowance assurance frankness. Met simplicity nor difficulty unreserved who. Entreaties mr conviction dissimilar me astonished estimating cultivated. On no applauded exquisite my additions. Pronounce add boy estimable nay suspected. You sudden nay elinor thirty esteem temper. Quiet leave shy you gay off asked large style.',1,'2024-02-05 10:09:10','2024-02-05 10:09:10'),
(15,'The man requested','Feature Request','The man requested an adapted spirit set pressed. Up to denoting subjects sensible feelings it indulged directly. We dwelling elegance do shutters appetite yourself diverted. Our next drew much you with rank. Tore many held age hold rose than ours. Her literature sentiments any contrasted. Set aware joy sense young now tears china shy.',1,'2024-02-05 11:05:34','2024-02-05 11:05:34'),
(16,'What is random text generator?','Feature Request','Random Text Generator is a web application that provides true random text that you can use in your documents or web designs. How does it work? First, we took many books available on Project Gutenberg and stored their contents in a database. Then a computer algorithm takes the words we stored earlier and shuffles them into sentences and paragraphs.',1,'2024-02-05 11:07:35','2024-02-05 11:07:35'),
(17,'What can I do with this ?','Improvement','This tool was created because we wanted random text for our web designs. When we show a design to a client we want to have some text that doesn\'t mean anything in particular just to indicate that \"here is where the text will be\". So why shouldn\'t we just copy-paste a single sentence and get a block of text?',1,'2024-02-05 11:08:16','2024-02-05 11:08:16');

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values 
(1,'2014_10_12_000000_create_users_table',1),
(2,'2014_10_12_100000_create_password_reset_tokens_table',1),
(3,'2014_10_12_200000_add_two_factor_columns_to_users_table',1),
(4,'2019_08_19_000000_create_failed_jobs_table',1),
(5,'2019_12_14_000001_create_personal_access_tokens_table',1),
(6,'2024_01_23_194506_create_sessions_table',1),
(7,'2024_02_02_110802_create_feedbacks_table',2),
(10,'2024_02_02_115955_create_comments_table',3);

/*Table structure for table `password_reset_tokens` */

DROP TABLE IF EXISTS `password_reset_tokens`;

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `password_reset_tokens` */

/*Table structure for table `personal_access_tokens` */

DROP TABLE IF EXISTS `personal_access_tokens`;

CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `personal_access_tokens` */

insert  into `personal_access_tokens`(`id`,`tokenable_type`,`tokenable_id`,`name`,`token`,`abilities`,`last_used_at`,`expires_at`,`created_at`,`updated_at`) values 
(1,'App\\Models\\User',1,'Personal Access Token','1eee4e9c0230fd37d0746cd57b19af49b0a4faef63180cd0203ebce05a3c3512','[\"*\"]',NULL,NULL,'2024-02-01 10:45:33','2024-02-01 10:45:33'),
(2,'App\\Models\\User',1,'Personal Access Token','89e09dfeb934670258ce0183f4e69a33e13e70c4c6961628b38a15abb7e93673','[\"*\"]',NULL,NULL,'2024-02-01 10:46:50','2024-02-01 10:46:50'),
(3,'App\\Models\\User',1,'Personal Access Token','6ca3d5c1f0085d9c98b545d60f0aa47a9fd10eba2a3880de2abfeec40dc81e18','[\"*\"]',NULL,NULL,'2024-02-01 10:49:34','2024-02-01 10:49:34'),
(4,'App\\Models\\User',1,'Personal Access Token','05c3d4ac32d080da4daad9db90f93c978bb4e2cc996c5972239c7a5d79ff42bb','[\"*\"]',NULL,NULL,'2024-02-01 10:52:45','2024-02-01 10:52:45'),
(5,'App\\Models\\User',1,'Personal Access Token','7e0c3885869cff4b9951b9da03b29a06d49551d273496b433c37842171919cf9','[\"*\"]',NULL,NULL,'2024-02-01 10:53:41','2024-02-01 10:53:41'),
(6,'App\\Models\\User',1,'Personal Access Token','03abfffe852a745299d0e444e6a7abdcfb7d417b5c6d7bc20302f9c4c2b5832b','[\"*\"]',NULL,NULL,'2024-02-01 10:56:41','2024-02-01 10:56:41'),
(7,'App\\Models\\User',1,'Personal Access Token','5cfc00dc868e147fed8ef0406a492382acd470fbfc0ea050661c62c80445da71','[\"*\"]',NULL,NULL,'2024-02-01 11:00:54','2024-02-01 11:00:54'),
(8,'App\\Models\\User',1,'Personal Access Token','ddd38ae63bcf047a561523e9ab81a9e7f88007bbd2e6188a57d3e3e95b3a8498','[\"*\"]',NULL,NULL,'2024-02-01 11:15:22','2024-02-01 11:15:22'),
(9,'App\\Models\\User',1,'Personal Access Token','25d69ee705b4c057be1525a22bfa65c2231b198d0665a4708cba4098b10fff21','[\"*\"]',NULL,NULL,'2024-02-01 11:17:53','2024-02-01 11:17:53'),
(10,'App\\Models\\User',1,'Personal Access Token','b64aa0d1a22b8a672a0350bb36799602c6608ff9585f567e2413c97c015ceff9','[\"*\"]',NULL,NULL,'2024-02-01 16:54:19','2024-02-01 16:54:19'),
(11,'App\\Models\\User',1,'Personal Access Token','6b7aba7bcae220d3a98c9048ff802cbddcf8ad174292e583cbb6d0f2e1c345af','[\"*\"]',NULL,NULL,'2024-02-01 16:58:55','2024-02-01 16:58:55'),
(12,'App\\Models\\User',1,'Personal Access Token','86ba6aa4a629ad39d14536f29746d14e9086d9b04514b05cd7d03eaee188b8c1','[\"*\"]',NULL,NULL,'2024-02-01 17:05:24','2024-02-01 17:05:24'),
(13,'App\\Models\\User',1,'Personal Access Token','afdb99d42ffd2f82aaed447e5768a08f2fb5bb6c20f0a6d5a6562b00a1e4b58c','[\"*\"]',NULL,NULL,'2024-02-01 17:06:56','2024-02-01 17:06:56'),
(14,'App\\Models\\User',2,'Personal Access Token','585a060b6f4e3e0d91e33838277695ae5ab0e88cf59c719939b7b31b26101846','[\"*\"]',NULL,NULL,'2024-02-01 18:21:24','2024-02-01 18:21:24'),
(15,'App\\Models\\User',1,'Personal Access Token','7c14dade4a40c78f3e8d9145e2d3a8b39b473a0ba2ec5b877dbcc331c1609f18','[\"*\"]',NULL,NULL,'2024-02-02 10:21:29','2024-02-02 10:21:29'),
(16,'App\\Models\\User',1,'Personal Access Token','a21ed5e292f676d1cd38a5dabcd718cf49296ddc97c91392ad37701ab08b5596','[\"*\"]',NULL,NULL,'2024-02-03 13:30:06','2024-02-03 13:30:06'),
(17,'App\\Models\\User',1,'Personal Access Token','db59a884e6ad3d17918593096b4dcb99ff25343e613bbca57cdd2c352107a947','[\"*\"]',NULL,NULL,'2024-02-03 19:48:22','2024-02-03 19:48:22'),
(18,'App\\Models\\User',1,'Personal Access Token','d58814f1ea96dd3634ef7995907c0d605d9d37bbc8331d708d69d1319fb2b200','[\"*\"]',NULL,NULL,'2024-02-04 09:57:57','2024-02-04 09:57:57'),
(19,'App\\Models\\User',1,'Personal Access Token','deae35e27ab257b7e8e2d890a053e07b791508f84264b8f6fa5a3da6d7a60b45','[\"*\"]',NULL,NULL,'2024-02-04 16:23:12','2024-02-04 16:23:12'),
(20,'App\\Models\\User',1,'Personal Access Token','3984cd20d7e4c351368514468615765583015c93d834db17800df8311c9de891','[\"*\"]',NULL,NULL,'2024-02-04 19:58:55','2024-02-04 19:58:55'),
(21,'App\\Models\\User',1,'Personal Access Token','86836350c4a51f6bd46c89caa3ef084e875183aff4706d868d4944c21dea8037','[\"*\"]',NULL,NULL,'2024-02-04 20:23:43','2024-02-04 20:23:43'),
(22,'App\\Models\\User',1,'Personal Access Token','61070cfc1a9b84631475bb9c306f2361d92ecd2eab84cbb2b57ec5d844c11cf8','[\"*\"]',NULL,NULL,'2024-02-04 20:28:28','2024-02-04 20:28:28'),
(23,'App\\Models\\User',3,'Personal Access Token','da7a3b15763575ee473c5106d799a306d6ea3ca829c37831685cb94f53b04499','[\"*\"]',NULL,NULL,'2024-02-05 07:51:13','2024-02-05 07:51:13'),
(24,'App\\Models\\User',4,'Personal Access Token','1d061946b13d426ca9b0c61c52e5ffdc06fac5bad1208e0f2ac9c33b11ae7b00','[\"*\"]',NULL,NULL,'2024-02-05 07:53:26','2024-02-05 07:53:26'),
(25,'App\\Models\\User',5,'Personal Access Token','ff3e6b699814e56ef8e25aa60905586609b10d2d54fa5ecc4910ffa5a7ff4403','[\"*\"]',NULL,NULL,'2024-02-05 07:54:16','2024-02-05 07:54:16'),
(26,'App\\Models\\User',8,'Personal Access Token','a02ae51caec420f0b852d52c2f807832fd61119ca764de9c15e1bf6cdc5926b9','[\"*\"]',NULL,NULL,'2024-02-05 08:18:06','2024-02-05 08:18:06'),
(27,'App\\Models\\User',1,'Personal Access Token','7f0afc112989f3b12332d51fb859bac6c55670b1edcb7aad86ddd5ed63c8bcf8','[\"*\"]',NULL,NULL,'2024-02-05 09:22:13','2024-02-05 09:22:13'),
(28,'App\\Models\\User',1,'Personal Access Token','5075c3ada470ef6ef9e068311df63633574e2c27b12a28f993070b39f0ad698d','[\"*\"]',NULL,NULL,'2024-02-05 09:55:11','2024-02-05 09:55:11'),
(29,'App\\Models\\User',1,'Personal Access Token','63493b88a11c76fabd0cbca2869179c661f26a95a802853b361bde89f54ddaa5','[\"*\"]',NULL,NULL,'2024-02-05 10:05:46','2024-02-05 10:05:46'),
(30,'App\\Models\\User',1,'Personal Access Token','0d59a73e210d4902bc5b1da89cabe3f6f18ce16d77fa717cb11ab89483391a7d','[\"*\"]',NULL,NULL,'2024-02-05 10:08:38','2024-02-05 10:08:38'),
(31,'App\\Models\\User',1,'Personal Access Token','d674c6db56b8657c4d5f850a10844d7b9af6cfead6beba6f630aecf71c67a7eb','[\"*\"]',NULL,NULL,'2024-02-05 10:14:26','2024-02-05 10:14:26'),
(32,'App\\Models\\User',1,'Personal Access Token','5b016a296324fdcd740dfcb52c313755d4085e5bb7aef30e99ab700635862ef2','[\"*\"]',NULL,NULL,'2024-02-05 10:17:12','2024-02-05 10:17:12'),
(33,'App\\Models\\User',1,'Personal Access Token','d220d82234925121ca9efcea9eb86323c8e4210d9cb0ec5f67b5d9b7134ae0e7','[\"*\"]',NULL,NULL,'2024-02-05 10:18:46','2024-02-05 10:18:46'),
(34,'App\\Models\\User',1,'Personal Access Token','b4751f331aa327f4ddbab56fab1faaedd1cf6be135f6a9af1ee33d99f3cd606a','[\"*\"]',NULL,NULL,'2024-02-05 10:22:15','2024-02-05 10:22:15'),
(35,'App\\Models\\User',1,'Personal Access Token','18edf57e1ca29b33929db2c12ee065288783f85ac48158a5151576b8514c9863','[\"*\"]',NULL,NULL,'2024-02-05 10:23:14','2024-02-05 10:23:14'),
(36,'App\\Models\\User',1,'Personal Access Token','498bafbf12b79067c26cd36c9efc537efc960dae2b6ee23ae27130313ec33ba2','[\"*\"]',NULL,NULL,'2024-02-05 10:24:53','2024-02-05 10:24:53'),
(37,'App\\Models\\User',1,'Personal Access Token','b7957a8634ce2df4e93c0e3c194d1a7c8807fdd0bacd1f6b006a53912b2d2b31','[\"*\"]',NULL,NULL,'2024-02-05 10:26:44','2024-02-05 10:26:44'),
(38,'App\\Models\\User',1,'Personal Access Token','a0c81ba43a6f4c8eae15399d97972ebb67aec8979037411b72e9361ab09a02c2','[\"*\"]',NULL,NULL,'2024-02-05 10:29:07','2024-02-05 10:29:07'),
(39,'App\\Models\\User',1,'Personal Access Token','59df81055726fad4f1f8b0a4689e285c4e11daa1242015b3627f5efaf7a024f9','[\"*\"]',NULL,NULL,'2024-02-05 10:33:24','2024-02-05 10:33:24'),
(40,'App\\Models\\User',1,'Personal Access Token','1987933f1140de7cdf15933f6c5c6ced469b2e418b037a41286cb77d20861325','[\"*\"]',NULL,NULL,'2024-02-05 10:35:31','2024-02-05 10:35:31'),
(41,'App\\Models\\User',1,'Personal Access Token','f12846c3ba70bfab53a64d1469383b97985880f958eeb690235d88742abf70f4','[\"*\"]',NULL,NULL,'2024-02-05 10:38:23','2024-02-05 10:38:23'),
(42,'App\\Models\\User',1,'Personal Access Token','e1016221a262572074ff7ba1907a1888445dd25ee802df5f134fcdd9e6593b3a','[\"*\"]',NULL,NULL,'2024-02-05 10:41:10','2024-02-05 10:41:10'),
(43,'App\\Models\\User',1,'Personal Access Token','88966619a513d6a134e1089ca62fb24b6f05b6b1fefca0b81e9a53cbc945c5b5','[\"*\"]',NULL,NULL,'2024-02-05 10:48:46','2024-02-05 10:48:46'),
(44,'App\\Models\\User',1,'Personal Access Token','ebf2661243d8a5e4c0c5861e30477b2c76fb9d88b7578252e402e9df4c446931','[\"*\"]',NULL,NULL,'2024-02-05 10:50:30','2024-02-05 10:50:30'),
(45,'App\\Models\\User',1,'Personal Access Token','c8c2deb2bdc13d6f2fb9817d2562cf3b218c20fb10525b45824b47b074b19aa8','[\"*\"]',NULL,NULL,'2024-02-05 10:52:50','2024-02-05 10:52:50'),
(46,'App\\Models\\User',1,'Personal Access Token','37357e6a6b97e1eb567676c07c50943634f930cce83b81e2230215b4637fb62d','[\"*\"]',NULL,NULL,'2024-02-05 10:54:06','2024-02-05 10:54:06'),
(47,'App\\Models\\User',1,'Personal Access Token','8ca41eca66f1ed5b4abc8e0c799e50c2fe4912894d61fc4c58ee9ecd85cec55c','[\"*\"]',NULL,NULL,'2024-02-05 10:54:19','2024-02-05 10:54:19'),
(48,'App\\Models\\User',1,'Personal Access Token','6f1d84c990e7d5b1e3bbda0cfb3a11fe2eb47c6c2603d62603720b1adb9f1fca','[\"*\"]',NULL,NULL,'2024-02-05 10:54:32','2024-02-05 10:54:32'),
(49,'App\\Models\\User',1,'Personal Access Token','a04624bc2329be6413583cb574e17fd0a4e8d57aab38d86338b7da9a9ff69efc','[\"*\"]',NULL,NULL,'2024-02-05 10:57:14','2024-02-05 10:57:14'),
(50,'App\\Models\\User',1,'Personal Access Token','2d99165131ef7931bf5885de2709614420dd7b66990c88e78124d732fbd0030b','[\"*\"]',NULL,NULL,'2024-02-05 11:03:31','2024-02-05 11:03:31'),
(51,'App\\Models\\User',1,'Personal Access Token','2e196ee39356e18d988079d875662d0c63c317543510cf19dde1afd1983cd53f','[\"*\"]',NULL,NULL,'2024-02-05 11:04:46','2024-02-05 11:04:46');

/*Table structure for table `sessions` */

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `sessions` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_team_id` bigint unsigned DEFAULT NULL,
  `profile_photo_path` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`email`,`email_verified_at`,`password`,`two_factor_secret`,`two_factor_recovery_codes`,`two_factor_confirmed_at`,`remember_token`,`current_team_id`,`profile_photo_path`,`created_at`,`updated_at`) values 
(1,'Danish Ali','danish@gmail.com',NULL,'$2y$12$JErj2HtLOndBVM8fw9FeQuSr7dEihS5HFzNFUvueF/UE48EfMzC1O',NULL,NULL,NULL,'6TMcALcCBIzpQx0wFoBbyyWfDy1FnmZi8YmrT8RuzLqz7wOh923TIh1m7tzE',NULL,NULL,'2024-02-01 10:45:33','2024-02-01 10:45:33'),
(2,'Jamshid Ali','jamshid@gmail.com',NULL,'$2a$04$b7pSwXfN0QyK68aeWOR5XeZEXQd1U8s4WPEUL.NqA79L6x4kgns5W',NULL,NULL,NULL,NULL,NULL,NULL,'2024-02-01 18:21:24','2024-02-01 18:21:24'),
(3,'Muhammad Arham','marham@gmail.com',NULL,'$2a$04$DYqOX8kZgyoDgAwWyGS8meQnMcWKqN0guYWsO5EDX6xMj/3RnGB6C',NULL,NULL,NULL,NULL,NULL,NULL,'2024-02-05 07:51:12','2024-02-05 07:51:12'),
(4,'Muhammad Ammar','mammar@gmail.com',NULL,'$2a$04$CZBQu/YG2w0UCWbiyh0Sjet8ZLx6vYwJHwGB8Bwnv02bvoNOJp/4.',NULL,NULL,NULL,NULL,NULL,NULL,'2024-02-05 07:53:26','2024-02-05 07:53:26'),
(5,'Nabeel Nazir','nabeel@gmail.com',NULL,'$2a$04$4jzoQ4V4MY83GOa8WoqegOTE0reCfTHsonPYeBeIYBygRGoS1aTzC',NULL,NULL,NULL,NULL,NULL,NULL,'2024-02-05 07:54:16','2024-02-05 07:54:16');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
