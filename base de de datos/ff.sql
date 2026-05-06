-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-11-2024 a las 15:51:41
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
-- Base de datos: `ff`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `dpi` varchar(255) DEFAULT NULL,
  `comentarios` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `correo`, `telefono`, `direccion`, `dpi`, `comentarios`) VALUES
(1, 'Yolanda Navas', 'ynavas@gmail.com', '78961122', '6a Avenida 3-45, Zona 1, Guatemala', '2456 78901 0101', 'Sin comentarios'),
(2, 'Arnoldo Cruz', 'acruz@gmail.com', '52965474', 'Calle Real 12-34, Zona 7, Mixco', '1998 12345 0101', 'Sin comentarios'),
(3, 'Joaquin Marroquin', 'jmarroquin@gmail.com', '85635421', '5ta Calle 10-15, Zona 10, Guatemala', '3215 67482 0101', 'Sin comentarios'),
(4, 'Erbi Garcia', 'egarcia@gmail.com', '77225849', '2a Avenida 6-22, Zona 5, Villa Nueva', '1452 96328 0101', 'Sin comentarios'),
(5, 'Francisco Barrera', 'fbarrera@gmail.com', '98644777', 'Boulevard El Naranjo 23-45, Zona 4, Mixco', '3689 74125 0101', 'Sin comentarios'),
(6, 'Steven Flores', 'sflores@gmail.com', '35979965', '5ta calle 17-73, Zona 4, Condominio Villa Nova, Villa Nueva, Guatemala', '3689 74125 0101', 'ninguno');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `id_compra` int(11) NOT NULL,
  `id_proveedor` int(11) DEFAULT NULL,
  `fecha_compra` date DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id_compra`, `id_proveedor`, `fecha_compra`, `total`) VALUES
(1, 1, '2024-10-26', 295.65),
(2, 1, '2024-10-26', 295.65),
(3, 1, '2024-10-27', 145.00),
(4, 1, '2024-10-29', 154.19),
(5, 1, '2024-11-01', 83.00),
(6, 1, '2024-11-03', 426.82),
(7, 1, '2024-11-03', 985.70),
(8, 1, '2024-11-13', 1.60),
(9, 1, '2024-11-13', 22.50);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--

CREATE TABLE `facturas` (
  `id` int(11) NOT NULL,
  `id_proveedor` int(11) NOT NULL,
  `numero_factura` varchar(50) NOT NULL,
  `fecha_factura` date DEFAULT NULL,
  `producto` varchar(100) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `facturas`
--

INSERT INTO `facturas` (`id`, `id_proveedor`, `numero_factura`, `fecha_factura`, `producto`, `precio`, `cantidad`, `total`) VALUES
(1, 1, '5954745', '2024-10-08', 'Esponja para lavar vehiculos', 12.22, 3, 36.66),
(2, 1, '5852476', '2024-10-05', 'Esponja para lavar vehiculos', 12.00, 2, 24.00),
(3, 1, '4008264427', '2024-10-01', 'Alfombra de papel', 7.75, 50, 387.50),
(4, 1, '4008264427', '2024-10-01', 'Alfombra de papel', 50.00, 50, 2500.00),
(5, 1, '5954745', '2024-10-08', 'Toalla de microfibra', 79.00, 8, 632.00),
(6, 1, '5852476', '2024-10-05', 'Toalla de microfibra', 8.88, 12, 106.56),
(7, 1, '4008264427', '2024-10-01', 'Desodorante ambiental', 5.22, 4, 20.88),
(8, 1, '4008264427', '2024-10-01', 'Desodorante ambiental', 5.55, 1, 5.55);

--
-- Disparadores `facturas`
--
DELIMITER $$
CREATE TRIGGER `actualizar_total_factura` BEFORE UPDATE ON `facturas` FOR EACH ROW BEGIN
    IF NEW.precio != OLD.precio OR NEW.cantidad != OLD.cantidad THEN
        SET NEW.total = NEW.cantidad * NEW.precio;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `actualizar_total_factura_v2` BEFORE INSERT ON `facturas` FOR EACH ROW BEGIN
    SET NEW.total = NEW.cantidad * NEW.precio;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login`
