-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 12, 2025 at 11:07 AM
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
-- Database: `course_feedback_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `id` varchar(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  `instructor` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`id`, `name`, `instructor`) VALUES
('208d89f9-0b17-4172-8053-c401027cd9a0', 'Visual Programming', 'Dr. Emre'),
('3c790fc2-ef8b-4711-aaba-6c834c0c3ead', 'Data Structures', 'Dr. Volkan'),
('63cecdb7-fc38-4f90-8624-e61f9c9f08f0', 'Mobile Programming', 'Dr. Raif'),
('b880e9b7-c91c-48d6-99be-5cb97464dfb2', 'English', 'Alex Alex'),
('ba247ab4-84a5-40b7-b8a8-fee856021ad2', 'Database Management', 'Dr. Volkan'),
('d5ee3fbc-234c-11f0-b040-1065302497f8', 'Introduction to Programming', 'Dr. Smith'),
('d5ee517e-234c-11f0-b040-1065302497f8', 'Data Science Fundamentals', 'Prof. Jones'),
('d5ee529e-234c-11f0-b040-1065302497f8', 'Web Development', 'Dr. Lee');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` varchar(36) NOT NULL,
  `course_id` varchar(36) NOT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `difficulty` int(11) NOT NULL,
  `learning_experience` int(11) NOT NULL,
  `comment` text DEFAULT NULL,
  `instructor_response` text DEFAULT NULL,
  `anonymous` tinyint(1) DEFAULT 1,
  `username` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `course_id`, `user_id`, `difficulty`, `learning_experience`, `comment`, `instructor_response`, `anonymous`, `username`) VALUES
