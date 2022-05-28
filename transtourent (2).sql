-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 28, 2022 at 11:14 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `transtourent`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(15) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `firstname` varchar(20) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `age` varchar(3) NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `email` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `approval`
--

CREATE TABLE `approval` (
  `approval_id` int(15) NOT NULL,
  `transaction_id` int(15) NOT NULL,
  `admin_id` int(15) NOT NULL,
  `payment_id` int(15) NOT NULL,
  `status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(15) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `firstname` varchar(20) NOT NULL,
  `location` varchar(30) NOT NULL,
  `contact_num` varchar(11) NOT NULL,
  `email` varchar(30) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `birth_month` varchar(10) NOT NULL,
  `birth_day` int(2) NOT NULL,
  `birth_year` int(4) NOT NULL,
  `age` int(11) NOT NULL,
  `custValid_id` blob DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `lastname`, `firstname`, `location`, `contact_num`, `email`, `gender`, `birth_month`, `birth_day`, `birth_year`, `age`, `custValid_id`, `username`, `password`) VALUES
(1, 'aniñon', 'jude', 'mojon', '09123456789', 'evilmaster26@gmail.com', 'Male', 'march', 16, 2001, 21, '', 'yhnnel', 'yhnnel123'),
(2, 'Beltran', 'Reevenn', 'barili', '09987654321', 'noe@gmail.com', 'Female', 'october', 10, 2000, 21, '', 'noe', 'noe123'),
(3, 'Palay', 'Joshua', 'cambinocot', '09123123123', 'josh@gmail.com', 'Male', 'october', 20, 2000, 21, '', 'joshua', 'joshua123'),
(4, 'Aniñon', 'Jean Ricka', 'Sa heart ni Yhnnel', '09221234567', 'Rjeanricka@yahoo.com', 'Female', 'january', 30, 2001, 18, '', 'badamdam', 'yhnnel');

-- --------------------------------------------------------

--
-- Table structure for table `destination`
--

CREATE TABLE `destination` (
  `destination_id` int(15) NOT NULL,
  `destination` varchar(30) NOT NULL,
  `num_days` varchar(20) NOT NULL,
  `pick_address` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `destination`
--

INSERT INTO `destination` (`destination_id`, `destination`, `num_days`, `pick_address`) VALUES
(1, 'Santander', '3', 'Cebu');

-- --------------------------------------------------------

--
-- Table structure for table `driver`
--

CREATE TABLE `driver` (
  `driver_id` int(15) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `firstname` varchar(20) NOT NULL,
  `contact_num` varchar(11) NOT NULL,
  `email` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `driver`
--

INSERT INTO `driver` (`driver_id`, `lastname`, `firstname`, `contact_num`, `email`) VALUES
(1, 'loar', 'remie jay', '09123456789', 'rj@gmail.com'),
(2, 'paradero', 'jesse', '09123456789', 'jesse@gmail.com'),
(3, 'doe', 'john', '09123456789', 'john@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(15) NOT NULL,
  `customer_id` int(15) NOT NULL,
  `transaction_id` int(10) NOT NULL,
  `receipt` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rental`
--

CREATE TABLE `rental` (
  `rental_id` int(15) NOT NULL,
  `rental_num` varchar(20) NOT NULL,
  `rental-date` date NOT NULL,
  `time_depart` time NOT NULL,
  `time_arrive` time NOT NULL,
  `destination_id` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `report_id` int(15) NOT NULL,
  `transaction_id` int(15) NOT NULL,
  `approval_id` int(15) NOT NULL,
  `rental_id` int(15) NOT NULL,
  `report_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transaction_id` int(15) NOT NULL,
  `customer_id` int(15) NOT NULL,
  `vehicle_id` int(15) NOT NULL,
  `destination_id` int(10) NOT NULL,
  `total_payment` float(10,2) NOT NULL,
  `payment_id` int(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`transaction_id`, `customer_id`, `vehicle_id`, `destination_id`, `total_payment`, `payment_id`) VALUES
(1, 2, 2, 1, 24000.00, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE TABLE `vehicle` (
  `vehicle_id` int(15) NOT NULL,
  `vehicle_type` varchar(10) NOT NULL,
  `num_seat` int(10) NOT NULL,
  `rent_price` float(10,2) NOT NULL,
  `driver_id` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `vehicle`
--

INSERT INTO `vehicle` (`vehicle_id`, `vehicle_type`, `num_seat`, `rent_price`, `driver_id`) VALUES
(1, 'van', 12, 7000.00, 1),
(2, 'van', 15, 8000.00, 2),
(3, 'van', 18, 9000.00, 3),
(4, 'bus', 40, 10000.00, 1),
(5, 'bus', 50, 15000.00, 2),
(6, 'bus', 60, 20000.00, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `approval`
--
ALTER TABLE `approval`
  ADD PRIMARY KEY (`approval_id`),
  ADD KEY `key6` (`transaction_id`),
  ADD KEY `key7` (`admin_id`),
  ADD KEY `key8` (`payment_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `destination`
--
ALTER TABLE `destination`
  ADD PRIMARY KEY (`destination_id`);

--
-- Indexes for table `driver`
--
ALTER TABLE `driver`
  ADD PRIMARY KEY (`driver_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `key12` (`customer_id`),
  ADD KEY `transaction_id` (`transaction_id`);

--
-- Indexes for table `rental`
--
ALTER TABLE `rental`
  ADD PRIMARY KEY (`rental_id`),
  ADD KEY `key13` (`destination_id`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `key9` (`approval_id`),
  ADD KEY `key10` (`rental_id`),
  ADD KEY `key11` (`transaction_id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `key2` (`customer_id`),
  ADD KEY `key3` (`vehicle_id`),
  ADD KEY `key4` (`payment_id`),
  ADD KEY `desti====` (`destination_id`);

--
-- Indexes for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`vehicle_id`),
  ADD KEY `key1` (`driver_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `approval`
--
ALTER TABLE `approval`
  ADD CONSTRAINT `key6` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`),
  ADD CONSTRAINT `key7` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),
  ADD CONSTRAINT `key8` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `key12` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`);

--
-- Constraints for table `rental`
--
ALTER TABLE `rental`
  ADD CONSTRAINT `key13` FOREIGN KEY (`destination_id`) REFERENCES `destination` (`destination_id`);

--
-- Constraints for table `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `key10` FOREIGN KEY (`rental_id`) REFERENCES `rental` (`rental_id`),
  ADD CONSTRAINT `key11` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`transaction_id`),
  ADD CONSTRAINT `key9` FOREIGN KEY (`approval_id`) REFERENCES `approval` (`approval_id`);

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `desti====` FOREIGN KEY (`destination_id`) REFERENCES `destination` (`destination_id`),
  ADD CONSTRAINT `key2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `key3` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`vehicle_id`),
  ADD CONSTRAINT `key4` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`);

--
-- Constraints for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD CONSTRAINT `key1` FOREIGN KEY (`driver_id`) REFERENCES `driver` (`driver_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