--

CREATE TABLE `login` (
  `id` int(11) NOT NULL,
  `user` varchar(300) NOT NULL,
  `username` varchar(300) NOT NULL,
  `password` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `login`
--

INSERT INTO `login` (`id`, `user`, `username`, `password`) VALUES
(1, 'Samus Aran', 'samus', '123456');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_car_wash`
--

CREATE TABLE `productos_car_wash` (
  `id` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `id_proveedor` int(11) DEFAULT NULL,
  `fecha_compra` date DEFAULT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos_car_wash`
--

INSERT INTO `productos_car_wash` (`id`, `codigo`, `nombre`, `descripcion`, `id_proveedor`, `fecha_compra`, `cantidad`, `precio`, `subtotal`) VALUES
(1, '001', 'Esponja para lavar vehiculos', 'Son especialmente para absorber agua o productos liquidos.', 1, '2024-11-13', 23.00, 7.50, 172.50),
(2, '002', 'Alfombra de papel', 'Son especialmente para el cuidado de las alfombras.', 1, '2024-11-13', 102.00, 0.80, 81.60),
(3, '003', 'Toalla de microfibra', 'Toallas Ultra Suaves de Microfibra, 24 toallas Ideal para no generar rayones en las superficies, no dejan pelusa, larga duracion.', 1, '2024-11-03', 23.00, 5.83, 134.09),
(4, '004', 'Desodorante ambiental', 'Actua inmediatamente neutralizando y destruyendo los malos olores, aromas fresa, vainilla, canela, chica fresa, disponible en aromas franceses como Carolina Herrera, Paris Hilton, Paco Rabanne, 212, capacidad caneca de 5 gls. gallon, 8 oz. Con atomizador.', 1, '2024-11-03', 15.00, 45.00, 675.00),
(5, '005', 'Atomizador industrial completo', 'Son especialmente para contener y dispersar productos.', 1, '2024-09-13', 20.00, 17.00, 340.00),
(6, '006', 'Multilimpiador con aroma', 'Capacidad caneca 5 gls, gallon, 24 oz Con atomizador, modo de uso diluir una parte de producto por una de agua, atomice en la superficie a limpiar, frote con cepillo y retire la suciedad con toalla humedad.', 1, '2024-09-13', 5.00, 55.00, 275.00),
(7, '007', 'Silicon de tablero', 'Aromas fresa, cherry, carro nuevo, vainilla, canela, chicle, almendra, Tambien disponible en aromas franceses, capacidad caneca de 5 gls, gallon, 8 oz. Con atomizador, Descripcion renueva y protege superficies de vinil, cuero y plastico.', 1, '2024-09-13', 5.00, 55.00, 275.00),
(8, '008', 'Renovador de cuero', 'Su proteccion prolongada ayuda a cuidar el tapizado de todos los agentes externos que puedan dañarlo como el polvo, las manchas y los liquidos derramados. Ademas de eliminar la suciedad, brinda protección y deja un aspecto natural, sin terminaciones grasosas.', 1, '2024-09-13', 5.00, 75.00, 375.00),
(9, '009', 'Shampoo para vehiculo', 'Capacidad caneca de 5 gls, galon, litro, descripción por el contenido de acrilac protege y renueva la pintura del vehiculo, modo de uso aplicar 6 onzas de producto por una cubeta de agua, no permitir que el producto se seque en la superficie.', 1, '2024-09-13', 5.00, 45.00, 225.00),
(10, '010', 'Desengrasante de motor extreme', 'Capacidad caneca de 5 gls, galon, litro, 24 oz, con atomizador, descripción especial para limpiar y liberar.', 1, '2024-09-13', 5.00, 55.00, 275.00),
(11, '011', 'Silicon de motor', 'Descripción proporciona una capa protectora sobre la superficie del motor, ideal para todo tipo de motor.', 1, '2024-10-27', 6.00, 90.00, 540.00),
(12, '012', 'Silicon de llantas liquido', 'Formula que produce un alto prolongado de brillo a las llantas de su vehiculo, repeliendo el polvo al 90%, capacidad caneca 5 gls, galon, litro, 8 oz. Con atomizador, modo de uso aplicar con atomizador.', 1, '2024-10-27', 4.00, 55.00, 220.00),
(14, '013', 'WP-LIMPIADOR BLANCO', 'Poderoso y eficiente limpiador disenado para eliminar manchas dificiles y suciedad en diversas superficies', 2, '2024-10-29', 5.00, 11.00, 55.00);

--
-- Disparadores `productos_car_wash`
--
DELIMITER $$
CREATE TRIGGER `actualizar_subtotal` BEFORE UPDATE ON `productos_car_wash` FOR EACH ROW BEGIN
  IF NEW.cantidad IS NOT NULL AND NEW.precio IS NOT NULL THEN
    SET NEW.subtotal = NEW.cantidad * NEW.precio;
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `calcular_subtotal` BEFORE INSERT ON `productos_car_wash` FOR EACH ROW SET NEW.subtotal = NEW.cantidad * NEW.precio
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_compra`
--

CREATE TABLE `productos_compra` (
  `id_producto` int(11) DEFAULT NULL,
  `id_compra` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos_compra`
--

INSERT INTO `productos_compra` (`id_producto`, `id_compra`, `cantidad`, `precio`) VALUES
(1, 1, 5, 7.50),
(2, 1, 5, 0.80),
(3, 1, 5, 5.83),
(4, 1, 5, 45.00),
(1, 2, 5, 7.50),
(2, 2, 5, 0.80),
(3, 2, 5, 5.83),
(4, 2, 5, 45.00),
(11, 3, 1, 90.00),
(12, 3, 1, 55.00),
(1, 4, 7, 7.50),
(2, 4, 9, 0.80),
(3, 4, 3, 5.83),
(14, 4, 7, 11.00),
(1, 5, 10, 7.50),
(2, 5, 10, 0.80),
(1, 6, 7, 7.50),
(2, 6, 18, 0.80),
(3, 7, 7, 5.83),
(4, 7, 10, 45.00),
(2, 8, 2, 0.80),
(1, 9, 3, 7.50);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`id`, `nombre`, `correo`, `telefono`, `direccion`) VALUES
(1, 'QUIMERA QuimicosDeLaEra', 'ventasquimera@outlook.com', '6640-4325', '22 Calle 6-79 Residenciales Fuentes del valle II Zona 5 Villa Nueva'),
(2, 'Quimicos FERKICA', 'ventas@quimicosferkica.com', '2305 5700', 'Av Centro América 14-20, Cdad. de Guatemala 01001');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor_vehiculo`
--

CREATE TABLE `proveedor_vehiculo` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedor_vehiculo`
--