('09639a3f-bf17-45e9-b61f-412bf11f2e6b', '3c790fc2-ef8b-4711-aaba-6c834c0c3ead', NULL, 1, 1, 'First & last time', 'I accept that!', 1, NULL),
('4b13e91e-3f29-4c1a-80b8-d3580558f3a5', 'd5ee529e-234c-11f0-b040-1065302497f8', NULL, 5, 1, 'Didn\'t like it', 'I accept your opinion.. I tried my best though ', 1, NULL),
('51e0efb3-8abb-4628-a741-869e3ce06c4a', 'd5ee3fbc-234c-11f0-b040-1065302497f8', '24082687-97c2-405e-afdd-3edeb676cef2', 3, 4, 'Great course', 'Thanks!!', 1, NULL),
('655c72c3-c98a-4164-990a-e56cba079041', '63cecdb7-fc38-4f90-8624-e61f9c9f08f0', NULL, 5, 1, 'That was a terrible one', 'I accept your opinion', 1, NULL),
('a454c866-eff3-4ed3-846d-2f322a6c0088', '208d89f9-0b17-4172-8053-c401027cd9a0', NULL, 1, 4, 'It was a good course', 'thank you', 1, NULL),
('a59f28fe-7e8b-4ba1-bec0-16e45d15edae', '63cecdb7-fc38-4f90-8624-e61f9c9f08f0', NULL, 1, 5, 'Fantastic!!!', 'Thanks', 1, NULL),
('bd22cbd5-b5e7-423d-9659-55d8199912a3', 'd5ee3fbc-234c-11f0-b040-1065302497f8', '24082687-97c2-405e-afdd-3edeb676cef2', 2, 2, 'Very BAD!!!!!!!!!!!!!!!', NULL, 0, 'Omar'),
('d38c171b-05f0-4c65-a2ac-babde7c07260', '3c790fc2-ef8b-4711-aaba-6c834c0c3ead', NULL, 1, 1, 'Not Good ', NULL, 1, NULL),
('d5f0d842-234c-11f0-b040-1065302497f8', 'd5ee3fbc-234c-11f0-b040-1065302497f8', NULL, 3, 4, 'Good course, but challenging assignments', 'all thanks for that mate!!', 1, NULL),
('d5f0eae0-234c-11f0-b040-1065302497f8', 'd5ee517e-234c-11f0-b040-1065302497f8', NULL, 4, 5, 'Really enjoyed the practical labs', NULL, 0, NULL),
('d5f0ec9c-234c-11f0-b040-1065302497f8', 'd5ee529e-234c-11f0-b040-1065302497f8', NULL, 2, 3, 'Could use more hands-on projects', 'Thanks for the feedback!!!', 1, NULL),
('e46be4db-2ffd-4e74-a543-209cb270da34', '3c790fc2-ef8b-4711-aaba-6c834c0c3ead', NULL, 2, 5, 'Thanks a lot !!!! ..... it was an amazing course!', 'I really appreciate it!!!!', 1, NULL),
('ecc5dd7a-9743-4a4f-9b47-29680e2da1bd', '63cecdb7-fc38-4f90-8624-e61f9c9f08f0', NULL, 3, 3, 'It was fun!!', 'thanks for the great feedback... good luck!!', 1, NULL),
('f64345aa-346f-4cfc-b8b7-aebb02dff340', 'ba247ab4-84a5-40b7-b8a8-fee856021ad2', NULL, 2, 4, 'It was a great experience!!', 'thanks', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` varchar(36) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` enum('student','instructor') DEFAULT 'student'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `role`) VALUES
('0600894f-c6b2-4f30-a28b-fed1aa082f77', 'student1', '$2b$12$P.U9gcUUdb.gLZs5ZL0Up.YFdxzsHhfLR44FNIGhGMI5zaFtZX436', 'student'),
('24082687-97c2-405e-afdd-3edeb676cef2', 'Omar', '$2b$12$BqeA3hqKJ0dEINghg772dORjWU2GXZFpTTsGw2/sunpKUSCTrGFIi', 'student'),
('814457d0-f4d3-47f2-a47b-44a337b4c886', 'Dr. Volkan', '$2b$12$.0Z9hncvn2Hwa4C3vGme.etIQiwGJ0KQn7zbORXIwmw4fKQzS409m', 'instructor'),
('83755d00-5f51-4490-94c8-d3bc310dac54', 'Mohammed', '$2b$12$XbH/I6BbEXzcDB7928zkKu2ijjtBAtlM7Q/0AMBtxExIO979pyxl2', 'student'),
('9840900c-c3c7-4e69-8e56-c5d6d00b08c6', 'Dr. Emre', '$2b$12$hm/88ZPXagEVhHehHIdZeu91rAjjOed9Emp9lsXenJOBI4TZjct9W', 'instructor'),
('ca6bf62e-2608-4252-99f7-881e50ddda12', 'student2', '$2b$12$WaYp3m0HTNNfXEWQsD.bDemWHWdCTcZBdE0VdowUgPXNhQosb/Gqm', 'student'),
('f1a2b3c4-5d6e-7f8a-9b0c-1d2e3f4a5b6c', 'Dr. Raif', '$2b$12$BqeA3hqKJ0dEINghg772dORjWU2GXZFpTTsGw2/sunpKUSCTrGFIi', 'instructor'),
('g2b3c4d5-6e7f-8a9b-0c1d-2e3f4a5b6c7d', 'Alex Alex', '$2b$12$BqeA3hqKJ0dEINghg772dORjWU2GXZFpTTsGw2/sunpKUSCTrGFIi', 'instructor'),
('h3c4d5e6-7f8a-9b0c-1d2e-3f4a5b6c7d8e', 'Dr. Smith', '$2b$12$BqeA3hqKJ0dEINghg772dORjWU2GXZFpTTsGw2/sunpKUSCTrGFIi', 'instructor'),
('i4d5e6f7-8a9b-0c1d-2e3f-4a5b6c7d8e9f', 'Prof. Jones', '$2b$12$BqeA3hqKJ0dEINghg772dORjWU2GXZFpTTsGw2/sunpKUSCTrGFIi', 'instructor'),
('j5e6f7a8-9b0c-1d2e-3f4a-5b6c7d8e9f0a', 'Dr. Lee', '$2b$12$BqeA3hqKJ0dEINghg772dORjWU2GXZFpTTsGw2/sunpKUSCTrGFIi', 'instructor');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
