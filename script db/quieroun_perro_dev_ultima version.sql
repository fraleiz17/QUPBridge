# SQL Manager Lite for MySQL 5.4.3.43929
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : quieroun_perro_dev


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES latin1 */;

SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `quieroun_perro_dev`;

CREATE DATABASE `quieroun_perro_dev`
    CHARACTER SET 'latin1'
    COLLATE 'latin1_swedish_ci';

USE `quieroun_perro_dev`;

#
# Dropping database objects
#

DROP TABLE IF EXISTS `zonageograficaestado`;
DROP TABLE IF EXISTS `zonageografica`;
DROP TABLE IF EXISTS `vs_database_diagrams`;
DROP TABLE IF EXISTS `visita`;
DROP TABLE IF EXISTS `videos`;
DROP TABLE IF EXISTS `ubicacionusuario`;
DROP TABLE IF EXISTS `usuariodato`;
DROP TABLE IF EXISTS `roltienepermiso`;
DROP TABLE IF EXISTS `rol`;
DROP TABLE IF EXISTS `raza`;
DROP TABLE IF EXISTS `publicaciones`;
DROP TABLE IF EXISTS `productodetalle`;
DROP TABLE IF EXISTS `permiso`;
DROP TABLE IF EXISTS `pais`;
DROP TABLE IF EXISTS `mensajes`;
DROP TABLE IF EXISTS `giroempresa`;
DROP TABLE IF EXISTS `usuariodetalle`;
DROP TABLE IF EXISTS `giro`;
DROP TABLE IF EXISTS `fotostienda`;
DROP TABLE IF EXISTS `fotospublicacion`;
DROP TABLE IF EXISTS `fotoscontenido`;
DROP TABLE IF EXISTS `favoritos`;
DROP TABLE IF EXISTS `estado`;
DROP TABLE IF EXISTS `cuponadquirido`;
DROP TABLE IF EXISTS `cupondetalle`;
DROP TABLE IF EXISTS `serviciocontratado`;
DROP TABLE IF EXISTS `detallepaquete`;
DROP TABLE IF EXISTS `tipopaquete`;
DROP TABLE IF EXISTS `cupon`;
DROP TABLE IF EXISTS `paquete`;
DROP TABLE IF EXISTS `contenido`;
DROP TABLE IF EXISTS `contadormensajes`;
DROP TABLE IF EXISTS `compradetalle`;
DROP TABLE IF EXISTS `compra`;
DROP TABLE IF EXISTS `ci_sessions`;
DROP TABLE IF EXISTS `catalogoproductos`;
DROP TABLE IF EXISTS `carritototal`;
DROP TABLE IF EXISTS `carrito`;
DROP TABLE IF EXISTS `usuario`;
DROP TABLE IF EXISTS `banner`;
DROP TABLE IF EXISTS `seccion`;

#
# Structure for the `seccion` table : 
#