INSERT INTO `proveedor_vehiculo` (`id`, `nombre`, `correo`, `telefono`, `direccion`) VALUES
(1, 'IAA', 'iaa@gmail.com', '+1-630-686-4097', 'wo Westbrook Corporate Center, 10th Floor, en Westchester, Illinois 60154, Estados Unidos'),
(2, 'Autowini', 'autowini@gmail.com', '+82-2-576-5533', '3F, Handok Bldg., 2645, Nambusunhwan-ro, Gangnam-gu, Seoul, 06271, South Korea');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id`, `descripcion`) VALUES
(1, 'ADMIN');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `salida_productos`
--

CREATE TABLE `salida_productos` (
  `id` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `id_proveedor` int(11) DEFAULT NULL,
  `fecha_salida` date DEFAULT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `precio` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `salida_productos`
--

INSERT INTO `salida_productos` (`id`, `codigo`, `nombre`, `descripcion`, `id_proveedor`, `fecha_salida`, `cantidad`, `precio`) VALUES
(1, '001', 'Esponja para lavar vehiculos', 'Son especialmente para absorber agua o productos liquidos.', 1, '2024-10-26', 5.00, 7.50),
(2, '002', 'Alfombra de papel', 'Son especialmente para el cuidado de las alfombras.', 1, '2024-10-26', 5.00, 0.80),
(3, '003', 'Toalla de microfibra', 'Toallas Ultra Suaves de Microfibra, 24 toallas Ideal para no generar rayones en las superficies, no dejan pelusa, larga duracion.', 1, '2024-10-26', 5.00, 5.83),
(4, '004', 'Desodorante ambiental', 'Actua inmediatamente neutralizando y destruyendo los malos olores, aromas fresa, vainilla, canela, chica fresa, disponible en aromas franceses como Carolina Herrera, Paris Hilton, Paco Rabanne, 212, capacidad caneca de 5 gls. gallon, 8 oz. Con atomizador.', 1, '2024-10-26', 5.00, 45.00),
(5, '001', 'Esponja para lavar vehiculos', 'Son especialmente para absorber agua o productos liquidos.', 1, '2024-10-26', 5.00, 7.50),
(6, '002', 'Alfombra de papel', 'Son especialmente para el cuidado de las alfombras.', 1, '2024-10-26', 5.00, 0.80),
(7, '003', 'Toalla de microfibra', 'Toallas Ultra Suaves de Microfibra, 24 toallas Ideal para no generar rayones en las superficies, no dejan pelusa, larga duracion.', 1, '2024-10-26', 5.00, 5.83),
(8, '004', 'Desodorante ambiental', 'Actua inmediatamente neutralizando y destruyendo los malos olores, aromas fresa, vainilla, canela, chica fresa, disponible en aromas franceses como Carolina Herrera, Paris Hilton, Paco Rabanne, 212, capacidad caneca de 5 gls. gallon, 8 oz. Con atomizador.', 1, '2024-10-26', 5.00, 45.00),
(9, '013', 'WP-LIMPIADOR BLANCO', 'Poderoso y eficiente limpiador disenado para eliminar manchas dificiles y suciedad en diversas superficies', 1, '2024-10-29', 2.00, 11.00),
(10, '001', 'Esponja para lavar vehiculos', 'Son especialmente para absorber agua o productos liquidos.', 1, '2024-10-29', 7.00, 7.50),
(11, '002', 'Alfombra de papel', 'Son especialmente para el cuidado de las alfombras.', 1, '2024-10-29', 9.00, 0.80),
(12, '002', 'Alfombra de papel', 'Son especialmente para el cuidado de las alfombras.', 1, '2024-10-30', 10.00, 0.80),
(13, '001', 'Esponja para lavar vehiculos', 'Son especialmente para absorber agua o productos liquidos.', 1, '2024-11-03', 2.00, 7.50),
(14, '002', 'Alfombra de papel', 'Son especialmente para el cuidado de las alfombras.', 1, '2024-11-03', 18.00, 0.80),
(15, '003', 'Toalla de microfibra', 'Toallas Ultra Suaves de Microfibra, 24 toallas Ideal para no generar rayones en las superficies, no dejan pelusa, larga duracion.', 1, '2024-11-03', 7.00, 5.83),
(16, '004', 'Desodorante ambiental', 'Actua inmediatamente neutralizando y destruyendo los malos olores, aromas fresa, vainilla, canela, chica fresa, disponible en aromas franceses como Carolina Herrera, Paris Hilton, Paco Rabanne, 212, capacidad caneca de 5 gls. gallon, 8 oz. Con atomizador.', 1, '2024-11-03', 10.00, 45.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `tiempo` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`id`, `nombre`, `descripcion`, `precio`, `tiempo`) VALUES
(1, 'Servicio de lavado interno', 'Lavado completo del interior del vehículo', 25.00, '00:30:00'),
(2, 'Servicio de lavado externo', 'Lavado detallado del exterior del vehículo', 25.00, '00:30:00'),
(3, 'Servicio lavado externo e interno', 'Lavado completo exterior e interior', 45.00, '00:35:00'),
(4, 'Servicio de lavado de motor', 'Limpieza detallada del motor', 75.00, '00:30:00'),
(5, 'Servicio ojo de pescado', 'Limpieza especial para quitar manchas difíciles', 75.00, '00:30:00'),
(6, 'Servicio de lavado de tapiceria', 'Lavado profundo de tapicería y asientos', 400.00, '72:00:00'),
(7, 'Servicio de lustrada', 'Pulido y encerado de la carrocería', 150.00, '01:00:00'),
(8, 'Servicio de pulida', 'Pulido profesional del vehículo', 500.00, '02:00:00'),
(9, 'Servicio de pulida aros', 'Pulido de los aros de las llantas', 200.00, '01:00:00'),
(10, 'Servicio de pulida silvin', 'Pulido de los faros delanteros', 150.00, '00:30:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios_vendidos`
--

