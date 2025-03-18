-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 13, 2025 at 04:47 PM
-- Server version: 10.6.5-MariaDB
-- PHP Version: 8.1.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shubham_shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
CREATE TABLE IF NOT EXISTS `admins` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) UNSIGNED DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `show_email_address` int(11) DEFAULT 0,
  `phone` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `show_phone_number` int(11) NOT NULL DEFAULT 0,
  `password` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admins_username_unique` (`username`),
  UNIQUE KEY `admins_email_unique` (`email`),
  KEY `admins_role_id_foreign` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `role_id`, `first_name`, `last_name`, `image`, `username`, `email`, `show_email_address`, `phone`, `show_phone_number`, `password`, `address`, `details`, `status`, `created_at`, `updated_at`) VALUES
(1, NULL, 'leo', 'Bourne', '65c20e674bd34.png', 'admin', '123@example.com', 1, '12345678', 1, '$2y$10$7rcuMv8LG9adF09JnRjt.O35YL/3dkFWA7EBhBT.LOZvS07OaeDFm', 'House no 3, Road 5/c, sector 11, Uttara, Dhaka, Bangladesh', 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Molestiae blanditiis minus tempora quibusdam quas quo magni, repellat sit? Adipisci accusantium quasi autem tempora nemo aspernatur tenetur repellat numquam sed cupiditate.', 1, NULL, '2024-05-15 02:09:24');

-- --------------------------------------------------------

--
-- Table structure for table `advertisements`
--

DROP TABLE IF EXISTS `advertisements`;
CREATE TABLE IF NOT EXISTS `advertisements` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ad_type` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `resolution_type` smallint(5) UNSIGNED NOT NULL COMMENT '1 => 300 x 250, 2 => 300 x 600, 3 => 728 x 90',
  `image` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `slot` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `views` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `aminites`
--

DROP TABLE IF EXISTS `aminites`;
CREATE TABLE IF NOT EXISTS `aminites` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `basic_settings`
--

DROP TABLE IF EXISTS `basic_settings`;
CREATE TABLE IF NOT EXISTS `basic_settings` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uniqid` int(10) UNSIGNED NOT NULL DEFAULT 12345,
  `favicon` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `logo_two` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `website_title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email_address` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `contact_number` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `theme_version` smallint(5) UNSIGNED NOT NULL,
  `base_currency_symbol` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `base_currency_symbol_position` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `base_currency_text` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `base_currency_text_position` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `base_currency_rate` decimal(8,2) DEFAULT NULL,
  `primary_color` varchar(30) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `smtp_status` tinyint(4) DEFAULT NULL,
  `smtp_host` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `smtp_port` int(11) DEFAULT NULL,
  `encryption` varchar(50) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `smtp_username` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `smtp_password` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `from_mail` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `from_name` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `to_mail` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `breadcrumb` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `disqus_status` tinyint(3) UNSIGNED DEFAULT NULL,
  `disqus_short_name` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_recaptcha_status` tinyint(4) DEFAULT NULL,
  `google_recaptcha_site_key` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_recaptcha_secret_key` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `whatsapp_status` tinyint(3) UNSIGNED DEFAULT NULL,
  `whatsapp_number` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `whatsapp_header_title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `whatsapp_popup_status` tinyint(3) UNSIGNED DEFAULT NULL,
  `whatsapp_popup_message` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `maintenance_img` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `maintenance_status` tinyint(4) DEFAULT NULL,
  `maintenance_msg` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `bypass_token` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `footer_logo` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `footer_background_image` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `admin_theme_version` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'light',
  `notification_image` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `counter_section_image` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `call_to_action_section_image` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `call_to_action_section_highlight_image` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `video_section_image` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `testimonial_section_image` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `category_section_background` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_adsense_publisher_id` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `equipment_tax_amount` decimal(5,2) UNSIGNED DEFAULT NULL,
  `product_tax_amount` decimal(5,2) UNSIGNED DEFAULT NULL,
  `self_pickup_status` tinyint(3) UNSIGNED DEFAULT NULL,
  `two_way_delivery_status` tinyint(3) UNSIGNED DEFAULT NULL,
  `guest_checkout_status` tinyint(3) UNSIGNED NOT NULL,
  `shop_status` int(11) DEFAULT 1,
  `admin_approve_status` int(11) NOT NULL DEFAULT 0,
  `listing_view` int(11) DEFAULT NULL,
  `facebook_login_status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1 -> enable, 0 -> disable',
  `facebook_app_id` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `facebook_app_secret` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_login_status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1 -> enable, 0 -> disable',
  `google_client_id` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_client_secret` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `tawkto_status` tinyint(3) UNSIGNED NOT NULL COMMENT '1 -> enable, 0 -> disable',
  `hero_section_background_img` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `tawkto_direct_chat_link` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `vendor_admin_approval` int(11) NOT NULL DEFAULT 0 COMMENT '1 active, 2 deactive',
  `vendor_email_verification` int(11) NOT NULL DEFAULT 0 COMMENT '1 active, 2 deactive',
  `admin_approval_notice` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `expiration_reminder` int(11) DEFAULT 3,
  `timezone` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `hero_section_video_url` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `contact_title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `contact_subtile` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `contact_details` longtext COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `latitude` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `longitude` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `preloader_status` int(11) DEFAULT 1,
  `preloader` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `basic_settings`
--

