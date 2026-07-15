-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-07-2026 a las 19:41:16
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tamagotchi`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_acciones`
--

CREATE TABLE `historial_acciones` (
  `id_accion` int(11) NOT NULL,
  `id_mascota` int(11) NOT NULL,
  `accion` varchar(100) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `historial_acciones`
--

INSERT INTO `historial_acciones` (`id_accion`, `id_mascota`, `accion`, `fecha`) VALUES
(1, 3, 'Alimento recibido', '2026-07-11 07:02:36'),
(2, 3, 'Alimento recibido', '2026-07-11 07:02:40'),
(3, 3, 'Alimento recibido', '2026-07-11 07:03:12'),
(4, 3, 'Alimento recibido', '2026-07-11 07:04:14'),
(5, 3, 'Alimento recibido', '2026-07-11 07:06:24'),
(6, 3, 'Alimento recibido', '2026-07-11 07:06:28'),
(7, 3, 'La mascota comio alimento', '2026-07-11 07:09:00'),
(8, 3, 'La mascota comio alimento', '2026-07-11 07:09:05'),
(9, 3, 'La mascota comio alimento', '2026-07-11 07:09:09'),
(10, 3, '🎁 Encontraste un tesoro escondido', '2026-07-11 07:31:39'),
(11, 3, '⚔️ Superaste un reto junto a tu mascota', '2026-07-11 07:31:41'),
(12, 3, '⚔️ Superaste un reto junto a tu mascota', '2026-07-11 07:31:42'),
(13, 3, '🌲 Exploraste el bosque y encontraste algo interesante', '2026-07-11 07:31:43'),
(14, 3, '💤 Tu mascota descansó', '2026-07-11 07:31:45'),
(15, 3, '⚔️ Superaste un reto junto a tu mascota', '2026-07-11 07:31:49'),
(16, 3, '🎁 Encontraste un tesoro escondido', '2026-07-11 07:31:51'),
(17, 3, '🌲 Exploraste el bosque y encontraste algo interesante', '2026-07-11 07:31:54'),
(18, 3, '💤 Tu mascota descansó', '2026-07-11 07:31:55'),
(19, 3, '⚔️ Superaste un reto junto a tu mascota', '2026-07-11 07:31:58'),
(20, 3, '🎁 Encontraste un tesoro escondido', '2026-07-11 07:31:59'),
(21, 4, '⚔️ Superaste un reto junto a tu mascota', '2026-07-11 07:39:44'),
(22, 4, '🎁 Encontraste un tesoro escondido', '2026-07-11 07:39:46'),
(23, 4, '🌲 Exploraste el bosque y encontraste algo interesante', '2026-07-11 07:39:48'),
(24, 4, 'Durmió', '2026-07-11 07:39:56'),
(25, 5, 'Comió alimento', '2026-07-12 01:04:00'),
(26, 5, 'Durmió', '2026-07-12 01:04:12'),
(27, 5, 'Comió alimento', '2026-07-12 01:04:21'),
(28, 5, 'Comió alimento', '2026-07-12 01:07:30'),
(29, 5, '🌲 Exploraste el bosque y encontraste algo interesante', '2026-07-12 01:08:37'),
(30, 5, '⚔️ Superaste un reto junto a tu mascota', '2026-07-12 01:08:38'),
(31, 5, '🎁 Encontraste un tesoro escondido', '2026-07-12 01:08:39'),
(32, 1, '⚔️ Superaste un reto junto a tu mascota', '2026-07-14 04:56:11'),
(33, 1, '🌲 Exploraste el bosque y encontraste algo interesante', '2026-07-14 04:56:13'),
(34, 1, '💤 Tu mascota descansó', '2026-07-14 04:56:14'),
(35, 1, '⚔️ Superaste un reto junto a tu mascota', '2026-07-14 05:11:01'),
(36, 1, '⚔️ Superaste un reto junto a tu mascota', '2026-07-14 05:11:03'),
(37, 1, '⚔️ Superaste un reto junto a tu mascota', '2026-07-14 05:11:04'),
(38, 1, '⚔️ Superaste un reto junto a tu mascota', '2026-07-14 05:11:05'),
(39, 1, '⚔️ Superaste un reto junto a tu mascota', '2026-07-14 05:11:06'),
(40, 1, '⚔️ Superaste un reto junto a tu mascota', '2026-07-14 05:11:07'),
(41, 1, '🌲 Exploraste el bosque y encontraste algo interesante', '2026-07-14 05:11:08'),
(42, 1, '⚔️ Superaste un reto junto a tu mascota', '2026-07-14 05:11:09'),
(43, 1, '🌲 Exploró el bosque y encontró monedas', '2026-07-14 05:29:53'),
(44, 1, '🌲 Exploró el bosque y encontró monedas', '2026-07-14 05:29:56'),
(45, 1, '🌲 Exploró el bosque y encontró monedas', '2026-07-14 05:29:58'),
(46, 1, '⚔️ Superó un reto y ganó una recompensa', '2026-07-14 05:29:59'),
(47, 1, '💎 Encontró un tesoro escondido', '2026-07-14 05:30:01'),
(48, 1, '💤 Descansó y recuperó energía', '2026-07-14 05:30:03'),
(49, 1, '💤 Descansó y recuperó energía', '2026-07-14 05:30:04'),
(50, 1, 'Ganó 15 monedas jugando palabras', '2026-07-14 05:33:21'),
(51, 1, 'Ganó 15 monedas jugando palabras', '2026-07-14 05:35:27'),
(52, 1, 'Ganó 15 monedas jugando palabras', '2026-07-14 05:35:27'),
(53, 1, 'Ganó 15 monedas jugando palabras', '2026-07-14 05:35:27'),
(54, 1, 'Ganó 15 monedas jugando palabras', '2026-07-14 05:35:39'),
(55, 6, 'Ganó 15 monedas jugando palabras', '2026-07-14 05:39:49'),
(56, 6, 'Ganó 15 monedas jugando palabras', '2026-07-14 05:47:40'),
(57, 7, 'Ganó 15 monedas jugando palabras', '2026-07-15 17:15:37'),
(58, 8, 'Ganó 15 monedas jugando palabras', '2026-07-15 17:23:24'),
(59, 8, 'Durmió', '2026-07-15 17:31:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id_item` int(11) NOT NULL,
  `id_mascota` int(11) NOT NULL,
  `nombre_objeto` varchar(100) NOT NULL,
  `cantidad` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mascotas`
--

CREATE TABLE `mascotas` (
  `id_mascota` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `tipo` enum('Perro','Gato') NOT NULL,
  `nombre_mascota` varchar(50) DEFAULT NULL,
  `hambre` int(11) DEFAULT 100,
  `felicidad` int(11) DEFAULT 100,
  `energia` int(11) DEFAULT 100,
  `salud` int(11) DEFAULT 100,
  `dinero` int(11) DEFAULT 50,
  `nivel` int(11) DEFAULT 1,
  `experiencia` int(11) DEFAULT 0,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mascotas`
--

INSERT INTO `mascotas` (`id_mascota`, `id_usuario`, `tipo`, `nombre_mascota`, `hambre`, `felicidad`, `energia`, `salud`, `dinero`, `nivel`, `experiencia`, `fecha_creacion`) VALUES
(1, 3, 'Perro', 'pau', 40, 97, 55, 100, 315, 1, 295, '2026-07-11 06:40:48'),
(2, 3, 'Perro', 'pau', 65, 79, 65, 100, 50, 1, 0, '2026-07-11 06:41:23'),
(3, 1, 'Perro', 'pau', 100, 100, 100, 100, 165, 1, 145, '2026-07-11 06:45:50'),
(4, 4, 'Gato', 'juansito', 100, 100, 100, 100, 100, 1, 45, '2026-07-11 07:39:23'),
(5, 5, 'Perro', 'pablo', 100, 100, 100, 100, 100, 1, 45, '2026-07-12 01:03:52'),
(6, 7, 'Gato', 'sandrita', 90, 100, 90, 100, 80, 1, 20, '2026-07-14 05:39:05'),
(7, 8, 'Gato', 'Pablo', 90, 97, 90, 100, 65, 1, 10, '2026-07-15 17:14:25'),
(8, 9, 'Perro', 'Chiringas', 75, 93, 90, 100, 65, 1, 10, '2026-07-15 17:22:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tienda`
--

CREATE TABLE `tienda` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `precio` int(11) NOT NULL,
  `categoria` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tienda`
--

INSERT INTO `tienda` (`id_producto`, `nombre`, `precio`, `categoria`) VALUES
(1, 'Croquetas', 10, 'Comida'),
(2, 'Carne', 20, 'Comida'),
(3, 'Pescado', 25, 'Comida'),
(4, 'Leche', 15, 'Comida'),
(5, 'Pelota', 40, 'Juguete'),
(6, 'Hueso', 25, 'Juguete'),
(7, 'Ratón de Juguete', 30, 'Juguete'),
(8, 'Collar Azul', 60, 'Accesorio'),
(9, 'Collar Rosa', 60, 'Accesorio'),
(10, 'Sombrero', 80, 'Accesorio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `edad` int(11) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `edad`, `correo`, `password`, `fecha_registro`) VALUES
(1, 'Emanuel', 18, 'emanuel@gmail.com', '12345', '2026-07-11 06:15:37'),
(2, 'Emanuel E', 10, 'emanuelito@gmail.com', '123456', '2026-07-11 06:30:41'),
(3, 'pau', 9, 'pau@gmail.com', '1234', '2026-07-11 06:34:43'),
(4, 'juan', 61, 'juan@gmail.com', '12345', '2026-07-11 07:38:53'),
(5, 'Pablo', 19, 'pablo@gmail.com', '12345', '2026-07-12 01:03:01'),
(6, 'Lupita', 19, 'lu@gmail.com', '1234', '2026-07-13 17:22:36'),
(7, 'Sandra', 40, 'sandra@gmail.com', '12345', '2026-07-14 05:38:47'),
(8, 'Paulita', 25, 'paulis@gmail.com', '12345', '2026-07-15 17:14:01'),
(9, 'Ruben', 23, 'Rubensito@gmail.com', '12345', '2026-07-15 17:21:56');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `historial_acciones`
--
ALTER TABLE `historial_acciones`
  ADD PRIMARY KEY (`id_accion`),
  ADD KEY `fk_mascota_historial` (`id_mascota`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id_item`),
  ADD KEY `fk_mascota_inventario` (`id_mascota`);

--
-- Indices de la tabla `mascotas`
--
ALTER TABLE `mascotas`
  ADD PRIMARY KEY (`id_mascota`),
  ADD KEY `fk_usuario` (`id_usuario`);

--
-- Indices de la tabla `tienda`
--
ALTER TABLE `tienda`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `historial_acciones`
--
ALTER TABLE `historial_acciones`
  MODIFY `id_accion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id_item` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mascotas`
--
ALTER TABLE `mascotas`
  MODIFY `id_mascota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `tienda`
--
ALTER TABLE `tienda`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `historial_acciones`
--
ALTER TABLE `historial_acciones`
  ADD CONSTRAINT `fk_mascota_historial` FOREIGN KEY (`id_mascota`) REFERENCES `mascotas` (`id_mascota`) ON DELETE CASCADE;

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `fk_mascota_inventario` FOREIGN KEY (`id_mascota`) REFERENCES `mascotas` (`id_mascota`) ON DELETE CASCADE;

--
-- Filtros para la tabla `mascotas`
--
ALTER TABLE `mascotas`
  ADD CONSTRAINT `fk_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
