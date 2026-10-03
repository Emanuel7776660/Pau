-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-10-2026 a las 20:50:10
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `criptex_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `access_logs`
--

CREATE TABLE `access_logs` (
  `id` int(11) NOT NULL,
  `attempted_key` varchar(50) NOT NULL,
  `is_success` tinyint(1) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `access_logs`
--

INSERT INTO `access_logs` (`id`, `attempted_key`, `is_success`, `ip_address`, `created_at`) VALUES
(1, 'L-1-α', 0, '::1', '2026-10-03 17:42:24'),
(2, 'L-1-α', 0, '::1', '2026-10-03 17:42:27'),
(3, 'L-1-α', 0, '::1', '2026-10-03 17:42:28'),
(4, 'H-7-θ', 0, '::1', '2026-10-03 17:47:36'),
(5, 'H-7-θ', 0, '::1', '2026-10-03 17:47:37'),
(6, 'H-7-θ', 0, '::1', '2026-10-03 17:47:39'),
(7, 'H-7-θ', 0, '::1', '2026-10-03 17:47:40'),
(8, 'A-1-α', 0, '::1', '2026-10-03 17:49:54'),
(9, 'H-7-θ', 0, '::1', '2026-10-03 17:50:20'),
(10, 'H-7-θ', 0, '::1', '2026-10-03 17:50:21'),
(11, 'H-7-θ', 0, '::1', '2026-10-03 17:50:23'),
(12, 'H-7-θ', 0, '::1', '2026-10-03 17:50:23'),
(13, 'H-7-θ', 0, '::1', '2026-10-03 17:50:23'),
(14, 'H-7-θ', 0, '::1', '2026-10-03 17:50:24'),
(15, 'H-7-θ', 0, '::1', '2026-10-03 17:50:24'),
(16, 'I-1-θ', 0, '::1', '2026-10-03 17:53:52'),
(17, 'A-1-α', 1, '::1', '2026-10-03 17:55:47'),
(18, 'D-4-Δ', 1, '::1', '2026-10-03 18:18:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `secrets`
--

CREATE TABLE `secrets` (
  `id` int(11) NOT NULL,
  `key_hash` varchar(64) NOT NULL,
  `encrypted_content` text NOT NULL,
  `iv` varchar(64) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `secrets`
--

INSERT INTO `secrets` (`id`, `key_hash`, `encrypted_content`, `iv`, `created_at`) VALUES
(4, '3de8d66faa30613ef35803f87a703e1fdd9e7f61a83ca8f137db33130b6f77b0', '13IrhJQVhklT7KJtTRJXb9o0sNM4bBcSFSS2AVDA18A=', '865ec68a70e19b16', '2026-10-03 18:18:22');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `access_logs`
--
ALTER TABLE `access_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `secrets`
--
ALTER TABLE `secrets`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `access_logs`
--
ALTER TABLE `access_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `secrets`
--
ALTER TABLE `secrets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
