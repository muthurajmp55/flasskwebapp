-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 30, 2021 at 08:22 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `automate_recruitment`
--

-- --------------------------------------------------------

--
-- Table structure for table `cba_admin`
--

CREATE TABLE `cba_admin` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `email` varchar(200) DEFAULT NULL,
  `password` varchar(200) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cba_admin`
--

INSERT INTO `cba_admin` (`id`, `name`, `email`, `password`, `created_date`) VALUES
(1, 'admin', 'admin@cba.com.in', 'admin123', '2021-05-30 19:20:20');

-- --------------------------------------------------------

--
-- Table structure for table `cba_employee`
--

CREATE TABLE `cba_employee` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(200) DEFAULT NULL,
  `role` varchar(200) NOT NULL,
  `team` varchar(200) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('0','1','2','3') NOT NULL COMMENT '0-firstround,1-secondround,2-selected,3-onboard'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cba_employee`
--

INSERT INTO `cba_employee` (`id`, `name`, `email`, `role`, `team`, `created_date`, `updated_date`, `status`) VALUES
(4, 'karthikeyan', NULL, 'Developer', 'Process automation team', '2021-05-28 14:58:50', '2021-05-28 09:28:50', '0'),
(5, 'jai', NULL, 'Datascientist', 'Process Automation', '2021-05-28 15:00:18', '2021-05-28 10:36:22', '3'),
(6, 'rahul', NULL, 'Developer', 'Process Automation', '2021-05-30 22:54:33', '2021-05-30 17:24:33', '1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cba_admin`
--
ALTER TABLE `cba_admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cba_employee`
--
ALTER TABLE `cba_employee`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cba_employee`
--
ALTER TABLE `cba_employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