CREATE TABLE `servicios_vendidos` (
  `id` int(11) NOT NULL,
  `id_clientes` int(11) NOT NULL,
  `id_servicios` int(11) NOT NULL,
  `fecha_servicio` date NOT NULL,
  `marca` varchar(100) NOT NULL,
  `modelo` varchar(100) NOT NULL,
  `color` varchar(50) NOT NULL,
  `linea` varchar(100) NOT NULL,
  `precio` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `servicios_vendidos`
--

INSERT INTO `servicios_vendidos` (`id`, `id_clientes`, `id_servicios`, `fecha_servicio`, `marca`, `modelo`, `color`, `linea`, `precio`) VALUES
(1, 6, 3, '2024-10-26', 'Toyota', '2018', 'Gris Osc Pol Con Fil Negro', 'RAV4 LE AWD', 45.00),
(2, 6, 5, '2024-10-26', 'Toyota', '2018', 'Gris Osc Pol Con Fil Negro', 'RAV4 LE AWD', 75.00),
(3, 6, 7, '2024-10-26', 'Toyota', '2018', 'Gris Osc Pol Con Fil Negro', 'RAV4 LE AWD', 150.00),
(4, 4, 4, '2024-10-26', 'Honda', '2001', 'Gris Pol Con Fil Negro', 'CR-V LX 2WD ', 75.00),
(5, 3, 1, '2024-11-03', 'Honda', '2006', 'Azul', 'CR-V EX 4WD', 25.00),
(6, 3, 2, '2024-11-03', 'Honda', '2006', '', 'CR-V EX 4WD', 25.00),
(7, 2, 6, '2024-11-03', 'Mazda', '2007', 'Morado', 'CX-5', 400.00),
(8, 2, 5, '2024-11-03', 'Honda', '2008', 'Negro', 'CR-V LX 2WD', 75.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `avatar` varchar(300) NOT NULL,
  `nombre` varchar(300) NOT NULL,
  `planeta` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `avatar`, `nombre`, `planeta`) VALUES
(1, 'https://i.imgur.com/gh3fPj5.png', 'Sams', 'K-2L'),
(3, 'https://i.imgur.com/hvhZNd3.jpg', 'Sylux', 'Cylosis');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_nuevos`
--

CREATE TABLE `usuarios_nuevos` (
  `id` int(11) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `nombre` varchar(300) NOT NULL,
  `usuario` varchar(300) NOT NULL,
  `contrasena` varchar(300) NOT NULL,
  `rol` varchar(100) DEFAULT NULL,
  `estado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios_nuevos`
--

INSERT INTO `usuarios_nuevos` (`id`, `correo`, `nombre`, `usuario`, `contrasena`, `rol`, `estado`) VALUES
(1, 'sflores@gmail.com', 'Steven Flores', 'sflores', '$2b$10$g0JoRkCi6rZ.7rnegIWk...9glDr0XJZtAUNYwYc4a9tK4pJvljwa', '1', 'Activo'),
(2, 'brodriguez@gmail.com', 'Brayna Rodriguez', 'brodriguez', '$2b$10$u7m6EZRS/nF84gKIRQXsB.yoS6cAd.ecDOmh91Lqh545GTo3epRKO', '1', 'Inactivo'),
(3, 'arodriguez@gmail.com', 'Abigail Rodriguez', 'arodriguez', '$2b$10$7VlGbhXrlqA4F14bM9CdzexXBqqBCybFg0Q8kjES0PXufyI9l0qrS', '1', 'Activo'),
(4, 'fcontreras@gmail.com', 'Francisco Contreras', 'fcontreras', '$2b$10$rsrwCVtBnUmRQWf9SUyMDuawIfHvjDCMlk9ZiP98Jo5jVOlJk1NY2', '1', 'Activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculos_predio`
--

CREATE TABLE `vehiculos_predio` (
  `id` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `placa` varchar(20) NOT NULL,
  `tipo_vehiculo` varchar(50) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `color` varchar(20) DEFAULT NULL,
  `uso` varchar(50) DEFAULT NULL,
  `linea` varchar(50) DEFAULT NULL,
  `chasis` varchar(50) DEFAULT NULL,
  `serie` varchar(50) DEFAULT NULL,
  `numero_asientos` int(11) DEFAULT NULL,
  `ejes` int(11) DEFAULT NULL,
  `numero_vin` varchar(20) NOT NULL,
  `motor` varchar(50) DEFAULT NULL,
  `cilindros` int(11) DEFAULT NULL,
  `c_c` int(11) DEFAULT NULL,
  `id_proveedor_vehiculo` int(11) DEFAULT NULL,
  `fecha_compra` date DEFAULT NULL,
  `precio_compra` decimal(10,2) DEFAULT NULL,
  `precio_vehiculo` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vehiculos_predio`
--

INSERT INTO `vehiculos_predio` (`id`, `codigo`, `placa`, `tipo_vehiculo`, `marca`, `modelo`, `color`, `uso`, `linea`, `chasis`, `serie`, `numero_asientos`, `ejes`, `numero_vin`, `motor`, `cilindros`, `c_c`, `id_proveedor_vehiculo`, `fecha_compra`, `precio_compra`, `precio_vehiculo`) VALUES
(1, '001', 'M-014JFQ', 'Cuatrimoto', 'Italika', '2022', 'Anaranjado Negro', 'MOTOCICLETA', 'ATV200 ', 'LRPRAL308NA022808', 'LRPRAL308NA022808', 2, 2, 'LRPRAL308NA022808', '1P65QML 1M017972', 1, 200, 1, '2024-09-20', 15000.00, 20000.00),
(2, '002', 'P-017KML', 'Camioneta', 'Kia', '2022', 'Negro Pol Con Fil Ne', 'PARTICULAR', 'SELTOS SX AWD', ' KNDETCA21N7238971 ', ' KNDETCA21N7238971 ', 5, 2, ' KNDETCA21N7238971 ', 'G4FJ MH622982', 4, 1600, 1, '2024-09-20', 130000.00, 150000.00),
(3, '003', 'P-317KSC', 'Automovil', 'Chevrolet', '2013', 'Blanco', 'PARTICULAR ', 'SPARK LT', 'KL8CD6S90DC551588', 'KL8CD6S90DC551588', 4, 2, 'KL8CD6S90DC551588', 'B12D2 NO VISIBLE POR CORROSION', 4, 1200, 1, '2024-09-20', 30000.00, 40000.00),
(4, '004', 'P-503KFB', 'Microbus', 'Hyundai', '2012', 'Plateado', 'PARTICULAR', 'GRAND STAREX CVX', 'KMJWA37JBCU416020', 'KMJWA37JBCU416020', 12, 2, 'KMJWA37JBCU416020', 'D4CB B913925', 4, 2497, 1, '2024-09-20', 50000.00, 60000.00),
(5, '005', 'M-520KFB', 'Moto', 'Italika', '2023', 'Negro Naranja', 'MOTOCICLETA ', 'DM250 ', 'LZSJCNLC1P1001255', 'LZSJCNLC1P1001255', 2, 2, 'LZSJCNLC1P1001255', 'ZS167FMM5P120396', 1, 250, 1, '2024-09-20', 12000.00, 14000.00),
(6, '006', 'P-586KXM', 'Camioneta', 'Mazda', '2013', 'Gris Oscuro Pol Con ', 'PARTICULAR', 'CX-9 GRAND TOURING AWD', 'JM3TB3DV2D0419611', 'JM3TB3DV2D0419611', 7, 2, 'JM3TB3DV2D0419611', 'CA10472222', 6, 3700, 1, '2024-09-20', 50000.00, 75000.00),
(7, '007', 'P-587KXM', 'Camioneta', 'Honda', '2006', 'Beige Pol Con Fil Ne', 'PARTICULAR ', 'CR-V EX 4WD', 'SHSRD78886U411650', 'SHSRD78886U411650', 5, 2, 'SHSRD78886U411650', 'K24A1 5514229', 4, 2400, 1, '2024-09-20', 35000.00, 40000.00),
(8, '008', 'P-588KXM', 'Camioneta', 'Kia', '2015	', 'Azul Pol', 'PARTICULAR', 'SPORTAGE LX AWD', 'KNDPBCAC6F7740560', 'KNDPBCAC6F7740560', 5, 2, 'KNDPBCAC6F7740560', 'G4KJ *KDR02496*', 4, 2400, 1, '2024-09-20', 50000.00, 60000.00),
(9, '009', 'P-589KXM', 'Automovil', 'Ford', '2019', 'Blanco', 'PARTICULAR', 'FIESTA S', '3FADP4AJ9KM129002 ', '3FADP4AJ9KM129002 ', 5, 2, '3FADP4AJ9KM129002 ', '*KM129002*', 4, 1600, 1, '2024-09-20', 35000.00, 45000.00),
(10, '010', 'P-590KXM', 'Automovil', 'Toyota', '2017', 'Corinto Pol', 'PARTICULAR ', 'YARIS IA', '3MYDLBYV9HY161616', '3MYDLBYV9HY161616', 5, 2, '3MYDLBYV9HY161616', 'P540341428', 4, 1500, 1, '2024-09-20', 50000.00, 75000.00),
(11, '011', 'P-678KWF', 'Camioneta', 'Hyundai', '2010', 'Blanco Pol', 'PARTICULAR', 'SANTA FE GLS FWD', '5NMSG3AB3AH406782', '5NMSG3AB3AH406782', 5, 2, '5NMSG3AB3AH406782', 'G4KE AKA221714', 4, 2400, 1, '2024-09-20', 35000.00, 45000.00),
(12, '012', 'P-679KWF', 'Automovil', 'Mitsubishi', '2019', 'Azul Claro Pol', 'PARTICULAR', 'MIRAGE G4 ES', 'A13AKHF03092', 'ML32F3FJ9KHF03092 ', 5, 2, 'ML32F3FJ9KHF03092 ', '3A92 UHK1793', 3, 1200, 1, '2024-09-20', 40000.00, 50000.00),
(13, '013', 'P-680KWF', 'Automovil', 'Nissan', '2019', 'Corinto Pol Con Lin ', 'PARTICULAR ', 'VERSA SV', '3N1CN7AP2KL836257', '3N1CN7AP2KL836257', 5, 2, '3N1CN7AP2KL836257', '*HR16*894743P', 4, 1600, 1, '2024-09-20', 35000.00, 50000.00),
(14, '014', 'P-682KKT', 'Camioneta', 'Toyota', '2009', 'Gris Claro Pol Con F', 'PARTICULAR', '4RUNNER SR5 4WD ', 'JTEBU14R89K037337', 'JTEBU14R89K037337', 7, 2, 'JTEBU14R89K037337', '1GR 0944517', 6, 4000, 1, '2024-09-20', 100000.00, 115000.00),
(15, '015', 'P-682KWF', 'Camioneta', 'Toyota', '2018', 'Gris Osc Pol Con Fil', 'PARTICULAR', 'RAV4 LE AWD', 'JTMBFREV1JJ205676', 'JTMBFREV1JJ205676', 5, 2, 'JTMBFREV1JJ205676', '2AR F557731', 4, 2500, 1, '2024-09-20', 100000.00, 140000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculos_vendidos`
--

CREATE TABLE `vehiculos_vendidos` (
  `id` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `placa` varchar(20) NOT NULL,
  `tipo_vehiculo` varchar(50) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `color` varchar(20) DEFAULT NULL,
  `uso` varchar(50) DEFAULT NULL,
  `linea` varchar(50) DEFAULT NULL,
  `chasis` varchar(50) DEFAULT NULL,
  `serie` varchar(50) DEFAULT NULL,
  `numero_asientos` int(11) DEFAULT NULL,
  `ejes` int(11) DEFAULT NULL,
  `numero_vin` varchar(20) NOT NULL,
  `motor` varchar(50) DEFAULT NULL,
  `cilindros` int(11) DEFAULT NULL,
  `c_c` int(11) DEFAULT NULL,
  `id_clientes` int(11) NOT NULL,
  `fecha_venta` date DEFAULT NULL,
  `precio_compra` decimal(10,2) DEFAULT NULL,
  `precio_venta` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vehiculos_vendidos`
--

INSERT INTO `vehiculos_vendidos` (`id`, `codigo`, `placa`, `tipo_vehiculo`, `marca`, `modelo`, `color`, `uso`, `linea`, `chasis`, `serie`, `numero_asientos`, `ejes`, `numero_vin`, `motor`, `cilindros`, `c_c`, `id_clientes`, `fecha_venta`, `precio_compra`, `precio_venta`) VALUES
(1, '019', 'P0 - 048DHM', 'Automovil', 'AUDI', '2007', 'GRIS DELFIN', 'PARTICULAR', 'COROLLA 1.8L', 'JTDBU4EE0AJ089124', 'JTDBU4EE0AJ089124', 5, 2, 'JTDBU4EE0AJ089124', '', 4, 1781, 6, '2024-10-27', 20000.00, 26000.00),
(2, '018', 'P-705JXT', 'Camioneta', 'Toyota', '2004', 'Gris Osc Pol', 'PARTICULAR', '4RUNNER LIMITED 4X4', 'JTEBU17R548019525', 'JTEBU17R548019525', 5, 2, 'JTEBU17R548019525', '1GR 0130926', 6, 4000, 1, '2024-10-27', 55000.00, 60000.00),
(3, '020', 'P0-356FHR', 'Automovil', 'Toyota', '2015', 'Blanco Perla', 'PARTICULAR', 'COROLLA 1.8L', 'JTDBU4EE0AJ089124', 'JTDBU4EE0AJ089124', 5, 2, 'JTDBU4EE0AJ089124', '2ZRFE1234567', 4, 1781, 6, '0000-00-00', 40000.00, 48000.00),
(4, '021', 'P0-523DFR', 'Camioneta', 'Mazda', '2013', 'Dorado', 'PARTICULAR', 'CX-9 GRAND TOURING AWD', 'JM3TB3DV2D0419611333', 'JM3TB3DV2D0419611333', 7, 2, 'JM3TB3DV2D041911333', 'ZB10472333', 6, 3700, 5, '2024-11-04', 50000.00, 77000.00);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id_compra`);

--
-- Indices de la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos_car_wash`
--
ALTER TABLE `productos_car_wash`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos_compra`
--
ALTER TABLE `productos_compra`
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_compra` (`id_compra`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `proveedor_vehiculo`
--
ALTER TABLE `proveedor_vehiculo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `salida_productos`
--
ALTER TABLE `salida_productos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `servicios_vendidos`
--
ALTER TABLE `servicios_vendidos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios_nuevos`
--
ALTER TABLE `usuarios_nuevos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `vehiculos_predio`
--
ALTER TABLE `vehiculos_predio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proveedor_vehiculo` (`id_proveedor_vehiculo`);

--
-- Indices de la tabla `vehiculos_vendidos`
--
ALTER TABLE `vehiculos_vendidos`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `facturas`
--
ALTER TABLE `facturas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `login`
--
ALTER TABLE `login`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `productos_car_wash`
--
ALTER TABLE `productos_car_wash`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `proveedor_vehiculo`
--
ALTER TABLE `proveedor_vehiculo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `salida_productos`
--
ALTER TABLE `salida_productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `servicios_vendidos`
--
ALTER TABLE `servicios_vendidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios_nuevos`
--
ALTER TABLE `usuarios_nuevos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `vehiculos_predio`
--
ALTER TABLE `vehiculos_predio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `vehiculos_vendidos`
--
ALTER TABLE `vehiculos_vendidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `productos_compra`
--
ALTER TABLE `productos_compra`
  ADD CONSTRAINT `productos_compra_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos_car_wash` (`id`),
  ADD CONSTRAINT `productos_compra_ibfk_2` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id_compra`);

--
-- Filtros para la tabla `vehiculos_predio`
--
ALTER TABLE `vehiculos_predio`
  ADD CONSTRAINT `vehiculos_predio_ibfk_1` FOREIGN KEY (`id_proveedor_vehiculo`) REFERENCES `proveedor_vehiculo` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
