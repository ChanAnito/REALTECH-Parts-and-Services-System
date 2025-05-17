-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 17, 2025 at 12:20 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pos_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `username` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_logs`
--

CREATE TABLE `admin_logs` (
  `id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `log_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_logs`
--

CREATE TABLE `employee_logs` (
  `id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `log_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee_logs`
--

INSERT INTO `employee_logs` (`id`, `username`, `action`, `log_time`) VALUES
(1, 'chan', 'Switched to Sales tab', '2025-05-15 00:06:11'),
(2, 'chan', 'Logged in', '2025-05-15 00:06:11'),
(3, 'chan', 'Switched to Inventory tab', '2025-05-15 00:06:17'),
(4, 'chan', 'Switched to Reports tab', '2025-05-15 00:06:18'),
(5, 'chan', 'Switched to Logs tab', '2025-05-15 00:06:19'),
(6, 'chan', 'Logged out', '2025-05-15 00:06:20'),
(7, 'admin1', 'Switched to Employee History tab', '2025-05-15 00:06:28'),
(8, 'admin1', 'Logged in', '2025-05-15 00:06:28'),
(9, 'admin1', 'Switched to Sales Reports tab', '2025-05-15 00:06:33'),
(10, 'admin1', 'Switched to Sales Reports tab', '2025-05-15 00:06:33'),
(11, 'admin1', 'Switched to Sales Reports tab', '2025-05-15 00:06:34'),
(12, 'admin1', 'Switched to Sales Reports tab', '2025-05-15 00:06:34'),
(13, 'admin1', 'Logged out', '2025-05-15 00:06:35'),
(14, 'chan', 'Switched to Sales tab', '2025-05-15 21:57:53'),
(15, 'chan', 'Logged in', '2025-05-15 21:57:53'),
(16, 'chan', 'Switched to Sales tab', '2025-05-15 21:57:56'),
(17, 'chan', 'Switched to Inventory tab', '2025-05-15 21:58:00'),
(18, 'chan', 'Logged out', '2025-05-15 21:58:08'),
(19, 'chan', 'Switched to Sales tab', '2025-05-16 09:03:16'),
(20, 'chan', 'Logged in', '2025-05-16 09:03:16'),
(21, 'test_user', 'Switched to Sales tab', '2025-05-16 09:04:11'),
(22, 'test_user', 'Logged in', '2025-05-16 09:04:11'),
(23, 'chan', 'Switched to Sales tab', '2025-05-16 09:07:01'),
(24, 'chan', 'Logged in', '2025-05-16 09:07:01'),
(25, 'chan', 'Switched to Logs tab', '2025-05-16 09:07:04'),
(26, 'chan', 'Switched to Reports tab', '2025-05-16 09:07:21'),
(27, 'chan', 'Switched to Logs tab', '2025-05-16 09:07:22'),
(28, 'admin', 'Switched to Sales tab', '2025-05-16 09:10:02'),
(29, 'admin', 'Logged in', '2025-05-16 09:10:02'),
(30, 'admin', 'Switched to Sales tab', '2025-05-16 09:10:09'),
(31, 'admin', 'Switched to Inventory tab', '2025-05-16 09:10:11'),
(32, 'admin', 'Switched to Reports tab', '2025-05-16 09:10:13'),
(33, 'admin', 'Switched to Logs tab', '2025-05-16 09:10:15'),
(34, 'admin1', 'Switched to Employee History tab', '2025-05-16 09:12:07'),
(35, 'admin1', 'Logged in', '2025-05-16 09:12:07'),
(36, 'admin', 'Switched to Sales tab', '2025-05-16 09:12:25'),
(37, 'admin', 'Logged in', '2025-05-16 09:12:25'),
(38, 'admin1', 'Switched to Employee History tab', '2025-05-16 09:12:55'),
(39, 'admin1', 'Logged in', '2025-05-16 09:12:55'),
(40, 'admin', 'Switched to Sales tab', '2025-05-16 09:17:55'),
(41, 'admin', 'Logged in', '2025-05-16 09:17:55'),
(42, 'admin', 'Logged out', '2025-05-16 09:17:57'),
(43, 'admin', 'Switched to Sales tab', '2025-05-16 09:22:33'),
(44, 'admin', 'Logged in', '2025-05-16 09:22:33'),
(45, 'admin', 'Switched to Sales tab', '2025-05-16 09:22:37'),
(46, 'admin', 'Switched to Inventory tab', '2025-05-16 09:22:39'),
(47, 'admin', 'Switched to Reports tab', '2025-05-16 09:22:41'),
(48, 'admin', 'Switched to Logs tab', '2025-05-16 09:22:42'),
(49, 'admin1', 'Switched to Employee History tab', '2025-05-16 09:26:54'),
(50, 'admin1', 'Logged in', '2025-05-16 09:26:54'),
(51, 'admin', 'Switched to Employee History tab', '2025-05-16 09:28:33'),
(52, 'admin', 'Logged in', '2025-05-16 09:28:33'),
(53, 'admin', 'Switched to Employee History tab', '2025-05-16 09:28:37'),
(54, 'admin', 'Switched to Employee History tab', '2025-05-16 09:29:15'),
(55, 'admin', 'Logged in', '2025-05-16 09:29:15'),
(56, 'admin', 'Switched to Sales Reports tab', '2025-05-16 09:29:17'),
(57, 'admin', 'Switched to Inventory tab', '2025-05-16 09:29:18'),
(58, 'admin', 'Switched to Restock Inventory tab', '2025-05-16 09:29:22'),
(59, 'admin', 'Switched to Employee History tab', '2025-05-16 09:29:24'),
(60, 'chan', 'Switched to Sales tab', '2025-05-16 09:30:51'),
(61, 'chan', 'Logged in', '2025-05-16 09:30:51'),
(62, 'chan', 'Switched to Sales tab', '2025-05-16 09:30:55'),
(63, 'chan', 'Added 5 x Intel Core i7-13700K to cart', '2025-05-16 09:31:08'),
(64, 'admin', 'Switched to Employee History tab', '2025-05-16 09:33:34'),
(65, 'admin', 'Logged in', '2025-05-16 09:33:34'),
(66, 'admin', 'Switched to Employee History tab', '2025-05-16 09:33:39'),
(67, 'admin', 'Logged out', '2025-05-16 09:34:13'),
(68, 'admin1', 'Switched to Employee History tab', '2025-05-16 09:37:32'),
(69, 'admin1', 'Logged in', '2025-05-16 09:37:32'),
(70, 'admin', 'Switched to Employee History tab', '2025-05-16 09:37:46'),
(71, 'admin', 'Logged in', '2025-05-16 09:37:47'),
(72, 'admin', 'Switched to Restock Inventory tab', '2025-05-16 09:37:50'),
(73, 'admin', 'Switched to Inventory tab', '2025-05-16 09:37:52'),
(74, 'admin', 'Switched to Sales Reports tab', '2025-05-16 09:37:53'),
(75, 'admin', 'Logged out', '2025-05-16 09:38:02'),
(76, 'chan', 'Switched to Sales tab', '2025-05-16 09:38:13'),
(77, 'chan', 'Logged in', '2025-05-16 09:38:13'),
(78, 'chan', 'Switched to Inventory tab', '2025-05-16 09:38:25'),
(79, 'chan', 'Switched to Reports tab', '2025-05-16 09:38:30'),
(80, 'chan', 'Switched to Logs tab', '2025-05-16 09:38:34'),
(81, 'chan', 'Switched to Sales tab', '2025-05-16 09:38:38'),
(82, 'chan', 'Switched to Inventory tab', '2025-05-16 09:38:41'),
(83, 'chan', 'Switched to Reports tab', '2025-05-16 09:38:43'),
(84, 'chan', 'Switched to Logs tab', '2025-05-16 09:38:44'),
(85, 'chan', 'Logged out', '2025-05-16 09:38:47'),
(86, 'admin', 'Switched to Employee History tab', '2025-05-16 09:39:18'),
(87, 'admin', 'Logged in', '2025-05-16 09:39:19'),
(88, 'chan ', 'Switched to Sales tab', '2025-05-16 13:26:34'),
(89, 'chan ', 'Logged in', '2025-05-16 13:26:34'),
(90, 'chan ', 'Switched to Sales tab', '2025-05-16 13:26:38'),
(91, 'chan ', 'Added 2 x NVIDIA RTX 4060 to cart', '2025-05-16 13:26:51'),
(92, 'chan ', 'Sale: 2 x NVIDIA RTX 4060 (Cash)', '2025-05-16 13:26:56'),
(93, 'chan ', 'Switched to Logs tab', '2025-05-16 13:27:01'),
(94, 'chan ', 'Switched to Reports tab', '2025-05-16 13:27:07'),
(95, 'chan ', 'Switched to Sales tab', '2025-05-16 13:30:53'),
(96, 'chan ', 'Logged out', '2025-05-16 13:30:56'),
(97, 'admin', 'Switched to Employee History tab', '2025-05-16 13:31:05'),
(98, 'admin', 'Logged in', '2025-05-16 13:31:05'),
(99, 'admin', 'Switched to Sales Reports tab', '2025-05-16 13:31:06'),
(100, 'admin', 'Switched to Employee History tab', '2025-05-16 13:35:29'),
(101, 'admin', 'Logged in', '2025-05-16 13:35:29'),
(102, 'admin', 'Switched to Employee History tab', '2025-05-16 13:35:30'),
(103, 'admin', 'Switched to Employee History tab', '2025-05-16 13:35:32'),
(104, 'admin', 'Switched to Sales tab', '2025-05-16 13:44:22'),
(105, 'admin', 'Logged in', '2025-05-16 13:44:22'),
(106, 'admin', 'Switched to Logs tab', '2025-05-16 13:44:25'),
(107, 'admin', 'Switched to Reports tab', '2025-05-16 13:44:26'),
(108, 'admin', 'Logged out', '2025-05-16 13:44:27'),
(109, 'admin', 'Switched to Sales tab', '2025-05-16 13:45:08'),
(110, 'admin', 'Logged in', '2025-05-16 13:45:08'),
(111, 'admin', 'Switched to Employee History tab', '2025-05-16 13:46:00'),
(112, 'admin', 'Logged in', '2025-05-16 13:46:00'),
(113, 'admin', 'Logged out', '2025-05-16 13:46:02'),
(114, 'admin', 'Switched to Employee History tab', '2025-05-16 16:59:35'),
(115, 'admin', 'Logged in', '2025-05-16 16:59:35'),
(116, 'admin', 'Switched to Employee History tab', '2025-05-16 16:59:36'),
(117, 'admin', 'Switched to Employee History tab', '2025-05-16 16:59:38'),
(118, 'admin', 'Switched to Employee History tab', '2025-05-16 16:59:38'),
(119, 'admin', 'Switched to Employee History tab', '2025-05-16 16:59:38'),
(120, 'admin', 'Switched to Employee History tab', '2025-05-16 16:59:38'),
(121, 'admin', 'Switched to Employee History tab', '2025-05-16 16:59:38'),
(122, 'test_user', 'Switched to Sales tab', '2025-05-16 17:01:57'),
(123, 'test_user', 'Logged in', '2025-05-16 17:01:57'),
(124, 'test_user', 'Added 2 x AMD RX 7800 XT to cart', '2025-05-16 17:02:08'),
(125, 'test_user', 'Sale: 2 x AMD RX 7800 XT (Cash)', '2025-05-16 17:02:16'),
(126, 'test_user', 'Switched to Sales tab', '2025-05-16 17:03:23'),
(127, 'test_user', 'Logged in', '2025-05-16 17:03:23'),
(128, 'test_user', 'Switched to Logs tab', '2025-05-16 17:03:27'),
(129, 'test_user', 'Logged out', '2025-05-16 17:04:08'),
(130, 'admin', 'Switched to Employee History tab', '2025-05-16 17:06:12'),
(131, 'admin', 'Logged in', '2025-05-16 17:06:12'),
(132, 'admin', 'Switched to Restock Inventory tab', '2025-05-16 17:06:18'),
(133, 'admin', 'Switched to Sales Reports tab', '2025-05-16 17:06:22'),
(134, 'admin', 'Switched to Inventory tab', '2025-05-16 17:06:24'),
(135, 'admin', 'Switched to Restock Inventory tab', '2025-05-16 17:06:32'),
(136, 'admin', 'Switched to Inventory tab', '2025-05-16 17:06:33'),
(137, 'chan', 'Switched to Sales tab', '2025-05-16 17:09:05'),
(138, 'chan', 'Logged in', '2025-05-16 17:09:05'),
(139, 'chan', 'Logged out', '2025-05-16 17:09:06'),
(140, 'gwen', 'Switched to Sales tab', '2025-05-16 17:09:36'),
(141, 'gwen', 'Logged in', '2025-05-16 17:09:36'),
(142, 'gwen', 'Switched to Logs tab', '2025-05-16 17:09:39'),
(143, 'gwen', 'Switched to Sales tab', '2025-05-16 17:09:43'),
(144, 'gwen', 'Switched to Reports tab', '2025-05-16 17:09:45'),
(145, 'gwen', 'Switched to Sales tab', '2025-05-16 17:09:47'),
(146, 'gwen', 'Added 1 x AMD Ryzen 9 7950X to cart', '2025-05-16 17:10:30'),
(147, 'gwen', 'Sale: 1 x AMD Ryzen 9 7950X (Cash)', '2025-05-16 17:10:38'),
(148, 'test_user', 'Switched to Sales tab', '2025-05-16 17:15:13'),
(149, 'test_user', 'Logged in', '2025-05-16 17:15:13'),
(150, 'test_user', 'Added 1 x Intel Core i5-13600K (Supplier: GlobalTech Distributors) to cart', '2025-05-16 17:15:44'),
(151, 'test_user', 'Sale: 1 x Intel Core i5-13600K (Cash, Supplier: GlobalTech Distributors)', '2025-05-16 17:15:46'),
(152, 'test_user', 'Logged out', '2025-05-16 17:15:49'),
(153, 'chan', 'Switched to Sales tab', '2025-05-16 17:16:34'),
(154, 'chan', 'Logged in', '2025-05-16 17:16:34'),
(155, 'chan', 'Switched to Sales tab', '2025-05-16 17:17:33'),
(156, 'chan', 'Logged in', '2025-05-16 17:17:33'),
(157, 'chan', 'Added 1 x AMD Ryzen 9 7950X (Supplier: GlobalTech Distributors) to cart', '2025-05-16 17:20:16'),
(158, 'test_user', 'Switched to Sales tab', '2025-05-16 17:21:52'),
(159, 'test_user', 'Logged in', '2025-05-16 17:21:52'),
(160, 'chan', 'Switched to Sales tab', '2025-05-16 17:22:07'),
(161, 'chan', 'Logged in', '2025-05-16 17:22:07'),
(162, 'chan', 'Switched to Sales tab', '2025-05-16 17:22:09'),
(163, 'chan', 'Switched to Inventory tab', '2025-05-16 17:22:12'),
(164, 'chan', 'Logged out', '2025-05-16 17:22:21'),
(165, 'admin', 'Switched to Employee History tab', '2025-05-16 17:22:33'),
(166, 'admin', 'Logged in', '2025-05-16 17:22:33'),
(167, 'admin', 'Switched to Restock Inventory tab', '2025-05-16 17:22:35'),
(168, 'admin', 'Restocked 2 units of AMD Ryzen 7 7700X', '2025-05-16 17:22:48'),
(169, 'admin', 'Switched to Inventory tab', '2025-05-16 17:22:52'),
(170, 'admin', 'Switched to Sales Reports tab', '2025-05-16 17:23:15'),
(171, 'admin', 'Switched to Inventory tab', '2025-05-16 17:23:17'),
(172, 'admin', 'Switched to Employee History tab', '2025-05-16 17:23:23'),
(173, 'admin', 'Switched to Inventory tab', '2025-05-16 17:23:36'),
(174, 'admin', 'Logged out', '2025-05-16 17:23:45'),
(175, 'admin1', 'Switched to Employee History tab', '2025-05-16 17:32:48'),
(176, 'admin1', 'Logged in', '2025-05-16 17:32:48'),
(177, 'chan', 'Switched to Sales tab', '2025-05-16 17:33:49'),
(178, 'chan', 'Logged in', '2025-05-16 17:33:49'),
(179, 'chan', 'Logged out', '2025-05-16 17:33:51'),
(180, 'admin1', 'Switched to Employee History tab', '2025-05-16 17:34:33'),
(181, 'admin1', 'Logged in', '2025-05-16 17:34:34'),
(182, 'admin1', 'Switched to Manage Supplier tab', '2025-05-16 17:34:36'),
(183, 'admin1', 'Switched to Employee History tab', '2025-05-16 17:35:58'),
(184, 'admin1', 'Logged in', '2025-05-16 17:35:58'),
(185, 'test_user', 'Viewed sales history', '2025-05-16 17:42:00'),
(186, 'test_user', 'Switched to Sales tab', '2025-05-16 17:42:00'),
(187, 'test_user', 'Logged in', '2025-05-16 17:42:00'),
(188, 'test_user', 'Viewed sales history', '2025-05-16 17:42:04'),
(189, 'test_user', 'Viewed sales history', '2025-05-16 17:42:04'),
(190, 'test_user', 'Viewed sales history', '2025-05-16 17:42:05'),
(191, 'test_user', 'Viewed sales history', '2025-05-16 17:42:05'),
(192, 'test_user', 'Viewed sales history', '2025-05-16 17:42:07'),
(193, 'test_user', 'Viewed sales history', '2025-05-16 17:42:08'),
(194, 'test_user', 'Viewed sales history', '2025-05-16 17:42:08'),
(195, 'test_user', 'Viewed sales history', '2025-05-16 17:43:10'),
(196, 'test_user', 'Switched to Sales tab', '2025-05-16 17:43:10'),
(197, 'test_user', 'Logged in', '2025-05-16 17:43:10'),
(198, 'test_user', 'Switched to Sales tab', '2025-05-16 17:43:26'),
(199, 'test_user', 'Logged in', '2025-05-16 17:43:26'),
(200, 'test_user', 'Switched to Sales tab', '2025-05-16 17:43:57'),
(201, 'test_user', 'Logged in', '2025-05-16 17:43:57'),
(202, 'test_user', 'Switched to Sales tab', '2025-05-16 17:47:14'),
(203, 'test_user', 'Logged in', '2025-05-16 17:47:14'),
(204, 'admin1', 'Switched to Employee History tab', '2025-05-16 17:47:28'),
(205, 'admin1', 'Logged in', '2025-05-16 17:47:28'),
(206, 'chan', 'Switched to Sales tab', '2025-05-16 17:49:04'),
(207, 'chan', 'Logged in', '2025-05-16 17:49:04'),
(208, 'test_user', 'Switched to Sales tab', '2025-05-16 17:52:10'),
(209, 'test_user', 'Logged in', '2025-05-16 17:52:10'),
(210, 'admin1', 'Switched to Employee History tab', '2025-05-16 17:52:21'),
(211, 'admin1', 'Logged in', '2025-05-16 17:52:21'),
(212, 'admin1', 'Switched to Employee History tab', '2025-05-16 17:52:26'),
(213, 'admin1', 'Logged in', '2025-05-16 17:52:26'),
(214, 'test_user', 'Switched to Sales tab', '2025-05-16 17:54:14'),
(215, 'test_user', 'Logged in', '2025-05-16 17:54:14'),
(216, 'test_user', 'Switched to Inventory tab', '2025-05-16 17:54:30'),
(217, 'test_user', 'Logged out', '2025-05-16 17:54:45'),
(218, 'admin', 'Switched to Employee History tab', '2025-05-16 17:54:52'),
(219, 'admin', 'Logged in', '2025-05-16 17:54:52'),
(220, 'admin', 'Switched to Restock Inventory tab', '2025-05-16 17:54:54'),
(221, 'admin', 'Restocked 69 units of Intel Core i3-13100', '2025-05-16 17:55:09'),
(222, 'admin', 'Switched to Inventory tab', '2025-05-16 17:55:15'),
(223, 'admin', 'Logged out', '2025-05-16 17:55:40'),
(224, 'test_user', 'Viewed sales history', '2025-05-16 17:56:09'),
(225, 'test_user', 'Switched to Sales tab', '2025-05-16 17:56:09'),
(226, 'test_user', 'Logged in', '2025-05-16 17:56:09'),
(227, 'test_user', 'Added 2 x Intel Core i5-13600K (Supplier: GlobalTech Distributors) to cart', '2025-05-16 17:56:23'),
(228, 'test_user', 'Viewed sales history', '2025-05-16 17:56:27'),
(229, 'test_user', 'Viewed sales history', '2025-05-16 17:56:28'),
(230, 'test_user', 'Viewed sales history', '2025-05-16 17:56:28'),
(231, 'chan', 'Viewed sales history', '2025-05-16 17:56:51'),
(232, 'chan', 'Switched to Sales tab', '2025-05-16 17:56:51'),
(233, 'chan', 'Logged in', '2025-05-16 17:56:51'),
(234, 'chan', 'Added 4 x AMD Ryzen 9 7950X (Supplier: GlobalTech Distributors) to cart', '2025-05-16 17:57:02'),
(235, 'chan', 'Viewed sales history', '2025-05-16 17:57:04'),
(236, 'chan', 'Switched to Reports tab', '2025-05-16 17:57:05'),
(237, 'chan', 'Switched to Logs tab', '2025-05-16 17:57:06'),
(238, 'chan', 'Switched to Inventory tab', '2025-05-16 17:57:07'),
(239, 'test_user', 'Switched to Sales tab', '2025-05-16 17:57:18'),
(240, 'test_user', 'Logged in', '2025-05-16 17:57:18'),
(241, 'test_user', 'Added 3 x Intel Core i7-13700K (Supplier: GlobalTech Distributors) to cart', '2025-05-16 17:57:36'),
(242, 'test_user', 'Updated Intel Core i7-13700K quantity to 3', '2025-05-16 17:57:37'),
(243, 'test_user', 'Updated Intel Core i7-13700K quantity to 4', '2025-05-16 17:57:43'),
(244, 'test_user', 'Switched to Sales tab', '2025-05-16 17:59:21'),
(245, 'test_user', 'Logged in', '2025-05-16 17:59:21'),
(246, 'test_user', 'Switched to Sales tab', '2025-05-16 18:04:57'),
(247, 'test_user', 'Logged in', '2025-05-16 18:04:57'),
(248, 'test_user', 'Added 2 x Intel Core i5-13600K (Supplier: GlobalTech Distributors) to cart', '2025-05-16 18:05:11'),
(249, 'test_user', 'Added 32 x NVIDIA RTX 4070 Ti (Supplier: GlobalTech Distributors) to cart', '2025-05-16 18:05:23'),
(250, 'test_user', 'Added 3 x NVIDIA RTX 4070 Ti (Supplier: GlobalTech Distributors) to cart', '2025-05-16 18:05:30'),
(251, 'test_user', 'Added 4 x Thermaltake Toughpower 850W (Supplier: ElectroMart Supplies) to cart', '2025-05-16 18:05:42'),
(252, 'test_user', 'Added 1 x Samsung 870 EVO 1TB SSD (Supplier: GlobalTech Distributors) to cart', '2025-05-16 18:05:52'),
(253, 'test_user', 'Added 3 x Thermaltake Toughpower 850W (Supplier: ElectroMart Supplies) to cart', '2025-05-16 18:06:12'),
(254, 'test_user', 'Switched to Sales tab', '2025-05-16 18:10:00'),
(255, 'test_user', 'Logged in', '2025-05-16 18:10:00'),
(256, 'chan', 'Switched to Sales tab', '2025-05-16 18:10:15'),
(257, 'chan', 'Logged in', '2025-05-16 18:10:15'),
(258, 'chan', 'Added 3 x Intel Core i5-13600K (Supplier: ElectroMart Supplies) to cart', '2025-05-16 18:10:23'),
(259, 'test_user', 'Switched to Sales tab', '2025-05-16 18:10:44'),
(260, 'test_user', 'Logged in', '2025-05-16 18:10:44'),
(261, 'test_user', 'Switched to Sales tab', '2025-05-16 18:10:49'),
(262, 'test_user', 'Logged in', '2025-05-16 18:10:49'),
(263, 'test_user', 'Switched to Sales tab', '2025-05-16 18:13:59'),
(264, 'test_user', 'Logged in', '2025-05-16 18:13:59'),
(265, 'chan', 'Switched to Sales tab', '2025-05-16 18:14:16'),
(266, 'chan', 'Logged in', '2025-05-16 18:14:16'),
(267, 'chan', 'Switched to Sales tab', '2025-05-16 18:15:49'),
(268, 'chan', 'Logged in', '2025-05-16 18:15:49'),
(269, 'test_user', 'Switched to Sales tab', '2025-05-16 18:16:20'),
(270, 'test_user', 'Logged in', '2025-05-16 18:16:20'),
(271, 'chan', 'Switched to Sales tab', '2025-05-16 18:24:44'),
(272, 'chan', 'Logged in', '2025-05-16 18:24:44'),
(273, 'chan', 'Switched to Sales tab', '2025-05-16 18:25:12'),
(274, 'chan', 'Logged in', '2025-05-16 18:25:12'),
(275, 'chan', 'Switched to Inventory tab', '2025-05-16 18:25:14'),
(276, 'chan', 'Switched to Reports tab', '2025-05-16 18:25:26'),
(277, 'chan', 'Switched to Sales tab', '2025-05-16 18:25:42'),
(278, 'test_user', 'Switched to Sales tab', '2025-05-16 18:29:19'),
(279, 'test_user', 'Logged in', '2025-05-16 18:29:19'),
(280, 'test_user', 'Switched to Sales tab', '2025-05-16 18:29:53'),
(281, 'test_user', 'Logged in', '2025-05-16 18:29:53'),
(282, 'test_user', 'Switched to Sales tab', '2025-05-16 18:30:16'),
(283, 'test_user', 'Logged in', '2025-05-16 18:30:16'),
(284, 'test_user', 'Switched to Sales tab', '2025-05-16 18:31:35'),
(285, 'test_user', 'Logged in', '2025-05-16 18:31:35'),
(286, 'test_user', 'Switched to Sales tab', '2025-05-16 18:31:58'),
(287, 'test_user', 'Logged in', '2025-05-16 18:31:58'),
(288, 'test_user', 'Added 1 x NVIDIA RTX 4080 (Supplier: GlobalTech Distributors) to cart', '2025-05-16 18:32:06'),
(289, 'test_user', 'Sale: 1 x NVIDIA RTX 4080 (Cash, Supplier: GlobalTech Distributors)', '2025-05-16 18:32:12'),
(290, 'test_user', 'Switched to Sales tab', '2025-05-16 18:33:27'),
(291, 'test_user', 'Logged in', '2025-05-16 18:33:27'),
(292, 'chan', 'Switched to Sales tab', '2025-05-16 18:33:47'),
(293, 'chan', 'Logged in', '2025-05-16 18:33:47'),
(294, 'chan', 'Added 2 x NVIDIA RTX 4080 (Supplier: ElectroMart Supplies) to cart', '2025-05-16 18:33:57'),
(295, 'chan', 'Sale: 2 x NVIDIA RTX 4080 (Cash, Supplier: ElectroMart Supplies)', '2025-05-16 18:33:59'),
(296, 'test_user', 'Switched to Sales tab', '2025-05-16 18:34:47'),
(297, 'test_user', 'Logged in', '2025-05-16 18:34:47'),
(298, 'chan', 'Switched to Sales tab', '2025-05-16 18:35:01'),
(299, 'chan', 'Logged in', '2025-05-16 18:35:01'),
(300, 'chan', 'Switched to Inventory tab', '2025-05-16 18:35:03'),
(301, 'chan', 'Switched to Reports tab', '2025-05-16 18:37:20'),
(302, 'chan', 'Switched to Logs tab', '2025-05-16 18:37:40'),
(303, 'chan', 'Switched to Reports tab', '2025-05-16 18:38:24'),
(304, 'admin', 'Switched to Employee History tab', '2025-05-16 18:39:47'),
(305, 'admin', 'Logged in', '2025-05-16 18:39:47'),
(306, 'admin', 'Switched to Employee History tab', '2025-05-16 18:39:49'),
(307, 'admin', 'Switched to Restock Inventory tab', '2025-05-16 18:40:08'),
(308, 'admin', 'Switched to Restock Inventory tab', '2025-05-16 18:40:08'),
(309, 'admin', 'Restocked 2 units of NVIDIA RTX 4090', '2025-05-16 18:40:24'),
(310, 'admin', 'Switched to Inventory tab', '2025-05-16 18:41:30'),
(311, 'admin', 'Switched to Sales Reports tab', '2025-05-16 18:42:00'),
(312, 'admin', 'Switched to Inventory tab', '2025-05-16 18:42:06'),
(313, 'admin', 'Switched to Restock Inventory tab', '2025-05-16 18:42:10'),
(314, 'admin', 'Switched to Inventory tab', '2025-05-16 18:42:12'),
(315, 'admin', 'Switched to Sales Reports tab', '2025-05-16 18:42:14'),
(316, 'admin', 'Switched to Inventory tab', '2025-05-16 18:42:35'),
(317, 'admin1', 'Switched to Employee History tab', '2025-05-16 18:45:06'),
(318, 'admin1', 'Logged in', '2025-05-16 18:45:06');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `name`, `price`, `stock`, `category`, `supplier_id`) VALUES
(1, 'Intel Core i9-13900K', 33999.00, 100, 'Processors', NULL),
(2, 'Intel Core i7-13700K', 23999.00, 120, 'Processors', NULL),
(3, 'Intel Core i5-13600K', 17999.00, 149, 'Processors', NULL),
(4, 'Intel Core i3-13100', 8499.00, 269, 'Processors', NULL),
(5, 'AMD Ryzen 9 7950X', 39999.00, 79, 'Processors', NULL),
(6, 'AMD Ryzen 7 7700X', 22999.00, 112, 'Processors', NULL),
(7, 'AMD Ryzen 5 7600X', 16999.00, 140, 'Processors', NULL),
(8, 'AMD Ryzen 3 5300G', 7999.00, 180, 'Processors', NULL),
(9, 'Intel Core i9-12900K', 29999.00, 90, 'Processors', NULL),
(10, 'Intel Core i7-12700K', 21999.00, 130, 'Processors', NULL),
(11, 'Intel Core i5-12600K', 15999.00, 160, 'Processors', NULL),
(12, 'Intel Core i3-12100F', 6999.00, 200, 'Processors', NULL),
(13, 'AMD Ryzen 9 5950X', 35999.00, 85, 'Processors', NULL),
(14, 'AMD Ryzen 7 5800X', 19999.00, 115, 'Processors', NULL),
(15, 'AMD Ryzen 5 5600X', 13999.00, 145, 'Processors', NULL),
(16, 'AMD Ryzen 3 4100', 5999.00, 190, 'Processors', NULL),
(17, 'Intel Core i7-11700K', 18999.00, 125, 'Processors', NULL),
(18, 'Intel Core i5-11600K', 12999.00, 155, 'Processors', NULL),
(19, 'AMD Ryzen 9 5900X', 31999.00, 95, 'Processors', NULL),
(20, 'AMD Ryzen 7 5700G', 17999.00, 135, 'Processors', NULL),
(21, 'NVIDIA RTX 4090', 94999.00, 52, 'Graphics Cards', NULL),
(22, 'NVIDIA RTX 4080', 71999.00, 57, 'Graphics Cards', NULL),
(23, 'NVIDIA RTX 4070 Ti', 47999.00, 80, 'Graphics Cards', NULL),
(24, 'NVIDIA RTX 4060', 19999.00, 118, 'Graphics Cards', NULL),
(25, 'AMD RX 7900 XTX', 57999.00, 70, 'Graphics Cards', NULL),
(26, 'AMD RX 7800 XT', 31999.00, 98, 'Graphics Cards', NULL),
(27, 'AMD RX 7700 XT', 25999.00, 110, 'Graphics Cards', NULL),
(28, 'AMD RX 7600', 15999.00, 140, 'Graphics Cards', NULL),
(29, 'NVIDIA RTX 3090', 69999.00, 65, 'Graphics Cards', NULL),
(30, 'NVIDIA RTX 3080', 45999.00, 85, 'Graphics Cards', NULL),
(31, 'NVIDIA RTX 3070', 29999.00, 105, 'Graphics Cards', NULL),
(32, 'NVIDIA RTX 3060', 18999.00, 130, 'Graphics Cards', NULL),
(33, 'AMD RX 6900 XT', 39999.00, 90, 'Graphics Cards', NULL),
(34, 'AMD RX 6800 XT', 33999.00, 95, 'Graphics Cards', NULL),
(35, 'AMD RX 6700 XT', 23999.00, 115, 'Graphics Cards', NULL),
(36, 'AMD RX 6600', 14999.00, 150, 'Graphics Cards', NULL),
(37, 'NVIDIA GTX 1660 Super', 12999.00, 160, 'Graphics Cards', NULL),
(38, 'NVIDIA GTX 1650', 8999.00, 180, 'Graphics Cards', NULL),
(39, 'AMD RX 580', 7999.00, 200, 'Graphics Cards', NULL),
(40, 'NVIDIA RTX 3050', 13999.00, 145, 'Graphics Cards', NULL),
(41, 'Corsair Vengeance 32GB DDR5', 7999.00, 120, 'Memory', NULL),
(42, 'G.Skill Trident Z 16GB DDR4', 3999.00, 150, 'Memory', NULL),
(43, 'Kingston Fury 64GB DDR5', 13999.00, 80, 'Memory', NULL),
(44, 'Crucial Ballistix 8GB DDR4', 1999.00, 200, 'Memory', NULL),
(45, 'Team T-Force 32GB DDR4', 5499.00, 130, 'Memory', NULL),
(46, 'Corsair Dominator 16GB DDR5', 5999.00, 140, 'Memory', NULL),
(47, 'G.Skill Ripjaws 32GB DDR4', 4999.00, 135, 'Memory', NULL),
(48, 'Kingston HyperX 16GB DDR4', 3499.00, 160, 'Memory', NULL),
(49, 'Crucial Pro 64GB DDR5', 11999.00, 90, 'Memory', NULL),
(50, 'Team Elite 8GB DDR4', 1799.00, 200, 'Memory', NULL),
(51, 'Corsair Vengeance 16GB DDR4', 3299.00, 170, 'Memory', NULL),
(52, 'G.Skill Aegis 32GB DDR4', 4799.00, 125, 'Memory', NULL),
(53, 'Kingston Fury 8GB DDR5', 2999.00, 180, 'Memory', NULL),
(54, 'Crucial Ballistix 16GB DDR4', 3399.00, 165, 'Memory', NULL),
(55, 'Team T-Force 64GB DDR5', 12999.00, 85, 'Memory', NULL),
(56, 'Corsair Dominator 32GB DDR5', 8999.00, 100, 'Memory', NULL),
(57, 'G.Skill Trident Z 8GB DDR4', 2499.00, 190, 'Memory', NULL),
(58, 'Kingston HyperX 32GB DDR4', 5299.00, 115, 'Memory', NULL),
(59, 'Crucial Pro 16GB DDR5', 3999.00, 145, 'Memory', NULL),
(60, 'Team Elite 32GB DDR4', 4499.00, 130, 'Memory', NULL),
(61, 'Samsung 990 Pro 2TB SSD', 11999.00, 100, 'Storage', NULL),
(62, 'WD Black SN850X 1TB SSD', 6999.00, 130, 'Storage', NULL),
(63, 'Crucial MX500 500GB SSD', 2999.00, 180, 'Storage', NULL),
(64, 'Seagate Barracuda 4TB HDD', 5999.00, 120, 'Storage', NULL),
(65, 'Samsung 870 EVO 1TB SSD', 5999.00, 140, 'Storage', NULL),
(66, 'WD Blue 2TB HDD', 3499.00, 160, 'Storage', NULL),
(67, 'Kingston NV2 1TB SSD', 3999.00, 150, 'Storage', NULL),
(68, 'Toshiba X300 6TB HDD', 7999.00, 90, 'Storage', NULL),
(69, 'Samsung 980 Pro 500GB SSD', 4999.00, 135, 'Storage', NULL),
(70, 'WD Black 8TB HDD', 10999.00, 80, 'Storage', NULL),
(71, 'Crucial P3 2TB SSD', 7999.00, 110, 'Storage', NULL),
(72, 'Seagate FireCuda 1TB SSD', 6499.00, 125, 'Storage', NULL),
(73, 'Samsung 870 QVO 4TB SSD', 15999.00, 70, 'Storage', NULL),
(74, 'WD Blue SN570 500GB SSD', 3499.00, 170, 'Storage', NULL),
(75, 'Toshiba N300 4TB HDD', 6499.00, 115, 'Storage', NULL),
(76, 'Kingston A2000 1TB SSD', 4999.00, 145, 'Storage', NULL),
(77, 'Seagate IronWolf 6TB HDD', 8999.00, 95, 'Storage', NULL),
(78, 'Samsung 990 EVO 1TB SSD', 6999.00, 120, 'Storage', NULL),
(79, 'WD Red 4TB HDD', 5999.00, 130, 'Storage', NULL),
(80, 'Crucial BX500 2TB SSD', 6499.00, 140, 'Storage', NULL),
(81, 'ASUS ROG Strix Z790-E', 22999.00, 80, 'Motherboards', NULL),
(82, 'MSI B550 Tomahawk', 9999.00, 120, 'Motherboards', NULL),
(83, 'Gigabyte Z690 Aorus', 15999.00, 100, 'Motherboards', NULL),
(84, 'ASRock B450 Steel Legend', 5999.00, 150, 'Motherboards', NULL),
(85, 'ASUS TUF Gaming X570', 11999.00, 110, 'Motherboards', NULL),
(86, 'MSI MPG Z490 Gaming', 10999.00, 115, 'Motherboards', NULL),
(87, 'Gigabyte B660M DS3H', 6999.00, 140, 'Motherboards', NULL),
(88, 'ASRock Z590 Phantom', 12999.00, 105, 'Motherboards', NULL),
(89, 'ASUS Prime B550M-A', 6499.00, 160, 'Motherboards', NULL),
(90, 'MSI B450 Gaming Plus', 5999.00, 170, 'Motherboards', NULL),
(91, 'Gigabyte X570 Aorus Elite', 10999.00, 120, 'Motherboards', NULL),
(92, 'ASRock B560 Pro4', 6999.00, 145, 'Motherboards', NULL),
(93, 'ASUS ROG Maximus Z690', 29999.00, 70, 'Motherboards', NULL),
(94, 'MSI Z590-A Pro', 9999.00, 130, 'Motherboards', NULL),
(95, 'Gigabyte B550 Aorus Pro', 8999.00, 125, 'Motherboards', NULL),
(96, 'ASRock X570 Taichi', 14999.00, 95, 'Motherboards', NULL),
(97, 'ASUS TUF B450-Plus', 6499.00, 155, 'Motherboards', NULL),
(98, 'MSI B660M Mortar', 7999.00, 135, 'Motherboards', NULL),
(99, 'Gigabyte Z790 UD', 11999.00, 100, 'Motherboards', NULL),
(100, 'ASRock B550 Extreme4', 8999.00, 115, 'Motherboards', NULL),
(101, 'Corsair RM850x', 7999.00, 120, 'Power Supplies', NULL),
(102, 'EVGA 750W Gold', 5999.00, 140, 'Power Supplies', NULL),
(103, 'Seasonic Focus 650W', 4999.00, 150, 'Power Supplies', NULL),
(104, 'Thermaltake Toughpower 850W', 6999.00, 110, 'Power Supplies', NULL),
(105, 'Cooler Master MWE 550W', 2999.00, 180, 'Power Supplies', NULL),
(106, 'Corsair CX650M', 3999.00, 160, 'Power Supplies', NULL),
(107, 'EVGA 850W Platinum', 8999.00, 100, 'Power Supplies', NULL),
(108, 'Seasonic Prime 1000W', 11999.00, 80, 'Power Supplies', NULL),
(109, 'Thermaltake Smart 500W', 2499.00, 200, 'Power Supplies', NULL),
(110, 'Cooler Master V750', 5999.00, 130, 'Power Supplies', NULL),
(111, 'Corsair RM750x', 6499.00, 125, 'Power Supplies', NULL),
(112, 'EVGA 600W Bronze', 3499.00, 170, 'Power Supplies', NULL),
(113, 'Seasonic Focus 750W', 5999.00, 135, 'Power Supplies', NULL),
(114, 'Thermaltake Litepower 450W', 1999.00, 190, 'Power Supplies', NULL),
(115, 'Cooler Master Elite 600W', 2999.00, 165, 'Power Supplies', NULL),
(116, 'Corsair SF600', 6999.00, 115, 'Power Supplies', NULL),
(117, 'EVGA 1000W Gold', 9999.00, 90, 'Power Supplies', NULL),
(118, 'Seasonic SSR-550FX', 4999.00, 145, 'Power Supplies', NULL),
(119, 'Thermaltake Toughpower 750W', 6499.00, 120, 'Power Supplies', NULL),
(120, 'Cooler Master V850', 7999.00, 105, 'Power Supplies', NULL),
(121, 'NZXT H510', 4999.00, 130, 'Cases', NULL),
(122, 'Lian Li PC-O11', 7999.00, 100, 'Cases', NULL),
(123, 'Fractal Design Meshify C', 5999.00, 120, 'Cases', NULL),
(124, 'Corsair 4000D Airflow', 6499.00, 115, 'Cases', NULL),
(125, 'Cooler Master MB511', 5499.00, 125, 'Cases', NULL),
(126, 'Phanteks Eclipse P400A', 4999.00, 135, 'Cases', NULL),
(127, 'NZXT H710i', 7999.00, 95, 'Cases', NULL),
(128, 'Lian Li Lancool 205', 5999.00, 110, 'Cases', NULL),
(129, 'Fractal Design Define 7', 8999.00, 90, 'Cases', NULL),
(130, 'Corsair iCUE 220T', 5499.00, 130, 'Cases', NULL),
(131, 'Cooler Master H500', 6999.00, 105, 'Cases', NULL),
(132, 'Phanteks Enthoo Pro', 6499.00, 115, 'Cases', NULL),
(133, 'NZXT H510 Elite', 6999.00, 100, 'Cases', NULL),
(134, 'Lian Li Lancool II Mesh', 6499.00, 120, 'Cases', NULL),
(135, 'Fractal Design Torrent', 7999.00, 95, 'Cases', NULL),
(136, 'Corsair Crystal 570X', 7999.00, 100, 'Cases', NULL),
(137, 'Cooler Master MasterBox Q300L', 3499.00, 150, 'Cases', NULL),
(138, 'Phanteks Evolv X', 9999.00, 85, 'Cases', NULL),
(139, 'NZXT H210', 4999.00, 130, 'Cases', NULL),
(140, 'Lian Li PC-O11 Air', 6999.00, 110, 'Cases', NULL),
(141, 'Logitech G Pro Keyboard', 5999.00, 120, 'Peripherals', NULL),
(142, 'Razer DeathAdder V2 Mouse', 3499.00, 150, 'Peripherals', NULL),
(143, 'SteelSeries Apex Pro', 7999.00, 100, 'Peripherals', NULL),
(144, 'HyperX Alloy Origins', 4999.00, 130, 'Peripherals', NULL),
(145, 'Logitech MX Master 3', 4999.00, 140, 'Peripherals', NULL),
(146, 'Razer BlackWidow V3', 6499.00, 110, 'Peripherals', NULL),
(147, 'SteelSeries Rival 5', 2999.00, 160, 'Peripherals', NULL),
(148, 'HyperX Pulsefire Surge', 2499.00, 170, 'Peripherals', NULL),
(149, 'Logitech G502 Hero', 3499.00, 145, 'Peripherals', NULL),
(150, 'Razer Basilisk V3', 3999.00, 135, 'Peripherals', NULL),
(151, 'SteelSeries Arctis 7', 6999.00, 105, 'Peripherals', NULL),
(152, 'HyperX Cloud II', 4999.00, 125, 'Peripherals', NULL),
(153, 'Logitech C920 Webcam', 3999.00, 140, 'Peripherals', NULL),
(154, 'Razer Seiren Mini', 2999.00, 150, 'Peripherals', NULL),
(155, 'SteelSeries QcK Prism', 2499.00, 160, 'Peripherals', NULL),
(156, 'Corsair K70 RGB MK.2', 6999.00, 115, 'Peripherals', NULL),
(157, 'Logitech G305 Wireless', 2999.00, 165, 'Peripherals', NULL),
(158, 'Razer Kraken X', 3499.00, 140, 'Peripherals', NULL),
(159, 'HyperX Cloud Alpha', 5999.00, 120, 'Peripherals', NULL),
(160, 'SteelSeries Aerox 3', 3999.00, 150, 'Peripherals', NULL),
(161, 'Noctua NH-U12S', 3999.00, 120, 'Cooling', NULL),
(162, 'Cooler Master Hyper 212', 2499.00, 150, 'Cooling', NULL),
(163, 'NZXT Kraken X63', 7999.00, 90, 'Cooling', NULL),
(164, 'Corsair H100i RGB', 6999.00, 100, 'Cooling', NULL),
(165, 'be quiet! Pure Rock 2', 2999.00, 140, 'Cooling', NULL),
(166, 'Arctic Freezer 34 eSports', 2499.00, 160, 'Cooling', NULL),
(167, 'Noctua NH-D15', 5999.00, 110, 'Cooling', NULL),
(168, 'Cooler Master MasterLiquid ML240L', 4999.00, 130, 'Cooling', NULL),
(169, 'NZXT Kraken Z73', 9999.00, 80, 'Cooling', NULL),
(170, 'Corsair H150i Elite', 8999.00, 95, 'Cooling', NULL),
(171, 'be quiet! Dark Rock Pro 4', 4999.00, 125, 'Cooling', NULL),
(172, 'Arctic Liquid Freezer II 240', 5999.00, 115, 'Cooling', NULL),
(173, 'Noctua NH-U14S', 4499.00, 135, 'Cooling', NULL),
(174, 'Cooler Master MasterAir MA410M', 3499.00, 145, 'Cooling', NULL),
(175, 'NZXT Kraken X53', 6499.00, 100, 'Cooling', NULL),
(176, 'Corsair H60', 3999.00, 150, 'Cooling', NULL),
(177, 'be quiet! Silent Loop 2 280mm', 6999.00, 105, 'Cooling', NULL),
(178, 'Arctic Freezer 50', 3499.00, 140, 'Cooling', NULL),
(179, 'Noctua NH-L9i', 2999.00, 160, 'Cooling', NULL),
(180, 'Cooler Master MasterLiquid ML360R', 7999.00, 90, 'Cooling', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `employee_username` varchar(255) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `sale_time` datetime DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `labor_cost` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `employee_username`, `item_id`, `quantity`, `total`, `payment_method`, `sale_time`, `supplier_id`, `labor_cost`) VALUES
(1, 'chan ', 24, 2, 39998.00, 'Cash', '2025-05-16 13:26:56', NULL, 0.00),
(2, 'test_user', 26, 2, 63998.00, 'Cash', '2025-05-16 17:02:16', NULL, 0.00),
(3, 'gwen', 5, 1, 39999.00, 'Cash', '2025-05-16 17:10:38', NULL, 0.00),
(4, 'test_user', 3, 1, 17999.00, 'Cash', '2025-05-16 17:15:46', 2, 0.00),
(5, 'test_user', 22, 1, 71999.00, 'Cash', '2025-05-16 18:32:12', 2, 0.00),
(6, 'chan', 22, 2, 143998.00, 'Cash', '2025-05-16 18:33:59', 3, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`) VALUES
(1, 'TechTrend Innovations'),
(2, 'GlobalTech Distributors'),
(3, 'ElectroMart Supplies');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `is_admin` tinyint(1) DEFAULT 0,
  `is_logged_in` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `is_admin`, `is_logged_in`) VALUES
(1, 'admin', 'admin123', 1, 0),
(2, 'chan', '1234', 0, 0),
(3, 'gwen', '1234', 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `admin_logs`
--
ALTER TABLE `admin_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_logs`
--
ALTER TABLE `employee_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_logs`
--
ALTER TABLE `admin_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_logs`
--
ALTER TABLE `employee_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=319;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=181;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE;

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`);

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