INSERT INTO `basic_settings` (`id`, `uniqid`, `favicon`, `logo`, `logo_two`, `website_title`, `email_address`, `contact_number`, `address`, `theme_version`, `base_currency_symbol`, `base_currency_symbol_position`, `base_currency_text`, `base_currency_text_position`, `base_currency_rate`, `primary_color`, `smtp_status`, `smtp_host`, `smtp_port`, `encryption`, `smtp_username`, `smtp_password`, `from_mail`, `from_name`, `to_mail`, `breadcrumb`, `disqus_status`, `disqus_short_name`, `google_recaptcha_status`, `google_recaptcha_site_key`, `google_recaptcha_secret_key`, `whatsapp_status`, `whatsapp_number`, `whatsapp_header_title`, `whatsapp_popup_status`, `whatsapp_popup_message`, `maintenance_img`, `maintenance_status`, `maintenance_msg`, `bypass_token`, `footer_logo`, `footer_background_image`, `admin_theme_version`, `notification_image`, `counter_section_image`, `call_to_action_section_image`, `call_to_action_section_highlight_image`, `video_section_image`, `testimonial_section_image`, `category_section_background`, `google_adsense_publisher_id`, `equipment_tax_amount`, `product_tax_amount`, `self_pickup_status`, `two_way_delivery_status`, `guest_checkout_status`, `shop_status`, `admin_approve_status`, `listing_view`, `facebook_login_status`, `facebook_app_id`, `facebook_app_secret`, `google_login_status`, `google_client_id`, `google_client_secret`, `tawkto_status`, `hero_section_background_img`, `tawkto_direct_chat_link`, `vendor_admin_approval`, `vendor_email_verification`, `admin_approval_notice`, `expiration_reminder`, `timezone`, `hero_section_video_url`, `contact_title`, `contact_subtile`, `contact_details`, `latitude`, `longitude`, `preloader_status`, `preloader`, `updated_at`) VALUES
(2, 12345, '6631b1ad22bf4.png', '673cc0fa05dc4.png', '64ed7071b1844.png', 'Shubham', 'bulistio@example.com', '+701 - 1111 - 2222 - 333', '450 Young Road, New York, USA', 1, '$', 'left', 'Rupees', 'left', '82.00', 'FFAD00', 1, 'smtp.gmail.com', 465, 'ssl', 'naveen.webconverts@gmail.com', 'mdthjsxbsbztpmdr', 'naveen.webconverts@gmail.com', 'naveen', NULL, '65c200e4ea394.png', 0, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '1632725312.png', 0, 'We are upgrading our site. We will come back soon. \r\nPlease stay with us.\r\nThank you.', 'fahad', '6593ab335bdcc.png', '638db9bf3f92a.jpg', 'light', '619b7d5e5e9df.png', '6530b4b2c6984.jpg', '663cb8ff44ba5.jpg', '663cb8e3a578e.png', '663efcc6ce380.jpg', '657a7500bb6c1.jpg', '63c92601cb853.jpg', 'dvf', '5.00', '5.00', 1, 1, 0, 0, 1, 1, 0, NULL, NULL, 1, '121739998629-rc42vu43g2di11632e1mm8i9fab6mgs1.apps.googleusercontent.com', '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', 0, '664b03706cf4a.png', '', 0, 0, 'Your account is deactive or pending now. Please Contact with admin!', 3, 'Asia/Dhaka', 'https://www.youtube.com/watch?v=9l6RywtDlKA', 'Get Connected', 'How Can We Help You?', 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\r\n\r\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.', '23.8587', '90.4001', 1, '65e7f2608a3c1.gif', '2023-08-24 00:02:42');

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

DROP TABLE IF EXISTS `blogs`;
CREATE TABLE IF NOT EXISTS `blogs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `image` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` mediumint(8) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `blogs`
--

INSERT INTO `blogs` (`id`, `image`, `serial_number`, `created_at`, `updated_at`) VALUES
(32, '674ae4cdb69ea.png', 1, '2024-11-30 04:41:25', '2024-11-30 04:41:25'),
(33, '674ae524e9714.png', 2, '2024-11-30 04:42:52', '2024-11-30 04:42:52');

-- --------------------------------------------------------

--
-- Table structure for table `blog_categories`
--

DROP TABLE IF EXISTS `blog_categories`;
CREATE TABLE IF NOT EXISTS `blog_categories` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL,
  `serial_number` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_categories_language_id_foreign` (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `blog_categories`
--

INSERT INTO `blog_categories` (`id`, `language_id`, `name`, `slug`, `status`, `serial_number`, `created_at`, `updated_at`) VALUES
(50, 20, 'Marriage', 'marriage', 1, 1, '2024-11-30 04:40:53', '2024-12-28 09:58:14'),
(51, 20, 'Birthday Wishes', 'birthday-wishes', 1, 1, '2024-08-17 19:33:43', '2024-08-17 19:33:43'),
(52, 20, 'Condolence Message', 'condolence-message', 1, 2, '2024-08-17 19:34:43', '2024-08-17 19:34:43'),
(53, 20, 'Marriage Wishes', 'marriage-wishes', 1, 3, '2024-08-17 19:35:02', '2024-08-17 19:35:02'),
(54, 20, 'Catering Service', 'catering-service', 1, 4, '2024-09-03 19:38:57', '2024-09-03 19:38:57');

-- --------------------------------------------------------

--
-- Table structure for table `blog_informations`
--

DROP TABLE IF EXISTS `blog_informations`;
CREATE TABLE IF NOT EXISTS `blog_informations` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `blog_category_id` bigint(20) UNSIGNED NOT NULL,
  `blog_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `author` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` blob NOT NULL,
  `meta_keywords` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_informations_language_id_foreign` (`language_id`),
  KEY `blog_informations_blog_category_id_foreign` (`blog_category_id`),
  KEY `blog_informations_blog_id_foreign` (`blog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `blog_informations`
--

INSERT INTO `blog_informations` (`id`, `language_id`, `blog_category_id`, `blog_id`, `title`, `slug`, `author`, `content`, `meta_keywords`, `meta_description`, `created_at`, `updated_at`) VALUES
(3, 20, 50, 32, 'test', 'test', 'asdasd', 0x3c703e57652077616e746564206120756e697175652c207468656d652062617365642077656464696e672c20616e642074686579206162736f6c7574656c79206e61696c656420697421205468652064c3a9636f72207761732062726561746874616b696e672c20616e642074686520656e74697265206576656e7420666c6f77656420736f3c6272202f3e736d6f6f74686c792e204f757220677565737473207765726520696e206177652c20616e6420776520636f756c646ee28099742062652068617070696572213c2f703e, 'sdfs', 'sdfsdfsf', '2024-11-30 04:41:30', '2024-11-30 04:41:30'),
(4, 20, 50, 33, 'testsadasd', 'testsadasd', 'asdasd', 0x3c703e57652077616e746564206120756e697175652c207468656d652062617365642077656464696e672c20616e642074686579206162736f6c7574656c79206e61696c656420697421205468652064c3a9636f72207761732062726561746874616b696e672c20616e642074686520656e74697265206576656e7420666c6f77656420736f3c6272202f3e736d6f6f74686c792e204f757220677565737473207765726520696e206177652c20616e6420776520636f756c646ee28099742062652068617070696572213c2f703e, NULL, NULL, '2024-11-30 04:42:53', '2024-11-30 04:42:53');

-- --------------------------------------------------------

--
-- Table structure for table `blog_sections`
--

DROP TABLE IF EXISTS `blog_sections`;
CREATE TABLE IF NOT EXISTS `blog_sections` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `button_text` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `blog_sections`
--

INSERT INTO `blog_sections` (`id`, `language_id`, `button_text`, `title`, `created_at`, `updated_at`) VALUES
(5, 20, 'Mores', 'Read our latest blogs', '2023-08-19 00:44:01', '2023-12-13 21:29:05');

-- --------------------------------------------------------

--
-- Table structure for table `business_hours`
--

DROP TABLE IF EXISTS `business_hours`;
CREATE TABLE IF NOT EXISTS `business_hours` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `day` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `holiday` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `business_hours`
--

INSERT INTO `business_hours` (`id`, `listing_id`, `day`, `start_time`, `end_time`, `holiday`, `created_at`, `updated_at`) VALUES
(8, 2, 'Saturday', '10:00 AM', '07:00 PM', 1, '2024-09-03 18:36:12', '2024-09-03 18:36:12'),
(9, 2, 'Sunday', '10:00 AM', '07:00 PM', 1, '2024-09-03 18:36:12', '2024-09-03 18:36:12'),
(10, 2, 'Monday', '10:00 AM', '07:00 PM', 1, '2024-09-03 18:36:12', '2024-09-03 18:36:12'),
(11, 2, 'Tuesday', '10:00 AM', '07:00 PM', 1, '2024-09-03 18:36:12', '2024-09-03 18:36:12'),
(12, 2, 'Wednesday', '10:00 AM', '07:00 PM', 1, '2024-09-03 18:36:12', '2024-09-03 18:36:12'),
(13, 2, 'Thursday', '10:00 AM', '07:00 PM', 1, '2024-09-03 18:36:12', '2024-09-03 18:36:12'),
(14, 2, 'Friday', '10:00 AM', '07:00 PM', 1, '2024-09-03 18:36:12', '2024-09-03 18:36:12'),
(22, 2, 'Saturday', '10:00 AM', '07:00 PM', 1, '2025-02-25 01:28:17', '2025-02-25 01:28:17'),
(23, 2, 'Sunday', '10:00 AM', '07:00 PM', 1, '2025-02-25 01:28:17', '2025-02-25 01:28:17'),
(24, 2, 'Monday', '10:00 AM', '07:00 PM', 1, '2025-02-25 01:28:17', '2025-02-25 01:28:17'),
(25, 2, 'Tuesday', '10:00 AM', '07:00 PM', 1, '2025-02-25 01:28:17', '2025-02-25 01:28:17'),
(26, 2, 'Wednesday', '10:00 AM', '07:00 PM', 1, '2025-02-25 01:28:17', '2025-02-25 01:28:17'),
(27, 2, 'Thursday', '10:00 AM', '07:00 PM', 1, '2025-02-25 01:28:17', '2025-02-25 01:28:17'),
(28, 2, 'Friday', '10:00 AM', '07:00 PM', 1, '2025-02-25 01:28:17', '2025-02-25 01:28:17');

-- --------------------------------------------------------

--
-- Table structure for table `call_to_action_sections`
--

DROP TABLE IF EXISTS `call_to_action_sections`;
CREATE TABLE IF NOT EXISTS `call_to_action_sections` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `subtitle` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `video_url` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `button_name` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `button_url` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `call_to_action_sections`
--

INSERT INTO `call_to_action_sections` (`id`, `language_id`, `subtitle`, `title`, `text`, `video_url`, `button_name`, `button_url`, `created_at`, `updated_at`) VALUES
(4, 20, 'pe earum totam minima aperiam repellendus possimus molestias optio sapiente, quam               repudiandae voluptatum accusantium.', 'Explore Your Favorite business with usWith Us', 'We highly recommend Carlist. We\'ve used them several times and have always been impressed with their excellent and awesome service.', NULL, 'Register Now', 'https://www.example.com', '2023-08-28 02:47:29', '2024-05-15 02:15:46');

-- --------------------------------------------------------

--
-- Table structure for table `category_sections`
--

DROP TABLE IF EXISTS `category_sections`;
CREATE TABLE IF NOT EXISTS `category_sections` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `subtitle` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `button_text` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `category_sections`
--

INSERT INTO `category_sections` (`id`, `language_id`, `title`, `subtitle`, `text`, `button_text`, `created_at`, `updated_at`) VALUES
(3, '20', 'Explore  Categories', NULL, '', 'Explore', '2023-08-19 00:11:48', '2024-04-30 22:23:14');

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
CREATE TABLE IF NOT EXISTS `cities` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `country_id` bigint(20) DEFAULT NULL,
  `feature_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=234 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`id`, `language_id`, `country_id`, `feature_image`, `state_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 20, 1, '1719857454.png', 1, 'Mysore(Mysuru)', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(2, 20, 1, '1723923504.jpeg', 1, 'Bangalore(Bengaluru)', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(3, 20, 1, '1723923581.jpeg', 1, 'Dharwad', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(4, 20, 1, '1723923644.jpeg', 1, 'Mandya', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(5, 20, 1, '1719857454.png', 1, 'Bagalkote', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(6, 20, 1, '1723923504.jpeg', 1, 'Badami', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(7, 20, 1, '1723923581.jpeg', 1, 'Bijjinagere', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(8, 20, 1, '1723923644.jpeg', 1, 'Hungund', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(9, 20, 1, '1719857454.png', 1, 'Jamkhandi', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(10, 20, 1, '1723923504.jpeg', 1, 'Mudhol', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(11, 20, 1, '1723923581.jpeg', 1, 'Terdal', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(12, 20, 1, '1723923644.jpeg', 1, 'Belagavi', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(13, 20, 1, '1719857454.png', 1, 'Athani', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(14, 20, 1, '1723923504.jpeg', 1, 'Bailhongal', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(15, 20, 1, '1723923581.jpeg', 1, 'Chikkodi', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(16, 20, 1, '1723923644.jpeg', 1, 'Gokak', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(17, 20, 1, '1719857454.png', 1, 'Hukkeri', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(18, 20, 1, '1723923504.jpeg', 1, 'Khanapur', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(19, 20, 1, '1723923581.jpeg', 1, 'Kittur', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(20, 20, 1, '1723923644.jpeg', 1, 'Ramadurg', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(21, 20, 1, '1719857454.png', 1, 'Saundatti', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(22, 20, 1, '1723923504.jpeg', 1, 'Yellapur', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(23, 20, 1, '1723923581.jpeg', 1, 'Bidar', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(24, 20, 1, '1723923644.jpeg', 1, 'Basavakalyan', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(25, 20, 1, '1719857454.png', 1, 'Bhalki', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(26, 20, 1, '1723923504.jpeg', 1, 'Humnabad', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(27, 20, 1, '1723923581.jpeg', 1, 'Kamalapur', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(28, 20, 1, '1723923644.jpeg', 1, 'Aurad', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(29, 20, 1, '1719857454.png', 1, 'Chamarajanagar', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(30, 20, 1, '1723923504.jpeg', 1, 'Gundlupet', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(31, 20, 1, '1723923581.jpeg', 1, 'Hanur', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(32, 20, 1, '1723923644.jpeg', 1, 'Kollegal', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(33, 20, 1, '1719857454.png', 1, 'Chikkamagaluru', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(34, 20, 1, '1723923504.jpeg', 1, 'Ajjampura', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(35, 20, 1, '1723923581.jpeg', 1, 'Balehonnur', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(36, 20, 1, '1723923644.jpeg', 1, 'Kadur', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(37, 20, 1, '1719857454.png', 1, 'Koppa', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(38, 20, 1, '1723923504.jpeg', 1, 'Sakleshpur', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(39, 20, 1, '1723923581.jpeg', 1, 'Chitradurga', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(40, 20, 1, '1723923644.jpeg', 1, 'Challakere', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(41, 20, 1, '1719857454.png', 1, 'Davanagere', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(42, 20, 1, '1719857454.png', 1, 'Hiriyur', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(43, 20, 1, '1723923504.jpeg', 1, 'Holalkere', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(44, 20, 1, '1723923581.jpeg', 1, 'Hospet(Hosapete)', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(45, 20, 1, '1723923644.jpeg', 1, 'Jagalur', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(46, 20, 1, '1719857454.png', 1, 'Molakalmuru', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(47, 20, 1, '1723923504.jpeg', 1, 'Niymagondanahalli', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(48, 20, 1, '1723923581.jpeg', 1, 'Palya', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(49, 20, 1, '1723923644.jpeg', 1, 'Mangaluru', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(50, 20, 1, '1719857454.png', 1, 'Bantwal', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(51, 20, 1, '1723923504.jpeg', 1, 'Beltangady', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(52, 20, 1, '1723923581.jpeg', 1, 'Moodbidri', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(53, 20, 1, '1723923644.jpeg', 1, 'Puttur', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(54, 20, 1, '1719857454.png', 1, 'Davanagere', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(55, 20, 1, '1723923504.jpeg', 1, 'Channagiri', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(56, 20, 1, '1723923581.jpeg', 1, 'Bhadravathi', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(57, 20, 1, '1723923644.jpeg', 1, 'Harihar', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(58, 20, 1, '1719857454.png', 1, 'Jagalur', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(59, 20, 1, '1723923504.jpeg', 1, 'Mayakonda', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(60, 20, 1, '1723923581.jpeg', 1, 'Nyamatti', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(61, 20, 1, '1723923644.jpeg', 1, 'Ron', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(62, 20, 1, '1719857454.png', 1, 'Alnavar', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(63, 20, 1, '1723923504.jpeg', 1, 'Annigeri', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(64, 20, 1, '1723923581.jpeg', 1, 'Kundagola', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(65, 20, 1, '1723923644.jpeg', 1, 'Navalgund', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(66, 20, 1, '1719857454.png', 1, 'Shiggaon', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(67, 20, 1, '1723923504.jpeg', 1, 'Hubballi', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(68, 20, 1, '1723923581.jpeg', 1, 'Gadag', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(69, 20, 1, '1723923644.jpeg', 1, 'Dharwar', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(70, 20, 1, '1719857454.png', 1, 'Koppal', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(71, 20, 1, '1723923504.jpeg', 1, 'Mundargi', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(72, 20, 1, '1723923581.jpeg', 1, 'Doddaballapur', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(73, 20, 1, '1723923644.jpeg', 1, 'Shirhatti', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(74, 20, 1, '1719857454.png', 1, 'Hassan', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(75, 20, 1, '1723923504.jpeg', 1, 'Arkalgud', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(76, 20, 1, '1723923581.jpeg', 1, 'Belur', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(77, 20, 1, '1723923644.jpeg', 1, 'Channarayapatna', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(78, 20, 1, '1719857454.png', 1, 'Holenarasipur', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(79, 20, 1, '1723923504.jpeg', 1, 'Sakleshpur', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(80, 20, 1, '1723923581.jpeg', 1, 'Haveri', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(81, 20, 1, '1723923644.jpeg', 1, 'Byadagi', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(82, 20, 1, '1719857454.png', 1, 'Hirekerur', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(83, 20, 1, '1719857454.png', 1, 'Ranibennur', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(84, 20, 1, '1723923504.jpeg', 1, 'Sirsi', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(85, 20, 1, '1723923581.jpeg', 1, 'Kalaburagi', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(86, 20, 1, '1723923644.jpeg', 1, 'Afzalpur', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(87, 20, 1, '1719857454.png', 1, 'Aland', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(88, 20, 1, '1723923504.jpeg', 1, 'Chincholi', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(89, 20, 1, '1723923581.jpeg', 1, 'Gulbarga', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(90, 20, 1, '1723923644.jpeg', 1, 'Jewargi', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(91, 20, 1, '1719857454.png', 1, 'Sedam', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(92, 20, 1, '1723923504.jpeg', 1, 'Shahapur', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(93, 20, 1, '1723923581.jpeg', 1, 'Kolar', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(94, 20, 1, '1723923644.jpeg', 1, 'Bangarapet', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(95, 20, 1, '1719857454.png', 1, 'Gowribidanur', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(96, 20, 1, '1723923504.jpeg', 1, 'KGF', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(97, 20, 1, '1723923581.jpeg', 1, 'Malur', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(98, 20, 1, '1723923644.jpeg', 1, 'Mulbagal', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(99, 20, 1, '1719857454.png', 1, 'Srinivaspur', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(100, 20, 1, '1723923504.jpeg', 1, 'Koppal', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(101, 20, 1, '1723923581.jpeg', 1, 'Gangavati', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(102, 20, 1, '1723923644.jpeg', 1, 'Kushtagi', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(103, 20, 1, '1719857454.png', 1, 'Yeliyur', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(104, 20, 1, '1723923504.jpeg', 1, 'KR Pet', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(105, 20, 1, '1723923581.jpeg', 1, 'Maddur', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(106, 20, 1, '1723923644.jpeg', 1, 'Malavalli', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(107, 20, 1, '1719857454.png', 1, 'Pandavapura', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(108, 20, 1, '1723923504.jpeg', 1, 'Hunsur', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(109, 20, 1, '1723923581.jpeg', 1, 'HD Kote', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(110, 20, 1, '1723923644.jpeg', 1, 'Nanjangud', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(111, 20, 1, '1719857454.png', 1, 'Periyapatna', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(112, 20, 1, '1723923504.jpeg', 1, 'T Narasipur', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(113, 20, 1, '1723923581.jpeg', 1, 'Varuna', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(114, 20, 1, '1723923644.jpeg', 1, 'Raichur', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(115, 20, 1, '1719857454.png', 1, 'Deodurg', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(116, 20, 1, '1723923504.jpeg', 1, 'Lingsugur', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(117, 20, 1, '1723923581.jpeg', 1, 'Mantralayam', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(118, 20, 1, '1723923644.jpeg', 1, 'Sindhnur', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(119, 20, 1, '1719857454.png', 1, 'Siruguppa', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(120, 20, 1, '1723923504.jpeg', 1, 'Shivamogga', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(121, 20, 1, '1723923581.jpeg', 1, 'Bhadravati', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(122, 20, 1, '1723923644.jpeg', 1, 'Sagara', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(123, 20, 1, '1719857454.png', 1, 'Shikaripur', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(124, 20, 1, '1719857454.png', 1, 'Kudligi', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(125, 20, 1, '1723923504.jpeg', 1, 'Tirthahalli', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(126, 20, 1, '1723923581.jpeg', 1, 'Tumkuru', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(127, 20, 1, '1723923644.jpeg', 1, 'Gubbi', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(128, 20, 1, '1719857454.png', 1, 'Koratagere', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(129, 20, 1, '1723923504.jpeg', 1, 'Madhugiri', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(130, 20, 1, '1723923581.jpeg', 1, 'Pavagada', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(131, 20, 1, '1723923644.jpeg', 1, 'Siddaganga', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(132, 20, 1, '1719857454.png', 1, 'Tiptur', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(133, 20, 1, '1723923504.jpeg', 1, 'Udupi', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(134, 20, 1, '1723923581.jpeg', 1, 'Brahmavar', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(135, 20, 1, '1723923644.jpeg', 1, 'Karkala', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(136, 20, 1, '1719857454.png', 1, 'Kundapura', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(137, 20, 1, '1723923504.jpeg', 1, 'Karwar', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(138, 20, 1, '1723923581.jpeg', 1, 'Ankola', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(139, 20, 1, '1723923644.jpeg', 1, 'Bhatkal', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(140, 20, 1, '1719857454.png', 1, 'Honnavar', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(141, 20, 1, '1723923504.jpeg', 1, 'Kumta', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(142, 20, 1, '1723923581.jpeg', 1, 'Siddapur', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(143, 20, 1, '1723923644.jpeg', 1, 'Sira', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(144, 20, 1, '1719857454.png', 1, 'Yalanduru', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(145, 20, 1, '1723923504.jpeg', 1, 'Vijayapura', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(146, 20, 1, '1719857454.png', 1, 'Mudbidri', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(147, 20, 1, '1723923644.jpeg', 1, 'Indi', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(148, 20, 1, '1719857454.png', 1, 'Mudhol', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(149, 20, 1, '1723923504.jpeg', 1, 'Muddebihal', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(150, 20, 1, '1723923581.jpeg', 1, 'Sindagi', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(151, 20, 1, '1723923644.jpeg', 1, 'Karatagi', '2024-07-01 18:10:54', '2024-07-01 18:10:54'),
(152, 20, 1, '1719857454.png', 1, 'Gurmitkal', '2024-08-17 19:38:24', '2024-08-17 19:38:24'),
(153, 20, 1, '1723923504.jpeg', 1, 'Shorapur', '2024-08-17 19:39:41', '2024-08-17 19:39:41'),
(154, 20, 1, '1723923581.jpeg', 1, 'Surpur', '2024-08-17 19:40:44', '2024-08-17 19:40:44'),
(155, 20, 1, '1719857454.png', 1, 'Ramanagar', '2024-08-17 19:41:47', '2024-08-17 19:41:47'),
(156, 20, 1, '1723923504.jpeg', 1, 'Ballari', '2024-08-17 19:42:50', '2024-08-17 19:42:50'),
(157, 20, 1, '1723923581.jpeg', 1, 'Sandur', '2024-08-17 19:43:53', '2024-08-17 19:43:53'),
(158, 20, 1, '1723923644.jpeg', 1, 'Chikkaballapur', '2024-08-17 19:44:56', '2024-08-17 19:44:56'),
(159, 20, 1, '1719857454.png', 1, 'Chintamani', '2024-08-17 19:45:59', '2024-08-17 19:45:59'),
(160, 20, 1, '1723923504.jpeg', 1, 'Mudigere', '2024-08-17 19:47:02', '2024-08-17 19:47:02'),
(161, 20, 1, '1723923581.jpeg', 1, 'Sulya', '2024-08-17 19:48:05', '2024-08-17 19:48:05'),
(162, 20, 1, '1719857454.png', 1, 'Madikeri', '2024-08-17 19:49:08', '2024-08-17 19:49:08'),
(163, 20, 1, '1723923504.jpeg', 1, 'Nelamangala', '2024-08-17 19:50:11', '2024-08-17 19:50:11'),
(164, 20, 1, '1723923581.jpeg', 1, 'Mundgod', '2024-08-17 19:51:14', '2024-08-17 19:51:14'),
(165, 20, 1, '1723923644.jpeg', 1, 'Chickballapur', '2024-08-17 19:52:17', '2024-08-17 19:52:17'),
(166, 20, 1, '1719857454.png', 1, 'Sidlaghatta', '2024-08-17 19:53:20', '2024-08-17 19:53:20'),
(167, 20, 1, '1723923504.jpeg', 1, 'Sringeri', '2024-08-17 19:54:23', '2024-08-17 19:54:23'),
(168, 20, 1, '1723923581.jpeg', 1, 'Tarikere', '2024-08-17 19:55:26', '2024-08-17 19:55:26'),
(169, 20, 1, '1719857454.png', 1, 'Harapanahalli', '2024-08-17 19:56:29', '2024-08-17 19:56:29'),
(170, 20, 1, '1723923504.jpeg', 1, 'Devanahalli', '2024-08-17 19:57:32', '2024-08-17 19:57:32'),
(171, 20, 1, '1723923581.jpeg', 1, 'Manipal', '2024-08-17 19:58:35', '2024-08-17 19:58:35'),
(172, 20, 1, '1723923581.jpeg', 1, 'Gundlupete', '2024-08-17 19:59:38', '2024-08-17 19:59:38'),
(173, 20, 1, '1723923581.jpeg', 1, 'Krishnarajanagara', '2024-08-18 19:59:38', '2024-08-18 19:59:38'),
(174, 20, 1, '1723923581.jpeg', 1, 'Hagaribommanahalli', '2024-08-19 19:59:38', '2024-08-19 19:59:38'),
(175, 20, 1, '1723923581.jpeg', 1, 'Kollegala', '2024-08-20 19:59:38', '2024-08-20 19:59:38'),
(176, 20, 1, '1723923581.jpeg', 1, 'Narasimharajapura', '2024-08-21 19:59:38', '2024-08-21 19:59:38'),
(177, 20, 1, '1723923581.jpeg', 1, 'Ranebennur', '2024-08-22 19:59:38', '2024-08-22 19:59:38'),
(178, 20, 1, '1723923581.jpeg', 1, 'Somwarpet', '2024-08-23 19:59:38', '2024-08-23 19:59:38'),
(179, 20, 1, '1723923581.jpeg', 1, 'Bramavara', '2024-08-24 19:59:38', '2024-08-24 19:59:38'),
(180, 20, 1, '1723923581.jpeg', 1, 'Sindhanur', '2024-08-25 19:59:38', '2024-08-25 19:59:38'),
(181, 20, 1, '1723923581.jpeg', 1, 'Hukeri', '2024-08-26 19:59:38', '2024-08-26 19:59:38'),
(182, 20, 1, '1723923581.jpeg', 1, 'Dandeli', '2024-08-27 19:59:38', '2024-08-27 19:59:38'),
(183, 20, 1, '1723923581.jpeg', 1, 'Bagepalli', '2024-08-28 19:59:38', '2024-08-28 19:59:38'),
(184, 20, 1, '1723923581.jpeg', 1, 'Kadaba', '2024-08-29 19:59:38', '2024-08-29 19:59:38'),
(185, 20, 1, '1723923581.jpeg', 1, 'Virajapet', '2024-08-30 19:59:38', '2024-08-30 19:59:38'),
(186, 20, 1, '1723923581.jpeg', 1, 'Channapatna', '2024-08-31 19:59:38', '2024-08-31 19:59:38'),
(187, 20, 1, '1723923581.jpeg', 1, 'Manvi', '2024-09-01 19:59:38', '2024-09-01 19:59:38'),
(188, 20, 1, '1723923581.jpeg', 1, 'Soraba', '2024-09-02 19:59:38', '2024-09-02 19:59:38'),
(189, 20, 1, '1723923581.jpeg', 1, 'Malpe', '2024-09-03 19:59:38', '2024-09-03 19:59:38'),
(190, 20, 1, '1723923581.jpeg', 1, 'T Narasipura', '2024-09-04 19:59:38', '2024-09-04 19:59:38'),
(191, 20, 1, '1723923581.jpeg', 1, 'Almel', '2024-09-05 19:59:38', '2024-09-05 19:59:38'),
(192, 20, 1, '1723923581.jpeg', 1, 'Ilkal', '2024-09-06 19:59:38', '2024-09-06 19:59:38'),
(193, 20, 1, '1723923581.jpeg', 1, 'Hoskote', '2024-09-07 19:59:38', '2024-09-07 19:59:38'),
(194, 20, 1, '1723923581.jpeg', 1, 'Ullal', '2024-09-08 19:59:38', '2024-09-08 19:59:38'),
(195, 20, 1, '1723923581.jpeg', 1, 'Piriyapatna', '2024-09-09 19:59:38', '2024-09-09 19:59:38'),
(196, 20, 1, '1723923581.jpeg', 1, 'Gonikoppal', '2024-09-10 19:59:38', '2024-09-10 19:59:38'),
(197, 20, 1, '1723923581.jpeg', 1, 'Kaup', '2024-09-11 19:59:38', '2024-09-11 19:59:38'),
(198, 20, 1, '1723923581.jpeg', 1, 'Yelburga', '2024-09-12 19:59:38', '2024-09-12 19:59:38'),
(199, 20, 1, '1723923581.jpeg', 1, 'Kushalnagar', '2024-09-13 19:59:38', '2024-09-13 19:59:38'),
(200, 20, 1, '1723923581.jpeg', 1, 'Thavarekere', '2024-09-14 19:59:38', '2024-09-14 19:59:38'),
(201, 20, 1, '1723923581.jpeg', 1, 'Yadgiri', '2024-09-15 19:59:38', '2024-09-15 19:59:38'),
(202, 20, 1, '1723923581.jpeg', 1, 'Nipani', '2024-09-16 19:59:38', '2024-09-16 19:59:38'),
(203, 20, 1, '1723923581.jpeg', 1, 'Anekal', '2024-09-17 19:59:38', '2024-09-17 19:59:38'),
(204, 20, 1, '1723923581.jpeg', 1, 'Hosanagara', '2024-09-18 19:59:38', '2024-09-18 19:59:38'),
(205, 20, 1, '1723923581.jpeg', 1, 'Ponnampet', '2024-09-19 19:59:38', '2024-09-19 19:59:38'),
(206, 20, 1, '1723923581.jpeg', 1, 'Belgaum', '2024-09-20 19:59:38', '2024-09-20 19:59:38'),
(207, 20, 1, '1723923581.jpeg', 1, 'Byndoor', '2024-09-21 19:59:38', '2024-09-21 19:59:38'),
(208, 20, 1, '1723923581.jpeg', 1, 'Rabkavi', '2024-09-22 19:59:38', '2024-09-22 19:59:38'),
(209, 20, 1, '1723923581.jpeg', 1, 'Hosadurga', '2024-09-23 19:59:38', '2024-09-23 19:59:38'),
(210, 20, 1, '1723923581.jpeg', 1, 'Bagewadi', '2024-09-24 19:59:38', '2024-09-24 19:59:38'),
(211, 20, 1, '1723923581.jpeg', 1, 'Raibag', '2024-09-25 19:59:38', '2024-09-25 19:59:38'),
(212, 20, 1, '1723923581.jpeg', 1, 'Bilagi', '2024-09-26 19:59:38', '2024-09-26 19:59:38'),
(213, 20, 1, '1723923581.jpeg', 1, 'Guledagudda', '2024-09-27 19:59:38', '2024-09-27 19:59:38'),
(214, 20, 1, '1723923581.jpeg', 1, 'Kampli', '2024-09-28 19:59:38', '2024-09-28 19:59:38'),
(215, 20, 1, '1723923581.jpeg', 1, 'Chelur', '2024-09-29 19:59:38', '2024-09-29 19:59:38'),
(216, 20, 1, '1723923581.jpeg', 1, 'Honnali', '2024-09-30 19:59:38', '2024-09-30 19:59:38'),
(217, 20, 1, '1723923581.jpeg', 1, 'Kalghatgi', '2024-10-01 19:59:38', '2024-10-01 19:59:38'),
(218, 20, 1, '1723923581.jpeg', 1, 'Nargund', '2024-10-02 19:59:38', '2024-10-02 19:59:38'),
(219, 20, 1, '1723923581.jpeg', 1, 'Hanagal', '2024-10-03 19:59:38', '2024-10-03 19:59:38'),
(220, 20, 1, '1723923581.jpeg', 1, 'Savanuru', '2024-10-04 19:59:38', '2024-10-04 19:59:38'),
(221, 20, 1, '1723923581.jpeg', 1, 'Rattihalli', '2024-10-05 19:59:38', '2024-10-05 19:59:38'),
(222, 20, 1, '1723923581.jpeg', 1, 'Devadurga', '2024-10-06 19:59:38', '2024-10-06 19:59:38'),
(223, 20, 1, '1723923581.jpeg', 1, 'Maski', '2024-10-07 19:59:38', '2024-10-07 19:59:38'),
(224, 20, 1, '1723923581.jpeg', 1, 'Hebri', '2024-10-08 19:59:38', '2024-10-08 19:59:38'),
(225, 20, 1, '1723923581.jpeg', 1, 'Supa', '2024-10-09 19:59:38', '2024-10-09 19:59:38'),
(226, 20, 1, '1723923581.jpeg', 1, 'Haliyal', '2024-10-10 19:59:38', '2024-10-10 19:59:38'),
(227, 20, 1, '1723923581.jpeg', 1, 'Talikoti', '2024-10-11 19:59:38', '2024-10-11 19:59:38'),
(228, 20, 1, '1723923581.jpeg', 1, 'Chadchan', '2024-10-12 19:59:38', '2024-10-12 19:59:38'),
(229, 20, 1, '1723923581.jpeg', 1, 'Babaleshwar', '2024-10-13 19:59:38', '2024-10-13 19:59:38'),
(230, 20, 1, '1723923581.jpeg', 1, 'Hunasagi', '2024-10-14 19:59:38', '2024-10-14 19:59:38'),
(231, 20, 1, '1723923581.jpeg', 1, 'Huvina Hadagali', '2024-10-15 19:59:38', '2024-10-15 19:59:38'),
(232, 20, 1, '1723923581.jpeg', 1, 'Chiknayakanhalli', '2024-10-16 19:59:38', '2024-10-16 19:59:38'),
(233, 20, 1, '1723923581.jpeg', 1, 'Kanakapura', '2024-10-17 19:59:38', '2024-10-17 19:59:38');

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

DROP TABLE IF EXISTS `conversations`;
CREATE TABLE IF NOT EXISTS `conversations` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '1=user, 2=admin, 3=vendor',
  `support_ticket_id` int(11) DEFAULT NULL,
  `reply` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `conversations`
--

INSERT INTO `conversations` (`id`, `user_id`, `type`, `support_ticket_id`, `reply`, `file`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 6, '<p>Is this okay?</p>', NULL, '2024-09-02 14:16:41', '2024-09-02 14:16:41'),
(2, 1, 3, 6, '<p>Yes</p>', NULL, '2024-09-02 14:17:02', '2024-09-02 14:17:02');

-- --------------------------------------------------------

--
-- Table structure for table `cookie_alerts`
--

DROP TABLE IF EXISTS `cookie_alerts`;
CREATE TABLE IF NOT EXISTS `cookie_alerts` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `cookie_alert_status` tinyint(3) UNSIGNED NOT NULL,
  `cookie_alert_btn_text` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `cookie_alert_text` text COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cookie_alerts_language_id_foreign` (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `cookie_alerts`
--

INSERT INTO `cookie_alerts` (`id`, `language_id`, `cookie_alert_status`, `cookie_alert_btn_text`, `cookie_alert_text`, `created_at`, `updated_at`) VALUES
(3, 20, 0, 'I Agree', 'We use cookies to give you the best online experience.\r\nBy continuing to browse the site you are agreeing to our use of cookies.', '2023-08-29 02:35:44', '2024-01-31 21:05:04');

-- --------------------------------------------------------

--
-- Table structure for table `counter_informations`
--

DROP TABLE IF EXISTS `counter_informations`;
CREATE TABLE IF NOT EXISTS `counter_informations` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `icon` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `amount` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `counter_sections`
--

DROP TABLE IF EXISTS `counter_sections`;
CREATE TABLE IF NOT EXISTS `counter_sections` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `subtitle` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `counter_sections`
--

INSERT INTO `counter_sections` (`id`, `language_id`, `title`, `subtitle`, `created_at`, `updated_at`) VALUES
(3, 20, 'See Our Achievement', NULL, '2023-08-19 00:38:24', '2023-11-04 02:33:22');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
CREATE TABLE IF NOT EXISTS `countries` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `language_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 20, 'India', '2024-11-30 05:42:35', '2024-11-30 05:42:35');

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

DROP TABLE IF EXISTS `faqs`;
CREATE TABLE IF NOT EXISTS `faqs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `question` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `answer` text COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `faqs_language_id_foreign` (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`id`, `language_id`, `question`, `answer`, `serial_number`, `created_at`, `updated_at`) VALUES
(44, 20, 'What is a good size for an event hall?', 'A good size for an event hall depends on the type of event and expected attendance. Generally, allow 10-15 square feet per person for standing events, 15-20 square feet for seated events without tables, and 20-25 square feet for seated events with tables. For example, a 200-person wedding reception might require 4,000-5,000 square feet. Always consider additional space for amenities like a dance floor, stage, or buffet area.', 1, '2024-08-15 10:38:57', '2024-08-16 17:23:14'),
(45, 20, 'How to find the best catering service?', 'To find the best catering service, start by researching online and reading reviews. Ask for recommendations from friends and colleagues, and check the menu variety and customization options. Inquire about pricing, compare quotes, and verify the caterer’s licensing and food safety certifications. Request tastings to assess food quality, and evaluate their communication and professionalism. Consider your event’s specific needs and budget when making your final decision.', 2, '2024-08-16 17:27:37', '2024-08-16 17:37:00'),
(46, 20, 'How to find the best makeup service?', 'To find the best makeup service, start by researching reviews and checking portfolios to ensure the artist\'s style matches your preferences. Ask for recommendations from friends or family, and consider booking a trial to test the service. This approach helps you choose a reliable and skilled makeup artist.', 3, '2024-08-16 17:32:40', '2024-08-16 17:36:16'),
(47, 20, 'How to find the best Shamiyana service?', 'To find the best Shamiyana service, start by researching online and reading reviews. Ask for recommendations from people who have used similar services. Check their range of designs and materials to ensure they meet your event’s needs. Inquire about pricing, compare quotes, and confirm their setup and delivery reliability. Lastly, ensure they have experience handling events like yours to guarantee a smooth and successful setup.', 4, '2024-08-16 17:50:19', '2024-08-16 17:50:19'),
(48, 20, 'How to find the best Nadaswaram service?', 'To find the best Nadaswaram service, start by researching local musicians who specialize in traditional performances. Ask for recommendations from friends, family, or event planners familiar with cultural events. Listen to sample recordings or watch videos of their performances to gauge their skill and style. Consider the musicians\' experience, reputation, and ability to perform for your specific occasion. Finally, discuss availability, pricing, and any specific requirements to ensure the service meets your needs.', 5, '2024-08-16 17:52:03', '2024-08-16 17:52:03'),
(49, 20, 'How to find the best Light Decoration service?', 'To find the best light decoration service, start by researching online and reading reviews. Ask for recommendations from friends or event planners, and check their portfolios to see previous work. Inquire about their experience with similar events and discuss your vision to ensure they can meet your needs. Compare pricing and ask for a detailed quote, including installation and removal services. Lastly, evaluate their communication and professionalism to ensure a smooth collaboration.', 6, '2024-08-16 17:53:14', '2024-08-16 17:53:14');

-- --------------------------------------------------------

--
-- Table structure for table `featured_listing_charges`
--

DROP TABLE IF EXISTS `featured_listing_charges`;
CREATE TABLE IF NOT EXISTS `featured_listing_charges` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `days` bigint(20) DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `featured_listing_charges`
--

INSERT INTO `featured_listing_charges` (`id`, `days`, `price`, `created_at`, `updated_at`) VALUES
(1, 5, 0, '2024-11-19 11:18:23', '2025-02-25 01:29:11');

-- --------------------------------------------------------

--
-- Table structure for table `feature_orders`
--

DROP TABLE IF EXISTS `feature_orders`;
CREATE TABLE IF NOT EXISTS `feature_orders` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `vendor_mail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` decimal(8,2) DEFAULT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `days` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `feature_orders`
--

INSERT INTO `feature_orders` (`id`, `listing_id`, `vendor_id`, `vendor_mail`, `order_number`, `total`, `payment_method`, `gateway_type`, `payment_status`, `order_status`, `attachment`, `invoice`, `days`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 'admin@example.com', '67c6f674d2e16', '0.00', 'naveen', 'offline', 'completed', 'completed', NULL, NULL, '5', '2025-03-04', '2025-03-09', '2025-03-04 07:17:48', '2025-03-04 07:17:48');

-- --------------------------------------------------------

--
-- Table structure for table `feature_sections`
--

DROP TABLE IF EXISTS `feature_sections`;
CREATE TABLE IF NOT EXISTS `feature_sections` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `subtitle` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_text` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `feature_sections`
--

INSERT INTO `feature_sections` (`id`, `language_id`, `subtitle`, `title`, `button_text`, `created_at`, `updated_at`) VALUES
(3, 20, NULL, 'Our top listing', 'Explore All Listings', '2023-08-19 03:00:57', '2024-05-15 02:16:25');

-- --------------------------------------------------------

--
-- Table structure for table `footer_contents`
--

DROP TABLE IF EXISTS `footer_contents`;
CREATE TABLE IF NOT EXISTS `footer_contents` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `about_company` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `copyright_text` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `footer_texts_language_id_foreign` (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `footer_contents`
--

INSERT INTO `footer_contents` (`id`, `language_id`, `about_company`, `copyright_text`, `created_at`, `updated_at`) VALUES
(5, 20, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.', '<p>Copyright ©2024. All Rights Reserved..</p>', '2023-08-19 23:40:53', '2024-01-24 21:43:45');

-- --------------------------------------------------------

--
-- Table structure for table `guests`
--

DROP TABLE IF EXISTS `guests`;
CREATE TABLE IF NOT EXISTS `guests` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `endpoint` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `guests`
--

INSERT INTO `guests` (`id`, `endpoint`, `created_at`, `updated_at`) VALUES
(1, 'https://fcm.googleapis.com/fcm/send/fSogsNMqYiw:APA91bEqvlrFxH_cZTXgJD3ScVhCbgp_IQV368_OEoMdZC5CjAyhC_zYuDT3G6qDC9xmb6Dgy1vj69amtqimCVBeak9WCPeaKVXggd6P_-9jS339e2Z6BgxT0OY_q6w6TLwMmxhnbMEY', '2024-07-24 20:48:37', '2024-07-24 20:48:37'),
(2, 'https://fcm.googleapis.com/fcm/send/emMK-yIUIiI:APA91bGPXJNIamQLYhauOZ8wdOTYaPOH_FGL1I33LgR176-I7naYxwk1ZoHG1N9pWc1WekBLv9rTY5n-pZ5eG79cv3OONwLLPW1UztSJcd_mLr8d0Tx1VrizxIxYa0AE2IXjFQa020x9', '2024-08-16 12:48:00', '2024-08-16 12:48:00'),
(3, 'https://fcm.googleapis.com/fcm/send/dFfxcK0BFv4:APA91bFK49S4QmSsXFs6kUbriYIdiUlTJQ0moIZdN4yXGSSJD2UreT_fXotwXtmg5Cuc0MRa7Wgcf0AOn4wyG-1QsCg3Xyf_wBflW0qeNOgFwluyzi-G0wLZrMSD7Fuo6xu_3t5qviFo', '2024-09-11 07:35:28', '2024-09-11 07:35:28'),
(4, 'https://fcm.googleapis.com/fcm/send/dR-x_OGFs00:APA91bGNjFj0eqbVnNKBXxc2071x1iRCyp19EivFQ-h5W8AL8ljvu_Vy2OOq0rsbBAcQfuSB3iIKMgHlJBvSeiN6mABoSofyfdKCud-wPLkdZObjO2ZeS0M_T_AJIx_C2cAzvmQKwRex', '2024-09-12 13:56:59', '2024-09-12 13:56:59');

-- --------------------------------------------------------

--
-- Table structure for table `hero_sections`
--

DROP TABLE IF EXISTS `hero_sections`;
CREATE TABLE IF NOT EXISTS `hero_sections` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hero_sections`
--

INSERT INTO `hero_sections` (`id`, `language_id`, `title`, `text`, `created_at`, `updated_at`) VALUES
(2, 20, 'Are You Looking For A business?', 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusa ntium doloremque laudantium, totamrem.', '2024-03-26 20:41:33', '2024-04-30 22:06:44');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
CREATE TABLE IF NOT EXISTS `languages` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `code` char(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `direction` tinyint(4) NOT NULL,
  `is_default` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`, `direction`, `is_default`, `created_at`, `updated_at`) VALUES
(20, 'English', 'en', 0, 1, '2023-08-17 03:19:12', '2024-04-30 22:05:07');

-- --------------------------------------------------------

--
-- Table structure for table `listings`
--

DROP TABLE IF EXISTS `listings`;
CREATE TABLE IF NOT EXISTS `listings` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `feature_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_background_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vendor_id` bigint(20) DEFAULT 0,
  `mail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `average_rating` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `min_price` double DEFAULT NULL,
  `max_price` double DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `visibility` int(11) NOT NULL DEFAULT 0,
  `is_featured` int(11) NOT NULL DEFAULT 0,
  `tawkto_status` tinyint(4) DEFAULT 0,
  `tawkto_direct_chat_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telegram_status` int(11) NOT NULL DEFAULT 0,
  `telegram_username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `messenger_status` int(11) NOT NULL DEFAULT 0,
  `messenger_direct_chat_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp_status` int(11) DEFAULT 0,
  `whatsapp_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp_header_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp_popup_status` int(11) DEFAULT NULL,
  `whatsapp_popup_message` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `average_rating` (`average_rating`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listings`
--

INSERT INTO `listings` (`id`, `feature_image`, `video_background_image`, `video_url`, `vendor_id`, `mail`, `average_rating`, `phone`, `latitude`, `longitude`, `min_price`, `max_price`, `status`, `visibility`, `is_featured`, `tawkto_status`, `tawkto_direct_chat_link`, `telegram_status`, `telegram_username`, `messenger_status`, `messenger_direct_chat_link`, `whatsapp_status`, `whatsapp_number`, `whatsapp_header_title`, `whatsapp_popup_status`, `whatsapp_popup_message`, `created_at`, `updated_at`) VALUES
(2, '1740466697.png', NULL, NULL, 1, 'naveen@webconverts.com', '0', '07204994823', '49.43453', '149.91553', 500, 1500, 1, 1, 0, 0, NULL, 0, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, '2025-02-25 01:28:17', '2025-03-04 07:18:25');

-- --------------------------------------------------------

--
-- Table structure for table `listing_categories`
--

DROP TABLE IF EXISTS `listing_categories`;
CREATE TABLE IF NOT EXISTS `listing_categories` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_number` bigint(20) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listing_categories`
--

INSERT INTO `listing_categories` (`id`, `language_id`, `name`, `icon`, `slug`, `serial_number`, `status`, `created_at`, `updated_at`) VALUES
(1, 20, 'Mehandi', 'fas fa-shopping-cart iconpicker-component', 'mehandi', 1, 1, '2024-11-30 04:36:39', '2024-11-30 05:42:21'),
(2, 20, 'Function Hall', 'fas fa-shopping-cart iconpicker-component', 'function-hall', 3, 1, '2025-02-11 03:10:44', '2025-02-11 03:10:44');

-- --------------------------------------------------------

--
-- Table structure for table `listing_contents`
--

DROP TABLE IF EXISTS `listing_contents`;
CREATE TABLE IF NOT EXISTS `listing_contents` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `listing_id` bigint(20) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aminities` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `features` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listing_contents`
--

INSERT INTO `listing_contents` (`id`, `language_id`, `listing_id`, `category_id`, `country_id`, `state_id`, `city_id`, `title`, `slug`, `aminities`, `description`, `address`, `meta_keyword`, `meta_description`, `features`, `created_at`, `updated_at`) VALUES
(2, 20, 2, 1, 1, 1, 2, 'test', 'test', '[]', '<p>dad dasdasd asdasdasd asdasdas adasda asdasd adasdas asdasd aasdasd</p>', 'lakshmi kantha nagara hebbal', 'asdasd', 'asdasd', NULL, '2025-02-25 01:28:17', '2025-03-04 06:17:54');

-- --------------------------------------------------------

--
-- Table structure for table `listing_faqs`
--

DROP TABLE IF EXISTS `listing_faqs`;
CREATE TABLE IF NOT EXISTS `listing_faqs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `language_id` bigint(20) DEFAULT NULL,
  `question` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `answer` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_number` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_features`
--

DROP TABLE IF EXISTS `listing_features`;
CREATE TABLE IF NOT EXISTS `listing_features` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `indx` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_feature_contents`
--

DROP TABLE IF EXISTS `listing_feature_contents`;
CREATE TABLE IF NOT EXISTS `listing_feature_contents` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `listing_feature_id` bigint(20) DEFAULT NULL,
  `language_id` bigint(20) DEFAULT NULL,
  `feature_heading` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `feature_value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_images`
--

DROP TABLE IF EXISTS `listing_images`;
CREATE TABLE IF NOT EXISTS `listing_images` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listing_images`
--

INSERT INTO `listing_images` (`id`, `listing_id`, `image`, `created_at`, `updated_at`) VALUES
(1, 2, '67bd68fbe4483.jpg', '2025-02-25 01:23:47', '2025-02-25 01:28:17'),
(2, 2, '67bd6a05080c0.jpg', '2025-02-25 01:28:13', '2025-02-25 01:28:17'),
(3, 2, '67bd6a058173f.jpg', '2025-02-25 01:28:13', '2025-02-25 01:28:17');

-- --------------------------------------------------------

--
-- Table structure for table `listing_messages`
--

DROP TABLE IF EXISTS `listing_messages`;
CREATE TABLE IF NOT EXISTS `listing_messages` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `vendor_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_products`
--

DROP TABLE IF EXISTS `listing_products`;
CREATE TABLE IF NOT EXISTS `listing_products` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `feature_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_price` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `previous_price` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_product_contents`
--

DROP TABLE IF EXISTS `listing_product_contents`;
CREATE TABLE IF NOT EXISTS `listing_product_contents` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` int(11) DEFAULT NULL,
  `listing_id` bigint(20) DEFAULT NULL,
  `listing_product_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keyword` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_product_images`
--

DROP TABLE IF EXISTS `listing_product_images`;
CREATE TABLE IF NOT EXISTS `listing_product_images` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `listing_product_id` int(11) DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_reviews`
--

DROP TABLE IF EXISTS `listing_reviews`;
CREATE TABLE IF NOT EXISTS `listing_reviews` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `listing_id` bigint(20) DEFAULT NULL,
  `rating` bigint(20) DEFAULT NULL,
  `review` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_sections`
--

DROP TABLE IF EXISTS `listing_sections`;
CREATE TABLE IF NOT EXISTS `listing_sections` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtitle` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_text` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listing_sections`
--

INSERT INTO `listing_sections` (`id`, `language_id`, `title`, `subtitle`, `button_text`, `created_at`, `updated_at`) VALUES
(3, 20, 'Featured Listings', NULL, 'Exploress', '2023-10-18 21:37:18', '2024-04-30 22:23:47');

-- --------------------------------------------------------

--
-- Table structure for table `listing_socail_medias`
--

DROP TABLE IF EXISTS `listing_socail_medias`;
CREATE TABLE IF NOT EXISTS `listing_socail_medias` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `location_sections`
--

DROP TABLE IF EXISTS `location_sections`;
CREATE TABLE IF NOT EXISTS `location_sections` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `location_sections`
--

INSERT INTO `location_sections` (`id`, `language_id`, `title`, `created_at`, `updated_at`) VALUES
(1, 20, 'Explore Most Popo', '2023-12-13 04:04:00', '2024-03-19 23:34:45');

-- --------------------------------------------------------

--
-- Table structure for table `mail_templates`
--

DROP TABLE IF EXISTS `mail_templates`;
CREATE TABLE IF NOT EXISTS `mail_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mail_type` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `mail_subject` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `mail_body` blob DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `mail_templates`
--

INSERT INTO `mail_templates` (`id`, `mail_type`, `mail_subject`, `mail_body`) VALUES
(1, 'verify_email', 'Verify Your Email Address', 0x3c703e44656172203c7374726f6e673e7b757365726e616d657d3c2f7374726f6e673e2c3c2f703e0d0a3c703e5765206a757374206e65656420746f2076657269667920796f757220656d61696c2061646472657373206265666f726520796f752063616e2061636365737320746f20796f75722064617368626f6172642e3c2f703e0d0a3c703e56657269667920796f757220656d61696c20616464726573732c207b766572696669636174696f6e5f6c696e6b7d2e3c2f703e0d0a3c703e5468616e6b20796f752e3c62723e7b776562736974655f7469746c657d3c2f703e),
(2, 'reset_password', 'Recover Password of Your Account', 0x3c703e4869207b637573746f6d65725f6e616d657d2c3c2f703e3c703e576520686176652072656365697665642061207265717565737420746f20726573657420796f75722070617373776f72642e20496620796f7520646964206e6f74206d616b652074686520726571756573742c2069676e6f7265207468697320656d61696c2e204f74686572776973652c20796f752063616e20726573657420796f75722070617373776f7264207573696e67207468652062656c6f77206c696e6b2e3c2f703e3c703e7b70617373776f72645f72657365745f6c696e6b7d3c2f703e3c703e5468616e6b732c3c6272202f3e7b776562736974655f7469746c657d3c2f703e),
(3, 'product_order', 'Product Order Has Been Placed', 0x3c703e4869c2a07b637573746f6d65725f6e616d657d2c3c2f703e3c703e596f7572206f7264657220686173206265656e20706c61636564207375636365737366756c6c792e205765206861766520617474616368656420616e20696e766f69636520696e2074686973206d61696c2e3c6272202f3e4f72646572204e6f3a20237b6f726465725f6e756d6265727d3c2f703e3c703e7b6f726465725f6c696e6b7d3c6272202f3e3c2f703e3c703e4265737420726567617264732e3c6272202f3e7b776562736974655f7469746c657d3c2f703e),
(4, 'package_purchase', 'Your Package Purchase is successful.', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e54686973206973206120636f6e6669726d6174696f6e206d61696c2066726f6d2075732e3c6272202f3e596f7520686176652050757263686173656420796f7572206d656d626572736869702e3c6272202f3e3c7374726f6e673e5061636b616765205469746c653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e3c7374726f6e673e41637469766174696f6e20446174653a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e3c7374726f6e673e45787069726520446174653a3c2f7374726f6e673e207b6578706972655f646174657d3c2f703e0d0a3c703ec2a03c2f703e0d0a3c703e5765206861766520617474616368656420616e20696e766f69636520776974682074686973206d61696c2e3c6272202f3e5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e0d0a3c703e3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e),
(8, 'membership_expiry_reminder', 'Your membership will be expired soon', 0x4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a596f7572206d656d626572736869702077696c6c206265206578706972656420736f6f6e2e3c6272202f3e0d0a596f7572206d656d626572736869702069732076616c69642074696c6c203c7374726f6e673e7b6c6173745f6461795f6f665f6d656d626572736869707d3c2f7374726f6e673e3c6272202f3e0d0a506c6561736520636c69636b2068657265202d207b6c6f67696e5f6c696e6b7d20746f206c6f6720696e746f207468652064617368626f61726420746f2070757263686173652061206e6577207061636b616765202f20657874656e64207468652063757272656e74207061636b61676520746f20657874656e6420796f7572206d656d626572736869702e3c6272202f3e3c6272202f3e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e),
(9, 'membership_expired', 'Your membership is expired', 0x4869207b757365726e616d657d2c3c62723e3c62723e0d0a0d0a596f7572206d656d6265727368697020697320657870697265642e3c62723e0d0a506c6561736520636c69636b2068657265202d207b6c6f67696e5f6c696e6b7d20746f206c6f6720696e746f207468652064617368626f61726420746f2070757263686173652061206e6577207061636b616765202f20657874656e64207468652063757272656e74207061636b61676520746f20636f6e74696e756520746865206d656d626572736869702e3c62723e3c62723e0d0a0d0a4265737420526567617264732c3c62723e0d0a7b776562736974655f7469746c657d2e),
(10, 'payment_accepted_for_membership_offline_gateway', 'Your payment for registration is approved', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e54686973206973206120636f6e6669726d6174696f6e206d61696c2066726f6d2075732e3c6272202f3e596f7572207061796d656e7420686173206265656e2061636365707465642026616d703b206e6f7720796f752063616e206c6f67696e20746f20796f757220757365722064617368626f61726420746f206275696c6420796f757220706f7274666f6c696f20776562736974652e3c6272202f3e3c7374726f6e673e5061636b616765205469746c653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e3c7374726f6e673e41637469766174696f6e20446174653a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e3c7374726f6e673e45787069726520446174653a3c2f7374726f6e673e207b6578706972655f646174657d3c2f703e0d0a3c703ec2a03c2f703e0d0a3c703e5765206861766520617474616368656420616e20696e766f69636520776974682074686973206d61696c2e3c6272202f3e5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e0d0a3c703e3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e),
(12, 'payment_rejected_for_membership_offline_gateway', 'Your payment for membership extension is rejected', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a57652061726520736f72727920746f20696e666f726d20796f75207468617420796f7572207061796d656e7420686173206265656e2072656a65637465643c6272202f3e0d0a0d0a3c7374726f6e673e5061636b616765205469746c653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e0d0a3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e3c2f703e),
(14, 'admin_changed_current_package', 'Admin has changed your current package', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a41646d696e20686173206368616e67656420796f75722063757272656e74207061636b616765203c623e287b7265706c616365645f7061636b6167657d293c2f623e3c2f703e0d0a3c703e3c623e4e6577205061636b61676520496e666f726d6174696f6e3a3c2f623e3c2f703e0d0a3c703e0d0a3c7374726f6e673e5061636b6167653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e0d0a3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e0d0a3c7374726f6e673e41637469766174696f6e20446174653a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e0d0a3c7374726f6e673e45787069726520446174653a3c2f7374726f6e673e207b6578706972655f646174657d3c2f703e3c703e3c6272202f3e3c2f703e3c703e5765206861766520617474616368656420616e20696e766f69636520776974682074686973206d61696c2e3c6272202f3e0d0a5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e3c703e3c6272202f3e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e3c2f703e),
(15, 'admin_added_current_package', 'Admin has added current package for you', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a41646d696e206861732061646465642063757272656e74207061636b61676520666f7220796f753c2f703e3c703e3c623e3c7370616e207374796c653d22666f6e742d73697a653a313870783b223e43757272656e74204d656d6265727368697020496e666f726d6174696f6e3a3c2f7370616e3e3c2f623e3c6272202f3e0d0a3c7374726f6e673e5061636b616765205469746c653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e0d0a3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e0d0a3c7374726f6e673e41637469766174696f6e20446174653a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e0d0a3c7374726f6e673e45787069726520446174653a3c2f7374726f6e673e207b6578706972655f646174657d3c2f703e3c703e3c6272202f3e3c2f703e3c703e5765206861766520617474616368656420616e20696e766f69636520776974682074686973206d61696c2e3c6272202f3e0d0a5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e3c703e3c6272202f3e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e3c2f703e),
(16, 'admin_changed_next_package', 'Admin has changed your next package', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a41646d696e20686173206368616e67656420796f7572206e657874207061636b616765203c623e287b7265706c616365645f7061636b6167657d293c2f623e3c2f703e3c703e3c623e3c7370616e207374796c653d22666f6e742d73697a653a313870783b223e4e657874204d656d6265727368697020496e666f726d6174696f6e3a3c2f7370616e3e3c2f623e3c6272202f3e0d0a3c7374726f6e673e5061636b616765205469746c653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e0d0a3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e0d0a3c7374726f6e673e41637469766174696f6e20446174653a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e0d0a3c7374726f6e673e45787069726520446174653a3c2f7374726f6e673e207b6578706972655f646174657d3c2f703e3c703e3c6272202f3e3c2f703e3c703e5765206861766520617474616368656420616e20696e766f69636520776974682074686973206d61696c2e3c6272202f3e0d0a5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e3c703e3c6272202f3e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e3c2f703e),
(17, 'admin_added_next_package', 'Admin has added next package for you', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a41646d696e20686173206164646564206e657874207061636b61676520666f7220796f753c2f703e3c703e3c623e3c7370616e207374796c653d22666f6e742d73697a653a313870783b223e4e657874204d656d6265727368697020496e666f726d6174696f6e3a3c2f7370616e3e3c2f623e3c6272202f3e0d0a3c7374726f6e673e5061636b616765205469746c653a3c2f7374726f6e673e207b7061636b6167655f7469746c657d3c6272202f3e0d0a3c7374726f6e673e5061636b6167652050726963653a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e0d0a3c7374726f6e673e41637469766174696f6e20446174653a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e0d0a3c7374726f6e673e45787069726520446174653a3c2f7374726f6e673e207b6578706972655f646174657d3c2f703e3c703e3c6272202f3e3c2f703e3c703e5765206861766520617474616368656420616e20696e766f69636520776974682074686973206d61696c2e3c6272202f3e0d0a5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e3c703e3c6272202f3e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e3c2f703e),
(18, 'admin_removed_current_package', 'Admin has removed current package for you', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a41646d696e206861732072656d6f7665642063757272656e74207061636b616765202d203c7374726f6e673e7b72656d6f7665645f7061636b6167655f7469746c657d3c2f7374726f6e673e3c62723e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e),
(19, 'admin_removed_next_package', 'Admin has removed next package for you', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e0d0a0d0a41646d696e206861732072656d6f766564206e657874207061636b616765202d203c7374726f6e673e7b72656d6f7665645f7061636b6167655f7469746c657d3c2f7374726f6e673e3c62723e0d0a0d0a4265737420526567617264732c3c6272202f3e0d0a7b776562736974655f7469746c657d2e3c6272202f3e),
(26, 'inquiry_about_listing', 'Inquiry About Listing', 0x3c64697620636c6173733d22223e0d0a3c64697620636c6173733d226969206774223e0d0a3c64697620636c6173733d226133732061694c223e0d0a3c703ec2a03c2f703e0d0a3c646976207374796c653d226d617267696e3a20303b20626f782d73697a696e673a20626f726465722d626f783b20636f6c6f723a20233061306130613b20666f6e742d66616d696c793a205461686f6d612c274c7563696461204772616e6465272c274c75636964612053616e73272c48656c7665746963612c417269616c2c73616e732d73657269663b20666f6e742d73697a653a20313670783b20666f6e742d7765696768743a206e6f726d616c3b206c696e652d6865696768743a20313970783b206d696e2d77696474683a20313030253b2070616464696e673a20303b20746578742d616c69676e3a206c6566743b2077696474683a203130302521696d706f7274616e743b223e0d0a3c7461626c65207374796c653d226d617267696e3a20303b206261636b67726f756e643a20236633663566383b20626f726465722d636f6c6c617073653a20636f6c6c617073653b20626f726465722d73706163696e673a20303b20636f6c6f723a20233061306130613b20666f6e742d66616d696c793a205461686f6d612c274c7563696461204772616e6465272c274c75636964612053616e73272c48656c7665746963612c417269616c2c73616e732d73657269663b20666f6e742d73697a653a20313670783b20666f6e742d7765696768743a206e6f726d616c3b206865696768743a20313030253b206c696e652d6865696768743a20313970783b2070616464696e673a20303b20746578742d616c69676e3a206c6566743b20766572746963616c2d616c69676e3a20746f703b2077696474683a20313030253b223e0d0a3c74626f64793e0d0a3c7472207374796c653d2270616464696e673a303b746578742d616c69676e3a6c6566743b223e0d0a3c7464207374796c653d226d617267696e3a20303b20626f726465722d636f6c6c617073653a20636f6c6c6170736521696d706f7274616e743b20636f6c6f723a20233061306130613b20666f6e742d66616d696c793a205461686f6d612c274c7563696461204772616e6465272c274c75636964612053616e73272c48656c7665746963612c417269616c2c73616e732d73657269663b20666f6e742d73697a653a20313670783b20666f6e742d7765696768743a206e6f726d616c3b206c696e652d6865696768743a20313970783b2070616464696e673a20303b20746578742d616c69676e3a206c6566743b20766572746963616c2d616c69676e3a20746f703b20776f72642d777261703a20627265616b2d776f72643b223e0d0a3c646976207374796c653d2270616464696e672d6c6566743a203136707821696d706f7274616e743b2070616464696e672d72696768743a203136707821696d706f7274616e743b223e3c6272202f3ec2a020c2a020c2a020c2a020c2a020c2a020c2a0c2a03c6272202f3ec2a020c2a020c2a020c2a020c2a020c2a020c2a00d0a3c7461626c65207374796c653d226d617267696e3a2030206175746f3b206261636b67726f756e643a20236635663566663b20626f726465723a2031707820736f6c696420236434646365323b20626f726465722d636f6c6c617073653a20636f6c6c617073653b20626f726465722d73706163696e673a20303b206d696e2d77696474683a2035303070783b2070616464696e673a20303b20746578742d616c69676e3a20696e68657269743b20766572746963616c2d616c69676e3a20746f703b2077696474683a2035383070783b223e0d0a3c74626f64793e0d0a3c7472207374796c653d2270616464696e673a303b746578742d616c69676e3a6c6566743b223e0d0a3c7464207374796c653d226d617267696e3a20303b20626f726465722d636f6c6c617073653a20636f6c6c6170736521696d706f7274616e743b20636f6c6f723a20233061306130613b20666f6e742d66616d696c793a205461686f6d612c274c7563696461204772616e6465272c274c75636964612053616e73272c48656c7665746963612c417269616c2c73616e732d73657269663b20666f6e742d73697a653a20313670783b20666f6e742d7765696768743a206e6f726d616c3b206c696e652d6865696768743a20313970783b2070616464696e673a20303b20746578742d616c69676e3a206c6566743b20766572746963616c2d616c69676e3a20746f703b20776f72642d777261703a20627265616b2d776f72643b223e3c6272202f3e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e44656172207b757365726e616d657d2c3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e5468697320656d61696c20696e666f726d7320796f75207468617420616e20656e71756972657220697320747279696e6720746f20636f6e7461637420796f752e20486572652069732074686520696e666f726d6174696f6e2061626f75742074686520656e7175697265722e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e3c7374726f6e673e4c697374696e673c2f7374726f6e673e3a207b6c697374696e675f6e616d657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e456e717569726572204e616d653a207b656e7175697265725f6e616d657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e456e71756972657220456d61696c3a207b656e7175697265725f656d61696c7d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e456e7175697265722050686f6e653a207b656e7175697265725f70686f6e657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e4d6573736167653a3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e7b656e7175697265725f6d6573736167657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223ec2a03c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e4265737420526567617264732e3c6272202f3e7b776562736974655f7469746c657d3c2f703e0d0ac2a03c6272202f3ec2a020c2a020c2a020c2a020c2a020c2a020c2a020c2a03c6272202f3ec2a020c2a020c2a020c2a020c2a020c2a020c2a03c2f74643e0d0a3c2f74723e0d0a3c2f74626f64793e0d0a3c2f7461626c653e0d0ac2a03c2f6469763e0d0ac2a020c2a020c2a020c2a03c2f74643e0d0a3c2f74723e0d0a3c2f74626f64793e0d0a3c2f7461626c653e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c2f6469763e0d0a3c703ec2a03c2f703e),
(27, 'payment_accepted_for_featured_offline_gateway', 'Your payment for Feature is approved', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e54686973206973206120636f6e6669726d6174696f6e206d61696c2066726f6d2075732e3c6272202f3e596f7572207061796d656e7420686173206265656e2061636365707465642026616d703b206e6f77207761697420666f722073746174757320617070726f76652e3c2f703e0d0a3c703e3c7374726f6e673e4c697374696e67203a3c2f7374726f6e673e207b6c697374696e675f6e616d657d3c6272202f3e3c7374726f6e673e5061796d656e74205669613a3c2f7374726f6e673e207b7061796d656e745f7669617d3c6272202f3e3c7374726f6e673e5061796d656e7420416d6f756e743a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c2f703e0d0a3c703e5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e0d0a3c703e3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223ec2a03c2f703e),
(28, 'payment_rejected_for_buy_feature_offline_gateway', 'Your payment for Active Listing Feature  is rejected', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e57652061726520736f72727920746f20696e666f726d20796f75207468617420796f7572207061796d656e7420686173206265656e2072656a65637465642e3c2f703e0d0a3c703e3c7374726f6e673e4c697374696e67203a3c2f7374726f6e673e207b6c697374696e675f6e616d657d3c6272202f3e3c7374726f6e673e5061796d656e74205669613a3c2f7374726f6e673e207b7061796d656e745f7669617d3c6272202f3e3c7374726f6e673e5061796d656e7420416d6f756e743a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e),
(29, 'listing_feature_active', 'Your request to feature listing is approved.', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e5765206861766520617070726f76656420796f757220726571756573742e3c2f703e0d0a3c703e596f7572206c697374696e6720697320666561747572656420666f72207b646179737d20646179732e20c2a03c2f703e0d0a3c703e3c7374726f6e673e4c697374696e67205469746c653c2f7374726f6e673e3a207b6c697374696e675f6e616d657d2e3c2f703e0d0a3c703e3c7374726f6e673e53746172742044617465203a3c2f7374726f6e673e207b61637469766174696f6e5f646174657d3c6272202f3e3c7374726f6e673e456e6420446174653a3c2f7374726f6e673e207b656e645f646174657d3c2f703e0d0a3c703ec2a03c2f703e0d0a3c703e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e),
(30, 'listing_feature_reject', 'Your Request to Feature Listing is Rejected.', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e3c2f703e0d0a3c703e57652061726520736f727279202e3c2f703e0d0a3c703e596f7572207265717565737420686173206265656e2072656a65637465643c2f703e0d0a3c703e506c6561736520637265617465206120737570706f7274207469636b65742e3c2f703e0d0a3c703e3c7374726f6e673e4c697374696e67205469746c653c2f7374726f6e673e3a207b6c697374696e675f6e616d657d2e3c2f703e0d0a3c703e3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e),
(31, 'payment_accepted_for_featured_online_gateway', 'Your payment to Feature your business is successful.', 0x3c703e4869207b757365726e616d657d2c3c6272202f3e3c6272202f3e54686973206973206120636f6e6669726d6174696f6e206d61696c2066726f6d2075732e3c6272202f3e596f7572207061796d656e7420686173206265656e2061636365707465642026616d703b206e6f77207761697420666f722073746174757320617070726f76652e3c6272202f3e3c7374726f6e673e5061796d656e74205669613a3c2f7374726f6e673e207b7061796d656e745f7669617d3c6272202f3e3c7374726f6e673e5061796d656e7420416d6f756e743a3c2f7374726f6e673e207b7061636b6167655f70726963657d3c2f703e0d0a3c703e5468616e6b20796f7520666f7220796f75722070757263686173652e3c2f703e0d0a3c703e3c6272202f3e4265737420526567617264732c3c6272202f3e7b776562736974655f7469746c657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223ec2a03c2f703e),
(32, 'inquiry_about_product', 'Inquiry About Product', 0x3c703ec2a03c2f703e0d0a3c646976207374796c653d226d617267696e3a20303b20626f782d73697a696e673a20626f726465722d626f783b20636f6c6f723a20233061306130613b20666f6e742d66616d696c793a205461686f6d612c274c7563696461204772616e6465272c274c75636964612053616e73272c48656c7665746963612c417269616c2c73616e732d73657269663b20666f6e742d73697a653a20313670783b20666f6e742d7765696768743a206e6f726d616c3b206c696e652d6865696768743a20313970783b206d696e2d77696474683a20313030253b2070616464696e673a20303b20746578742d616c69676e3a206c6566743b2077696474683a203130302521696d706f7274616e743b223e0d0a3c7461626c65207374796c653d226d617267696e3a20303b206261636b67726f756e643a20236633663566383b20626f726465722d636f6c6c617073653a20636f6c6c617073653b20626f726465722d73706163696e673a20303b20636f6c6f723a20233061306130613b20666f6e742d66616d696c793a205461686f6d612c274c7563696461204772616e6465272c274c75636964612053616e73272c48656c7665746963612c417269616c2c73616e732d73657269663b20666f6e742d73697a653a20313670783b20666f6e742d7765696768743a206e6f726d616c3b206865696768743a20313030253b206c696e652d6865696768743a20313970783b2070616464696e673a20303b20746578742d616c69676e3a206c6566743b20766572746963616c2d616c69676e3a20746f703b2077696474683a20313030253b223e0d0a3c74626f64793e0d0a3c7472207374796c653d2270616464696e673a303b746578742d616c69676e3a6c6566743b223e0d0a3c7464207374796c653d226d617267696e3a20303b20626f726465722d636f6c6c617073653a20636f6c6c6170736521696d706f7274616e743b20636f6c6f723a20233061306130613b20666f6e742d66616d696c793a205461686f6d612c274c7563696461204772616e6465272c274c75636964612053616e73272c48656c7665746963612c417269616c2c73616e732d73657269663b20666f6e742d73697a653a20313670783b20666f6e742d7765696768743a206e6f726d616c3b206c696e652d6865696768743a20313970783b2070616464696e673a20303b20746578742d616c69676e3a206c6566743b20766572746963616c2d616c69676e3a20746f703b20776f72642d777261703a20627265616b2d776f72643b223e0d0a3c646976207374796c653d2270616464696e672d6c6566743a203136707821696d706f7274616e743b2070616464696e672d72696768743a203136707821696d706f7274616e743b223e3c6272202f3ec2a020c2a020c2a020c2a020c2a020c2a020c2a0c2a03c6272202f3ec2a020c2a020c2a020c2a020c2a020c2a020c2a00d0a3c7461626c65207374796c653d226d617267696e3a2030206175746f3b206261636b67726f756e643a20236635663566663b20626f726465723a2031707820736f6c696420236434646365323b20626f726465722d636f6c6c617073653a20636f6c6c617073653b20626f726465722d73706163696e673a20303b206d696e2d77696474683a2035303070783b2070616464696e673a20303b20746578742d616c69676e3a20696e68657269743b20766572746963616c2d616c69676e3a20746f703b2077696474683a2035383070783b223e0d0a3c74626f64793e0d0a3c7472207374796c653d2270616464696e673a303b746578742d616c69676e3a6c6566743b223e0d0a3c7464207374796c653d226d617267696e3a20303b20626f726465722d636f6c6c617073653a20636f6c6c6170736521696d706f7274616e743b20636f6c6f723a20233061306130613b20666f6e742d66616d696c793a205461686f6d612c274c7563696461204772616e6465272c274c75636964612053616e73272c48656c7665746963612c417269616c2c73616e732d73657269663b20666f6e742d73697a653a20313670783b20666f6e742d7765696768743a206e6f726d616c3b206c696e652d6865696768743a20313970783b2070616464696e673a20303b20746578742d616c69676e3a206c6566743b20766572746963616c2d616c69676e3a20746f703b20776f72642d777261703a20627265616b2d776f72643b223e3c6272202f3e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e44656172207b757365726e616d657d2c3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e5468697320656d61696c20696e666f726d7320796f75207468617420616e20656e71756972657220697320747279696e6720746f20636f6e7461637420796f752e20486572652069732074686520696e666f726d6174696f6e2061626f75742074686520656e7175697265722e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e3c7374726f6e673e4c697374696e673c2f7374726f6e673e3a207b6c697374696e675f6e616d657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e3c7374726f6e673e50726f647563743c2f7374726f6e673e3a207b70726f647563745f6e616d657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e456e717569726572204e616d653a207b656e7175697265725f6e616d657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e456e71756972657220456d61696c3a207b656e7175697265725f656d61696c7d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e4d6573736167653a3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e7b656e7175697265725f6d6573736167657d2e3c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223ec2a03c2f703e0d0a3c70207374796c653d2270616464696e672d6c6566743a343070783b223e4265737420526567617264732e3c6272202f3e7b776562736974655f7469746c657d3c2f703e0d0a3c2f74643e0d0a3c2f74723e0d0a3c2f74626f64793e0d0a3c2f7461626c653e0d0a3c2f6469763e0d0a3c2f74643e0d0a3c2f74723e0d0a3c2f74626f64793e0d0a3c2f7461626c653e0d0a3c2f6469763e);

-- --------------------------------------------------------

--
-- Table structure for table `memberships`
--

DROP TABLE IF EXISTS `memberships`;
CREATE TABLE IF NOT EXISTS `memberships` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `price` double DEFAULT NULL,
  `currency` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `currency_symbol` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `payment_method` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `is_trial` tinyint(4) NOT NULL DEFAULT 0,
  `trial_days` int(11) NOT NULL DEFAULT 0,
  `receipt` longtext COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `transaction_details` longtext COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `settings` longtext COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `package_id` bigint(20) DEFAULT NULL,
  `vendor_id` bigint(20) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `modified` tinyint(4) DEFAULT NULL COMMENT '1 - modified by Admin, 0 - not modified by Admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `memberships`
--

INSERT INTO `memberships` (`id`, `price`, `currency`, `currency_symbol`, `payment_method`, `transaction_id`, `status`, `is_trial`, `trial_days`, `receipt`, `transaction_details`, `settings`, `package_id`, `vendor_id`, `start_date`, `expire_date`, `modified`, `created_at`, `updated_at`) VALUES
(1, 0, 'Rupees', '$', '-', 'c6fe4e8e', 1, 0, 0, NULL, 'Free', '{\"id\":2,\"uniqid\":12345,\"favicon\":\"6631b1ad22bf4.png\",\"logo\":\"673cc0fa05dc4.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Shubham\",\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"Rupees\",\"base_currency_text_position\":\"left\",\"base_currency_rate\":\"82.00\",\"primary_color\":\"FFAD00\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":465,\"encryption\":\"ssl\",\"smtp_username\":\"naveen.webconverts@gmail.com\",\"smtp_password\":\"mdthjsxbsbztpmdr\",\"from_mail\":\"naveen.webconverts@gmail.com\",\"from_name\":\"naveen\",\"to_mail\":null,\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":null,\"google_recaptcha_status\":0,\"google_recaptcha_site_key\":null,\"google_recaptcha_secret_key\":null,\"whatsapp_status\":0,\"whatsapp_number\":null,\"whatsapp_header_title\":null,\"whatsapp_popup_status\":0,\"whatsapp_popup_message\":null,\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"fahad\",\"footer_logo\":\"6593ab335bdcc.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"light\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663cb8ff44ba5.jpg\",\"call_to_action_section_highlight_image\":\"663cb8e3a578e.png\",\"video_section_image\":\"663efcc6ce380.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":0,\"admin_approve_status\":1,\"listing_view\":1,\"facebook_login_status\":0,\"facebook_app_id\":null,\"facebook_app_secret\":null,\"google_login_status\":0,\"google_client_id\":null,\"google_client_secret\":null,\"tawkto_status\":0,\"hero_section_background_img\":\"664b03706cf4a.png\",\"tawkto_direct_chat_link\":\"\",\"vendor_admin_approval\":0,\"vendor_email_verification\":0,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T05:32:42.000000Z\"}', 86, 1, '2025-02-25', '2025-03-25', NULL, '2025-02-25 01:16:28', '2025-02-25 01:16:28'),
(2, 0, 'Rupees', '$', '-', '4f8aab2e', 1, 0, 0, NULL, 'Free', '{\"id\":2,\"uniqid\":12345,\"favicon\":\"6631b1ad22bf4.png\",\"logo\":\"673cc0fa05dc4.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Shubham\",\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"Rupees\",\"base_currency_text_position\":\"left\",\"base_currency_rate\":\"82.00\",\"primary_color\":\"FFAD00\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":465,\"encryption\":\"ssl\",\"smtp_username\":\"naveen.webconverts@gmail.com\",\"smtp_password\":\"mdthjsxbsbztpmdr\",\"from_mail\":\"naveen.webconverts@gmail.com\",\"from_name\":\"naveen\",\"to_mail\":null,\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":null,\"google_recaptcha_status\":0,\"google_recaptcha_site_key\":null,\"google_recaptcha_secret_key\":null,\"whatsapp_status\":0,\"whatsapp_number\":null,\"whatsapp_header_title\":null,\"whatsapp_popup_status\":0,\"whatsapp_popup_message\":null,\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"fahad\",\"footer_logo\":\"6593ab335bdcc.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"light\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663cb8ff44ba5.jpg\",\"call_to_action_section_highlight_image\":\"663cb8e3a578e.png\",\"video_section_image\":\"663efcc6ce380.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":0,\"admin_approve_status\":1,\"listing_view\":1,\"facebook_login_status\":0,\"facebook_app_id\":null,\"facebook_app_secret\":null,\"google_login_status\":0,\"google_client_id\":null,\"google_client_secret\":null,\"tawkto_status\":0,\"hero_section_background_img\":\"664b03706cf4a.png\",\"tawkto_direct_chat_link\":\"\",\"vendor_admin_approval\":0,\"vendor_email_verification\":0,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T05:32:42.000000Z\"}', 86, 1, '2025-02-25', '2025-03-25', NULL, '2025-02-25 01:18:56', '2025-02-25 01:18:56'),
(3, 0, 'Rupees', '$', '-', '8a27f420', 1, 0, 0, NULL, 'Free', '{\"id\":2,\"uniqid\":12345,\"favicon\":\"6631b1ad22bf4.png\",\"logo\":\"673cc0fa05dc4.png\",\"logo_two\":\"64ed7071b1844.png\",\"website_title\":\"Shubham\",\"email_address\":\"bulistio@example.com\",\"contact_number\":\"+701 - 1111 - 2222 - 333\",\"address\":\"450 Young Road, New York, USA\",\"theme_version\":1,\"base_currency_symbol\":\"$\",\"base_currency_symbol_position\":\"left\",\"base_currency_text\":\"Rupees\",\"base_currency_text_position\":\"left\",\"base_currency_rate\":\"82.00\",\"primary_color\":\"FFAD00\",\"smtp_status\":1,\"smtp_host\":\"smtp.gmail.com\",\"smtp_port\":465,\"encryption\":\"ssl\",\"smtp_username\":\"naveen.webconverts@gmail.com\",\"smtp_password\":\"mdthjsxbsbztpmdr\",\"from_mail\":\"naveen.webconverts@gmail.com\",\"from_name\":\"naveen\",\"to_mail\":null,\"breadcrumb\":\"65c200e4ea394.png\",\"disqus_status\":0,\"disqus_short_name\":null,\"google_recaptcha_status\":0,\"google_recaptcha_site_key\":null,\"google_recaptcha_secret_key\":null,\"whatsapp_status\":0,\"whatsapp_number\":null,\"whatsapp_header_title\":null,\"whatsapp_popup_status\":0,\"whatsapp_popup_message\":null,\"maintenance_img\":\"1632725312.png\",\"maintenance_status\":0,\"maintenance_msg\":\"We are upgrading our site. We will come back soon. \\r\\nPlease stay with us.\\r\\nThank you.\",\"bypass_token\":\"fahad\",\"footer_logo\":\"6593ab335bdcc.png\",\"footer_background_image\":\"638db9bf3f92a.jpg\",\"admin_theme_version\":\"light\",\"notification_image\":\"619b7d5e5e9df.png\",\"counter_section_image\":\"6530b4b2c6984.jpg\",\"call_to_action_section_image\":\"663cb8ff44ba5.jpg\",\"call_to_action_section_highlight_image\":\"663cb8e3a578e.png\",\"video_section_image\":\"663efcc6ce380.jpg\",\"testimonial_section_image\":\"657a7500bb6c1.jpg\",\"category_section_background\":\"63c92601cb853.jpg\",\"google_adsense_publisher_id\":\"dvf\",\"equipment_tax_amount\":\"5.00\",\"product_tax_amount\":\"5.00\",\"self_pickup_status\":1,\"two_way_delivery_status\":1,\"guest_checkout_status\":0,\"shop_status\":0,\"admin_approve_status\":1,\"listing_view\":1,\"facebook_login_status\":0,\"facebook_app_id\":null,\"facebook_app_secret\":null,\"google_login_status\":0,\"google_client_id\":null,\"google_client_secret\":null,\"tawkto_status\":0,\"hero_section_background_img\":\"664b03706cf4a.png\",\"tawkto_direct_chat_link\":\"\",\"vendor_admin_approval\":0,\"vendor_email_verification\":0,\"admin_approval_notice\":\"Your account is deactive or pending now. Please Contact with admin!\",\"expiration_reminder\":3,\"timezone\":\"Asia\\/Dhaka\",\"hero_section_video_url\":\"https:\\/\\/www.youtube.com\\/watch?v=9l6RywtDlKA\",\"contact_title\":\"Get Connected\",\"contact_subtile\":\"How Can We Help You?\",\"contact_details\":\"Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\\r\\n\\r\\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.\",\"latitude\":\"23.8587\",\"longitude\":\"90.4001\",\"preloader_status\":1,\"preloader\":\"65e7f2608a3c1.gif\",\"updated_at\":\"2023-08-24T05:32:42.000000Z\"}', 86, 1, '2025-02-25', '2025-03-25', NULL, '2025-02-25 01:21:20', '2025-02-25 01:21:20');

-- --------------------------------------------------------

--
-- Table structure for table `menu_builders`
--

DROP TABLE IF EXISTS `menu_builders`;
CREATE TABLE IF NOT EXISTS `menu_builders` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `menus` text COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `menu_builders`
--

INSERT INTO `menu_builders` (`id`, `language_id`, `menus`, `created_at`, `updated_at`) VALUES
(7, 20, '[{\"text\":\"Home\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"home\"},{\"text\":\"Listings\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"listings\"},{\"text\":\"Pricing\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"pricing\"},{\"text\":\"Vendors\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"vendors\"},{\"text\":\"Shop\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"shop\",\"children\":[{\"text\":\"Cart\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"cart\"},{\"text\":\"Checkout\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"checkout\"}]},{\"text\":\"Pages\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"custom\",\"children\":[{\"text\":\"Blog\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"blog\"},{\"text\":\"FAQ\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"faq\"},{\"text\":\"About Us\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"about-us\"}]},{\"text\":\"Contact\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"contact\"}]', '2023-08-17 03:19:12', '2024-05-15 03:10:52');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2023_10_19_031727_create_listing_sections_table', 1),
(2, '2023_10_19_035156_pacakge_section', 2),
(3, '2023_11_13_042845_v', 3),
(4, '2023_11_13_042942_listing_category', 3),
(5, '2023_11_13_044154_create_settings_table', 3),
(6, '2023_11_13_071453_aminites', 4),
(7, '2023_11_14_025059_listing_images', 5),
(8, '2023_11_15_025019_listings', 6),
(9, '2023_11_15_025156_listing_contents', 6),
(10, '2023_11_16_033741_listing_features', 7),
(11, '2023_11_20_062648_listing_reviews', 8),
(12, '2023_11_21_090259_messages', 9),
(13, '2023_11_21_091821_listing_messages', 10),
(14, '2023_11_22_040920_listing_social_media', 11),
(15, '2023_11_23_034340_listing_products', 12),
(16, '2023_11_23_034430_listing_products_content', 12),
(17, '2023_11_23_034512_listingproductimages', 12),
(18, '2023_11_26_031913_business_hours', 13),
(19, '2023_12_02_045705_listing_faq', 14),
(20, '2023_12_05_033837_listing_feature_charges', 15),
(21, '2023_12_05_081415_feature_orders', 16),
(22, '2023_12_13_050545_video_sections', 17),
(23, '2023_12_13_095353_location_section', 18),
(24, '2023_12_17_033638_countries', 19),
(25, '2023_12_17_044738_states', 20),
(26, '2023_12_17_064230_cities', 21),
(27, '2023_12_24_031950_product_messages', 22),
(28, '2024_01_10_033406_listingspecificationcontents', 23),
(29, '2024_03_27_022811_herosections', 24);

-- --------------------------------------------------------

--
-- Table structure for table `offline_gateways`
--

DROP TABLE IF EXISTS `offline_gateways`;
CREATE TABLE IF NOT EXISTS `offline_gateways` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `short_description` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `instructions` longtext COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0 -> gateway is deactive, 1 -> gateway is active.',
  `has_attachment` tinyint(1) NOT NULL COMMENT '0 -> do not need attachment, 1 -> need attachment.',
  `serial_number` mediumint(8) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `offline_gateways`
--

INSERT INTO `offline_gateways` (`id`, `name`, `short_description`, `instructions`, `status`, `has_attachment`, `serial_number`, `created_at`, `updated_at`) VALUES
(14, 'naveen', 'gsgsdgs sdfsdfsf', '', 1, 1, 23, '2025-03-04 02:15:18', '2025-03-04 02:15:18');

-- --------------------------------------------------------

--
-- Table structure for table `online_gateways`
--

DROP TABLE IF EXISTS `online_gateways`;
CREATE TABLE IF NOT EXISTS `online_gateways` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `keyword` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `information` mediumtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `online_gateways`
--

INSERT INTO `online_gateways` (`id`, `name`, `keyword`, `information`, `status`) VALUES
(1, 'PayPal', 'paypal', '{\"sandbox_status\":\"0\",\"client_id\":\"\",\"client_secret\":\"\"}', 0),
(2, 'Instamojo', 'instamojo', '{\"sandbox_status\":\"0\",\"key\":\"\",\"token\":\"\"}', 0),
(3, 'Paystack', 'paystack', '{\"key\":\"\"}', 0),
(4, 'Flutterwave', 'flutterwave', '{\"public_key\":\"\",\"secret_key\":\"\"}', 0),
(5, 'Razorpay', 'razorpay', '{\"key\":\"\",\"secret\":\"\"}', 0),
(6, 'MercadoPago', 'mercadopago', '{\"sandbox_status\":\"0\",\"token\":\"\"}', 0),
(7, 'Mollie', 'mollie', '{\"key\":\"\"}', 0),
(10, 'Stripe', 'stripe', '{\"key\":\"\",\"secret\":\"\"}', 0),
(11, 'Paytm', 'paytm', '{\"environment\":\"local\",\"merchant_key\":\"\",\"merchant_mid\":\"\",\"merchant_website\":\"\",\"industry_type\":\"\"}', 0),
(21, 'Authorize.net', 'authorize.net', '{\"login_id\":\"\",\"transaction_key\":\"\",\"public_key\":\"\",\"sandbox_check\":\"0\",\"text\":\"Pay via your Authorize.net account.\"}', 0);

-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

DROP TABLE IF EXISTS `packages`;
CREATE TABLE IF NOT EXISTS `packages` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `price` double NOT NULL DEFAULT 0,
  `icon` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `term` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `number_of_listing` int(11) DEFAULT 0,
  `recommended` int(11) DEFAULT NULL,
  `number_of_images_per_listing` int(11) DEFAULT 0,
  `number_of_products` int(11) DEFAULT 0,
  `number_of_images_per_products` int(11) DEFAULT 0,
  `number_of_amenities_per_listing` int(11) DEFAULT 0,
  `number_of_additional_specification` int(11) DEFAULT 0,
  `number_of_social_links` int(11) DEFAULT 0,
  `number_of_faq` int(11) DEFAULT 0,
  `custom_features` longtext COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `features` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `packages`
--

INSERT INTO `packages` (`id`, `title`, `slug`, `price`, `icon`, `term`, `number_of_listing`, `recommended`, `number_of_images_per_listing`, `number_of_products`, `number_of_images_per_products`, `number_of_amenities_per_listing`, `number_of_additional_specification`, `number_of_social_links`, `number_of_faq`, `custom_features`, `status`, `features`, `created_at`, `updated_at`) VALUES
(86, 'free', 'free', 0, 'fas fa-gift iconpicker-component', 'monthly', 1, 1, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'null', '2025-02-25 01:16:15', '2025-03-04 07:58:17');

-- --------------------------------------------------------

--
-- Table structure for table `package_sections`
--

DROP TABLE IF EXISTS `package_sections`;
CREATE TABLE IF NOT EXISTS `package_sections` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtitle` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_text` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `package_sections`
--

INSERT INTO `package_sections` (`id`, `language_id`, `title`, `subtitle`, `button_text`, `created_at`, `updated_at`) VALUES
(1, 20, 'Most Affordable Package', NULL, NULL, '2023-10-18 22:02:00', '2024-04-30 22:24:17');

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
CREATE TABLE IF NOT EXISTS `pages` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` tinyint(3) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `page_contents`
--

DROP TABLE IF EXISTS `page_contents`;
CREATE TABLE IF NOT EXISTS `page_contents` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `page_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` blob NOT NULL,
  `meta_keywords` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `page_contents_language_id_foreign` (`language_id`),
  KEY `page_contents_page_id_foreign` (`page_id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `page_headings`
--

DROP TABLE IF EXISTS `page_headings`;
CREATE TABLE IF NOT EXISTS `page_headings` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `listing_page_title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `blog_page_title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `contact_page_title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `products_page_title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `error_page_title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `pricing_page_title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `faq_page_title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `forget_password_page_title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `vendor_forget_password_page_title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `login_page_title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `signup_page_title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `vendor_login_page_title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `vendor_signup_page_title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `cart_page_title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `checkout_page_title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `vendor_page_title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `about_us_title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `wishlist_page_title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `dashboard_page_title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `orders_page_title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `support_ticket_page_title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `support_ticket_create_page_title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `change_password_page_title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `edit_profile_page_title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `page_headings_language_id_foreign` (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `page_headings`
--

INSERT INTO `page_headings` (`id`, `language_id`, `listing_page_title`, `blog_page_title`, `contact_page_title`, `products_page_title`, `error_page_title`, `pricing_page_title`, `faq_page_title`, `forget_password_page_title`, `vendor_forget_password_page_title`, `login_page_title`, `signup_page_title`, `vendor_login_page_title`, `vendor_signup_page_title`, `cart_page_title`, `checkout_page_title`, `vendor_page_title`, `about_us_title`, `wishlist_page_title`, `dashboard_page_title`, `orders_page_title`, `support_ticket_page_title`, `support_ticket_create_page_title`, `change_password_page_title`, `edit_profile_page_title`, `created_at`, `updated_at`) VALUES
(9, 20, 'Listings', 'Blog', 'Contact', 'Products', '404', 'Pricing', 'FAQ', 'Forget Password', 'Forget Password', 'Login', 'Signup', 'Vendor Login', 'Vendor Signup', 'Cart', 'Checkout', 'Vendors', 'About Us', 'Wishlists', 'Dashboard', 'Orders', 'Support Tickets', 'Create a Support Ticket', 'Change Password', 'Edit Profile', '2023-08-27 01:23:22', '2024-01-01 04:49:59');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`id`, `email`, `token`, `created_at`) VALUES
(8, 'fahadahmadshemul@gmail.com', 'ktTRmy3rfZBfonez2MM80l9jZvEwYbaS', NULL),
(9, 'fahadahmadshemul@gmail.com', 'LqksSbBPKGXCNF3hJ9a5Ghri3aX5973G', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `popups`
--

DROP TABLE IF EXISTS `popups`;
CREATE TABLE IF NOT EXISTS `popups` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `type` smallint(5) UNSIGNED NOT NULL,
  `image` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `background_color` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `background_color_opacity` decimal(3,2) UNSIGNED DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `button_text` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `button_color` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `button_url` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `delay` int(10) UNSIGNED NOT NULL COMMENT 'value will be in milliseconds',
  `serial_number` mediumint(8) UNSIGNED NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '0 => deactive, 1 => active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `popups_language_id_foreign` (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `vendor_id` bigint(20) DEFAULT NULL,
  `product_type` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `featured_image` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `slider_images` text COLLATE utf8mb3_unicode_ci NOT NULL,
  `status` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `input_type` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `file` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `link` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `stock` int(10) UNSIGNED DEFAULT NULL,
  `sku` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `current_price` decimal(8,2) UNSIGNED NOT NULL,
  `previous_price` decimal(8,2) UNSIGNED DEFAULT NULL,
  `average_rating` decimal(4,2) UNSIGNED DEFAULT 0.00,
  `is_featured` varchar(5) COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

DROP TABLE IF EXISTS `product_categories`;
CREATE TABLE IF NOT EXISTS `product_categories` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL,
  `serial_number` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_categories_language_id_foreign` (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `product_categories`
--

INSERT INTO `product_categories` (`id`, `language_id`, `name`, `slug`, `status`, `serial_number`, `created_at`, `updated_at`) VALUES
(61, 20, 'mehindi', 'mehindi', 1, 1, '2024-11-30 04:38:36', '2024-11-30 04:38:36');

-- --------------------------------------------------------

--
-- Table structure for table `product_contents`
--

DROP TABLE IF EXISTS `product_contents`;
CREATE TABLE IF NOT EXISTS `product_contents` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `product_category_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `summary` text COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb3_unicode_ci NOT NULL,
  `meta_keywords` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_contents_language_id_foreign` (`language_id`),
  KEY `product_contents_product_category_id_foreign` (`product_category_id`),
  KEY `product_contents_product_id_foreign` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_coupons`
--

DROP TABLE IF EXISTS `product_coupons`;
CREATE TABLE IF NOT EXISTS `product_coupons` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `value` decimal(8,2) UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `minimum_spend` decimal(8,2) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_messages`
--

DROP TABLE IF EXISTS `product_messages`;
CREATE TABLE IF NOT EXISTS `product_messages` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) DEFAULT NULL,
  `vendor_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_orders`
--

DROP TABLE IF EXISTS `product_orders`;
CREATE TABLE IF NOT EXISTS `product_orders` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `order_number` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `billing_name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `billing_email` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `billing_phone` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `billing_address` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `billing_city` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `billing_state` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `billing_country` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_email` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_phone` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_address` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_city` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_state` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `shipping_country` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `total` decimal(8,2) UNSIGNED NOT NULL,
  `discount` decimal(8,2) UNSIGNED DEFAULT NULL,
  `product_shipping_charge_id` bigint(20) UNSIGNED DEFAULT NULL,
  `shipping_cost` decimal(8,2) UNSIGNED DEFAULT NULL,
  `tax` decimal(8,2) UNSIGNED NOT NULL,
  `grand_total` decimal(8,2) UNSIGNED NOT NULL,
  `currency_text` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `currency_text_position` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `currency_symbol` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `currency_symbol_position` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `payment_method` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `gateway_type` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `payment_status` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `order_status` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `attachment` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `invoice` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_orders_user_id_foreign` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_purchase_items`
--

DROP TABLE IF EXISTS `product_purchase_items`;
CREATE TABLE IF NOT EXISTS `product_purchase_items` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_purchase_items_product_order_id_foreign` (`product_order_id`),
  KEY `product_purchase_items_product_id_foreign` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_reviews`
--

DROP TABLE IF EXISTS `product_reviews`;
CREATE TABLE IF NOT EXISTS `product_reviews` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `comment` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `rating` smallint(5) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_reviews_user_id_foreign` (`user_id`),
  KEY `product_reviews_product_id_foreign` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_shipping_charges`
--

DROP TABLE IF EXISTS `product_shipping_charges`;
CREATE TABLE IF NOT EXISTS `product_shipping_charges` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `short_text` text COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_charge` decimal(8,2) UNSIGNED NOT NULL,
  `serial_number` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shipping_charges_language_id_foreign` (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `push_subscriptions`
--

DROP TABLE IF EXISTS `push_subscriptions`;
CREATE TABLE IF NOT EXISTS `push_subscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `subscribable_type` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `subscribable_id` bigint(20) UNSIGNED NOT NULL,
  `endpoint` varchar(500) COLLATE utf8mb3_unicode_ci NOT NULL,
  `public_key` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `auth_token` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `content_encoding` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `push_subscriptions_endpoint_unique` (`endpoint`),
  KEY `push_subscriptions_subscribable_type_subscribable_id_index` (`subscribable_type`,`subscribable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quick_links`
--

DROP TABLE IF EXISTS `quick_links`;
CREATE TABLE IF NOT EXISTS `quick_links` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` smallint(5) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quick_links_language_id_foreign` (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
CREATE TABLE IF NOT EXISTS `role_permissions` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `permissions` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`id`, `name`, `permissions`, `created_at`, `updated_at`) VALUES
(15, 'naveen', NULL, '2024-08-05 09:16:11', '2024-08-05 09:16:11');

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
CREATE TABLE IF NOT EXISTS `sections` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `work_process_section_status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `category_section_status` tinyint(4) DEFAULT 0,
  `featured_listing_section_status` tinyint(4) NOT NULL DEFAULT 1,
  `feature_section_status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `latest_listing_section_status` tinyint(4) DEFAULT NULL,
  `counter_section_status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `package_section_status` tinyint(4) NOT NULL DEFAULT 1,
  `video_section` tinyint(4) DEFAULT 0,
  `testimonial_section_status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `call_to_action_section_status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `location_section_status` tinyint(4) DEFAULT NULL,
  `blog_section_status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `subscribe_section_status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `footer_section_status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`id`, `work_process_section_status`, `category_section_status`, `featured_listing_section_status`, `feature_section_status`, `latest_listing_section_status`, `counter_section_status`, `package_section_status`, `video_section`, `testimonial_section_status`, `call_to_action_section_status`, `location_section_status`, `blog_section_status`, `subscribe_section_status`, `footer_section_status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, NULL, '2024-03-21 00:17:28');

-- --------------------------------------------------------

--
-- Table structure for table `seos`
--

DROP TABLE IF EXISTS `seos`;
CREATE TABLE IF NOT EXISTS `seos` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `meta_keyword_home` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_home` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_keyword_pricing` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_pricing` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_keyword_listings` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_listings` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_keyword_products` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_products` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_keyword_blog` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_blog` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_keyword_faq` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_faq` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_keyword_contact` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_contact` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_keyword_login` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_login` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_keyword_signup` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_signup` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_keyword_forget_password` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_forget_password` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_keywords_vendor_login` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_vendor_login` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_keywords_vendor_signup` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_vendor_signup` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_keywords_vendor_forget_password` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_descriptions_vendor_forget_password` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_keywords_vendor_page` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_vendor_page` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_keywords_about_page` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_about_page` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `seos_language_id_foreign` (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `seos`
--

INSERT INTO `seos` (`id`, `language_id`, `meta_keyword_home`, `meta_description_home`, `meta_keyword_pricing`, `meta_description_pricing`, `meta_keyword_listings`, `meta_description_listings`, `meta_keyword_products`, `meta_description_products`, `meta_keyword_blog`, `meta_description_blog`, `meta_keyword_faq`, `meta_description_faq`, `meta_keyword_contact`, `meta_description_contact`, `meta_keyword_login`, `meta_description_login`, `meta_keyword_signup`, `meta_description_signup`, `meta_keyword_forget_password`, `meta_description_forget_password`, `meta_keywords_vendor_login`, `meta_description_vendor_login`, `meta_keywords_vendor_signup`, `meta_description_vendor_signup`, `meta_keywords_vendor_forget_password`, `meta_descriptions_vendor_forget_password`, `meta_keywords_vendor_page`, `meta_description_vendor_page`, `meta_keywords_about_page`, `meta_description_about_page`, `created_at`, `updated_at`) VALUES
(5, 20, 'Home', 'Home Descriptions', 'Pricimg', 'Pricing descriptions', 'Listings', 'Listings Description', 'products', 'Product descriptions', 'Blog', 'Blog descriptions', 'Faq', 'faq descriptions', 'contact', 'contact descriptions', 'Login', 'Login descriptions', 'Signup', 'signup descriptions', 'Forget Password', 'Forget Password descriptions', 'Vendor Login', 'Vendor Login descriptions', 'Vendor Signup', 'Vendor Signup descriptions', 'Vendor Forget Password', 'vendor forget password descriptions', 'vendors', 'vendors descriptions', 'About us', 'about us descriptions', '2023-08-27 01:03:33', '2024-01-01 21:20:39');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
CREATE TABLE IF NOT EXISTS `settings` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `social_medias`
--

DROP TABLE IF EXISTS `social_medias`;
CREATE TABLE IF NOT EXISTS `social_medias` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `icon` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `social_medias`
--

INSERT INTO `social_medias` (`id`, `icon`, `url`, `serial_number`, `created_at`, `updated_at`) VALUES
(36, 'fab fa-facebook-f', 'http://example.com/', 1, '2021-11-20 03:01:42', '2021-11-20 03:01:42'),
(37, 'fab fa-twitter', 'http://example.com/', 3, '2021-11-20 03:03:22', '2021-11-20 03:03:22'),
(38, 'fab fa-linkedin-in', 'http://example.com/', 2, '2021-11-20 03:04:29', '2021-11-20 03:04:29');

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
CREATE TABLE IF NOT EXISTS `states` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `country_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `states`
--

INSERT INTO `states` (`id`, `language_id`, `country_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 20, 1, 'Karnataka', '2025-02-11 03:08:45', '2025-02-11 03:08:45');

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

DROP TABLE IF EXISTS `subscribers`;
CREATE TABLE IF NOT EXISTS `subscribers` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email_id` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscribers_email_id_unique` (`email_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

DROP TABLE IF EXISTS `support_tickets`;
CREATE TABLE IF NOT EXISTS `support_tickets` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `user_type` varchar(20) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '1-pending, 2-open, 3-closed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `last_message` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `support_ticket_statuses`
--

DROP TABLE IF EXISTS `support_ticket_statuses`;
CREATE TABLE IF NOT EXISTS `support_ticket_statuses` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `support_ticket_status` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `support_ticket_statuses`
--

INSERT INTO `support_ticket_statuses` (`id`, `support_ticket_status`, `created_at`, `updated_at`) VALUES
(1, 'active', '2022-06-25 03:52:18', '2024-03-21 00:50:57');

-- --------------------------------------------------------

--
-- Table structure for table `testimonials`
--

DROP TABLE IF EXISTS `testimonials`;
CREATE TABLE IF NOT EXISTS `testimonials` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `occupation` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `comment` text COLLATE utf8mb3_unicode_ci NOT NULL,
  `rating` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `testimonial_sections`
--

DROP TABLE IF EXISTS `testimonial_sections`;
CREATE TABLE IF NOT EXISTS `testimonial_sections` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `subtitle` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `clients` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `testimonial_sections`
--

INSERT INTO `testimonial_sections` (`id`, `language_id`, `subtitle`, `title`, `clients`, `created_at`, `updated_at`) VALUES
(7, 20, NULL, 'What Clients Say About Bulistio Packages', '10k+ Active Client’s', '2023-08-19 03:45:43', '2023-12-13 21:06:27');

-- --------------------------------------------------------

--
-- Table structure for table `timezones`
--

DROP TABLE IF EXISTS `timezones`;
CREATE TABLE IF NOT EXISTS `timezones` (
  `country_code` char(3) NOT NULL,
  `timezone` varchar(125) NOT NULL DEFAULT '',
  `gmt_offset` float(10,2) DEFAULT NULL,
  `dst_offset` float(10,2) DEFAULT NULL,
  `raw_offset` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`country_code`,`timezone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `timezones`
--

INSERT INTO `timezones` (`country_code`, `timezone`, `gmt_offset`, `dst_offset`, `raw_offset`) VALUES
('AD', 'Europe/Andorra', 1.00, 2.00, 1.00),
('AE', 'Asia/Dubai', 4.00, 4.00, 4.00),
('AF', 'Asia/Kabul', 4.50, 4.50, 4.50),
('AG', 'America/Antigua', -4.00, -4.00, -4.00),
('AI', 'America/Anguilla', -4.00, -4.00, -4.00),
('AL', 'Europe/Tirane', 1.00, 2.00, 1.00),
('AM', 'Asia/Yerevan', 4.00, 4.00, 4.00),
('AO', 'Africa/Luanda', 1.00, 1.00, 1.00),
('AQ', 'Antarctica/Casey', 8.00, 8.00, 8.00),
('AQ', 'Antarctica/Davis', 7.00, 7.00, 7.00),
('AQ', 'Antarctica/DumontDUrville', 10.00, 10.00, 10.00),
('AQ', 'Antarctica/Mawson', 5.00, 5.00, 5.00),
('AQ', 'Antarctica/McMurdo', 13.00, 12.00, 12.00),
('AQ', 'Antarctica/Palmer', -3.00, -4.00, -4.00),
('AQ', 'Antarctica/Rothera', -3.00, -3.00, -3.00),
('AQ', 'Antarctica/South_Pole', 13.00, 12.00, 12.00),
('AQ', 'Antarctica/Syowa', 3.00, 3.00, 3.00),
('AQ', 'Antarctica/Vostok', 6.00, 6.00, 6.00),
('AR', 'America/Argentina/Buenos_Aires', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Catamarca', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Cordoba', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Jujuy', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/La_Rioja', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Mendoza', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Rio_Gallegos', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Salta', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/San_Juan', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/San_Luis', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Tucuman', -3.00, -3.00, -3.00),
('AR', 'America/Argentina/Ushuaia', -3.00, -3.00, -3.00),
('AS', 'Pacific/Pago_Pago', -11.00, -11.00, -11.00),
('AT', 'Europe/Vienna', 1.00, 2.00, 1.00),
('AU', 'Antarctica/Macquarie', 11.00, 11.00, 11.00),
('AU', 'Australia/Adelaide', 10.50, 9.50, 9.50),
('AU', 'Australia/Brisbane', 10.00, 10.00, 10.00),
('AU', 'Australia/Broken_Hill', 10.50, 9.50, 9.50),
('AU', 'Australia/Currie', 11.00, 10.00, 10.00),
('AU', 'Australia/Darwin', 9.50, 9.50, 9.50),
('AU', 'Australia/Eucla', 8.75, 8.75, 8.75),
('AU', 'Australia/Hobart', 11.00, 10.00, 10.00),
('AU', 'Australia/Lindeman', 10.00, 10.00, 10.00),
('AU', 'Australia/Lord_Howe', 11.00, 10.50, 10.50),
('AU', 'Australia/Melbourne', 11.00, 10.00, 10.00),
('AU', 'Australia/Perth', 8.00, 8.00, 8.00),
('AU', 'Australia/Sydney', 11.00, 10.00, 10.00),
('AW', 'America/Aruba', -4.00, -4.00, -4.00),
('AX', 'Europe/Mariehamn', 2.00, 3.00, 2.00),
('AZ', 'Asia/Baku', 4.00, 5.00, 4.00),
('BA', 'Europe/Sarajevo', 1.00, 2.00, 1.00),
('BB', 'America/Barbados', -4.00, -4.00, -4.00),
('BD', 'Asia/Dhaka', 6.00, 6.00, 6.00),
('BE', 'Europe/Brussels', 1.00, 2.00, 1.00),
('BF', 'Africa/Ouagadougou', 0.00, 0.00, 0.00),
('BG', 'Europe/Sofia', 2.00, 3.00, 2.00),
('BH', 'Asia/Bahrain', 3.00, 3.00, 3.00),
('BI', 'Africa/Bujumbura', 2.00, 2.00, 2.00),
('BJ', 'Africa/Porto-Novo', 1.00, 1.00, 1.00),
('BL', 'America/St_Barthelemy', -4.00, -4.00, -4.00),
('BM', 'Atlantic/Bermuda', -4.00, -3.00, -4.00),
('BN', 'Asia/Brunei', 8.00, 8.00, 8.00),
('BO', 'America/La_Paz', -4.00, -4.00, -4.00),
('BQ', 'America/Kralendijk', -4.00, -4.00, -4.00),
('BR', 'America/Araguaina', -3.00, -3.00, -3.00),
('BR', 'America/Bahia', -3.00, -3.00, -3.00),
('BR', 'America/Belem', -3.00, -3.00, -3.00),
('BR', 'America/Boa_Vista', -4.00, -4.00, -4.00),
('BR', 'America/Campo_Grande', -3.00, -4.00, -4.00),
('BR', 'America/Cuiaba', -3.00, -4.00, -4.00),
('BR', 'America/Eirunepe', -5.00, -5.00, -5.00),
('BR', 'America/Fortaleza', -3.00, -3.00, -3.00),
('BR', 'America/Maceio', -3.00, -3.00, -3.00),
('BR', 'America/Manaus', -4.00, -4.00, -4.00),
('BR', 'America/Noronha', -2.00, -2.00, -2.00),
('BR', 'America/Porto_Velho', -4.00, -4.00, -4.00),
('BR', 'America/Recife', -3.00, -3.00, -3.00),
('BR', 'America/Rio_Branco', -5.00, -5.00, -5.00),
('BR', 'America/Santarem', -3.00, -3.00, -3.00),
('BR', 'America/Sao_Paulo', -2.00, -3.00, -3.00),
('BS', 'America/Nassau', -5.00, -4.00, -5.00),
('BT', 'Asia/Thimphu', 6.00, 6.00, 6.00),
('BW', 'Africa/Gaborone', 2.00, 2.00, 2.00),
('BY', 'Europe/Minsk', 3.00, 3.00, 3.00),
('BZ', 'America/Belize', -6.00, -6.00, -6.00),
('CA', 'America/Atikokan', -5.00, -5.00, -5.00),
('CA', 'America/Blanc-Sablon', -4.00, -4.00, -4.00),
('CA', 'America/Cambridge_Bay', -7.00, -6.00, -7.00),
('CA', 'America/Creston', -7.00, -7.00, -7.00),
('CA', 'America/Dawson', -8.00, -7.00, -8.00),
('CA', 'America/Dawson_Creek', -7.00, -7.00, -7.00),
('CA', 'America/Edmonton', -7.00, -6.00, -7.00),
('CA', 'America/Glace_Bay', -4.00, -3.00, -4.00),
('CA', 'America/Goose_Bay', -4.00, -3.00, -4.00),
('CA', 'America/Halifax', -4.00, -3.00, -4.00),
('CA', 'America/Inuvik', -7.00, -6.00, -7.00),
('CA', 'America/Iqaluit', -5.00, -4.00, -5.00),
('CA', 'America/Moncton', -4.00, -3.00, -4.00),
('CA', 'America/Montreal', -5.00, -4.00, -5.00),
('CA', 'America/Nipigon', -5.00, -4.00, -5.00),
('CA', 'America/Pangnirtung', -5.00, -4.00, -5.00),
('CA', 'America/Rainy_River', -6.00, -5.00, -6.00),
('CA', 'America/Rankin_Inlet', -6.00, -5.00, -6.00),
('CA', 'America/Regina', -6.00, -6.00, -6.00),
('CA', 'America/Resolute', -6.00, -5.00, -6.00),
('CA', 'America/St_Johns', -3.50, -2.50, -3.50),
('CA', 'America/Swift_Current', -6.00, -6.00, -6.00),
('CA', 'America/Thunder_Bay', -5.00, -4.00, -5.00),
('CA', 'America/Toronto', -5.00, -4.00, -5.00),
('CA', 'America/Vancouver', -8.00, -7.00, -8.00),
('CA', 'America/Whitehorse', -8.00, -7.00, -8.00),
('CA', 'America/Winnipeg', -6.00, -5.00, -6.00),
('CA', 'America/Yellowknife', -7.00, -6.00, -7.00),
('CC', 'Indian/Cocos', 6.50, 6.50, 6.50),
('CD', 'Africa/Kinshasa', 1.00, 1.00, 1.00),
('CD', 'Africa/Lubumbashi', 2.00, 2.00, 2.00),
('CF', 'Africa/Bangui', 1.00, 1.00, 1.00),
('CG', 'Africa/Brazzaville', 1.00, 1.00, 1.00),
('CH', 'Europe/Zurich', 1.00, 2.00, 1.00),
('CI', 'Africa/Abidjan', 0.00, 0.00, 0.00),
('CK', 'Pacific/Rarotonga', -10.00, -10.00, -10.00),
('CL', 'America/Santiago', -3.00, -4.00, -4.00),
('CL', 'Pacific/Easter', -5.00, -6.00, -6.00),
('CM', 'Africa/Douala', 1.00, 1.00, 1.00),
('CN', 'Asia/Chongqing', 8.00, 8.00, 8.00),
('CN', 'Asia/Harbin', 8.00, 8.00, 8.00),
('CN', 'Asia/Kashgar', 8.00, 8.00, 8.00),
('CN', 'Asia/Shanghai', 8.00, 8.00, 8.00),
('CN', 'Asia/Urumqi', 8.00, 8.00, 8.00),
('CO', 'America/Bogota', -5.00, -5.00, -5.00),
('CR', 'America/Costa_Rica', -6.00, -6.00, -6.00),
('CU', 'America/Havana', -5.00, -4.00, -5.00),
('CV', 'Atlantic/Cape_Verde', -1.00, -1.00, -1.00),
('CW', 'America/Curacao', -4.00, -4.00, -4.00),
('CX', 'Indian/Christmas', 7.00, 7.00, 7.00),
('CY', 'Asia/Nicosia', 2.00, 3.00, 2.00),
('CZ', 'Europe/Prague', 1.00, 2.00, 1.00),
('DE', 'Europe/Berlin', 1.00, 2.00, 1.00),
('DE', 'Europe/Busingen', 1.00, 2.00, 1.00),
('DJ', 'Africa/Djibouti', 3.00, 3.00, 3.00),
('DK', 'Europe/Copenhagen', 1.00, 2.00, 1.00),
('DM', 'America/Dominica', -4.00, -4.00, -4.00),
('DO', 'America/Santo_Domingo', -4.00, -4.00, -4.00),
('DZ', 'Africa/Algiers', 1.00, 1.00, 1.00),
('EC', 'America/Guayaquil', -5.00, -5.00, -5.00),
('EC', 'Pacific/Galapagos', -6.00, -6.00, -6.00),
('EE', 'Europe/Tallinn', 2.00, 3.00, 2.00),
('EG', 'Africa/Cairo', 2.00, 2.00, 2.00),
('EH', 'Africa/El_Aaiun', 0.00, 0.00, 0.00),
('ER', 'Africa/Asmara', 3.00, 3.00, 3.00),
('ES', 'Africa/Ceuta', 1.00, 2.00, 1.00),
('ES', 'Atlantic/Canary', 0.00, 1.00, 0.00),
('ES', 'Europe/Madrid', 1.00, 2.00, 1.00),
('ET', 'Africa/Addis_Ababa', 3.00, 3.00, 3.00),
('FI', 'Europe/Helsinki', 2.00, 3.00, 2.00),
('FJ', 'Pacific/Fiji', 13.00, 12.00, 12.00),
('FK', 'Atlantic/Stanley', -3.00, -3.00, -3.00),
('FM', 'Pacific/Chuuk', 10.00, 10.00, 10.00),
('FM', 'Pacific/Kosrae', 11.00, 11.00, 11.00),
('FM', 'Pacific/Pohnpei', 11.00, 11.00, 11.00),
('FO', 'Atlantic/Faroe', 0.00, 1.00, 0.00),
('FR', 'Europe/Paris', 1.00, 2.00, 1.00),
('GA', 'Africa/Libreville', 1.00, 1.00, 1.00),
('GB', 'Europe/London', 0.00, 1.00, 0.00),
('GD', 'America/Grenada', -4.00, -4.00, -4.00),
('GE', 'Asia/Tbilisi', 4.00, 4.00, 4.00),
('GF', 'America/Cayenne', -3.00, -3.00, -3.00),
('GG', 'Europe/Guernsey', 0.00, 1.00, 0.00),
('GH', 'Africa/Accra', 0.00, 0.00, 0.00),
('GI', 'Europe/Gibraltar', 1.00, 2.00, 1.00),
('GL', 'America/Danmarkshavn', 0.00, 0.00, 0.00),
('GL', 'America/Godthab', -3.00, -2.00, -3.00),
('GL', 'America/Scoresbysund', -1.00, 0.00, -1.00),
('GL', 'America/Thule', -4.00, -3.00, -4.00),
('GM', 'Africa/Banjul', 0.00, 0.00, 0.00),
('GN', 'Africa/Conakry', 0.00, 0.00, 0.00),
('GP', 'America/Guadeloupe', -4.00, -4.00, -4.00),
('GQ', 'Africa/Malabo', 1.00, 1.00, 1.00),
('GR', 'Europe/Athens', 2.00, 3.00, 2.00),
('GS', 'Atlantic/South_Georgia', -2.00, -2.00, -2.00),
('GT', 'America/Guatemala', -6.00, -6.00, -6.00),
('GU', 'Pacific/Guam', 10.00, 10.00, 10.00),
('GW', 'Africa/Bissau', 0.00, 0.00, 0.00),
('GY', 'America/Guyana', -4.00, -4.00, -4.00),
('HK', 'Asia/Hong_Kong', 8.00, 8.00, 8.00),
('HN', 'America/Tegucigalpa', -6.00, -6.00, -6.00),
('HR', 'Europe/Zagreb', 1.00, 2.00, 1.00),
('HT', 'America/Port-au-Prince', -5.00, -4.00, -5.00),
('HU', 'Europe/Budapest', 1.00, 2.00, 1.00),
('ID', 'Asia/Jakarta', 7.00, 7.00, 7.00),
('ID', 'Asia/Jayapura', 9.00, 9.00, 9.00),
('ID', 'Asia/Makassar', 8.00, 8.00, 8.00),
('ID', 'Asia/Pontianak', 7.00, 7.00, 7.00),
('IE', 'Europe/Dublin', 0.00, 1.00, 0.00),
('IL', 'Asia/Jerusalem', 2.00, 3.00, 2.00),
('IM', 'Europe/Isle_of_Man', 0.00, 1.00, 0.00),
('IN', 'Asia/Kolkata', 5.50, 5.50, 5.50),
('IO', 'Indian/Chagos', 6.00, 6.00, 6.00),
('IQ', 'Asia/Baghdad', 3.00, 3.00, 3.00),
('IR', 'Asia/Tehran', 3.50, 4.50, 3.50),
('IS', 'Atlantic/Reykjavik', 0.00, 0.00, 0.00),
('IT', 'Europe/Rome', 1.00, 2.00, 1.00),
('JE', 'Europe/Jersey', 0.00, 1.00, 0.00),
('JM', 'America/Jamaica', -5.00, -5.00, -5.00),
('JO', 'Asia/Amman', 2.00, 3.00, 2.00),
('JP', 'Asia/Tokyo', 9.00, 9.00, 9.00),
('KE', 'Africa/Nairobi', 3.00, 3.00, 3.00),
('KG', 'Asia/Bishkek', 6.00, 6.00, 6.00),
('KH', 'Asia/Phnom_Penh', 7.00, 7.00, 7.00),
('KI', 'Pacific/Enderbury', 13.00, 13.00, 13.00),
('KI', 'Pacific/Kiritimati', 14.00, 14.00, 14.00),
('KI', 'Pacific/Tarawa', 12.00, 12.00, 12.00),
('KM', 'Indian/Comoro', 3.00, 3.00, 3.00),
('KN', 'America/St_Kitts', -4.00, -4.00, -4.00),
('KP', 'Asia/Pyongyang', 9.00, 9.00, 9.00),
('KR', 'Asia/Seoul', 9.00, 9.00, 9.00),
('KW', 'Asia/Kuwait', 3.00, 3.00, 3.00),
('KY', 'America/Cayman', -5.00, -5.00, -5.00),
('KZ', 'Asia/Almaty', 6.00, 6.00, 6.00),
('KZ', 'Asia/Aqtau', 5.00, 5.00, 5.00),
('KZ', 'Asia/Aqtobe', 5.00, 5.00, 5.00),
('KZ', 'Asia/Oral', 5.00, 5.00, 5.00),
('KZ', 'Asia/Qyzylorda', 6.00, 6.00, 6.00),
('LA', 'Asia/Vientiane', 7.00, 7.00, 7.00),
('LB', 'Asia/Beirut', 2.00, 3.00, 2.00),
('LC', 'America/St_Lucia', -4.00, -4.00, -4.00),
('LI', 'Europe/Vaduz', 1.00, 2.00, 1.00),
('LK', 'Asia/Colombo', 5.50, 5.50, 5.50),
('LR', 'Africa/Monrovia', 0.00, 0.00, 0.00),
('LS', 'Africa/Maseru', 2.00, 2.00, 2.00),
('LT', 'Europe/Vilnius', 2.00, 3.00, 2.00),
('LU', 'Europe/Luxembourg', 1.00, 2.00, 1.00),
('LV', 'Europe/Riga', 2.00, 3.00, 2.00),
('LY', 'Africa/Tripoli', 2.00, 2.00, 2.00),
('MA', 'Africa/Casablanca', 0.00, 0.00, 0.00),
('MC', 'Europe/Monaco', 1.00, 2.00, 1.00),
('MD', 'Europe/Chisinau', 2.00, 3.00, 2.00),
('ME', 'Europe/Podgorica', 1.00, 2.00, 1.00),
('MF', 'America/Marigot', -4.00, -4.00, -4.00),
('MG', 'Indian/Antananarivo', 3.00, 3.00, 3.00),
('MH', 'Pacific/Kwajalein', 12.00, 12.00, 12.00),
('MH', 'Pacific/Majuro', 12.00, 12.00, 12.00),
('MK', 'Europe/Skopje', 1.00, 2.00, 1.00),
('ML', 'Africa/Bamako', 0.00, 0.00, 0.00),
('MM', 'Asia/Rangoon', 6.50, 6.50, 6.50),
('MN', 'Asia/Choibalsan', 8.00, 8.00, 8.00),
('MN', 'Asia/Hovd', 7.00, 7.00, 7.00),
('MN', 'Asia/Ulaanbaatar', 8.00, 8.00, 8.00),
('MO', 'Asia/Macau', 8.00, 8.00, 8.00),
('MP', 'Pacific/Saipan', 10.00, 10.00, 10.00),
('MQ', 'America/Martinique', -4.00, -4.00, -4.00),
('MR', 'Africa/Nouakchott', 0.00, 0.00, 0.00),
('MS', 'America/Montserrat', -4.00, -4.00, -4.00),
('MT', 'Europe/Malta', 1.00, 2.00, 1.00),
('MU', 'Indian/Mauritius', 4.00, 4.00, 4.00),
('MV', 'Indian/Maldives', 5.00, 5.00, 5.00),
('MW', 'Africa/Blantyre', 2.00, 2.00, 2.00),
('MX', 'America/Bahia_Banderas', -6.00, -5.00, -6.00),
('MX', 'America/Cancun', -6.00, -5.00, -6.00),
('MX', 'America/Chihuahua', -7.00, -6.00, -7.00),
('MX', 'America/Hermosillo', -7.00, -7.00, -7.00),
('MX', 'America/Matamoros', -6.00, -5.00, -6.00),
('MX', 'America/Mazatlan', -7.00, -6.00, -7.00),
('MX', 'America/Merida', -6.00, -5.00, -6.00),
('MX', 'America/Mexico_City', -6.00, -5.00, -6.00),
('MX', 'America/Monterrey', -6.00, -5.00, -6.00),
('MX', 'America/Ojinaga', -7.00, -6.00, -7.00),
('MX', 'America/Santa_Isabel', -8.00, -7.00, -8.00),
('MX', 'America/Tijuana', -8.00, -7.00, -8.00),
('MY', 'Asia/Kuala_Lumpur', 8.00, 8.00, 8.00),
('MY', 'Asia/Kuching', 8.00, 8.00, 8.00),
('MZ', 'Africa/Maputo', 2.00, 2.00, 2.00),
('NA', 'Africa/Windhoek', 2.00, 1.00, 1.00),
('NC', 'Pacific/Noumea', 11.00, 11.00, 11.00),
('NE', 'Africa/Niamey', 1.00, 1.00, 1.00),
('NF', 'Pacific/Norfolk', 11.50, 11.50, 11.50),
('NG', 'Africa/Lagos', 1.00, 1.00, 1.00),
('NI', 'America/Managua', -6.00, -6.00, -6.00),
('NL', 'Europe/Amsterdam', 1.00, 2.00, 1.00),
('NO', 'Europe/Oslo', 1.00, 2.00, 1.00),
('NP', 'Asia/Kathmandu', 5.75, 5.75, 5.75),
('NR', 'Pacific/Nauru', 12.00, 12.00, 12.00),
('NU', 'Pacific/Niue', -11.00, -11.00, -11.00),
('NZ', 'Pacific/Auckland', 13.00, 12.00, 12.00),
('NZ', 'Pacific/Chatham', 13.75, 12.75, 12.75),
('OM', 'Asia/Muscat', 4.00, 4.00, 4.00),
('PA', 'America/Panama', -5.00, -5.00, -5.00),
('PE', 'America/Lima', -5.00, -5.00, -5.00),
('PF', 'Pacific/Gambier', -9.00, -9.00, -9.00),
('PF', 'Pacific/Marquesas', -9.50, -9.50, -9.50),
('PF', 'Pacific/Tahiti', -10.00, -10.00, -10.00),
('PG', 'Pacific/Port_Moresby', 10.00, 10.00, 10.00),
('PH', 'Asia/Manila', 8.00, 8.00, 8.00),
('PK', 'Asia/Karachi', 5.00, 5.00, 5.00),
('PL', 'Europe/Warsaw', 1.00, 2.00, 1.00),
('PM', 'America/Miquelon', -3.00, -2.00, -3.00),
('PN', 'Pacific/Pitcairn', -8.00, -8.00, -8.00),
('PR', 'America/Puerto_Rico', -4.00, -4.00, -4.00),
('PS', 'Asia/Gaza', 2.00, 3.00, 2.00),
('PS', 'Asia/Hebron', 2.00, 3.00, 2.00),
('PT', 'Atlantic/Azores', -1.00, 0.00, -1.00),
('PT', 'Atlantic/Madeira', 0.00, 1.00, 0.00),
('PT', 'Europe/Lisbon', 0.00, 1.00, 0.00),
('PW', 'Pacific/Palau', 9.00, 9.00, 9.00),
('PY', 'America/Asuncion', -3.00, -4.00, -4.00),
('QA', 'Asia/Qatar', 3.00, 3.00, 3.00),
('RE', 'Indian/Reunion', 4.00, 4.00, 4.00),
('RO', 'Europe/Bucharest', 2.00, 3.00, 2.00),
('RS', 'Europe/Belgrade', 1.00, 2.00, 1.00),
('RU', 'Asia/Anadyr', 12.00, 12.00, 12.00),
('RU', 'Asia/Irkutsk', 9.00, 9.00, 9.00),
('RU', 'Asia/Kamchatka', 12.00, 12.00, 12.00),
('RU', 'Asia/Khandyga', 10.00, 10.00, 10.00),
('RU', 'Asia/Krasnoyarsk', 8.00, 8.00, 8.00),
('RU', 'Asia/Magadan', 12.00, 12.00, 12.00),
('RU', 'Asia/Novokuznetsk', 7.00, 7.00, 7.00),
('RU', 'Asia/Novosibirsk', 7.00, 7.00, 7.00),
('RU', 'Asia/Omsk', 7.00, 7.00, 7.00),
('RU', 'Asia/Sakhalin', 11.00, 11.00, 11.00),
('RU', 'Asia/Ust-Nera', 11.00, 11.00, 11.00),
('RU', 'Asia/Vladivostok', 11.00, 11.00, 11.00),
('RU', 'Asia/Yakutsk', 10.00, 10.00, 10.00),
('RU', 'Asia/Yekaterinburg', 6.00, 6.00, 6.00),
('RU', 'Europe/Kaliningrad', 3.00, 3.00, 3.00),
('RU', 'Europe/Moscow', 4.00, 4.00, 4.00),
('RU', 'Europe/Samara', 4.00, 4.00, 4.00),
('RU', 'Europe/Volgograd', 4.00, 4.00, 4.00),
('RW', 'Africa/Kigali', 2.00, 2.00, 2.00),
('SA', 'Asia/Riyadh', 3.00, 3.00, 3.00),
('SB', 'Pacific/Guadalcanal', 11.00, 11.00, 11.00),
('SC', 'Indian/Mahe', 4.00, 4.00, 4.00),
('SD', 'Africa/Khartoum', 3.00, 3.00, 3.00),
('SE', 'Europe/Stockholm', 1.00, 2.00, 1.00),
('SG', 'Asia/Singapore', 8.00, 8.00, 8.00),
('SH', 'Atlantic/St_Helena', 0.00, 0.00, 0.00),
('SI', 'Europe/Ljubljana', 1.00, 2.00, 1.00),
('SJ', 'Arctic/Longyearbyen', 1.00, 2.00, 1.00),
('SK', 'Europe/Bratislava', 1.00, 2.00, 1.00),
('SL', 'Africa/Freetown', 0.00, 0.00, 0.00),
('SM', 'Europe/San_Marino', 1.00, 2.00, 1.00),
('SN', 'Africa/Dakar', 0.00, 0.00, 0.00),
('SO', 'Africa/Mogadishu', 3.00, 3.00, 3.00),
('SR', 'America/Paramaribo', -3.00, -3.00, -3.00),
('SS', 'Africa/Juba', 3.00, 3.00, 3.00),
('ST', 'Africa/Sao_Tome', 0.00, 0.00, 0.00),
('SV', 'America/El_Salvador', -6.00, -6.00, -6.00),
('SX', 'America/Lower_Princes', -4.00, -4.00, -4.00),
('SY', 'Asia/Damascus', 2.00, 3.00, 2.00),
('SZ', 'Africa/Mbabane', 2.00, 2.00, 2.00),
('TC', 'America/Grand_Turk', -5.00, -4.00, -5.00),
('TD', 'Africa/Ndjamena', 1.00, 1.00, 1.00),
('TF', 'Indian/Kerguelen', 5.00, 5.00, 5.00),
('TG', 'Africa/Lome', 0.00, 0.00, 0.00),
('TH', 'Asia/Bangkok', 7.00, 7.00, 7.00),
('TJ', 'Asia/Dushanbe', 5.00, 5.00, 5.00),
('TK', 'Pacific/Fakaofo', 13.00, 13.00, 13.00),
('TL', 'Asia/Dili', 9.00, 9.00, 9.00),
('TM', 'Asia/Ashgabat', 5.00, 5.00, 5.00),
('TN', 'Africa/Tunis', 1.00, 1.00, 1.00),
('TO', 'Pacific/Tongatapu', 13.00, 13.00, 13.00),
('TR', 'Europe/Istanbul', 2.00, 3.00, 2.00),
('TT', 'America/Port_of_Spain', -4.00, -4.00, -4.00),
('TV', 'Pacific/Funafuti', 12.00, 12.00, 12.00),
('TW', 'Asia/Taipei', 8.00, 8.00, 8.00),
('TZ', 'Africa/Dar_es_Salaam', 3.00, 3.00, 3.00),
('UA', 'Europe/Kiev', 2.00, 3.00, 2.00),
('UA', 'Europe/Simferopol', 2.00, 4.00, 4.00),
('UA', 'Europe/Uzhgorod', 2.00, 3.00, 2.00),
('UA', 'Europe/Zaporozhye', 2.00, 3.00, 2.00),
('UG', 'Africa/Kampala', 3.00, 3.00, 3.00),
('UM', 'Pacific/Johnston', -10.00, -10.00, -10.00),
('UM', 'Pacific/Midway', -11.00, -11.00, -11.00),
('UM', 'Pacific/Wake', 12.00, 12.00, 12.00),
('US', 'America/Adak', -10.00, -9.00, -10.00),
('US', 'America/Anchorage', -9.00, -8.00, -9.00),
('US', 'America/Boise', -7.00, -6.00, -7.00),
('US', 'America/Chicago', -6.00, -5.00, -6.00),
('US', 'America/Denver', -7.00, -6.00, -7.00),
('US', 'America/Detroit', -5.00, -4.00, -5.00),
('US', 'America/Indiana/Indianapolis', -5.00, -4.00, -5.00),
('US', 'America/Indiana/Knox', -6.00, -5.00, -6.00),
('US', 'America/Indiana/Marengo', -5.00, -4.00, -5.00),
('US', 'America/Indiana/Petersburg', -5.00, -4.00, -5.00),
('US', 'America/Indiana/Tell_City', -6.00, -5.00, -6.00),
('US', 'America/Indiana/Vevay', -5.00, -4.00, -5.00),
('US', 'America/Indiana/Vincennes', -5.00, -4.00, -5.00),
('US', 'America/Indiana/Winamac', -5.00, -4.00, -5.00),
('US', 'America/Juneau', -9.00, -8.00, -9.00),
('US', 'America/Kentucky/Louisville', -5.00, -4.00, -5.00),
('US', 'America/Kentucky/Monticello', -5.00, -4.00, -5.00),
('US', 'America/Los_Angeles', -8.00, -7.00, -8.00),
('US', 'America/Menominee', -6.00, -5.00, -6.00),
('US', 'America/Metlakatla', -8.00, -8.00, -8.00),
('US', 'America/New_York', -5.00, -4.00, -5.00),
('US', 'America/Nome', -9.00, -8.00, -9.00),
('US', 'America/North_Dakota/Beulah', -6.00, -5.00, -6.00),
('US', 'America/North_Dakota/Center', -6.00, -5.00, -6.00),
('US', 'America/North_Dakota/New_Salem', -6.00, -5.00, -6.00),
('US', 'America/Phoenix', -7.00, -7.00, -7.00),
('US', 'America/Shiprock', -7.00, -6.00, -7.00),
('US', 'America/Sitka', -9.00, -8.00, -9.00),
('US', 'America/Yakutat', -9.00, -8.00, -9.00),
('US', 'Pacific/Honolulu', -10.00, -10.00, -10.00),
('UY', 'America/Montevideo', -2.00, -3.00, -3.00),
('UZ', 'Asia/Samarkand', 5.00, 5.00, 5.00),
('UZ', 'Asia/Tashkent', 5.00, 5.00, 5.00),
('VA', 'Europe/Vatican', 1.00, 2.00, 1.00),
('VC', 'America/St_Vincent', -4.00, -4.00, -4.00),
('VE', 'America/Caracas', -4.50, -4.50, -4.50),
('VG', 'America/Tortola', -4.00, -4.00, -4.00),
('VI', 'America/St_Thomas', -4.00, -4.00, -4.00),
('VN', 'Asia/Ho_Chi_Minh', 7.00, 7.00, 7.00),
('VU', 'Pacific/Efate', 11.00, 11.00, 11.00),
('WF', 'Pacific/Wallis', 12.00, 12.00, 12.00),
('WS', 'Pacific/Apia', 14.00, 13.00, 13.00),
('YE', 'Asia/Aden', 3.00, 3.00, 3.00),
('YT', 'Indian/Mayotte', 3.00, 3.00, 3.00),
('ZA', 'Africa/Johannesburg', 2.00, 2.00, 2.00),
('ZM', 'Africa/Lusaka', 2.00, 2.00, 2.00),
('ZW', 'Africa/Harare', 2.00, 2.00, 2.00);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 -> banned or deactive, 1 -> active',
  `verification_token` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `provider` varchar(20) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `provider_id` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `zip_code` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_username_unique` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

DROP TABLE IF EXISTS `vendors`;
CREATE TABLE IF NOT EXISTS `vendors` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `photo` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `to_mail` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `username` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `amount` double(8,2) DEFAULT 0.00,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `avg_rating` float(8,2) NOT NULL DEFAULT 0.00,
  `show_email_addresss` tinyint(4) NOT NULL DEFAULT 1,
  `show_phone_number` tinyint(4) NOT NULL DEFAULT 1,
  `show_contact_form` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`id`, `photo`, `email`, `to_mail`, `phone`, `username`, `password`, `status`, `amount`, `email_verified_at`, `avg_rating`, `show_email_addresss`, `show_phone_number`, `show_contact_form`, `created_at`, `updated_at`) VALUES
(1, NULL, 'admin@example.com', NULL, NULL, '123123', '$2y$10$DD0N5CERY60mB5J9M234gO4n4MiCqBeVqrLJCWFgPAlX91/1cuM96', 1, 0.00, '2025-02-25 01:10:32', 0.00, 1, 1, 1, '2024-08-15 01:18:10', '2025-02-25 01:10:32'),
(2, NULL, 'sangeetha2311992@gmail.com', NULL, NULL, 'sangeetha', '$2y$10$KV0wP0iWq5MybJ6w4.PWUOOmVkVe2fzbVghGcyIM6th./vfjWs60i', 1, 0.00, '2025-02-25 01:30:28', 0.00, 1, 1, 1, '2025-02-25 01:30:28', '2025-02-25 01:30:28');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_infos`
--

DROP TABLE IF EXISTS `vendor_infos`;
CREATE TABLE IF NOT EXISTS `vendor_infos` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `vendor_id` bigint(20) DEFAULT NULL,
  `language_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `zip_code` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `address` longtext COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `details` longtext COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `vendor_infos`
--

INSERT INTO `vendor_infos` (`id`, `vendor_id`, `language_id`, `name`, `country`, `city`, `state`, `zip_code`, `address`, `details`, `created_at`, `updated_at`) VALUES
(1, 1, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-08-15 01:18:10', '2024-08-15 01:18:10'),
(2, 2, 20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-02-25 01:30:29', '2025-02-25 01:30:29');

-- --------------------------------------------------------

--
-- Table structure for table `video_sections`
--

DROP TABLE IF EXISTS `video_sections`;
CREATE TABLE IF NOT EXISTS `video_sections` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) DEFAULT NULL,
  `subtitle` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `video_sections`
--

INSERT INTO `video_sections` (`id`, `language_id`, `subtitle`, `title`, `video_url`, `button_name`, `button_url`, `created_at`, `updated_at`) VALUES
(1, 20, 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusa ntium doloremque.  Start From: $200.00', 'Explore Your Favorite Restaurant Listsss', 'https://www.youtube.com/watch?v=QSwvg9Rv2EI', 'Browse moreee', 'https://www.example.com', '2023-12-12 23:15:10', '2024-05-15 02:17:32');

-- --------------------------------------------------------

--
-- Table structure for table `visitors`
--

DROP TABLE IF EXISTS `visitors`;
CREATE TABLE IF NOT EXISTS `visitors` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `listing_id` bigint(20) DEFAULT NULL,
  `vendor_id` bigint(20) DEFAULT NULL,
  `ip_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `visitors`
--

INSERT INTO `visitors` (`id`, `listing_id`, `vendor_id`, `ip_address`, `date`, `created_at`, `updated_at`) VALUES
(1, 2, 1, '127.0.0.1', '2025-03-04', '2025-03-04 03:19:52', '2025-03-04 03:19:52'),
(2, 2, 1, '127.0.0.1', '2025-03-07', '2025-03-07 05:29:19', '2025-03-07 05:29:19');

-- --------------------------------------------------------

--
-- Table structure for table `wishlists`
--

DROP TABLE IF EXISTS `wishlists`;
CREATE TABLE IF NOT EXISTS `wishlists` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `listing_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `work_processes`
--

DROP TABLE IF EXISTS `work_processes`;
CREATE TABLE IF NOT EXISTS `work_processes` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `icon` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci NOT NULL,
  `text` text COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `work_process_sections`
--

DROP TABLE IF EXISTS `work_process_sections`;
CREATE TABLE IF NOT EXISTS `work_process_sections` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` bigint(20) UNSIGNED NOT NULL,
  `button_text` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `work_process_sections`
--

INSERT INTO `work_process_sections` (`id`, `language_id`, `button_text`, `title`, `created_at`, `updated_at`) VALUES
(3, 20, 'Details', 'How It Worksz', '2023-08-19 04:05:15', '2023-10-19 00:16:59');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `admins_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `role_permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD CONSTRAINT `blog_categories_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `blog_informations`
--
ALTER TABLE `blog_informations`
  ADD CONSTRAINT `blog_informations_blog_category_id_foreign` FOREIGN KEY (`blog_category_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `blog_informations_blog_id_foreign` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `blog_informations_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cookie_alerts`
--
ALTER TABLE `cookie_alerts`
  ADD CONSTRAINT `cookie_alerts_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `faqs`
--
ALTER TABLE `faqs`
  ADD CONSTRAINT `faqs_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `footer_contents`
--
ALTER TABLE `footer_contents`
  ADD CONSTRAINT `footer_texts_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `page_contents`
--
ALTER TABLE `page_contents`
  ADD CONSTRAINT `page_contents_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `page_contents_page_id_foreign` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `popups`
--
ALTER TABLE `popups`
  ADD CONSTRAINT `popups_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD CONSTRAINT `product_categories_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_contents`
--
ALTER TABLE `product_contents`
  ADD CONSTRAINT `product_contents_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_contents_product_category_id_foreign` FOREIGN KEY (`product_category_id`) REFERENCES `product_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_contents_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_orders`
--
ALTER TABLE `product_orders`
  ADD CONSTRAINT `product_orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_purchase_items`
--
ALTER TABLE `product_purchase_items`
  ADD CONSTRAINT `product_purchase_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_purchase_items_product_order_id_foreign` FOREIGN KEY (`product_order_id`) REFERENCES `product_orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_reviews`
--
ALTER TABLE `product_reviews`
  ADD CONSTRAINT `product_reviews_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_reviews_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_shipping_charges`
--
ALTER TABLE `product_shipping_charges`
  ADD CONSTRAINT `shipping_charges_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `quick_links`
--
ALTER TABLE `quick_links`
  ADD CONSTRAINT `quick_links_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `seos`
--
ALTER TABLE `seos`
  ADD CONSTRAINT `seos_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
