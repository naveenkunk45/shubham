-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 25, 2024 at 06:34 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bulistio_main_file`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED DEFAULT NULL,
  `first_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `show_email_address` int DEFAULT '0',
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `show_phone_number` int NOT NULL DEFAULT '0',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `address` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `details` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `role_id`, `first_name`, `last_name`, `image`, `username`, `email`, `show_email_address`, `phone`, `show_phone_number`, `password`, `address`, `details`, `status`, `created_at`, `updated_at`) VALUES
(1, NULL, 'leo', 'Bourne', '65c20e674bd34.png', 'admin', '123@example.com', 1, '12345678', 1, '$2y$10$7rcuMv8LG9adF09JnRjt.O35YL/3dkFWA7EBhBT.LOZvS07OaeDFm', 'House no 3, Road 5/c, sector 11, Uttara, Dhaka, Bangladesh', 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Molestiae blanditiis minus tempora quibusdam quas quo magni, repellat sit? Adipisci accusantium quasi autem tempora nemo aspernatur tenetur repellat numquam sed cupiditate.', 1, NULL, '2024-05-15 02:09:24');

-- --------------------------------------------------------

--
-- Table structure for table `advertisements`
--

CREATE TABLE `advertisements` (
  `id` bigint UNSIGNED NOT NULL,
  `ad_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `resolution_type` smallint UNSIGNED NOT NULL COMMENT '1 => 300 x 250, 2 => 300 x 600, 3 => 728 x 90',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `slot` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `views` int UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `aminites`
--

CREATE TABLE `aminites` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `basic_settings`
--

CREATE TABLE `basic_settings` (
  `id` bigint UNSIGNED NOT NULL,
  `uniqid` int UNSIGNED NOT NULL DEFAULT '12345',
  `favicon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `logo_two` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `website_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `contact_number` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `theme_version` smallint UNSIGNED NOT NULL,
  `base_currency_symbol` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `base_currency_symbol_position` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `base_currency_text` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `base_currency_text_position` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `base_currency_rate` decimal(8,2) DEFAULT NULL,
  `primary_color` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `smtp_status` tinyint DEFAULT NULL,
  `smtp_host` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `smtp_port` int DEFAULT NULL,
  `encryption` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `smtp_username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `smtp_password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `from_mail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `from_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `to_mail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `breadcrumb` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `disqus_status` tinyint UNSIGNED DEFAULT NULL,
  `disqus_short_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_recaptcha_status` tinyint DEFAULT NULL,
  `google_recaptcha_site_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_recaptcha_secret_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `whatsapp_status` tinyint UNSIGNED DEFAULT NULL,
  `whatsapp_number` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `whatsapp_header_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `whatsapp_popup_status` tinyint UNSIGNED DEFAULT NULL,
  `whatsapp_popup_message` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `maintenance_img` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `maintenance_status` tinyint DEFAULT NULL,
  `maintenance_msg` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `bypass_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `footer_logo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `footer_background_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `admin_theme_version` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'light',
  `notification_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `counter_section_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `call_to_action_section_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `call_to_action_section_highlight_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `video_section_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `testimonial_section_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `category_section_background` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_adsense_publisher_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `equipment_tax_amount` decimal(5,2) UNSIGNED DEFAULT NULL,
  `product_tax_amount` decimal(5,2) UNSIGNED DEFAULT NULL,
  `self_pickup_status` tinyint UNSIGNED DEFAULT NULL,
  `two_way_delivery_status` tinyint UNSIGNED DEFAULT NULL,
  `guest_checkout_status` tinyint UNSIGNED NOT NULL,
  `shop_status` int DEFAULT '1',
  `admin_approve_status` int NOT NULL DEFAULT '0',
  `listing_view` int DEFAULT NULL,
  `facebook_login_status` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '1 -> enable, 0 -> disable',
  `facebook_app_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `facebook_app_secret` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_login_status` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '1 -> enable, 0 -> disable',
  `google_client_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `google_client_secret` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `tawkto_status` tinyint UNSIGNED NOT NULL COMMENT '1 -> enable, 0 -> disable',
  `hero_section_background_img` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `tawkto_direct_chat_link` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `vendor_admin_approval` int NOT NULL DEFAULT '0' COMMENT '1 active, 2 deactive',
  `vendor_email_verification` int NOT NULL DEFAULT '0' COMMENT '1 active, 2 deactive',
  `admin_approval_notice` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `expiration_reminder` int DEFAULT '3',
  `timezone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `hero_section_video_url` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `contact_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `contact_subtile` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `contact_details` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `latitude` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `longitude` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `preloader_status` int DEFAULT '1',
  `preloader` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `basic_settings`
--

INSERT INTO `basic_settings` (`id`, `uniqid`, `favicon`, `logo`, `logo_two`, `website_title`, `email_address`, `contact_number`, `address`, `theme_version`, `base_currency_symbol`, `base_currency_symbol_position`, `base_currency_text`, `base_currency_text_position`, `base_currency_rate`, `primary_color`, `smtp_status`, `smtp_host`, `smtp_port`, `encryption`, `smtp_username`, `smtp_password`, `from_mail`, `from_name`, `to_mail`, `breadcrumb`, `disqus_status`, `disqus_short_name`, `google_recaptcha_status`, `google_recaptcha_site_key`, `google_recaptcha_secret_key`, `whatsapp_status`, `whatsapp_number`, `whatsapp_header_title`, `whatsapp_popup_status`, `whatsapp_popup_message`, `maintenance_img`, `maintenance_status`, `maintenance_msg`, `bypass_token`, `footer_logo`, `footer_background_image`, `admin_theme_version`, `notification_image`, `counter_section_image`, `call_to_action_section_image`, `call_to_action_section_highlight_image`, `video_section_image`, `testimonial_section_image`, `category_section_background`, `google_adsense_publisher_id`, `equipment_tax_amount`, `product_tax_amount`, `self_pickup_status`, `two_way_delivery_status`, `guest_checkout_status`, `shop_status`, `admin_approve_status`, `listing_view`, `facebook_login_status`, `facebook_app_id`, `facebook_app_secret`, `google_login_status`, `google_client_id`, `google_client_secret`, `tawkto_status`, `hero_section_background_img`, `tawkto_direct_chat_link`, `vendor_admin_approval`, `vendor_email_verification`, `admin_approval_notice`, `expiration_reminder`, `timezone`, `hero_section_video_url`, `contact_title`, `contact_subtile`, `contact_details`, `latitude`, `longitude`, `preloader_status`, `preloader`, `updated_at`) VALUES
(2, 12345, '6631b1ad22bf4.png', '65b9bb8f98dd7.png', '64ed7071b1844.png', 'Bulistio', 'bulistio@example.com', '+701 - 1111 - 2222 - 333', '450 Young Road, New York, USA', 1, '$', 'left', 'USD', 'left', 1.00, 'C493C5', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '65c200e4ea394.png', 0, NULL, 0, NULL, NULL, 0, NULL, NULL, 0, NULL, '1632725312.png', 0, 'We are upgrading our site. We will come back soon. \r\nPlease stay with us.\r\nThank you.', 'fahad', '6593ab335bdcc.png', '638db9bf3f92a.jpg', 'light', '619b7d5e5e9df.png', '6530b4b2c6984.jpg', '663cb8ff44ba5.jpg', '663cb8e3a578e.png', '663efcc6ce380.jpg', '657a7500bb6c1.jpg', '63c92601cb853.jpg', 'dvf', 5.00, 5.00, 1, 1, 0, 1, 1, 0, 0, NULL, NULL, 0, NULL, NULL, 0, '664b03706cf4a.png', '', 1, 1, 'Your account is deactive or pending now. Please Contact with admin!', 3, 'Asia/Dhaka', 'https://www.youtube.com/watch?v=9l6RywtDlKA', 'Get Connected', 'How Can We Help You?', 'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores pariatur a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat veritatis architecto. Aliquid doloremque nesciunt nobis, debitis, quas veniam.\r\n\r\nLorem ipsum, dolor sit amet consectetur adipisicing elit. Maiores a ea similique quod dicta ipsa vel quidem repellendus, beatae nulla veniam, quaerat.', '23.8587', '90.4001', 1, '65e7f2608a3c1.gif', '2023-08-24 00:02:42');

-- --------------------------------------------------------

--
-- Table structure for table `blogs`
--

CREATE TABLE `blogs` (
  `id` bigint UNSIGNED NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` mediumint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_categories`
--

CREATE TABLE `blog_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED NOT NULL,
  `serial_number` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_informations`
--

CREATE TABLE `blog_informations` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `blog_category_id` bigint UNSIGNED NOT NULL,
  `blog_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `author` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` blob NOT NULL,
  `meta_keywords` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_sections`
--

CREATE TABLE `blog_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `button_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `blog_sections`
--

INSERT INTO `blog_sections` (`id`, `language_id`, `button_text`, `title`, `created_at`, `updated_at`) VALUES
(5, 20, 'Mores', 'Read our latest blogs', '2023-08-19 00:44:01', '2023-12-13 21:29:05');

-- --------------------------------------------------------

--
-- Table structure for table `business_hours`
--

CREATE TABLE `business_hours` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `day` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `holiday` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `call_to_action_sections`
--

CREATE TABLE `call_to_action_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `subtitle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `video_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `button_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `button_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `call_to_action_sections`
--

INSERT INTO `call_to_action_sections` (`id`, `language_id`, `subtitle`, `title`, `text`, `video_url`, `button_name`, `button_url`, `created_at`, `updated_at`) VALUES
(4, 20, 'pe earum totam minima aperiam repellendus possimus molestias optio sapiente, quam               repudiandae voluptatum accusantium.', 'Explore Your Favorite business with usWith Us', 'We highly recommend Carlist. We\'ve used them several times and have always been impressed with their excellent and awesome service.', NULL, 'Register Now', 'https://www.example.com', '2023-08-28 02:47:29', '2024-05-15 02:15:46');

-- --------------------------------------------------------

--
-- Table structure for table `category_sections`
--

CREATE TABLE `category_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `subtitle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `button_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `category_sections`
--

INSERT INTO `category_sections` (`id`, `language_id`, `title`, `subtitle`, `text`, `button_text`, `created_at`, `updated_at`) VALUES
(3, '20', 'Explore  Categories', NULL, '', 'Explore', '2023-08-19 00:11:48', '2024-04-30 22:23:14');

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `country_id` bigint DEFAULT NULL,
  `feature_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int DEFAULT NULL,
  `type` tinyint DEFAULT NULL COMMENT '1=user, 2=admin, 3=vendor',
  `support_ticket_id` int DEFAULT NULL,
  `reply` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `file` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `cookie_alerts`
--

CREATE TABLE `cookie_alerts` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `cookie_alert_status` tinyint UNSIGNED NOT NULL,
  `cookie_alert_btn_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `cookie_alert_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `cookie_alerts`
--

INSERT INTO `cookie_alerts` (`id`, `language_id`, `cookie_alert_status`, `cookie_alert_btn_text`, `cookie_alert_text`, `created_at`, `updated_at`) VALUES
(3, 20, 0, 'I Agree', 'We use cookies to give you the best online experience.\r\nBy continuing to browse the site you are agreeing to our use of cookies.', '2023-08-29 02:35:44', '2024-01-31 21:05:04');

-- --------------------------------------------------------

--
-- Table structure for table `counter_informations`
--

CREATE TABLE `counter_informations` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `amount` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `counter_sections`
--

CREATE TABLE `counter_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` int DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `subtitle` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `counter_sections`
--

INSERT INTO `counter_sections` (`id`, `language_id`, `title`, `subtitle`, `created_at`, `updated_at`) VALUES
(3, 20, 'See Our Achievement', NULL, '2023-08-19 00:38:24', '2023-11-04 02:33:22');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `question` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `answer` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `featured_listing_charges`
--

CREATE TABLE `featured_listing_charges` (
  `id` bigint UNSIGNED NOT NULL,
  `days` bigint DEFAULT NULL,
  `price` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feature_orders`
--

CREATE TABLE `feature_orders` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `vendor_id` int DEFAULT NULL,
  `vendor_mail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` decimal(8,2) DEFAULT NULL,
  `payment_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `days` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feature_sections`
--

CREATE TABLE `feature_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `subtitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `feature_sections`
--

INSERT INTO `feature_sections` (`id`, `language_id`, `subtitle`, `title`, `button_text`, `created_at`, `updated_at`) VALUES
(3, 20, NULL, 'Our top listing', 'Explore All Listings', '2023-08-19 03:00:57', '2024-05-15 02:16:25');

-- --------------------------------------------------------

--
-- Table structure for table `footer_contents`
--

CREATE TABLE `footer_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `about_company` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `copyright_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `footer_contents`
--

INSERT INTO `footer_contents` (`id`, `language_id`, `about_company`, `copyright_text`, `created_at`, `updated_at`) VALUES
(5, 20, 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.', '<p>Copyright ©2024. All Rights Reserved..</p>', '2023-08-19 23:40:53', '2024-01-24 21:43:45');

-- --------------------------------------------------------

--
-- Table structure for table `guests`
--

CREATE TABLE `guests` (
  `id` bigint UNSIGNED NOT NULL,
  `endpoint` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hero_sections`
--

CREATE TABLE `hero_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hero_sections`
--

INSERT INTO `hero_sections` (`id`, `language_id`, `title`, `text`, `created_at`, `updated_at`) VALUES
(2, 20, 'Are You Looking For A business?', 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusa ntium doloremque laudantium, totamrem.', '2024-03-26 20:41:33', '2024-04-30 22:06:44');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `code` char(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `direction` tinyint NOT NULL,
  `is_default` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`, `direction`, `is_default`, `created_at`, `updated_at`) VALUES
(20, 'English', 'en', 0, 1, '2023-08-17 03:19:12', '2024-04-30 22:05:07');

-- --------------------------------------------------------

--
-- Table structure for table `listings`
--

CREATE TABLE `listings` (
  `id` bigint UNSIGNED NOT NULL,
  `feature_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_background_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vendor_id` bigint DEFAULT '0',
  `mail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `average_rating` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `min_price` double DEFAULT NULL,
  `max_price` double DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `visibility` int NOT NULL DEFAULT '0',
  `is_featured` int NOT NULL DEFAULT '0',
  `tawkto_status` tinyint DEFAULT '0',
  `tawkto_direct_chat_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telegram_status` int NOT NULL DEFAULT '0',
  `telegram_username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `messenger_status` int NOT NULL DEFAULT '0',
  `messenger_direct_chat_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp_status` int DEFAULT '0',
  `whatsapp_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp_header_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp_popup_status` int DEFAULT NULL,
  `whatsapp_popup_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_categories`
--

CREATE TABLE `listing_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_number` bigint DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_contents`
--

CREATE TABLE `listing_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `listing_id` bigint DEFAULT NULL,
  `category_id` bigint DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `state_id` int DEFAULT NULL,
  `city_id` int DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aminities` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keyword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `features` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_faqs`
--

CREATE TABLE `listing_faqs` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `language_id` bigint DEFAULT NULL,
  `question` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `answer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `serial_number` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_features`
--

CREATE TABLE `listing_features` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `indx` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_feature_contents`
--

CREATE TABLE `listing_feature_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_feature_id` bigint DEFAULT NULL,
  `language_id` bigint DEFAULT NULL,
  `feature_heading` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `feature_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_images`
--

CREATE TABLE `listing_images` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_messages`
--

CREATE TABLE `listing_messages` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_products`
--

CREATE TABLE `listing_products` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `vendor_id` int DEFAULT NULL,
  `feature_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_price` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `previous_price` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_product_contents`
--

CREATE TABLE `listing_product_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` int DEFAULT NULL,
  `listing_id` bigint DEFAULT NULL,
  `listing_product_id` int DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_keyword` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `meta_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_product_images`
--

CREATE TABLE `listing_product_images` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `listing_product_id` int DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_reviews`
--

CREATE TABLE `listing_reviews` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `listing_id` bigint DEFAULT NULL,
  `rating` bigint DEFAULT NULL,
  `review` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `listing_sections`
--

CREATE TABLE `listing_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtitle` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `button_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `listing_sections`
--

INSERT INTO `listing_sections` (`id`, `language_id`, `title`, `subtitle`, `button_text`, `created_at`, `updated_at`) VALUES
(3, 20, 'Featured Listings', NULL, 'Exploress', '2023-10-18 21:37:18', '2024-04-30 22:23:47');

-- --------------------------------------------------------

--
-- Table structure for table `listing_socail_medias`
--

CREATE TABLE `listing_socail_medias` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `location_sections`
--

CREATE TABLE `location_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `location_sections`
--

INSERT INTO `location_sections` (`id`, `language_id`, `title`, `created_at`, `updated_at`) VALUES
(1, 20, 'Explore Most Popo', '2023-12-13 04:04:00', '2024-03-19 23:34:45');

-- --------------------------------------------------------

--
-- Table structure for table `mail_templates`
--

CREATE TABLE `mail_templates` (
  `id` int NOT NULL,
  `mail_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `mail_subject` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `mail_body` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

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

CREATE TABLE `memberships` (
  `id` bigint UNSIGNED NOT NULL,
  `price` double DEFAULT NULL,
  `currency` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `currency_symbol` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `payment_method` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0',
  `is_trial` tinyint NOT NULL DEFAULT '0',
  `trial_days` int NOT NULL DEFAULT '0',
  `receipt` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `transaction_details` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `settings` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `package_id` bigint DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `modified` tinyint DEFAULT NULL COMMENT '1 - modified by Admin, 0 - not modified by Admin',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menu_builders`
--

CREATE TABLE `menu_builders` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `menus` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `menu_builders`
--

INSERT INTO `menu_builders` (`id`, `language_id`, `menus`, `created_at`, `updated_at`) VALUES
(7, 20, '[{\"text\":\"Home\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"home\"},{\"text\":\"Listings\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"listings\"},{\"text\":\"Pricing\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"pricing\"},{\"text\":\"Vendors\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"vendors\"},{\"text\":\"Shop\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"shop\",\"children\":[{\"text\":\"Cart\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"cart\"},{\"text\":\"Checkout\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"checkout\"}]},{\"text\":\"Pages\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"custom\",\"children\":[{\"text\":\"Blog\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"blog\"},{\"text\":\"FAQ\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"faq\"},{\"text\":\"About Us\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"about-us\"}]},{\"text\":\"Contact\",\"href\":\"\",\"icon\":\"empty\",\"target\":\"_self\",\"title\":\"\",\"type\":\"contact\"}]', '2023-08-17 03:19:12', '2024-05-15 03:10:52');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

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

CREATE TABLE `offline_gateways` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `short_description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `instructions` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0 -> gateway is deactive, 1 -> gateway is active.',
  `has_attachment` tinyint(1) NOT NULL COMMENT '0 -> do not need attachment, 1 -> need attachment.',
  `serial_number` mediumint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `online_gateways`
--

CREATE TABLE `online_gateways` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `keyword` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `information` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

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

CREATE TABLE `packages` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `price` double NOT NULL DEFAULT '0',
  `icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `term` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `number_of_listing` int DEFAULT '0',
  `recommended` int DEFAULT NULL,
  `number_of_images_per_listing` int DEFAULT '0',
  `number_of_products` int DEFAULT '0',
  `number_of_images_per_products` int DEFAULT '0',
  `number_of_amenities_per_listing` int DEFAULT '0',
  `number_of_additional_specification` int DEFAULT '0',
  `number_of_social_links` int DEFAULT '0',
  `number_of_faq` int DEFAULT '0',
  `custom_features` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `status` int NOT NULL DEFAULT '1',
  `features` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `package_sections`
--

CREATE TABLE `package_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtitle` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `button_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `package_sections`
--

INSERT INTO `package_sections` (`id`, `language_id`, `title`, `subtitle`, `button_text`, `created_at`, `updated_at`) VALUES
(1, 20, 'Most Affordable Package', NULL, NULL, '2023-10-18 22:02:00', '2024-04-30 22:24:17');

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` bigint UNSIGNED NOT NULL,
  `status` tinyint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `page_contents`
--

CREATE TABLE `page_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `page_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` blob NOT NULL,
  `meta_keywords` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `page_headings`
--

CREATE TABLE `page_headings` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `listing_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `blog_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `contact_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `products_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `error_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `pricing_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `faq_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `forget_password_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `vendor_forget_password_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `login_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `signup_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `vendor_login_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `vendor_signup_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `cart_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `checkout_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `vendor_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `about_us_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `wishlist_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `dashboard_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `orders_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `support_ticket_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `support_ticket_create_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `change_password_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `edit_profile_page_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `page_headings`
--

INSERT INTO `page_headings` (`id`, `language_id`, `listing_page_title`, `blog_page_title`, `contact_page_title`, `products_page_title`, `error_page_title`, `pricing_page_title`, `faq_page_title`, `forget_password_page_title`, `vendor_forget_password_page_title`, `login_page_title`, `signup_page_title`, `vendor_login_page_title`, `vendor_signup_page_title`, `cart_page_title`, `checkout_page_title`, `vendor_page_title`, `about_us_title`, `wishlist_page_title`, `dashboard_page_title`, `orders_page_title`, `support_ticket_page_title`, `support_ticket_create_page_title`, `change_password_page_title`, `edit_profile_page_title`, `created_at`, `updated_at`) VALUES
(9, 20, 'Listings', 'Blog', 'Contact', 'Products', '404', 'Pricing', 'FAQ', 'Forget Password', 'Forget Password', 'Login', 'Signup', 'Vendor Login', 'Vendor Signup', 'Cart', 'Checkout', 'Vendors', 'About Us', 'Wishlists', 'Dashboard', 'Orders', 'Support Tickets', 'Create a Support Ticket', 'Change Password', 'Edit Profile', '2023-08-27 01:23:22', '2024-01-01 04:49:59');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` bigint NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

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

CREATE TABLE `popups` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `type` smallint UNSIGNED NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `background_color` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `background_color_opacity` decimal(3,2) UNSIGNED DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `button_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `button_color` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `button_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `delay` int UNSIGNED NOT NULL COMMENT 'value will be in milliseconds',
  `serial_number` mediumint UNSIGNED NOT NULL,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '0 => deactive, 1 => active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint UNSIGNED NOT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `product_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `featured_image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `slider_images` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `status` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `input_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `file` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `link` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `stock` int UNSIGNED DEFAULT NULL,
  `sku` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `current_price` decimal(8,2) UNSIGNED NOT NULL,
  `previous_price` decimal(8,2) UNSIGNED DEFAULT NULL,
  `average_rating` decimal(4,2) UNSIGNED DEFAULT '0.00',
  `is_featured` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'no',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

CREATE TABLE `product_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `status` tinyint UNSIGNED NOT NULL,
  `serial_number` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_contents`
--

CREATE TABLE `product_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `product_category_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `summary` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `meta_keywords` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_coupons`
--

CREATE TABLE `product_coupons` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `value` decimal(8,2) UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `minimum_spend` decimal(8,2) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_messages`
--

CREATE TABLE `product_messages` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` bigint DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_orders`
--

CREATE TABLE `product_orders` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `order_number` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `billing_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `billing_email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `billing_phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `billing_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `billing_city` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `billing_state` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `billing_country` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_city` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_state` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `shipping_country` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `total` decimal(8,2) UNSIGNED NOT NULL,
  `discount` decimal(8,2) UNSIGNED DEFAULT NULL,
  `product_shipping_charge_id` bigint UNSIGNED DEFAULT NULL,
  `shipping_cost` decimal(8,2) UNSIGNED DEFAULT NULL,
  `tax` decimal(8,2) UNSIGNED NOT NULL,
  `grand_total` decimal(8,2) UNSIGNED NOT NULL,
  `currency_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `currency_text_position` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `currency_symbol` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `currency_symbol_position` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `payment_method` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `gateway_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `payment_status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `order_status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `invoice` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_purchase_items`
--

CREATE TABLE `product_purchase_items` (
  `id` bigint UNSIGNED NOT NULL,
  `product_order_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `quantity` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_reviews`
--

CREATE TABLE `product_reviews` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `rating` smallint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_shipping_charges`
--

CREATE TABLE `product_shipping_charges` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `short_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `shipping_charge` decimal(8,2) UNSIGNED NOT NULL,
  `serial_number` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `push_subscriptions`
--

CREATE TABLE `push_subscriptions` (
  `id` bigint UNSIGNED NOT NULL,
  `subscribable_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `subscribable_id` bigint UNSIGNED NOT NULL,
  `endpoint` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `public_key` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `auth_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `content_encoding` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quick_links`
--

CREATE TABLE `quick_links` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` smallint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `permissions` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `id` bigint UNSIGNED NOT NULL,
  `work_process_section_status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `category_section_status` tinyint DEFAULT '0',
  `featured_listing_section_status` tinyint NOT NULL DEFAULT '1',
  `feature_section_status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `latest_listing_section_status` tinyint DEFAULT NULL,
  `counter_section_status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `package_section_status` tinyint NOT NULL DEFAULT '1',
  `video_section` tinyint DEFAULT '0',
  `testimonial_section_status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `call_to_action_section_status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `location_section_status` tinyint DEFAULT NULL,
  `blog_section_status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `subscribe_section_status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `footer_section_status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`id`, `work_process_section_status`, `category_section_status`, `featured_listing_section_status`, `feature_section_status`, `latest_listing_section_status`, `counter_section_status`, `package_section_status`, `video_section`, `testimonial_section_status`, `call_to_action_section_status`, `location_section_status`, `blog_section_status`, `subscribe_section_status`, `footer_section_status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, NULL, '2024-03-21 00:17:28');

-- --------------------------------------------------------

--
-- Table structure for table `seos`
--

CREATE TABLE `seos` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `meta_keyword_home` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_home` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_pricing` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_pricing` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_listings` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_listings` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_products` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_products` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_blog` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_blog` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_faq` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_faq` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_contact` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_contact` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_login` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_login` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_signup` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_signup` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keyword_forget_password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_forget_password` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_keywords_vendor_login` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_vendor_login` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_keywords_vendor_signup` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_vendor_signup` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_keywords_vendor_forget_password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_descriptions_vendor_forget_password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_keywords_vendor_page` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_description_vendor_page` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `meta_keywords_about_page` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `meta_description_about_page` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `seos`
--

INSERT INTO `seos` (`id`, `language_id`, `meta_keyword_home`, `meta_description_home`, `meta_keyword_pricing`, `meta_description_pricing`, `meta_keyword_listings`, `meta_description_listings`, `meta_keyword_products`, `meta_description_products`, `meta_keyword_blog`, `meta_description_blog`, `meta_keyword_faq`, `meta_description_faq`, `meta_keyword_contact`, `meta_description_contact`, `meta_keyword_login`, `meta_description_login`, `meta_keyword_signup`, `meta_description_signup`, `meta_keyword_forget_password`, `meta_description_forget_password`, `meta_keywords_vendor_login`, `meta_description_vendor_login`, `meta_keywords_vendor_signup`, `meta_description_vendor_signup`, `meta_keywords_vendor_forget_password`, `meta_descriptions_vendor_forget_password`, `meta_keywords_vendor_page`, `meta_description_vendor_page`, `meta_keywords_about_page`, `meta_description_about_page`, `created_at`, `updated_at`) VALUES
(5, 20, 'Home', 'Home Descriptions', 'Pricimg', 'Pricing descriptions', 'Listings', 'Listings Description', 'products', 'Product descriptions', 'Blog', 'Blog descriptions', 'Faq', 'faq descriptions', 'contact', 'contact descriptions', 'Login', 'Login descriptions', 'Signup', 'signup descriptions', 'Forget Password', 'Forget Password descriptions', 'Vendor Login', 'Vendor Login descriptions', 'Vendor Signup', 'Vendor Signup descriptions', 'Vendor Forget Password', 'vendor forget password descriptions', 'vendors', 'vendors descriptions', 'About us', 'about us descriptions', '2023-08-27 01:03:33', '2024-01-01 21:20:39');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `social_medias`
--

CREATE TABLE `social_medias` (
  `id` bigint UNSIGNED NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

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

CREATE TABLE `states` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `country_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
  `id` bigint UNSIGNED NOT NULL,
  `email_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int NOT NULL,
  `user_type` varchar(20) DEFAULT NULL,
  `admin_id` int DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `description` longtext,
  `attachment` varchar(255) DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1-pending, 2-open, 3-closed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `last_message` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `support_ticket_statuses`
--

CREATE TABLE `support_ticket_statuses` (
  `id` bigint UNSIGNED NOT NULL,
  `support_ticket_status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `support_ticket_statuses`
--

INSERT INTO `support_ticket_statuses` (`id`, `support_ticket_status`, `created_at`, `updated_at`) VALUES
(1, 'active', '2022-06-25 03:52:18', '2024-03-21 00:50:57');

-- --------------------------------------------------------

--
-- Table structure for table `testimonials`
--

CREATE TABLE `testimonials` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `occupation` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `rating` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `testimonial_sections`
--

CREATE TABLE `testimonial_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `subtitle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `clients` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `testimonial_sections`
--

INSERT INTO `testimonial_sections` (`id`, `language_id`, `subtitle`, `title`, `clients`, `created_at`, `updated_at`) VALUES
(7, 20, NULL, 'What Clients Say About Bulistio Packages', '10k+ Active Client’s', '2023-08-19 03:45:43', '2023-12-13 21:06:27');

-- --------------------------------------------------------

--
-- Table structure for table `timezones`
--

CREATE TABLE `timezones` (
  `country_code` char(3) NOT NULL,
  `timezone` varchar(125) NOT NULL DEFAULT '',
  `gmt_offset` float(10,2) DEFAULT NULL,
  `dst_offset` float(10,2) DEFAULT NULL,
  `raw_offset` float(10,2) DEFAULT NULL
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

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '0 -> banned or deactive, 1 -> active',
  `verification_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `provider` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `provider_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `zip_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `address` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` bigint UNSIGNED NOT NULL,
  `photo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `to_mail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0',
  `amount` double(8,2) DEFAULT '0.00',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `avg_rating` float(8,2) NOT NULL DEFAULT '0.00',
  `show_email_addresss` tinyint NOT NULL DEFAULT '1',
  `show_phone_number` tinyint NOT NULL DEFAULT '1',
  `show_contact_form` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vendor_infos`
--

CREATE TABLE `vendor_infos` (
  `id` bigint UNSIGNED NOT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `language_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `zip_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `address` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `details` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `video_sections`
--

CREATE TABLE `video_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint DEFAULT NULL,
  `subtitle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `video_sections`
--

INSERT INTO `video_sections` (`id`, `language_id`, `subtitle`, `title`, `video_url`, `button_name`, `button_url`, `created_at`, `updated_at`) VALUES
(1, 20, 'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusa ntium doloremque.  Start From: $200.00', 'Explore Your Favorite Restaurant Listsss', 'https://www.youtube.com/watch?v=QSwvg9Rv2EI', 'Browse moreee', 'https://www.example.com', '2023-12-12 23:15:10', '2024-05-15 02:17:32');

-- --------------------------------------------------------

--
-- Table structure for table `visitors`
--

CREATE TABLE `visitors` (
  `id` bigint UNSIGNED NOT NULL,
  `listing_id` bigint DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `ip_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wishlists`
--

CREATE TABLE `wishlists` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint NOT NULL,
  `listing_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `work_processes`
--

CREATE TABLE `work_processes` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `serial_number` int UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `work_process_sections`
--

CREATE TABLE `work_process_sections` (
  `id` bigint UNSIGNED NOT NULL,
  `language_id` bigint UNSIGNED NOT NULL,
  `button_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `work_process_sections`
--

INSERT INTO `work_process_sections` (`id`, `language_id`, `button_text`, `title`, `created_at`, `updated_at`) VALUES
(3, 20, 'Details', 'How It Worksz', '2023-08-19 04:05:15', '2023-10-19 00:16:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_username_unique` (`username`),
  ADD UNIQUE KEY `admins_email_unique` (`email`),
  ADD KEY `admins_role_id_foreign` (`role_id`);

--
-- Indexes for table `advertisements`
--
ALTER TABLE `advertisements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `aminites`
--
ALTER TABLE `aminites`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `basic_settings`
--
ALTER TABLE `basic_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_categories_language_id_foreign` (`language_id`);

--
-- Indexes for table `blog_informations`
--
ALTER TABLE `blog_informations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_informations_language_id_foreign` (`language_id`),
  ADD KEY `blog_informations_blog_category_id_foreign` (`blog_category_id`),
  ADD KEY `blog_informations_blog_id_foreign` (`blog_id`);

--
-- Indexes for table `blog_sections`
--
ALTER TABLE `blog_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `business_hours`
--
ALTER TABLE `business_hours`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `call_to_action_sections`
--
ALTER TABLE `call_to_action_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category_sections`
--
ALTER TABLE `category_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cookie_alerts`
--
ALTER TABLE `cookie_alerts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cookie_alerts_language_id_foreign` (`language_id`);

--
-- Indexes for table `counter_informations`
--
ALTER TABLE `counter_informations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `counter_sections`
--
ALTER TABLE `counter_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faqs_language_id_foreign` (`language_id`);

--
-- Indexes for table `featured_listing_charges`
--
ALTER TABLE `featured_listing_charges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feature_orders`
--
ALTER TABLE `feature_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feature_sections`
--
ALTER TABLE `feature_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `footer_contents`
--
ALTER TABLE `footer_contents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `footer_texts_language_id_foreign` (`language_id`);

--
-- Indexes for table `guests`
--
ALTER TABLE `guests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hero_sections`
--
ALTER TABLE `hero_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listings`
--
ALTER TABLE `listings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `average_rating` (`average_rating`);

--
-- Indexes for table `listing_categories`
--
ALTER TABLE `listing_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_contents`
--
ALTER TABLE `listing_contents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_faqs`
--
ALTER TABLE `listing_faqs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_features`
--
ALTER TABLE `listing_features`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_feature_contents`
--
ALTER TABLE `listing_feature_contents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_images`
--
ALTER TABLE `listing_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_messages`
--
ALTER TABLE `listing_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_products`
--
ALTER TABLE `listing_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_product_contents`
--
ALTER TABLE `listing_product_contents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_product_images`
--
ALTER TABLE `listing_product_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_reviews`
--
ALTER TABLE `listing_reviews`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_sections`
--
ALTER TABLE `listing_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `listing_socail_medias`
--
ALTER TABLE `listing_socail_medias`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `location_sections`
--
ALTER TABLE `location_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mail_templates`
--
ALTER TABLE `mail_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `memberships`
--
ALTER TABLE `memberships`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_builders`
--
ALTER TABLE `menu_builders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `offline_gateways`
--
ALTER TABLE `offline_gateways`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `online_gateways`
--
ALTER TABLE `online_gateways`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `package_sections`
--
ALTER TABLE `package_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `page_contents`
--
ALTER TABLE `page_contents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `page_contents_language_id_foreign` (`language_id`),
  ADD KEY `page_contents_page_id_foreign` (`page_id`);

--
-- Indexes for table `page_headings`
--
ALTER TABLE `page_headings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `page_headings_language_id_foreign` (`language_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `popups`
--
ALTER TABLE `popups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `popups_language_id_foreign` (`language_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_categories_language_id_foreign` (`language_id`);

--
-- Indexes for table `product_contents`
--
ALTER TABLE `product_contents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_contents_language_id_foreign` (`language_id`),
  ADD KEY `product_contents_product_category_id_foreign` (`product_category_id`),
  ADD KEY `product_contents_product_id_foreign` (`product_id`);

--
-- Indexes for table `product_coupons`
--
ALTER TABLE `product_coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_messages`
--
ALTER TABLE `product_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_orders`
--
ALTER TABLE `product_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_orders_user_id_foreign` (`user_id`);

--
-- Indexes for table `product_purchase_items`
--
ALTER TABLE `product_purchase_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_purchase_items_product_order_id_foreign` (`product_order_id`),
  ADD KEY `product_purchase_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `product_reviews`
--
ALTER TABLE `product_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_reviews_user_id_foreign` (`user_id`),
  ADD KEY `product_reviews_product_id_foreign` (`product_id`);

--
-- Indexes for table `product_shipping_charges`
--
ALTER TABLE `product_shipping_charges`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shipping_charges_language_id_foreign` (`language_id`);

--
-- Indexes for table `push_subscriptions`
--
ALTER TABLE `push_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `push_subscriptions_endpoint_unique` (`endpoint`),
  ADD KEY `push_subscriptions_subscribable_type_subscribable_id_index` (`subscribable_type`,`subscribable_id`);

--
-- Indexes for table `quick_links`
--
ALTER TABLE `quick_links`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quick_links_language_id_foreign` (`language_id`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seos`
--
ALTER TABLE `seos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seos_language_id_foreign` (`language_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_medias`
--
ALTER TABLE `social_medias`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subscribers_email_id_unique` (`email_id`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_ticket_statuses`
--
ALTER TABLE `support_ticket_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `testimonial_sections`
--
ALTER TABLE `testimonial_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `timezones`
--
ALTER TABLE `timezones`
  ADD PRIMARY KEY (`country_code`,`timezone`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vendor_infos`
--
ALTER TABLE `vendor_infos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `video_sections`
--
ALTER TABLE `video_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `visitors`
--
ALTER TABLE `visitors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `work_processes`
--
ALTER TABLE `work_processes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `work_process_sections`
--
ALTER TABLE `work_process_sections`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `advertisements`
--
ALTER TABLE `advertisements`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `aminites`
--
ALTER TABLE `aminites`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `basic_settings`
--
ALTER TABLE `basic_settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `blog_categories`
--
ALTER TABLE `blog_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `blog_informations`
--
ALTER TABLE `blog_informations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `blog_sections`
--
ALTER TABLE `blog_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `business_hours`
--
ALTER TABLE `business_hours`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `call_to_action_sections`
--
ALTER TABLE `call_to_action_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `category_sections`
--
ALTER TABLE `category_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cookie_alerts`
--
ALTER TABLE `cookie_alerts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `counter_informations`
--
ALTER TABLE `counter_informations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `counter_sections`
--
ALTER TABLE `counter_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `featured_listing_charges`
--
ALTER TABLE `featured_listing_charges`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `feature_orders`
--
ALTER TABLE `feature_orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `feature_sections`
--
ALTER TABLE `feature_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `footer_contents`
--
ALTER TABLE `footer_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `guests`
--
ALTER TABLE `guests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hero_sections`
--
ALTER TABLE `hero_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `listings`
--
ALTER TABLE `listings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `listing_categories`
--
ALTER TABLE `listing_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `listing_contents`
--
ALTER TABLE `listing_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `listing_faqs`
--
ALTER TABLE `listing_faqs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `listing_features`
--
ALTER TABLE `listing_features`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `listing_feature_contents`
--
ALTER TABLE `listing_feature_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `listing_images`
--
ALTER TABLE `listing_images`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `listing_messages`
--
ALTER TABLE `listing_messages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `listing_products`
--
ALTER TABLE `listing_products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `listing_product_contents`
--
ALTER TABLE `listing_product_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `listing_product_images`
--
ALTER TABLE `listing_product_images`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `listing_reviews`
--
ALTER TABLE `listing_reviews`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `listing_sections`
--
ALTER TABLE `listing_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `listing_socail_medias`
--
ALTER TABLE `listing_socail_medias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `location_sections`
--
ALTER TABLE `location_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `mail_templates`
--
ALTER TABLE `mail_templates`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `memberships`
--
ALTER TABLE `memberships`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menu_builders`
--
ALTER TABLE `menu_builders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `offline_gateways`
--
ALTER TABLE `offline_gateways`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `online_gateways`
--
ALTER TABLE `online_gateways`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `packages`
--
ALTER TABLE `packages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `package_sections`
--
ALTER TABLE `package_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `page_contents`
--
ALTER TABLE `page_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `page_headings`
--
ALTER TABLE `page_headings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `popups`
--
ALTER TABLE `popups`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `product_contents`
--
ALTER TABLE `product_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=143;

--
-- AUTO_INCREMENT for table `product_coupons`
--
ALTER TABLE `product_coupons`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `product_messages`
--
ALTER TABLE `product_messages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_orders`
--
ALTER TABLE `product_orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `product_purchase_items`
--
ALTER TABLE `product_purchase_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `product_reviews`
--
ALTER TABLE `product_reviews`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_shipping_charges`
--
ALTER TABLE `product_shipping_charges`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `push_subscriptions`
--
ALTER TABLE `push_subscriptions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quick_links`
--
ALTER TABLE `quick_links`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `seos`
--
ALTER TABLE `seos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `social_medias`
--
ALTER TABLE `social_medias`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `states`
--
ALTER TABLE `states`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `support_ticket_statuses`
--
ALTER TABLE `support_ticket_statuses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `testimonial_sections`
--
ALTER TABLE `testimonial_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vendor_infos`
--
ALTER TABLE `vendor_infos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `video_sections`
--
ALTER TABLE `video_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `visitors`
--
ALTER TABLE `visitors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wishlists`
--
ALTER TABLE `wishlists`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `work_processes`
--
ALTER TABLE `work_processes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `work_process_sections`
--
ALTER TABLE `work_process_sections`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