CREATE TABLE `seccion` (
  `seccionID` INTEGER(10) NOT NULL AUTO_INCREMENT,
  `seccionNombre` VARCHAR(50) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY USING BTREE (`seccionID`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=18 AVG_ROW_LENGTH=1092 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `banner` table : 
#

CREATE TABLE `banner` (
  `bannerID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `imgbaner` VARCHAR(100) COLLATE utf8_general_ci NOT NULL,
  `texto` VARCHAR(50) COLLATE utf8_general_ci NOT NULL,
  `zonaID` INTEGER(11) NOT NULL DEFAULT 9,
  `posicion` INTEGER(11) DEFAULT NULL COMMENT '1 - arriba 2 - centro -3 abajo - 4 lateral',
  `seccionID` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`bannerID`, `zonaID`) COMMENT '',
   INDEX `pertenece` USING BTREE (`zonaID`) COMMENT '',
   INDEX `seccion` USING BTREE (`seccionID`) COMMENT '',
  CONSTRAINT `banner_fk1` FOREIGN KEY (`seccionID`) REFERENCES `seccion` (`seccionID`)
)ENGINE=InnoDB
AUTO_INCREMENT=17 AVG_ROW_LENGTH=2340 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `usuario` table : 
#

CREATE TABLE `usuario` (
  `idUsuario` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(39) COLLATE utf8_general_ci NOT NULL,
  `apellido` VARCHAR(65) COLLATE utf8_general_ci NOT NULL,
  `telefono` INTEGER(10) NOT NULL,
  `correo` VARCHAR(45) COLLATE utf8_general_ci NOT NULL,
  `contrasena` VARCHAR(100) COLLATE utf8_general_ci NOT NULL,
  `recepcionCorreo` INTEGER(1) NOT NULL DEFAULT 1 COMMENT '1 - recepciï¿½n de correo activa\n 0 - recepciï¿½n de correo inactiva',
  `tipoUsuario` INTEGER(1) NOT NULL DEFAULT 1 COMMENT '0 - Administrador\n1 - usuario normal\n2 - negocio\n3 - AC',
  `status` INTEGER(1) NOT NULL DEFAULT 0 COMMENT '0 - no activado\n1 - activo',
  `nivel` INTEGER(11) DEFAULT NULL COMMENT 'establecimiento de jerarquï¿½a en usuarios',
  `codigoConfirmacion` VARCHAR(100) COLLATE utf8_general_ci NOT NULL COMMENT 'cï¿½digo necesario para confirmar cuenta.',
  `fechaRegistro` DATETIME NOT NULL,
  `useragent` VARCHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `last_ip_access` VARCHAR(16) COLLATE utf8_general_ci DEFAULT NULL,
  `authKey` VARCHAR(100) COLLATE utf8_general_ci DEFAULT NULL,
  `paqueteGratis` INTEGER(11) DEFAULT 1 COMMENT 'si paquete gratis = 1 no lo ha usado, si = 0 entonces ya tiene costo',
  PRIMARY KEY USING BTREE (`idUsuario`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=8 AVG_ROW_LENGTH=3276 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `carrito` table : 
#

CREATE TABLE `carrito` (
  `cartID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `usuarioID` INTEGER(11) DEFAULT NULL,
  `productoID` INTEGER(11) DEFAULT NULL,
  `cantidad` INTEGER(11) DEFAULT NULL COMMENT 'cantidad',
  `precio` FLOAT(5,2) DEFAULT NULL,
  `nombre` VARCHAR(120) COLLATE utf8_general_ci DEFAULT NULL,
  `talla` VARCHAR(120) COLLATE utf8_general_ci DEFAULT NULL,
  `color` VARCHAR(70) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`cartID`) COMMENT '',
   INDEX `usuarioID` USING BTREE (`usuarioID`) COMMENT '',
  CONSTRAINT `carrito_fk1` FOREIGN KEY (`usuarioID`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=5 AVG_ROW_LENGTH=8192 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `carritototal` table : 
#

CREATE TABLE `carritototal` (
  `carritoTotalID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `usuarioID` INTEGER(11) DEFAULT NULL,
  `totalProductos` FLOAT(9,2) DEFAULT NULL,
  `totalPrecio` FLOAT(9,2) DEFAULT NULL,
  `subtotal` FLOAT(9,2) DEFAULT NULL,
  `descuento` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`carritoTotalID`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=2 AVG_ROW_LENGTH=16384 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `catalogoproductos` table : 
#

CREATE TABLE `catalogoproductos` (
  `productoID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) COLLATE utf8_general_ci NOT NULL,
  `descripcion` TEXT COLLATE utf8_general_ci NOT NULL,
  `sku` VARCHAR(30) COLLATE utf8_general_ci NOT NULL,
  `precio` FLOAT(7,2) NOT NULL,
  PRIMARY KEY USING BTREE (`productoID`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=18 AVG_ROW_LENGTH=1024 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `ci_sessions` table : 
#

CREATE TABLE `ci_sessions` (
  `session_id` VARCHAR(40) COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `ip_address` VARCHAR(16) COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `user_agent` VARCHAR(120) COLLATE utf8_general_ci NOT NULL,
  `last_activity` INTEGER(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_data` TEXT COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY USING BTREE (`session_id`) COMMENT '',
   INDEX `last_activity_idx` USING BTREE (`last_activity`) COMMENT ''
)ENGINE=InnoDB
AVG_ROW_LENGTH=9362 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT='tabla necesaria para CodeIgniter ... '
;

#
# Structure for the `compra` table : 
#

CREATE TABLE `compra` (
  `compraID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `usuarioID` INTEGER(11) NOT NULL,
  `subtotal` FLOAT(5,2) NOT NULL,
  `idCuponAdquirido` INTEGER(11) DEFAULT NULL,
  `descuento` INTEGER(2) DEFAULT NULL,
  `total` FLOAT(5,2) NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY USING BTREE (`compraID`) COMMENT '',
   INDEX `usuarioID` USING BTREE (`usuarioID`) COMMENT '',
  CONSTRAINT `compra_fk1` FOREIGN KEY (`usuarioID`) REFERENCES `usuario` (`idUsuario`)
)ENGINE=InnoDB
AUTO_INCREMENT=6 AVG_ROW_LENGTH=5461 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `compradetalle` table : 
#

CREATE TABLE `compradetalle` (
  `compraDetalleID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `compraID` INTEGER(11) NOT NULL,
  `productoID` INTEGER(11) NOT NULL,
  `cantidad` INTEGER(11) NOT NULL,
  `precio` FLOAT(5,2) NOT NULL,
  `nombre` VARCHAR(120) COLLATE utf8_general_ci NOT NULL,
  `talla` VARCHAR(120) COLLATE utf8_general_ci NOT NULL,
  `color` VARCHAR(120) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY USING BTREE (`compraDetalleID`) COMMENT '',
   INDEX `compraID` USING BTREE (`compraID`) COMMENT '',
  CONSTRAINT `compradetalle_fk1` FOREIGN KEY (`compraID`) REFERENCES `compra` (`compraID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=7 AVG_ROW_LENGTH=4096 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `contadormensajes` table : 
#

CREATE TABLE `contadormensajes` (
  `contadorID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `cantMensajes` CHAR(20) COLLATE utf8_general_ci NOT NULL,
  `idUsuario` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`contadorID`) COMMENT '',
   INDEX `tiene` USING BTREE (`idUsuario`) COMMENT '',
  CONSTRAINT `tiene` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `contenido` table : 
#

CREATE TABLE `contenido` (
  `contenidoID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `seccionID` INTEGER(1) NOT NULL,
  `seccionDetalle` VARCHAR(50) COLLATE utf8_general_ci NOT NULL,
  `texto` TEXT COLLATE utf8_general_ci NOT NULL,
  `fecha` DATE NOT NULL,
  `zonaID` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`contenidoID`) COMMENT '',
   INDEX `seccion` USING BTREE (`seccionID`) COMMENT '',
  CONSTRAINT `contenido_fk1` FOREIGN KEY (`seccionID`) REFERENCES `seccion` (`seccionID`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `paquete` table : 
#

CREATE TABLE `paquete` (
  `paqueteID` INTEGER(3) NOT NULL AUTO_INCREMENT,
  `nombrePaquete` VARCHAR(20) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY USING BTREE (`paqueteID`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=4 AVG_ROW_LENGTH=5461 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `cupon` table : 
#

CREATE TABLE `cupon` (
  `cuponID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `nombreCupon` VARCHAR(45) COLLATE utf8_general_ci NOT NULL,
  `paqueteID` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`cuponID`) COMMENT '',
   INDEX `paqueteID` USING BTREE (`paqueteID`) COMMENT '',
  CONSTRAINT `cupon_fk1` FOREIGN KEY (`paqueteID`) REFERENCES `paquete` (`paqueteID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=52 AVG_ROW_LENGTH=4096 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `tipopaquete` table : 
#

CREATE TABLE `tipopaquete` (
  `idtipopaquete` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `nombreTipoPaquete` VARCHAR(80) COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY USING BTREE (`idtipopaquete`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=4 AVG_ROW_LENGTH=5461 CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT=''
;

#
# Structure for the `detallepaquete` table : 
#

CREATE TABLE `detallepaquete` (
  `detalleID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `cantFotos` INTEGER(11) NOT NULL,
  `caracteres` INTEGER(11) NOT NULL,
  `vigencia` INTEGER(2) NOT NULL,
  `cupones` INTEGER(2) NOT NULL,
  `videos` INTEGER(2) NOT NULL,
  `precio` FLOAT(5,2) NOT NULL,
  `paqueteID` INTEGER(3) NOT NULL,
  `tipoPaquete` INTEGER(11) NOT NULL DEFAULT 1 COMMENT 'Elemento que identifica el tipo de paquete',
  PRIMARY KEY USING BTREE (`detalleID`, `paqueteID`) COMMENT '',
   INDEX `detallePaquete` USING BTREE (`paqueteID`) COMMENT '',
   INDEX `fk_tipoPaquete_paquete_idx` USING BTREE (`tipoPaquete`) COMMENT '',
  CONSTRAINT `detallePaquete` FOREIGN KEY (`paqueteID`) REFERENCES `paquete` (`paqueteID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detallepaquete_fk1` FOREIGN KEY (`tipoPaquete`) REFERENCES `tipopaquete` (`idtipopaquete`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=4 AVG_ROW_LENGTH=5461 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `serviciocontratado` table : 
#

CREATE TABLE `serviciocontratado` (
  `servicioID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `cantFotos` INTEGER(11) NOT NULL,
  `caracteres` INTEGER(11) NOT NULL,
  `vigencia` INTEGER(2) NOT NULL,
  `cupones` INTEGER(2) NOT NULL,
  `videos` INTEGER(2) NOT NULL,
  `precio` FLOAT(5,2) NOT NULL,
  `detalleID` INTEGER(11) NOT NULL,
  `paqueteID` INTEGER(3) NOT NULL,
  `idUsuario` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`servicioID`, `detalleID`, `paqueteID`) COMMENT '',
   INDEX `detallePaqueteUsuario` USING BTREE (`idUsuario`) COMMENT '',
   INDEX `historicoPaquete` USING BTREE (`detalleID`, `paqueteID`) COMMENT '',
  CONSTRAINT `detallePaqueteUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `historicoPaquete` FOREIGN KEY (`detalleID`, `paqueteID`) REFERENCES `detallepaquete` (`detalleID`, `paqueteID`)
)ENGINE=InnoDB
AUTO_INCREMENT=31 AVG_ROW_LENGTH=606 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `cupondetalle` table : 
#

CREATE TABLE `cupondetalle` (
  `cuponDetalleID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(100) COLLATE utf8_general_ci NOT NULL,
  `valor` VARCHAR(100) COLLATE utf8_general_ci NOT NULL,
  `vigencia` INTEGER(2) NOT NULL,
  `tipoCupon` INTEGER(1) NOT NULL,
  `cuponID` INTEGER(11) NOT NULL,
  PRIMARY KEY USING BTREE (`cuponDetalleID`, `cuponID`) COMMENT '',
   INDEX `detalleCupon` USING BTREE (`cuponID`) COMMENT '',
  CONSTRAINT `detalleCupon` FOREIGN KEY (`cuponID`) REFERENCES `cupon` (`cuponID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=68 AVG_ROW_LENGTH=4096 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `cuponadquirido` table : 
#

CREATE TABLE `cuponadquirido` (
  `idCuponAdquirido` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(100) COLLATE utf8_general_ci NOT NULL,
  `valor` VARCHAR(100) COLLATE utf8_general_ci NOT NULL,
  `vigencia` DATE NOT NULL,
  `tipoCupon` INTEGER(1) NOT NULL,
  `vigente` TINYINT(1) NOT NULL,
  `usado` TINYINT(1) NOT NULL,
  `servicioID` INTEGER(11) NOT NULL,
  `detalleID` INTEGER(11) NOT NULL,
  `paqueteID` INTEGER(3) NOT NULL,
  `cuponDetalleID` INTEGER(11) DEFAULT NULL,
  `cuponID` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`idCuponAdquirido`, `servicioID`, `detalleID`, `paqueteID`) COMMENT '',
   INDEX `detalleCuponPaquete` USING BTREE (`servicioID`, `detalleID`, `paqueteID`) COMMENT '',
   INDEX `historicoCupon` USING BTREE (`cuponDetalleID`, `cuponID`) COMMENT '',
  CONSTRAINT `detalleCuponPaquete` FOREIGN KEY (`servicioID`, `detalleID`, `paqueteID`) REFERENCES `serviciocontratado` (`servicioID`, `detalleID`, `paqueteID`),
  CONSTRAINT `historicoCupon` FOREIGN KEY (`cuponDetalleID`, `cuponID`) REFERENCES `cupondetalle` (`cuponDetalleID`, `cuponID`)
)ENGINE=InnoDB
AUTO_INCREMENT=54 AVG_ROW_LENGTH=528 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `estado` table : 
#

CREATE TABLE `estado` (
  `estadoID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `nombreEstado` VARCHAR(30) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY USING BTREE (`estadoID`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=34 AVG_ROW_LENGTH=496 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `favoritos` table : 
#

CREATE TABLE `favoritos` (
  `publicacionID` INTEGER(11) NOT NULL,
  `idUsuario` INTEGER(11) DEFAULT NULL,
   INDEX `favoritos` USING BTREE (`idUsuario`) COMMENT '',
  CONSTRAINT `favoritos` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `fotoscontenido` table : 
#

CREATE TABLE `fotoscontenido` (
  `fotoID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `foto` VARCHAR(120) COLLATE utf8_general_ci NOT NULL,
  `contenidoID` INTEGER(11) NOT NULL,
  PRIMARY KEY USING BTREE (`fotoID`) COMMENT '',
   INDEX `productoID_new` USING BTREE (`contenidoID`) COMMENT '',
  CONSTRAINT `fotostienda_fk1_new` FOREIGN KEY (`contenidoID`) REFERENCES `catalogoproductos` (`productoID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=1 AVG_ROW_LENGTH=819 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `fotospublicacion` table : 
#

CREATE TABLE `fotospublicacion` (
  `fotoID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `foto` VARCHAR(180) COLLATE utf8_general_ci NOT NULL,
  `publicacionID` INTEGER(11) NOT NULL,
  `servicioID` INTEGER(11) NOT NULL,
  `detalleID` INTEGER(11) NOT NULL,
  `paqueteID` INTEGER(3) NOT NULL,
  PRIMARY KEY USING BTREE (`fotoID`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=2 AVG_ROW_LENGTH=16384 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `fotostienda` table : 
#

CREATE TABLE `fotostienda` (
  `fotoID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `foto` VARCHAR(120) COLLATE utf8_general_ci NOT NULL,
  `productoID` INTEGER(11) NOT NULL,
  PRIMARY KEY USING BTREE (`fotoID`) COMMENT '',
   INDEX `productoID` USING BTREE (`productoID`) COMMENT '',
  CONSTRAINT `fotostienda_fk1` FOREIGN KEY (`productoID`) REFERENCES `catalogoproductos` (`productoID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=24 AVG_ROW_LENGTH=819 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `giro` table : 
#

CREATE TABLE `giro` (
  `giroID` INTEGER(11) NOT NULL AUTO_INCREMENT COMMENT 'Se definen de acuerdo al formulario de registro para empresa en index_view',
  `nombreGiro` VARCHAR(100) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY USING BTREE (`giroID`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=13 AVG_ROW_LENGTH=1365 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `usuariodetalle` table : 
#

CREATE TABLE `usuariodetalle` (
  `idusuarioDetalle` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` INTEGER(11) NOT NULL,
  `tipoUsuario` INTEGER(1) NOT NULL,
  `nombreNegocio` VARCHAR(80) COLLATE utf8_general_ci NOT NULL,
  `giro` VARCHAR(45) COLLATE utf8_general_ci DEFAULT NULL,
  `nombreContacto` VARCHAR(45) COLLATE utf8_general_ci NOT NULL,
  `telefono` VARCHAR(45) COLLATE utf8_general_ci NOT NULL,
  `calle` VARCHAR(45) COLLATE utf8_general_ci DEFAULT NULL,
  `numero` VARCHAR(45) COLLATE utf8_general_ci DEFAULT NULL,
  `idEstado` INTEGER(11) DEFAULT NULL,
  `colonia` VARCHAR(45) COLLATE utf8_general_ci DEFAULT NULL,
  `cp` INTEGER(11) DEFAULT NULL,
  `correo` VARCHAR(45) COLLATE utf8_general_ci NOT NULL,
  `paginaWeb` VARCHAR(45) COLLATE utf8_general_ci DEFAULT NULL,
  `logo` VARCHAR(45) COLLATE utf8_general_ci DEFAULT NULL,
  `descripcion` TINYTEXT COLLATE utf8_general_ci,
  `municipioC` VARCHAR(80) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`idusuarioDetalle`, `idUsuario`) COMMENT '',
   INDEX `detalleUsuario` USING BTREE (`idUsuario`) COMMENT '',
   INDEX `idusuarioDetalle` USING BTREE (`idusuarioDetalle`) COMMENT '',
  CONSTRAINT `detalleUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=3 AVG_ROW_LENGTH=8192 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT='Ambos usuarios, Negocio y AC comparten estos datos, por lo cual ambos se almacenan en esta tabla'
;

#
# Structure for the `giroempresa` table : 
#

CREATE TABLE `giroempresa` (
  `giroEmpresaID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `idUsuarioDetalle` INTEGER(11) NOT NULL,
  `giroID` INTEGER(11) NOT NULL,
  PRIMARY KEY USING BTREE (`giroEmpresaID`) COMMENT '',
   INDEX `idUsuarioDetalle` USING BTREE (`idUsuarioDetalle`) COMMENT '',
  CONSTRAINT `giroempresa_fk1` FOREIGN KEY (`idUsuarioDetalle`) REFERENCES `usuariodetalle` (`idusuarioDetalle`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=3 AVG_ROW_LENGTH=8192 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `mensajes` table : 
#

CREATE TABLE `mensajes` (
  `mensajeID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `asunto` VARCHAR(30) COLLATE utf8_general_ci NOT NULL,
  `mensaje` VARCHAR(300) COLLATE utf8_general_ci NOT NULL,
  `idUsuario` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`mensajeID`) COMMENT '',
   INDEX `mensajes` USING BTREE (`idUsuario`) COMMENT '',
  CONSTRAINT `mensajes` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=1 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `pais` table : 
#

CREATE TABLE `pais` (
  `paisID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `PAIS_ISONUM` SMALLINT(6) DEFAULT NULL,
  `PAIS_ISO2` CHAR(2) COLLATE utf8_general_ci DEFAULT NULL,
  `PAIS_ISO3` CHAR(3) COLLATE utf8_general_ci DEFAULT NULL,
  `nombrePais` VARCHAR(80) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`paisID`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=241 AVG_ROW_LENGTH=68 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `permiso` table : 
#

CREATE TABLE `permiso` (
  `idPermiso` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `nivel` INTEGER(11) NOT NULL,
  `nombrePermiso` VARCHAR(70) COLLATE utf8_general_ci NOT NULL,
  `borrado` INTEGER(11) NOT NULL DEFAULT 0,
  PRIMARY KEY USING BTREE (`idPermiso`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=8 AVG_ROW_LENGTH=2340 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `productodetalle` table : 
#

CREATE TABLE `productodetalle` (
  `detalleProductoID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `productoID` INTEGER(11) DEFAULT NULL,
  `detalle` VARCHAR(70) COLLATE utf8_general_ci DEFAULT NULL,
  `valor` VARCHAR(70) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`detalleProductoID`) COMMENT '',
   INDEX `productoID` USING BTREE (`productoID`) COMMENT '',
  CONSTRAINT `productodetalle_fk1` FOREIGN KEY (`productoID`) REFERENCES `catalogoproductos` (`productoID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=25 AVG_ROW_LENGTH=1260 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `publicaciones` table : 
#

CREATE TABLE `publicaciones` (
  `publicacionID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `seccion` INTEGER(1) NOT NULL,
  `titulo` VARCHAR(50) COLLATE utf8_general_ci NOT NULL,
  `vigente` TINYINT(1) NOT NULL,
  `fechaCreacion` DATE NOT NULL,
  `fechaVencimiento` DATE NOT NULL,
  `numeroVisitas` INTEGER(11) NOT NULL,
  `estadoID` INTEGER(11) NOT NULL,
  `genero` TINYINT(1) NOT NULL,
  `razaID` CHAR(20) COLLATE utf8_general_ci NOT NULL,
  `precio` FLOAT(5,2) NOT NULL,
  `descripcion` TEXT COLLATE utf8_general_ci NOT NULL,
  `muestraTelefono` TINYINT(1) NOT NULL,
  `aprobada` TINYINT(1) NOT NULL,
  `servicioID` INTEGER(11) NOT NULL,
  `detalleID` INTEGER(11) NOT NULL,
  `paqueteID` INTEGER(3) NOT NULL,
  `ciudad` VARCHAR(80) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`publicacionID`, `servicioID`, `detalleID`, `paqueteID`) COMMENT '',
   INDEX `contenidoPublicacion` USING BTREE (`servicioID`, `detalleID`, `paqueteID`) COMMENT '',
   INDEX `publicacionID` USING BTREE (`publicacionID`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=23 AVG_ROW_LENGTH=1820 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `raza` table : 
#

CREATE TABLE `raza` (
  `razaID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `raza` VARCHAR(30) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`razaID`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=84 AVG_ROW_LENGTH=197 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `rol` table : 
#

CREATE TABLE `rol` (
  `idRol` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `nombreRol` VARCHAR(45) COLLATE utf8_general_ci NOT NULL,
  `borrado` INTEGER(11) NOT NULL,
  PRIMARY KEY USING BTREE (`idRol`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=4 AVG_ROW_LENGTH=5461 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `roltienepermiso` table : 
#

CREATE TABLE `roltienepermiso` (
  `idRol` INTEGER(11) NOT NULL,
  `idPermiso` INTEGER(11) NOT NULL,
  PRIMARY KEY USING BTREE (`idRol`, `idPermiso`) COMMENT '',
   INDEX `fk_rol_has_permiso_permiso1` USING BTREE (`idPermiso`) COMMENT '',
   INDEX `fk_rol_has_permiso_rol` USING BTREE (`idRol`) COMMENT '',
  CONSTRAINT `fk_rol_has_permiso_permiso1` FOREIGN KEY (`idPermiso`) REFERENCES `permiso` (`idPermiso`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_rol_has_permiso_rol` FOREIGN KEY (`idRol`) REFERENCES `rol` (`idRol`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AVG_ROW_LENGTH=2730 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `usuariodato` table : 
#

CREATE TABLE `usuariodato` (
  `idUsuarioDato` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` INTEGER(11) NOT NULL,
  `razonSocial` VARCHAR(45) COLLATE utf8_general_ci NOT NULL,
  `rfc` VARCHAR(20) COLLATE utf8_general_ci DEFAULT NULL,
  `calle` VARCHAR(45) COLLATE utf8_general_ci DEFAULT NULL,
  `noInterior` VARCHAR(11) COLLATE utf8_general_ci DEFAULT NULL,
  `noExterior` VARCHAR(11) COLLATE utf8_general_ci DEFAULT NULL,
  `cp` INTEGER(7) DEFAULT NULL,
  `municipio` VARCHAR(45) COLLATE utf8_general_ci DEFAULT NULL,
  `estadoID` INTEGER(11) NOT NULL,
  `idPais` INTEGER(11) DEFAULT 147 COMMENT '147 = Mï¿½xico',
  PRIMARY KEY USING BTREE (`idUsuarioDato`) COMMENT '',
   INDEX `adicional` USING BTREE (`idUsuario`) COMMENT '',
  CONSTRAINT `adicional` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=8 AVG_ROW_LENGTH=2730 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `ubicacionusuario` table : 
#

CREATE TABLE `ubicacionusuario` (
  `ubicacionUsuarioID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `tipoUsuario` INTEGER(1) NOT NULL,
  `latitud` VARCHAR(40) COLLATE utf8_general_ci NOT NULL,
  `longitud` VARCHAR(20) COLLATE utf8_general_ci NOT NULL,
  `idUsuarioDato` INTEGER(11) NOT NULL,
  `estadoID` INTEGER(11) DEFAULT NULL,
  `zonageograficaID` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`ubicacionUsuarioID`, `idUsuarioDato`) COMMENT '',
   INDEX `ubicacionUsuario` USING BTREE (`idUsuarioDato`) COMMENT '',
  CONSTRAINT `ubicacionUsuario` FOREIGN KEY (`idUsuarioDato`) REFERENCES `usuariodato` (`idUsuarioDato`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=3 AVG_ROW_LENGTH=8192 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `videos` table : 
#

CREATE TABLE `videos` (
  `videoID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `link` TEXT COLLATE utf8_general_ci NOT NULL,
  `publicacionID` INTEGER(11) NOT NULL,
  `servicioID` INTEGER(11) NOT NULL,
  `detalleID` INTEGER(11) NOT NULL,
  `paqueteID` INTEGER(3) NOT NULL,
  PRIMARY KEY USING BTREE (`videoID`) COMMENT '',
   INDEX `publicacionID` USING BTREE (`publicacionID`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=4 AVG_ROW_LENGTH=5461 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `visita` table : 
#

CREATE TABLE `visita` (
  `idVisita` INTEGER(11) NOT NULL,
  `numeroVisitas` INTEGER(11) DEFAULT 0,
  PRIMARY KEY USING BTREE (`idVisita`) COMMENT ''
)ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `vs_database_diagrams` table : 
#

CREATE TABLE `vs_database_diagrams` (
  `name` CHAR(80) COLLATE latin1_swedish_ci DEFAULT NULL,
  `diadata` TEXT COLLATE latin1_swedish_ci,
  `comment` VARCHAR(1022) COLLATE latin1_swedish_ci DEFAULT NULL,
  `preview` TEXT COLLATE latin1_swedish_ci,
  `lockinfo` CHAR(80) COLLATE latin1_swedish_ci DEFAULT NULL,
  `locktime` TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `version` CHAR(80) COLLATE latin1_swedish_ci DEFAULT NULL
)ENGINE=InnoDB
CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
COMMENT=''
;

#
# Structure for the `zonageografica` table : 
#

CREATE TABLE `zonageografica` (
  `zonaID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `zona` VARCHAR(60) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY USING BTREE (`zonaID`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=10 AVG_ROW_LENGTH=1820 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `zonageograficaestado` table : 
#

CREATE TABLE `zonageograficaestado` (
  `zonaID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) COLLATE utf8_general_ci NOT NULL,
  `estadoID` INTEGER(11) NOT NULL,
  `zonageograficaID` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`zonaID`, `estadoID`) COMMENT '',
   INDEX `zonageograficaID` USING BTREE (`zonageograficaID`) COMMENT '',
  CONSTRAINT `zonageograficaestado_fk1` FOREIGN KEY (`zonageograficaID`) REFERENCES `zonageografica` (`zonaID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=35 AVG_ROW_LENGTH=496 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Data for the `seccion` table  (LIMIT -482,500)
#

INSERT INTO `seccion` (`seccionID`, `seccionNombre`) VALUES

  (1,'Inicio'),
  (2,'Venta'),
  (3,'Cruza'),
  (4,'Directorio'),
  (5,'Perfil de usuario'),
  (6,'Adopci�n'),
  (7,'Perros Perdidos'),
  (8,'La raza del mes'),
  (9,'Evento del mes'),
  (10,'Datos Curiosos'),
  (11,'Asociaciones Protectoras'),
  (12,'�Qui�nes somos?'),
  (13,'Tutorial'),
  (14,'Publicidad'),
  (15,'Preguntas frecuentes'),
  (16,'Tienda'),
  (17,'Publicidad Lateral');
COMMIT;

#
# Data for the `banner` table  (LIMIT -492,500)
#

INSERT INTO `banner` (`bannerID`, `imgbaner`, `texto`, `zonaID`, `posicion`, `seccionID`) VALUES

  (6,'banner_lateral/_9ad4a__0019e_3_thumb.png','',9,4,17),
  (7,'/_29f25__15bf6_Hydrangeas_thumb.jpg','texto apoyo',9,2,1),
  (11,'banner_superior/_b2fea__fce75_Chrysanthemum_thumb.jpg','',9,1,1),
  (13,'','Apoyo',9,2,2),
  (14,'banner_superior/_e5c93__05ef5_Chrysanthemum_thumb.jpg','',9,1,2),
  (15,'banner_superior/_f2c7d__40f78_Hydrangeas_-_copia_thumb.jpg','',9,1,10),
  (16,'','APOYO EN PERFIL',9,2,5);
COMMIT;

#
# Data for the `usuario` table  (LIMIT -494,500)
#

INSERT INTO `usuario` (`idUsuario`, `nombre`, `apellido`, `telefono`, `correo`, `contrasena`, `recepcionCorreo`, `tipoUsuario`, `status`, `nivel`, `codigoConfirmacion`, `fechaRegistro`, `useragent`, `last_ip_access`, `authKey`, `paqueteGratis`) VALUES

  (2,'admin','admin',1111,'admin@gmail.com','2e0e4da5c11c0f8a73a01a5ddd672211af58c5b1e5179d7412',0,0,1,0,'A7995E2C507D113EF045E8BE6','2014-07-14 21:23:15',NULL,NULL,'3820DB1BE72A752191F8',1),
  (3,'martha','hdez',1111,'marthahdez2@gmail.com','547bee0d5a4d07320698bc26ca7c68f8dec2af4574a5829b70',1,1,1,1,'EA5A0F1E6DD8358A5ECDC3C6C','2014-07-17 17:24:18',NULL,NULL,'DFD57D93EB823B4AC189',1),
  (4,'dddd','dddd',0,'dddd@ssss.com','2e0e4da5c11c0f8a73a01a5ddd672211af58c5b1e5179d7412',0,1,1,1,'A7995E2C507D113EF045E8BE6','2014-08-03 18:24:47',NULL,NULL,'891403277F2699130E62',1),
  (6,'Martha','hh',2147483647,'martha.tain@gmail.com','2e0e4da5c11c0f8a73a01a5ddd672211af58c5b1e5179d7412',0,2,1,2,'A7995E2C507D113EF045E8BE6','2014-08-06 21:23:18',NULL,NULL,'8BD0398D1A4C904F4DFD',1),
  (7,'AAA','AAAAAAA',0,'AAAA@AAA.COM','2e0e4da5c11c0f8a73a01a5ddd672211af58c5b1e5179d7412',0,3,1,3,'FA5760A00DBFD87A83B1444D1','2014-08-06 21:27:41',NULL,NULL,'64D45A8A6320C079B5DB',1);
COMMIT;

#
# Data for the `carrito` table  (LIMIT -497,500)
#

INSERT INTO `carrito` (`cartID`, `usuarioID`, `productoID`, `cantidad`, `precio`, `nombre`, `talla`, `color`) VALUES

  (3,2,17,10,78.00,'MMM','3','AMARILLO'),
  (4,2,3,1,123.00,'AAA','0','0');
COMMIT;

#
# Data for the `carritototal` table  (LIMIT -498,500)
#

INSERT INTO `carritototal` (`carritoTotalID`, `usuarioID`, `totalProductos`, `totalPrecio`, `subtotal`, `descuento`) VALUES

  (1,2,11.00,903.00,903.00,0);
COMMIT;

#
# Data for the `catalogoproductos` table  (LIMIT -483,500)
#

INSERT INTO `catalogoproductos` (`productoID`, `nombre`, `descripcion`, `sku`, `precio`) VALUES

  (1,'BOTAS DE LLUVIA','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut aliquam arcu. Aliquam lectus ante, aliquam vitae consectetur eu, blandit at massa. Suspendisse nec elementum leo. Nullam auctor neque eu nulla tincidunt consequat. Nullam ut massa eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse gravida nec sapien a tempor. ','BBB001',1500.00),
  (3,'AAA','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut aliquam arcu. Aliquam lectus ante, aliquam vitae consectetur eu, blandit at massa. Suspendisse nec elementum leo. Nullam auctor neque eu nulla tincidunt consequat. Nullam ut massa eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse gravida nec sapien a tempor. ','AAA01',123.00),
  (4,'BBB','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut aliquam arcu. Aliquam lectus ante, aliquam vitae consectetur eu, blandit at massa. Suspendisse nec elementum leo. Nullam auctor neque eu nulla tincidunt consequat. Nullam ut massa eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse gravida nec sapien a tempor. ','BBB',5656.00),
  (5,'CCC','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut aliquam arcu. Aliquam lectus ante, aliquam vitae consectetur eu, blandit at massa. Suspendisse nec elementum leo. Nullam auctor neque eu nulla tincidunt consequat. Nullam ut massa eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse gravida nec sapien a tempor. ','CCC',234.00),
  (6,'DDD','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut aliquam arcu. Aliquam lectus ante, aliquam vitae consectetur eu, blandit at massa. Suspendisse nec elementum leo. Nullam auctor neque eu nulla tincidunt consequat. Nullam ut massa eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse gravida nec sapien a tempor. ','DDD',555.00),
  (7,'EE','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut aliquam arcu. Aliquam lectus ante, aliquam vitae consectetur eu, blandit at massa. Suspendisse nec elementum leo. Nullam auctor neque eu nulla tincidunt consequat. Nullam ut massa eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse gravida nec sapien a tempor. ','EE',234.00),
  (8,'FFF','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut aliquam arcu. Aliquam lectus ante, aliquam vitae consectetur eu, blandit at massa. Suspendisse nec elementum leo. Nullam auctor neque eu nulla tincidunt consequat. Nullam ut massa eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse gravida nec sapien a tempor. ','FFF',65.00),
  (9,'GGG','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut aliquam arcu. Aliquam lectus ante, aliquam vitae consectetur eu, blandit at massa. Suspendisse nec elementum leo. Nullam auctor neque eu nulla tincidunt consequat. Nullam ut massa eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse gravida nec sapien a tempor. ','GGG',78.00),
  (10,'HHH','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut aliquam arcu. Aliquam lectus ante, aliquam vitae consectetur eu, blandit at massa. Suspendisse nec elementum leo. Nullam auctor neque eu nulla tincidunt consequat. Nullam ut massa eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse gravida nec sapien a tempor. ','HHH',0.00),
  (11,'JJJ','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut aliquam arcu. Aliquam lectus ante, aliquam vitae consectetur eu, blandit at massa. Suspendisse nec elementum leo. Nullam auctor neque eu nulla tincidunt consequat. Nullam ut massa eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse gravida nec sapien a tempor. ','JJJ',56.00),
  (12,'HHH','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut aliquam arcu. Aliquam lectus ante, aliquam vitae consectetur eu, blandit at massa. Suspendisse nec elementum leo. Nullam auctor neque eu nulla tincidunt consequat. Nullam ut massa eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse gravida nec sapien a tempor. ','HHH',78.00),
  (13,'HHH','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut aliquam arcu. Aliquam lectus ante, aliquam vitae consectetur eu, blandit at massa. Suspendisse nec elementum leo. Nullam auctor neque eu nulla tincidunt consequat. Nullam ut massa eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse gravida nec sapien a tempor. ','HHH',78.00),
  (14,'III','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut aliquam arcu. Aliquam lectus ante, aliquam vitae consectetur eu, blandit at massa. Suspendisse nec elementum leo. Nullam auctor neque eu nulla tincidunt consequat. Nullam ut massa eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse gravida nec sapien a tempor. ','III',87.00),
  (15,'KK','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut aliquam arcu. Aliquam lectus ante, aliquam vitae consectetur eu, blandit at massa. Suspendisse nec elementum leo. Nullam auctor neque eu nulla tincidunt consequat. Nullam ut massa eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse gravida nec sapien a tempor. ','KKK',89.00),
  (16,'LLL','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut aliquam arcu. Aliquam lectus ante, aliquam vitae consectetur eu, blandit at massa. Suspendisse nec elementum leo. Nullam auctor neque eu nulla tincidunt consequat. Nullam ut massa eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse gravida nec sapien a tempor. ','LLL',80.00),
  (17,'MMM','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut aliquam arcu. Aliquam lectus ante, aliquam vitae consectetur eu, blandit at massa. Suspendisse nec elementum leo. Nullam auctor neque eu nulla tincidunt consequat. Nullam ut massa eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse gravida nec sapien a tempor. ','MMM',78.00);
COMMIT;

#
# Data for the `ci_sessions` table  (LIMIT -492,500)
#

INSERT INTO `ci_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES

  ('19f185fc56c5ba47f618854a23c9a504','127.0.0.1','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36',1408055299,'a:14:{s:9:\"user_data\";s:0:\"\";s:6:\"banner\";a:7:{i:0;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:1:\"6\";s:8:\"imgbaner\";s:40:\"banner_lateral/_9ad4a__0019e_3_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"4\";s:9:\"seccionID\";s:2:\"17\";}i:1;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:1:\"7\";s:8:\"imgbaner\";s:35:\"/_29f25__15bf6_Hydrangeas_thumb.jpg\";s:5:\"texto\";s:11:\"texto apoyo\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"1\";}i:2;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"11\";s:8:\"imgbaner\";s:53:\"banner_superior/_b2fea__fce75_Chrysanthemum_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"1\";}i:3;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"13\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:5:\"Apoyo\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"2\";}i:4;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"14\";s:8:\"imgbaner\";s:53:\"banner_superior/_e5c93__05ef5_Chrysanthemum_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"2\";}i:5;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"15\";s:8:\"imgbaner\";s:58:\"banner_superior/_f2c7d__40f78_Hydrangeas_-_copia_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:2:\"10\";}i:6;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"16\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:15:\"APOYO EN PERFIL\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"5\";}}s:6:\"logged\";b:1;s:9:\"idUsuario\";s:1:\"3\";s:6:\"correo\";s:21:\"marthahdez2@gmail.com\";s:6:\"nombre\";s:6:\"martha\";s:8:\"apellido\";s:4:\"hdez\";s:8:\"telefono\";s:4:\"1111\";s:11:\"tipoUsuario\";s:1:\"1\";s:7:\"authKey\";s:20:\"66452166C9B233FE4A21\";s:5:\"nivel\";s:1:\"1\";s:13:\"idUsuarioDato\";s:1:\"3\";s:3:\"rol\";i:1;s:14:\"manuallyLogged\";b:1;}'),
  ('5c5dbe829ed0e8a0049a5136cbd8bcbc','127.0.0.1','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36',1408050297,'a:2:{s:9:\"user_data\";s:0:\"\";s:6:\"banner\";a:7:{i:0;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:1:\"6\";s:8:\"imgbaner\";s:40:\"banner_lateral/_9ad4a__0019e_3_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"4\";s:9:\"seccionID\";s:2:\"17\";}i:1;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:1:\"7\";s:8:\"imgbaner\";s:35:\"/_29f25__15bf6_Hydrangeas_thumb.jpg\";s:5:\"texto\";s:11:\"texto apoyo\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"1\";}i:2;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"11\";s:8:\"imgbaner\";s:53:\"banner_superior/_b2fea__fce75_Chrysanthemum_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"1\";}i:3;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"13\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:5:\"Apoyo\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"2\";}i:4;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"14\";s:8:\"imgbaner\";s:53:\"banner_superior/_e5c93__05ef5_Chrysanthemum_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"2\";}i:5;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"15\";s:8:\"imgbaner\";s:58:\"banner_superior/_f2c7d__40f78_Hydrangeas_-_copia_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:2:\"10\";}i:6;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"16\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:15:\"APOYO EN PERFIL\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"5\";}}}'),
  ('6e40808b636b585feca32e3553394c14','127.0.0.1','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36',1408050298,'a:2:{s:9:\"user_data\";s:0:\"\";s:6:\"banner\";a:7:{i:0;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:1:\"6\";s:8:\"imgbaner\";s:40:\"banner_lateral/_9ad4a__0019e_3_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"4\";s:9:\"seccionID\";s:2:\"17\";}i:1;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:1:\"7\";s:8:\"imgbaner\";s:35:\"/_29f25__15bf6_Hydrangeas_thumb.jpg\";s:5:\"texto\";s:11:\"texto apoyo\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"1\";}i:2;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"11\";s:8:\"imgbaner\";s:53:\"banner_superior/_b2fea__fce75_Chrysanthemum_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"1\";}i:3;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"13\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:5:\"Apoyo\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"2\";}i:4;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"14\";s:8:\"imgbaner\";s:53:\"banner_superior/_e5c93__05ef5_Chrysanthemum_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"2\";}i:5;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"15\";s:8:\"imgbaner\";s:58:\"banner_superior/_f2c7d__40f78_Hydrangeas_-_copia_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:2:\"10\";}i:6;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"16\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:15:\"APOYO EN PERFIL\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"5\";}}}'),
  ('862fef8336523259deccf92ef8b8bb6e','127.0.0.1','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36',1408053668,'a:14:{s:9:\"user_data\";s:0:\"\";s:6:\"banner\";a:7:{i:0;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:1:\"6\";s:8:\"imgbaner\";s:40:\"banner_lateral/_9ad4a__0019e_3_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"4\";s:9:\"seccionID\";s:2:\"17\";}i:1;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:1:\"7\";s:8:\"imgbaner\";s:35:\"/_29f25__15bf6_Hydrangeas_thumb.jpg\";s:5:\"texto\";s:11:\"texto apoyo\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"1\";}i:2;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"11\";s:8:\"imgbaner\";s:53:\"banner_superior/_b2fea__fce75_Chrysanthemum_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"1\";}i:3;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"13\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:5:\"Apoyo\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"2\";}i:4;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"14\";s:8:\"imgbaner\";s:53:\"banner_superior/_e5c93__05ef5_Chrysanthemum_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"2\";}i:5;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"15\";s:8:\"imgbaner\";s:58:\"banner_superior/_f2c7d__40f78_Hydrangeas_-_copia_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:2:\"10\";}i:6;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"16\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:15:\"APOYO EN PERFIL\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"5\";}}s:6:\"logged\";b:1;s:9:\"idUsuario\";s:1:\"3\";s:6:\"correo\";s:21:\"marthahdez2@gmail.com\";s:6:\"nombre\";s:6:\"martha\";s:8:\"apellido\";s:4:\"hdez\";s:8:\"telefono\";s:4:\"1111\";s:11:\"tipoUsuario\";s:1:\"1\";s:7:\"authKey\";s:20:\"ED5679775E628DBDF0B1\";s:5:\"nivel\";s:1:\"1\";s:13:\"idUsuarioDato\";s:1:\"3\";s:3:\"rol\";i:1;s:14:\"manuallyLogged\";b:1;}'),
  ('8983e728478278ade60ece586b5f79b4','127.0.0.1','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36',1408053074,'a:14:{s:9:\"user_data\";s:0:\"\";s:6:\"banner\";a:7:{i:0;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:1:\"6\";s:8:\"imgbaner\";s:40:\"banner_lateral/_9ad4a__0019e_3_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"4\";s:9:\"seccionID\";s:2:\"17\";}i:1;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:1:\"7\";s:8:\"imgbaner\";s:35:\"/_29f25__15bf6_Hydrangeas_thumb.jpg\";s:5:\"texto\";s:11:\"texto apoyo\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"1\";}i:2;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"11\";s:8:\"imgbaner\";s:53:\"banner_superior/_b2fea__fce75_Chrysanthemum_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"1\";}i:3;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"13\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:5:\"Apoyo\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"2\";}i:4;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"14\";s:8:\"imgbaner\";s:53:\"banner_superior/_e5c93__05ef5_Chrysanthemum_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"2\";}i:5;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"15\";s:8:\"imgbaner\";s:58:\"banner_superior/_f2c7d__40f78_Hydrangeas_-_copia_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:2:\"10\";}i:6;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"16\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:15:\"APOYO EN PERFIL\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"5\";}}s:6:\"logged\";b:1;s:9:\"idUsuario\";s:1:\"3\";s:6:\"correo\";s:21:\"marthahdez2@gmail.com\";s:6:\"nombre\";s:6:\"martha\";s:8:\"apellido\";s:4:\"hdez\";s:8:\"telefono\";s:4:\"1111\";s:11:\"tipoUsuario\";s:1:\"1\";s:7:\"authKey\";s:20:\"3C8CCA47299C2ACCDAAD\";s:5:\"nivel\";s:1:\"1\";s:13:\"idUsuarioDato\";s:1:\"3\";s:3:\"rol\";i:1;s:14:\"manuallyLogged\";b:1;}'),
  ('aa79910ac37b24bccd702cd01fbef779','127.0.0.1','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36',1408050299,'a:2:{s:9:\"user_data\";s:0:\"\";s:6:\"banner\";a:7:{i:0;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:1:\"6\";s:8:\"imgbaner\";s:40:\"banner_lateral/_9ad4a__0019e_3_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"4\";s:9:\"seccionID\";s:2:\"17\";}i:1;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:1:\"7\";s:8:\"imgbaner\";s:35:\"/_29f25__15bf6_Hydrangeas_thumb.jpg\";s:5:\"texto\";s:11:\"texto apoyo\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"1\";}i:2;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"11\";s:8:\"imgbaner\";s:53:\"banner_superior/_b2fea__fce75_Chrysanthemum_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"1\";}i:3;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"13\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:5:\"Apoyo\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"2\";}i:4;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"14\";s:8:\"imgbaner\";s:53:\"banner_superior/_e5c93__05ef5_Chrysanthemum_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"2\";}i:5;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"15\";s:8:\"imgbaner\";s:58:\"banner_superior/_f2c7d__40f78_Hydrangeas_-_copia_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:2:\"10\";}i:6;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"16\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:15:\"APOYO EN PERFIL\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"5\";}}}'),
  ('dfa50da5af89cd4c0045a1077ff3cf88','127.0.0.1','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36',1408050296,'a:14:{s:9:\"user_data\";s:0:\"\";s:6:\"banner\";a:7:{i:0;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:1:\"6\";s:8:\"imgbaner\";s:40:\"banner_lateral/_9ad4a__0019e_3_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"4\";s:9:\"seccionID\";s:2:\"17\";}i:1;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:1:\"7\";s:8:\"imgbaner\";s:35:\"/_29f25__15bf6_Hydrangeas_thumb.jpg\";s:5:\"texto\";s:11:\"texto apoyo\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"1\";}i:2;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"11\";s:8:\"imgbaner\";s:53:\"banner_superior/_b2fea__fce75_Chrysanthemum_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"1\";}i:3;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"13\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:5:\"Apoyo\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"2\";}i:4;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"14\";s:8:\"imgbaner\";s:53:\"banner_superior/_e5c93__05ef5_Chrysanthemum_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"2\";}i:5;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"15\";s:8:\"imgbaner\";s:58:\"banner_superior/_f2c7d__40f78_Hydrangeas_-_copia_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:2:\"10\";}i:6;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"16\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:15:\"APOYO EN PERFIL\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"5\";}}s:6:\"logged\";b:1;s:9:\"idUsuario\";s:1:\"3\";s:6:\"correo\";s:21:\"marthahdez2@gmail.com\";s:6:\"nombre\";s:6:\"martha\";s:8:\"apellido\";s:4:\"hdez\";s:8:\"telefono\";s:4:\"1111\";s:11:\"tipoUsuario\";s:1:\"1\";s:7:\"authKey\";s:20:\"11CD560A94C104CA1F83\";s:5:\"nivel\";s:1:\"1\";s:13:\"idUsuarioDato\";s:1:\"3\";s:3:\"rol\";i:1;s:14:\"manuallyLogged\";b:1;}');
COMMIT;

#
# Data for the `compra` table  (LIMIT -494,500)
#

INSERT INTO `compra` (`compraID`, `usuarioID`, `subtotal`, `idCuponAdquirido`, `descuento`, `total`, `fecha`) VALUES

  (1,3,425.00,NULL,20,340.00,'2014-08-06 00:11:56'),
  (2,3,123.00,NULL,5,116.85,'2014-08-13 00:38:34'),
  (3,3,999.99,NULL,0,999.99,'2014-08-13 00:45:08'),
  (4,7,999.99,NULL,NULL,999.99,'2014-08-14 01:40:51'),
  (5,3,999.99,NULL,NULL,999.99,'2014-08-14 09:34:45');
COMMIT;

#
# Data for the `compradetalle` table  (LIMIT -493,500)
#

INSERT INTO `compradetalle` (`compraDetalleID`, `compraID`, `productoID`, `cantidad`, `precio`, `nombre`, `talla`, `color`) VALUES

  (1,1,11,1,56.00,'JJJ','',''),
  (2,1,3,3,123.00,'AAA','',''),
  (3,2,3,1,123.00,'AAA','0','0'),
  (4,3,1,2,999.99,'BOTAS DE LLUVIA','0','0'),
  (5,4,1,4,999.99,'BOTAS DE LLUVIA','0','0'),
  (6,5,1,1,999.99,'BOTAS DE LLUVIA','0','0');
COMMIT;

#
# Data for the `paquete` table  (LIMIT -496,500)
#

INSERT INTO `paquete` (`paqueteID`, `nombrePaquete`) VALUES

  (1,'Lite'),
  (2,'Regular'),
  (3,'Premium');
COMMIT;

#
# Data for the `cupon` table  (LIMIT -495,500)
#

INSERT INTO `cupon` (`cuponID`, `nombreCupon`, `paqueteID`) VALUES

  (48,'Tienda',1),
  (49,'Paquete',1),
  (50,'Negocio',1),
  (51,'Negocio',1);
COMMIT;

#
# Data for the `tipopaquete` table  (LIMIT -496,500)
#

INSERT INTO `tipopaquete` (`idtipopaquete`, `nombreTipoPaquete`) VALUES

  (1,'Lite'),
  (2,'Regular'),
  (3,'Premium');
COMMIT;

#
# Data for the `detallepaquete` table  (LIMIT -496,500)
#

INSERT INTO `detallepaquete` (`detalleID`, `cantFotos`, `caracteres`, `vigencia`, `cupones`, `videos`, `precio`, `paqueteID`, `tipoPaquete`) VALUES

  (1,5,5,5,5,5,5.00,1,1),
  (2,2,300,30,2,1,100.00,2,2),
  (3,3,1000,60,5,2,166.00,3,3);
COMMIT;

#
# Data for the `serviciocontratado` table  (LIMIT -470,500)
#

INSERT INTO `serviciocontratado` (`servicioID`, `cantFotos`, `caracteres`, `vigencia`, `cupones`, `videos`, `precio`, `detalleID`, `paqueteID`, `idUsuario`) VALUES

  (1,1,50,30,0,0,0.00,1,1,3),
  (3,5,5,5,5,5,5.00,1,1,3),
  (4,5,5,5,5,5,5.00,1,1,3),
  (5,5,5,5,5,5,5.00,1,1,3),
  (6,5,5,5,5,5,5.00,1,1,3),
  (7,2,300,30,2,1,100.00,2,2,3),
  (8,5,5,5,5,5,5.00,1,1,3),
  (9,5,5,5,5,5,5.00,1,1,3),
  (10,5,5,5,5,5,5.00,1,1,3),
  (11,5,5,5,5,5,5.00,1,1,3),
  (12,3,1000,60,5,2,166.00,3,3,3),
  (13,5,5,5,5,5,5.00,1,1,3),
  (14,2,300,30,2,1,100.00,2,2,3),
  (15,2,300,30,2,1,100.00,2,2,7),
  (16,5,5,5,5,5,5.00,1,1,7),
  (17,5,5,5,5,5,5.00,1,1,3),
  (18,2,300,30,2,1,100.00,2,2,3),
  (19,2,300,30,2,1,100.00,2,2,3),
  (20,2,300,30,2,1,100.00,2,2,3),
  (21,2,300,30,2,1,100.00,2,2,3),
  (22,2,300,30,2,1,100.00,2,2,3),
  (23,2,300,30,2,1,100.00,2,2,3),
  (24,2,300,30,2,1,100.00,2,2,3),
  (25,5,5,5,5,5,5.00,1,1,3),
  (26,5,5,5,5,5,5.00,1,1,3),
  (27,5,5,5,5,5,5.00,1,1,3),
  (28,3,1000,60,5,2,166.00,3,3,3),
  (29,2,300,30,2,1,100.00,2,2,3),
  (30,5,5,5,5,5,5.00,1,1,3);
COMMIT;

#
# Data for the `cupondetalle` table  (LIMIT -495,500)
#

INSERT INTO `cupondetalle` (`cuponDetalleID`, `descripcion`, `valor`, `vigencia`, `tipoCupon`, `cuponID`) VALUES

  (64,'cuponTienda','5',5,1,48),
  (65,'cuponPaquete','5',5,2,49),
  (66,'Tienda 1','44',5,3,50),
  (67,'Tienda 2','444',5,3,51);
COMMIT;

#
# Data for the `cuponadquirido` table  (LIMIT -468,500)
#

INSERT INTO `cuponadquirido` (`idCuponAdquirido`, `descripcion`, `valor`, `vigencia`, `tipoCupon`, `vigente`, `usado`, `servicioID`, `detalleID`, `paqueteID`, `cuponDetalleID`, `cuponID`) VALUES

  (4,'Tienda 1','44','0000-00-00',3,1,0,5,1,1,66,50),
  (5,'Tienda 2','444','0000-00-00',3,1,0,5,1,1,67,51),
  (7,'cuponPaquete','5','0000-00-00',2,1,0,6,1,1,65,49),
  (8,'Tienda 1','44','0000-00-00',3,1,0,6,1,1,66,50),
  (9,'Tienda 2','444','0000-00-00',3,1,0,6,1,1,67,51),
  (10,'cuponTienda','5','0000-00-00',1,1,0,8,1,1,64,48),
  (12,'Tienda 1','44','0000-00-00',3,1,0,8,1,1,66,50),
  (13,'Tienda 2','444','0000-00-00',3,1,0,8,1,1,67,51),
  (14,'cuponTienda','5','0000-00-00',1,1,0,9,1,1,64,48),
  (16,'Tienda 1','44','0000-00-00',3,1,0,9,1,1,66,50),
  (17,'Tienda 2','444','0000-00-00',3,1,0,9,1,1,67,51),
  (18,'cuponTienda','5','0000-00-00',1,1,0,10,1,1,64,48),
  (20,'Tienda 1','44','0000-00-00',3,1,0,10,1,1,66,50),
  (21,'Tienda 2','444','0000-00-00',3,1,0,10,1,1,67,51),
  (24,'Tienda 1','44','0000-00-00',3,1,0,11,1,1,66,50),
  (25,'Tienda 2','444','0000-00-00',3,1,0,11,1,1,67,51),
  (28,'Tienda 1','44','0000-00-00',3,1,0,13,1,1,66,50),
  (29,'Tienda 2','444','0000-00-00',3,1,0,13,1,1,67,51),
  (32,'Tienda 1','44','0000-00-00',3,1,0,16,1,1,66,50),
  (33,'Tienda 2','444','0000-00-00',3,1,0,16,1,1,67,51),
  (36,'Tienda 1','44','0000-00-00',3,1,0,17,1,1,66,50),
  (37,'Tienda 2','444','0000-00-00',3,1,0,17,1,1,67,51),
  (40,'Tienda 1','44','0000-00-00',3,1,0,25,1,1,66,50),
  (41,'Tienda 2','444','0000-00-00',3,1,0,25,1,1,67,51),
  (44,'Tienda 1','44','0000-00-00',3,1,0,26,1,1,66,50),
  (45,'Tienda 2','444','0000-00-00',3,1,0,26,1,1,67,51),
  (48,'Tienda 1','44','0000-00-00',3,1,0,27,1,1,66,50),
  (49,'Tienda 2','444','0000-00-00',3,1,0,27,1,1,67,51),
  (51,'cuponPaquete','5','0000-00-00',2,1,0,30,1,1,65,49),
  (52,'Tienda 1','44','0000-00-00',3,1,0,30,1,1,66,50),
  (53,'Tienda 2','444','0000-00-00',3,1,0,30,1,1,67,51);
COMMIT;

#
# Data for the `estado` table  (LIMIT -466,500)
#

INSERT INTO `estado` (`estadoID`, `nombreEstado`) VALUES

  (1,'Aguascalientes'),
  (2,'Baja California'),
  (3,'Baja California Sur'),
  (4,'Campeche'),
  (5,'Chiapas'),
  (6,'Chihuahua'),
  (7,'Coahuila'),
  (8,'Colima'),
  (9,'Distrito Federal'),
  (10,'Durango'),
  (11,'Estado de Mï¿½xico'),
  (12,'Guanajuato'),
  (13,'Guerrero'),
  (14,'Hidalgo'),
  (15,'Jalisco'),
  (16,'Michoacï¿½n'),
  (17,'Morelos'),
  (18,'Nayarit'),
  (19,'Nuevo Leï¿½n'),
  (20,'Oaxaca'),
  (21,'Puebla'),
  (22,'Querï¿½taro'),
  (23,'Quintana Roo'),
  (24,'San Luis Potosï¿½'),
  (25,'Sinaloa'),
  (26,'Sonora'),
  (27,'Tabasco'),
  (28,'Tamaulipas'),
  (29,'Tlaxcala'),
  (30,'Veracruz'),
  (31,'Yucatï¿½n'),
  (32,'Zacatecas'),
  (33,'Fuera de Mï¿½xico');
COMMIT;

#
# Data for the `fotospublicacion` table  (LIMIT -498,500)
#

INSERT INTO `fotospublicacion` (`fotoID`, `foto`, `publicacionID`, `servicioID`, `detalleID`, `paqueteID`) VALUES

  (1,'',1,1,1,1);
COMMIT;

#
# Data for the `fotostienda` table  (LIMIT -479,500)
#

INSERT INTO `fotostienda` (`fotoID`, `foto`, `productoID`) VALUES

  (1,'021.png',1),
  (2,'021.png',1),
  (3,'021.png',1),
  (7,'021.png',3),
  (8,'021.png',3),
  (9,'021.png',3),
  (10,'021.png',4),
  (11,'021.png',4),
  (12,'021.png',4),
  (13,'021.png',5),
  (14,'021.png',5),
  (15,'021.png',5),
  (16,'021.png',6),
  (17,'021.png',8),
  (18,'021.png',9),
  (19,'021.png',10),
  (20,'021.png',11),
  (21,'021.png',17),
  (22,'021.png',17),
  (23,'021.png',17);
COMMIT;

#
# Data for the `giro` table  (LIMIT -487,500)
#

INSERT INTO `giro` (`giroID`, `nombreGiro`) VALUES

  (1,'Accesorios para mascotas'),
  (2,'Veterinaria '),
  (3,'Estetica canina'),
  (4,'Adiestramiento canino'),
  (5,'Centro de sociabilizaci�n'),
  (6,'Criadero de perros '),
  (7,'Hotel y pensi�n canina '),
  (8,'Alimento y medicamento'),
  (9,'Guarderia de perros'),
  (10,'Tienda de mascotas '),
  (11,'Servicios funerarios '),
  (12,'Servico de paseo');
COMMIT;

#
# Data for the `usuariodetalle` table  (LIMIT -497,500)
#

INSERT INTO `usuariodetalle` (`idusuarioDetalle`, `idUsuario`, `tipoUsuario`, `nombreNegocio`, `giro`, `nombreContacto`, `telefono`, `calle`, `numero`, `idEstado`, `colonia`, `cp`, `correo`, `paginaWeb`, `logo`, `descripcion`, `municipioC`) VALUES

  (1,6,2,'AAAAA',NULL,'','','1111','222',22,'WWWW',0,'DDDD@DDD.COM','','',' AAAAAA',NULL),
  (2,7,3,'','0','','','','',0,'',0,'0','','',' ',NULL);
COMMIT;

#
# Data for the `giroempresa` table  (LIMIT -497,500)
#

INSERT INTO `giroempresa` (`giroEmpresaID`, `idUsuarioDetalle`, `giroID`) VALUES

  (1,1,6),
  (2,1,7);
COMMIT;

#
# Data for the `pais` table  (LIMIT -259,500)
#

INSERT INTO `pais` (`paisID`, `PAIS_ISONUM`, `PAIS_ISO2`, `PAIS_ISO3`, `nombrePais`) VALUES

  (1,4,'AF','AFG','Afganistï¿½n'),
  (2,248,'AX','ALA','Islas Gland'),
  (3,8,'AL','ALB','Albania'),
  (4,276,'DE','DEU','Alemania'),
  (5,20,'AD','AND','Andorra'),
  (6,24,'AO','AGO','Angola'),
  (7,660,'AI','AIA','Anguilla'),
  (8,10,'AQ','ATA','Antï¿½rtida'),
  (9,28,'AG','ATG','Antigua y Barbuda'),
  (10,530,'AN','ANT','Antillas Holandesas'),
  (11,682,'SA','SAU','Arabia Saudï¿½'),
  (12,12,'DZ','DZA','Argelia'),
  (13,32,'AR','ARG','Argentina'),
  (14,51,'AM','ARM','Armenia'),
  (15,533,'AW','ABW','Aruba'),
  (16,36,'AU','AUS','Australia'),
  (17,40,'AT','AUT','Austria'),
  (18,31,'AZ','AZE','Azerbaiyï¿½n'),
  (19,44,'BS','BHS','Bahamas'),
  (20,48,'BH','BHR','Bahrï¿½in'),
  (21,50,'BD','BGD','Bangladesh'),
  (22,52,'BB','BRB','Barbados'),
  (23,112,'BY','BLR','Bielorrusia'),
  (24,56,'BE','BEL','Bï¿½lgica'),
  (25,84,'BZ','BLZ','Belice'),
  (26,204,'BJ','BEN','Benin'),
  (27,60,'BM','BMU','Bermudas'),
  (28,64,'BT','BTN','Bhutï¿½n'),
  (29,68,'BO','BOL','Bolivia'),
  (30,70,'BA','BIH','Bosnia y Herzegovina'),
  (31,72,'BW','BWA','Botsuana'),
  (32,74,'BV','BVT','Isla Bouvet'),
  (33,76,'BR','BRA','Brasil'),
  (34,96,'BN','BRN','Brunï¿½i'),
  (35,100,'BG','BGR','Bulgaria'),
  (36,854,'BF','BFA','Burkina Faso'),
  (37,108,'BI','BDI','Burundi'),
  (38,132,'CV','CPV','Cabo Verde'),
  (39,136,'KY','CYM','Islas Caimï¿½n'),
  (40,116,'KH','KHM','Camboya'),
  (41,120,'CM','CMR','Camerï¿½n'),
  (42,124,'CA','CAN','Canadï¿½'),
  (43,140,'CF','CAF','Repï¿½blica Centroafricana'),
  (44,148,'TD','TCD','Chad'),
  (45,203,'CZ','CZE','Repï¿½blica Checa'),
  (46,152,'CL','CHL','Chile'),
  (47,156,'CN','CHN','China'),
  (48,196,'CY','CYP','Chipre'),
  (49,162,'CX','CXR','Isla de Navidad'),
  (50,336,'VA','VAT','Ciudad del Vaticano'),
  (51,166,'CC','CCK','Islas Cocos'),
  (52,170,'CO','COL','Colombia'),
  (53,174,'KM','COM','Comoras'),
  (54,180,'CD','COD','Repï¿½blica Democrï¿½tica del Congo'),
  (55,178,'CG','COG','Congo'),
  (56,184,'CK','COK','Islas Cook'),
  (57,408,'KP','PRK','Corea del Norte'),
  (58,410,'KR','KOR','Corea del Sur'),
  (59,384,'CI','CIV','Costa de Marfil'),
  (60,188,'CR','CRI','Costa Rica'),
  (61,191,'HR','HRV','Croacia'),
  (62,192,'CU','CUB','Cuba'),
  (63,208,'DK','DNK','Dinamarca'),
  (64,212,'DM','DMA','Dominica'),
  (65,214,'DO','DOM','Repï¿½blica Dominicana'),
  (66,218,'EC','ECU','Ecuador'),
  (67,818,'EG','EGY','Egipto'),
  (68,222,'SV','SLV','El Salvador'),
  (69,784,'AE','ARE','Emiratos ï¿½rabes Unidos'),
  (70,232,'ER','ERI','Eritrea'),
  (71,703,'SK','SVK','Eslovaquia'),
  (72,705,'SI','SVN','Eslovenia'),
  (73,724,'ES','ESP','Espaï¿½a'),
  (74,581,'UM','UMI','Islas ultramarinas de Estados Unidos'),
  (75,840,'US','USA','Estados Unidos'),
  (76,233,'EE','EST','Estonia'),
  (77,231,'ET','ETH','Etiopï¿½a'),
  (78,234,'FO','FRO','Islas Feroe'),
  (79,608,'PH','PHL','Filipinas'),
  (80,246,'FI','FIN','Finlandia'),
  (81,242,'FJ','FJI','Fiyi'),
  (82,250,'FR','FRA','Francia'),
  (83,266,'GA','GAB','Gabï¿½n'),
  (84,270,'GM','GMB','Gambia'),
  (85,268,'GE','GEO','Georgia'),
  (86,239,'GS','SGS','Islas Georgias del Sur y Sandwich del Sur'),
  (87,288,'GH','GHA','Ghana'),
  (88,292,'GI','GIB','Gibraltar'),
  (89,308,'GD','GRD','Granada'),
  (90,300,'GR','GRC','Grecia'),
  (91,304,'GL','GRL','Groenlandia'),
  (92,312,'GP','GLP','Guadalupe'),
  (93,316,'GU','GUM','Guam'),
  (94,320,'GT','GTM','Guatemala'),
  (95,254,'GF','GUF','Guayana Francesa'),
  (96,324,'GN','GIN','Guinea'),
  (97,226,'GQ','GNQ','Guinea Ecuatorial'),
  (98,624,'GW','GNB','Guinea-Bissau'),
  (99,328,'GY','GUY','Guyana'),
  (100,332,'HT','HTI','Haitï¿½'),
  (101,334,'HM','HMD','Islas Heard y McDonald'),
  (102,340,'HN','HND','Honduras'),
  (103,344,'HK','HKG','Hong Kong'),
  (104,348,'HU','HUN','Hungrï¿½a'),
  (105,356,'IN','IND','India'),
  (106,360,'ID','IDN','Indonesia'),
  (107,364,'IR','IRN','Irï¿½n'),
  (108,368,'IQ','IRQ','Iraq'),
  (109,372,'IE','IRL','Irlanda'),
  (110,352,'IS','ISL','Islandia'),
  (111,376,'IL','ISR','Israel'),
  (112,380,'IT','ITA','Italia'),
  (113,388,'JM','JAM','Jamaica'),
  (114,392,'JP','JPN','Japï¿½n'),
  (115,400,'JO','JOR','Jordania'),
  (116,398,'KZ','KAZ','Kazajstï¿½n'),
  (117,404,'KE','KEN','Kenia'),
  (118,417,'KG','KGZ','Kirguistï¿½n'),
  (119,296,'KI','KIR','Kiribati'),
  (120,414,'KW','KWT','Kuwait'),
  (121,418,'LA','LAO','Laos'),
  (122,426,'LS','LSO','Lesotho'),
  (123,428,'LV','LVA','Letonia'),
  (124,422,'LB','LBN','Lï¿½bano'),
  (125,430,'LR','LBR','Liberia'),
  (126,434,'LY','LBY','Libia'),
  (127,438,'LI','LIE','Liechtenstein'),
  (128,440,'LT','LTU','Lituania'),
  (129,442,'LU','LUX','Luxemburgo'),
  (130,446,'MO','MAC','Macao'),
  (131,807,'MK','MKD','ARY Macedonia'),
  (132,450,'MG','MDG','Madagascar'),
  (133,458,'MY','MYS','Malasia'),
  (134,454,'MW','MWI','Malawi'),
  (135,462,'MV','MDV','Maldivas'),
  (136,466,'ML','MLI','Malï¿½'),
  (137,470,'MT','MLT','Malta'),
  (138,238,'FK','FLK','Islas Malvinas'),
  (139,580,'MP','MNP','Islas Marianas del Norte'),
  (140,504,'MA','MAR','Marruecos'),
  (141,584,'MH','MHL','Islas Marshall'),
  (142,474,'MQ','MTQ','Martinica'),
  (143,480,'MU','MUS','Mauricio'),
  (144,478,'MR','MRT','Mauritania'),
  (145,175,'YT','MYT','Mayotte'),
  (146,484,'MX','MEX','Mï¿½xico'),
  (147,583,'FM','FSM','Micronesia'),
  (148,498,'MD','MDA','Moldavia'),
  (149,492,'MC','MCO','Mï¿½naco'),
  (150,496,'MN','MNG','Mongolia'),
  (151,500,'MS','MSR','Montserrat'),
  (152,508,'MZ','MOZ','Mozambique'),
  (153,104,'MM','MMR','Myanmar'),
  (154,516,'NA','NAM','Namibia'),
  (155,520,'NR','NRU','Nauru'),
  (156,524,'NP','NPL','Nepal'),
  (157,558,'NI','NIC','Nicaragua'),
  (158,562,'NE','NER','Nï¿½ger'),
  (159,566,'NG','NGA','Nigeria'),
  (160,570,'NU','NIU','Niue'),
  (161,574,'NF','NFK','Isla Norfolk'),
  (162,578,'NO','NOR','Noruega'),
  (163,540,'NC','NCL','Nueva Caledonia'),
  (164,554,'NZ','NZL','Nueva Zelanda'),
  (165,512,'OM','OMN','Omï¿½n'),
  (166,528,'NL','NLD','Paï¿½ses Bajos'),
  (167,586,'PK','PAK','Pakistï¿½n'),
  (168,585,'PW','PLW','Palau'),
  (169,275,'PS','PSE','Palestina'),
  (170,591,'PA','PAN','Panamï¿½'),
  (171,598,'PG','PNG','Papï¿½a Nueva Guinea'),
  (172,600,'PY','PRY','Paraguay'),
  (173,604,'PE','PER','Perï¿½'),
  (174,612,'PN','PCN','Islas Pitcairn'),
  (175,258,'PF','PYF','Polinesia Francesa'),
  (176,616,'PL','POL','Polonia'),
  (177,620,'PT','PRT','Portugal'),
  (178,630,'PR','PRI','Puerto Rico'),
  (179,634,'QA','QAT','Qatar'),
  (180,826,'GB','GBR','Reino Unido'),
  (181,638,'RE','REU','Reuniï¿½n'),
  (182,646,'RW','RWA','Ruanda'),
  (183,642,'RO','ROU','Rumania'),
  (184,643,'RU','RUS','Rusia'),
  (185,732,'EH','ESH','Sahara Occidental'),
  (186,90,'SB','SLB','Islas Salomï¿½n'),
  (187,882,'WS','WSM','Samoa'),
  (188,16,'AS','ASM','Samoa Americana'),
  (189,659,'KN','KNA','San Cristï¿½bal y Nevis'),
  (190,674,'SM','SMR','San Marino'),
  (191,666,'PM','SPM','San Pedro y Miquelï¿½n'),
  (192,670,'VC','VCT','San Vicente y las Granadinas'),
  (193,654,'SH','SHN','Santa Helena'),
  (194,662,'LC','LCA','Santa Lucï¿½a'),
  (195,678,'ST','STP','Santo Tomï¿½ y Prï¿½ncipe'),
  (196,686,'SN','SEN','Senegal'),
  (197,891,'CS','SCG','Serbia y Montenegro'),
  (198,690,'SC','SYC','Seychelles'),
  (199,694,'SL','SLE','Sierra Leona'),
  (200,702,'SG','SGP','Singapur'),
  (201,760,'SY','SYR','Siria'),
  (202,706,'SO','SOM','Somalia'),
  (203,144,'LK','LKA','Sri Lanka'),
  (204,748,'SZ','SWZ','Suazilandia'),
  (205,710,'ZA','ZAF','Sudï¿½frica'),
  (206,736,'SD','SDN','Sudï¿½n'),
  (207,752,'SE','SWE','Suecia'),
  (208,756,'CH','CHE','Suiza'),
  (209,740,'SR','SUR','Surinam'),
  (210,744,'SJ','SJM','Svalbard y Jan Mayen'),
  (211,764,'TH','THA','Tailandia'),
  (212,158,'TW','TWN','Taiwï¿½n'),
  (213,834,'TZ','TZA','Tanzania'),
  (214,762,'TJ','TJK','Tayikistï¿½n'),
  (215,86,'IO','IOT','Territorio Britï¿½nico del Ocï¿½ano ï¿½ndico'),
  (216,260,'TF','ATF','Territorios Australes Franceses'),
  (217,626,'TL','TLS','Timor Oriental'),
  (218,768,'TG','TGO','Togo'),
  (219,772,'TK','TKL','Tokelau'),
  (220,776,'TO','TON','Tonga'),
  (221,780,'TT','TTO','Trinidad y Tobago'),
  (222,788,'TN','TUN','Tï¿½nez'),
  (223,796,'TC','TCA','Islas Turcas y Caicos'),
  (224,795,'TM','TKM','Turkmenistï¿½n'),
  (225,792,'TR','TUR','Turquï¿½a'),
  (226,798,'TV','TUV','Tuvalu'),
  (227,804,'UA','UKR','Ucrania'),
  (228,800,'UG','UGA','Uganda'),
  (229,858,'UY','URY','Uruguay'),
  (230,860,'UZ','UZB','Uzbekistï¿½n'),
  (231,548,'VU','VUT','Vanuatu'),
  (232,862,'VE','VEN','Venezuela'),
  (233,704,'VN','VNM','Vietnam'),
  (234,92,'VG','VGB','Islas Vï¿½rgenes Britï¿½nicas'),
  (235,850,'VI','VIR','Islas Vï¿½rgenes de los Estados Unidos'),
  (236,876,'WF','WLF','Wallis y Futuna'),
  (237,887,'YE','YEM','Yemen'),
  (238,262,'DJ','DJI','Yibuti'),
  (239,894,'ZM','ZMB','Zambia'),
  (240,716,'ZW','ZWE','Zimbabue');
COMMIT;

#
# Data for the `permiso` table  (LIMIT -492,500)
#

INSERT INTO `permiso` (`idPermiso`, `nivel`, `nombrePermiso`, `borrado`) VALUES

  (1,1,'Usuario Normal : Cuenta',0),
  (2,2,'Usuario Negocio: Cuenta Negocio',0),
  (3,3,'Usuario AC: Cuenta AC',0),
  (4,0,'Admin',0),
  (5,1,'Carrito: Usuario',0),
  (6,2,'Carrito: Negocio',0),
  (7,3,'Carrito: AC',0);
COMMIT;

#
# Data for the `productodetalle` table  (LIMIT -486,500)
#

INSERT INTO `productodetalle` (`detalleProductoID`, `productoID`, `detalle`, `valor`) VALUES

  (12,15,'talla','4'),
  (13,16,'talla','1'),
  (14,16,'talla','2'),
  (15,16,'talla','3'),
  (16,16,'color','Rojo'),
  (17,16,'color','Morado'),
  (18,16,'color','Amarillo'),
  (19,17,'talla','1'),
  (20,17,'talla','2'),
  (21,17,'talla','3'),
  (22,17,'color','ROSA'),
  (23,17,'color','AZUL'),
  (24,17,'color','AMARILLO');
COMMIT;

#
# Data for the `publicaciones` table  (LIMIT -490,500)
#

INSERT INTO `publicaciones` (`publicacionID`, `seccion`, `titulo`, `vigente`, `fechaCreacion`, `fechaVencimiento`, `numeroVisitas`, `estadoID`, `genero`, `razaID`, `precio`, `descripcion`, `muestraTelefono`, `aprobada`, `servicioID`, `detalleID`, `paqueteID`, `ciudad`) VALUES

  (1,2,'Venta de Cachorro',1,'2014-07-16','2014-08-15',0,1,1,'1',999.99,'50 caracteres para anunciar',1,1,1,1,1,NULL),
  (3,2,'qqqq',1,'2014-08-12','2014-08-17',0,1,0,'2',999.99,'ddddd',0,1,11,1,1,NULL),
  (4,3,'TITULO EN PREMIUM',1,'2014-08-12','2014-10-11',0,22,1,'71',999.99,'PERRO SCHNAUZER EN VENTA',1,2,12,3,3,NULL),
  (6,2,'ssss',1,'2014-08-12','2014-09-11',0,4,1,'3',45.00,'dddddd',1,0,14,2,2,NULL),
  (7,6,'ADOPCION PERRO',1,'2014-08-14','2014-09-13',0,15,0,'2',999.99,'4444 4444 4444 0008',0,0,15,2,2,'GDL'),
  (8,6,'ADOPCION PERRO',1,'2014-08-14','2014-08-19',0,15,0,'2',999.99,'4444 4444 4444 0008',0,0,16,1,1,'GDL'),
  (20,6,'asdfghh',1,'2014-08-14','2014-10-13',0,1,1,'1',999.99,'4444 4444 4444 00084444 4444 4444 00084444 4444 4444 0008',1,0,28,3,3,'ssss'),
  (21,2,'AAA',1,'2014-08-14','2014-09-13',0,2,0,'2',444.00,'AAAAAAAA',0,0,29,2,2,'AAA'),
  (22,7,'aaaa',1,'2014-08-14','2014-08-19',0,2,1,'2',76.00,'gjhgh',1,0,30,1,1,'bd');
COMMIT;

#
# Data for the `raza` table  (LIMIT -416,500)
#

INSERT INTO `raza` (`razaID`, `raza`) VALUES

  (1,'Akita Inu'),
  (2,'Alaskan Malamute'),
  (3,'Barzoi'),
  (4,'Basset Azul de Gascuña'),
  (5,'Basset Hound'),
  (6,'Beagle'),
  (7,'Beauceron'),
  (8,'Bichón Maltés'),
  (9,'Bobtail'),
  (10,'Border Collie'),
  (11,'Boxer'),
  (12,'Boyero de Berna'),
  (13,'Braco'),
  (14,'Briard'),
  (15,'Bull Terrier Inglés'),
  (16,'Bulldog'),
  (17,'Bullmastiff'),
  (18,'Cairn Terrier'),
  (19,'Cane Corso'),
  (20,'Caniche'),
  (21,'Cavalier King Charles'),
  (22,'Chihuahua'),
  (23,'Chow Chow'),
  (24,'Cocker Spaniel'),
  (25,'Collie'),
  (26,'Dálmata'),
  (27,'Doberman'),
  (28,'Dogo'),
  (29,'Epagneul'),
  (30,'Fox Terrier'),
  (31,'Galgo'),
  (32,'Golden Retriever'),
  (33,'Gordon Setter'),
  (34,'Gos d''Atura'),
  (35,'Gran Danés'),
  (36,'Husky Siberiano'),
  (37,'Komondor'),
  (38,'Labrador Retriever'),
  (39,'Lebrel'),
  (40,'Mastiff'),
  (41,'Mastín'),
  (42,'Montaña de los Pirineos'),
  (43,'Norfolk Terrier'),
  (44,'Norwich Terrier'),
  (45,'Papillon'),
  (46,'Pastor Alemán'),
  (47,'Pastor Australiano'),
  (48,'Pastor Belga'),
  (49,'Pastor Blanco Suizo'),
  (50,'Pastor de los Pirineos'),
  (51,'Pekinés'),
  (52,'Pequeño Azul de Gascuña'),
  (53,'Pequeño Basset Griffon'),
  (54,'Pequeño Brabantino'),
  (55,'Pequeño Perro León'),
  (56,'Pequeño Perro Ruso'),
  (57,'Pequeño Sabueso Suizo'),
  (58,'Perdiguero'),
  (59,'Perro de Agua Español'),
  (60,'Perro Lobo de Checoslovaquia'),
  (61,'Pinscher miniatura'),
  (62,'Pit Bull'),
  (63,'Podenco'),
  (64,'Pointer Inglés'),
  (65,'Presa Canario'),
  (66,'Pug'),
  (67,'Rafeiro do Alentejo'),
  (68,'Rottweiler'),
  (69,'Samoyedo'),
  (70,'San Bernardo'),
  (71,'Schnauzer'),
  (72,'Scottish Terrier'),
  (73,'Setter'),
  (74,'Shar Pei'),
  (75,'Shih Tzu'),
  (76,'Spitz'),
  (77,'Springer Spaniel'),
  (78,'Teckel'),
  (79,'Terranova'),
  (80,'Weimaraner'),
  (81,'Westies'),
  (82,'Whippet'),
  (83,'Yorkshire Terrier');
COMMIT;

#
# Data for the `rol` table  (LIMIT -496,500)
#

INSERT INTO `rol` (`idRol`, `nombreRol`, `borrado`) VALUES

  (1,'Usuario Normal',0),
  (2,'Usuario Negocio',0),
  (3,'Usuario AC',0);
COMMIT;

#
# Data for the `roltienepermiso` table  (LIMIT -493,500)
#

INSERT INTO `roltienepermiso` (`idRol`, `idPermiso`) VALUES

  (1,1),
  (1,5),
  (2,2),
  (2,5),
  (3,3),
  (3,5);
COMMIT;

#
# Data for the `usuariodato` table  (LIMIT -494,500)
#

INSERT INTO `usuariodato` (`idUsuarioDato`, `idUsuario`, `razonSocial`, `rfc`, `calle`, `noInterior`, `noExterior`, `cp`, `municipio`, `estadoID`, `idPais`) VALUES

  (2,2,'','','','0','',0,'',0,147),
  (3,3,'','','','0','',0,'',0,147),
  (4,4,'','','','0','',0,'',0,147),
  (6,6,'AAAA','AAAAA','AAA','0','222',2222,'QRO',22,147),
  (7,7,'','','','0','0',0,'',0,147);
COMMIT;

#
# Data for the `ubicacionusuario` table  (LIMIT -497,500)
#

INSERT INTO `ubicacionusuario` (`ubicacionUsuarioID`, `tipoUsuario`, `latitud`, `longitud`, `idUsuarioDato`, `estadoID`, `zonageograficaID`) VALUES

  (1,2,'20.571765230363617','-100.3824978359375',6,22,4),
  (2,3,'','',7,0,NULL);
COMMIT;

#
# Data for the `videos` table  (LIMIT -496,500)
#

INSERT INTO `videos` (`videoID`, `link`, `publicacionID`, `servicioID`, `detalleID`, `paqueteID`) VALUES

  (1,'4444 4444 4444 0008',20,28,3,3),
  (2,'fotospublicacion',21,29,2,2),
  (3,'<link type=\"text/css\" rel=\"stylesheet\" href=\"<?php echo base_url() ?>css/reset.css\" media=\"screen\"></link>',22,30,1,1);
COMMIT;

#
# Data for the `visita` table  (LIMIT -498,500)
#

INSERT INTO `visita` (`idVisita`, `numeroVisitas`) VALUES

  (1,1955);
COMMIT;

#
# Data for the `vs_database_diagrams` table  (LIMIT -498,500)
#

INSERT INTO `vs_database_diagrams` (`name`, `diadata`, `comment`, `preview`, `lockinfo`, `locktime`, `version`) VALUES

  ('productos',NULL,NULL,NULL,'quieroun_perro*3989957','2014-07-25 13:46:09',NULL);
COMMIT;

#
# Data for the `zonageografica` table  (LIMIT -490,500)
#

INSERT INTO `zonageografica` (`zonaID`, `zona`) VALUES

  (1,'Noroeste'),
  (2,'Noreste'),
  (3,'Occidente'),
  (4,'Centronorte'),
  (5,'Metropolitana'),
  (6,'Oriente'),
  (7,'Suroeste'),
  (8,'Sureste'),
  (9,'Todas');
COMMIT;

#
# Data for the `zonageograficaestado` table  (LIMIT -466,500)
#

INSERT INTO `zonageograficaestado` (`zonaID`, `nombre`, `estadoID`, `zonageograficaID`) VALUES

  (2,'Noroeste',2,1),
  (3,'Noroeste',3,1),
  (4,'Noroeste',26,1),
  (5,'Noroeste',25,1),
  (6,'Noroeste',6,1),
  (7,'Noroeste',10,1),
  (8,'Noreste',7,2),
  (9,'Noreste',19,2),
  (10,'Noreste',28,2),
  (11,'Occidente',15,3),
  (12,'Occidente',18,3),
  (13,'Occidente',8,3),
  (14,'Occidente',16,3),
  (15,'Centronorte',1,4),
  (16,'Centronorte',12,4),
  (17,'Centronorte',24,4),
  (18,'Centronorte',22,4),
  (19,'Centronorte',32,4),
  (20,'Metropolitana',11,5),
  (21,'Metropolitana',9,5),
  (22,'Metropolitana',17,5),
  (23,'Oriente',14,6),
  (24,'Oriente',21,6),
  (25,'Oriente',29,6),
  (26,'Oriente',30,6),
  (27,'Oriente',27,6),
  (28,'Suroeste',13,7),
  (29,'Suroeste',20,7),
  (30,'Suroeste',5,7),
  (31,'Sureste',4,8),
  (32,'Sureste',23,8),
  (33,'Sureste',31,8),
  (34,'Sureste',27,8);
COMMIT;



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;