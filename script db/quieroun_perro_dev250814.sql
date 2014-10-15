

DROP DATABASE IF EXISTS `quieroun_perro_dev`;

CREATE DATABASE `quieroun_perro_dev`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

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
DROP TABLE IF EXISTS `mensajesadmin`;
DROP TABLE IF EXISTS `mensajes`;
DROP TABLE IF EXISTS `giroempresa`;
DROP TABLE IF EXISTS `usuariodetalle`;
DROP TABLE IF EXISTS `giro`;
DROP TABLE IF EXISTS `fotostienda`;
DROP TABLE IF EXISTS `fotospublicacion`;
DROP TABLE IF EXISTS `fotoscontenido`;
DROP TABLE IF EXISTS `favoritos`;
DROP TABLE IF EXISTS `estado`;
DROP TABLE IF EXISTS `cupondetalle`;
DROP TABLE IF EXISTS `cuponadquirido`;
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
AUTO_INCREMENT=56 AVG_ROW_LENGTH=2340 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
  `recepcionCorreo` INTEGER(1) NOT NULL DEFAULT 1 COMMENT '1 - recepci�n de correo activa\n 0 - recepci�n de correo inactiva',
  `tipoUsuario` INTEGER(1) NOT NULL DEFAULT 1 COMMENT '0 - Administrador\n1 - usuario normal\n2 - negocio\n3 - AC',
  `status` INTEGER(1) NOT NULL DEFAULT 0 COMMENT '0 - no activado\n1 - activo',
  `nivel` INTEGER(11) DEFAULT NULL COMMENT 'establecimiento de jerarqu�a en usuarios',
  `codigoConfirmacion` VARCHAR(100) COLLATE utf8_general_ci NOT NULL COMMENT 'c�digo necesario para confirmar cuenta.',
  `fechaRegistro` DATETIME NOT NULL,
  `useragent` VARCHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `last_ip_access` VARCHAR(16) COLLATE utf8_general_ci DEFAULT NULL,
  `authKey` VARCHAR(100) COLLATE utf8_general_ci DEFAULT NULL,
  `paqueteGratis` INTEGER(11) DEFAULT 1 COMMENT 'si paquete gratis = 1 no lo ha usado, si = 0 entonces ya tiene costo',
  PRIMARY KEY USING BTREE (`idUsuario`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=12 AVG_ROW_LENGTH=3276 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
AUTO_INCREMENT=6 AVG_ROW_LENGTH=8192 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
AUTO_INCREMENT=4 AVG_ROW_LENGTH=16384 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
  `pagado` INTEGER(11) DEFAULT 0,
  PRIMARY KEY USING BTREE (`compraID`) COMMENT '',
   INDEX `usuarioID` USING BTREE (`usuarioID`) COMMENT '',
  CONSTRAINT `compra_fk1` FOREIGN KEY (`usuarioID`) REFERENCES `usuario` (`idUsuario`)
)ENGINE=InnoDB
AUTO_INCREMENT=33 AVG_ROW_LENGTH=5461 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
AUTO_INCREMENT=17 AVG_ROW_LENGTH=4096 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
  `fecha` VARCHAR(80) COLLATE utf8_general_ci NOT NULL,
  `zonaID` INTEGER(11) DEFAULT NULL,
  `nombre` VARCHAR(120) COLLATE utf8_general_ci DEFAULT NULL,
  `mes` VARCHAR(30) COLLATE utf8_general_ci DEFAULT NULL,
  `origenes` MEDIUMTEXT COLLATE utf8_general_ci,
  `caracter` MEDIUMTEXT COLLATE utf8_general_ci,
  `cualidades` MEDIUMTEXT COLLATE utf8_general_ci,
  `colores` MEDIUMTEXT COLLATE utf8_general_ci,
  `acercaDe` MEDIUMTEXT COLLATE utf8_general_ci,
  `horario` VARCHAR(80) COLLATE utf8_general_ci DEFAULT NULL,
  `lugar` VARCHAR(120) COLLATE utf8_general_ci DEFAULT NULL,
  `domicilio` VARCHAR(200) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`contenidoID`) COMMENT '',
   INDEX `seccion` USING BTREE (`seccionID`) COMMENT '',
  CONSTRAINT `contenido_fk1` FOREIGN KEY (`seccionID`) REFERENCES `seccion` (`seccionID`)
)ENGINE=InnoDB
AUTO_INCREMENT=15 AVG_ROW_LENGTH=2048 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
AUTO_INCREMENT=63 AVG_ROW_LENGTH=4096 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `tipopaquete` table : 
#

CREATE TABLE `tipopaquete` (
  `idtipopaquete` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `nombreTipoPaquete` VARCHAR(80) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY USING BTREE (`idtipopaquete`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=4 AVG_ROW_LENGTH=5461 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
  `pagado` INTEGER(11) DEFAULT 0,
  PRIMARY KEY USING BTREE (`servicioID`, `detalleID`, `paqueteID`) COMMENT '',
   INDEX `detallePaqueteUsuario` USING BTREE (`idUsuario`) COMMENT '',
   INDEX `historicoPaquete` USING BTREE (`detalleID`, `paqueteID`) COMMENT '',
  CONSTRAINT `detallePaqueteUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `historicoPaquete` FOREIGN KEY (`detalleID`, `paqueteID`) REFERENCES `detallepaquete` (`detalleID`, `paqueteID`)
)ENGINE=InnoDB
AUTO_INCREMENT=2 AVG_ROW_LENGTH=606 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
  CONSTRAINT `detalleCuponPaquete` FOREIGN KEY (`servicioID`, `detalleID`, `paqueteID`) REFERENCES `serviciocontratado` (`servicioID`, `detalleID`, `paqueteID`)
)ENGINE=InnoDB
AUTO_INCREMENT=1 AVG_ROW_LENGTH=528 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
AUTO_INCREMENT=79 AVG_ROW_LENGTH=4096 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
   INDEX `productoID_new` USING BTREE (`contenidoID`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=18 AVG_ROW_LENGTH=819 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
AUTO_INCREMENT=40 AVG_ROW_LENGTH=16384 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
AUTO_INCREMENT=4 AVG_ROW_LENGTH=8192 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
AUTO_INCREMENT=6 AVG_ROW_LENGTH=8192 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `mensajes` table : 
#

CREATE TABLE `mensajes` (
  `mensajeID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `asunto` VARCHAR(80) COLLATE utf8_general_ci NOT NULL,
  `mensaje` VARCHAR(300) COLLATE utf8_general_ci NOT NULL,
  `idUsuario` INTEGER(11) DEFAULT NULL,
  `tipoMensaje` VARCHAR(60) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`mensajeID`) COMMENT '',
   INDEX `mensajes` USING BTREE (`idUsuario`) COMMENT '',
  CONSTRAINT `mensajes` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=28 AVG_ROW_LENGTH=2340 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `mensajesadmin` table : 
#

CREATE TABLE `mensajesadmin` (
  `mensajeID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `tipoMensaje` VARCHAR(80) COLLATE utf8_general_ci DEFAULT NULL,
  `asunto` VARCHAR(80) COLLATE utf8_general_ci DEFAULT NULL,
  `contenido` TEXT COLLATE utf8_general_ci,
  PRIMARY KEY USING BTREE (`mensajeID`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=9 AVG_ROW_LENGTH=4096 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
AUTO_INCREMENT=29 AVG_ROW_LENGTH=1260 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
AUTO_INCREMENT=2 AVG_ROW_LENGTH=1820 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
  `idPais` INTEGER(11) DEFAULT 147 COMMENT '147 = M�xico',
  PRIMARY KEY USING BTREE (`idUsuarioDato`) COMMENT '',
   INDEX `adicional` USING BTREE (`idUsuario`) COMMENT '',
  CONSTRAINT `adicional` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB
AUTO_INCREMENT=9 AVG_ROW_LENGTH=2730 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
AUTO_INCREMENT=4 AVG_ROW_LENGTH=8192 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
AUTO_INCREMENT=33 AVG_ROW_LENGTH=5461 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
  `name` CHAR(80) COLLATE utf8_general_ci DEFAULT NULL,
  `diadata` TEXT COLLATE utf8_general_ci,
  `comment` VARCHAR(1022) COLLATE utf8_general_ci DEFAULT NULL,
  `preview` TEXT COLLATE utf8_general_ci,
  `lockinfo` CHAR(80) COLLATE utf8_general_ci DEFAULT NULL,
  `locktime` TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `version` CHAR(80) COLLATE utf8_general_ci DEFAULT NULL
)ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
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
  (6,'Adopci'),
  (7,'Perros Perdidos'),
  (8,'La raza del mes'),
  (9,'Evento del mes'),
  (10,'Datos Curiosos'),
  (11,'Asociaciones Protectoras'),
  (12,'?Qui?nes somos?'),
  (13,'Tutorial'),
  (14,'Publicidad'),
  (15,'Preguntas frecuentes'),
  (16,'Tienda'),
  (17,'Publicidad Lateral');
COMMIT;

#
# Data for the `banner` table  (LIMIT -457,500)
#

INSERT INTO `banner` (`bannerID`, `imgbaner`, `texto`, `zonaID`, `posicion`, `seccionID`) VALUES

  (6,'banner_lateral/_9ad4a__0019e_3_thumb.png','',9,4,17),
  (7,'/_29f25__15bf6_Hydrangeas_thumb.jpg','texto apoyo',9,2,1),
  (11,'banner_superior/_b2fea__fce75_Chrysanthemum_thumb.jpg','',9,1,1),
  (13,'','Apoyo',9,2,2),
  (16,'','APOYO EN PERFIL',9,2,5),
  (17,'banner_superior/_53b24__cab21_accept_thumb.png','',9,1,6),
  (18,'banner_inferior/_3dc5d__fb4d1_accept_thumb.png','',9,3,6),
  (19,'','TEXTO DE APOYO EN ADOPCION ZONA 9',9,2,6),
  (20,'banner_superior/_822d8__10821_accept1_thumb.png','',4,1,6),
  (21,'banner_inferior/_88e8c__a065d_accept1_thumb.png','',4,3,6),
  (22,'','TEXTO DE APOYO EN ADOPCION EN ZONA 4',4,2,6),
  (23,'banner_superior/_dc6b7__993f9_accept_thumb.png','',9,1,11),
  (24,'','APOYO EN ASOCIACIONES',9,2,11),
  (25,'banner_inferior/_cae83__edf42_accept_thumb.png','',9,3,11),
  (26,'banner_superior/_cc08c__6dc52_cancel_thumb.png','',9,1,3),
  (27,'','APOYO EN CRUZA',9,2,3),
  (28,'banner_inferior/_ae18e__766e9_cancel_thumb.png','',9,3,3),
  (29,'/_2d53b__bd399_900x500_1_thumb.jpg','',9,2,1),
  (30,'/_d6b77__32fe3_900x500_2_thumb.jpg','',9,2,1),
  (31,'/_32586__d5ea9_900x500_3_thumb.jpg','',9,2,1),
  (32,'banner_superior/_166ef__2c8e3_2_thumb.png','',9,1,1),
  (33,'banner_superior/_58322__060cc__166ef__2c8e3_2_thumb.png','',9,1,1),
  (34,'banner_superior/_129a3__05901__4e023__0fbf0_Chrysanthemum_thumb_thumb.jpg','',9,1,2),
  (36,'banner_superior/_ea1f1__d803d__3bbd0__55d73_Hydrangeas_thumb_thumb.jpg','',9,1,16),
  (37,'banner_inferior/_53d25__26d2b__4e023__0fbf0_Chrysanthemum_thumb_thumb.jpg','',9,3,16),
  (38,'banner_superior/_c95b5__56c48__7fa10__f1a51_Jellyfish_thumb_thumb.jpg','',9,1,2),
  (39,'banner_superior/_bc22e__3527e__166ef__2c8e3_2_thumb_thumb.png','',9,1,2),
  (40,'banner_superior/_538f2__c3f56_1_thumb.png','',9,1,4),
  (41,'banner_superior/_37a6d__acac4__4e023__0fbf0_Chrysanthemum_thumb_thumb.jpg','',9,1,4),
  (42,'','texto de apoyo en directorio',9,2,4),
  (43,'banner_inferior/_aa110__287d6_1_thumb.png','',9,3,2),
  (44,'banner_inferior/_70a27__f56d0_3_thumb.png','',9,3,4),
  (45,'banner_superior/_2ef37__170fb__18b38__28cb4_Jellyfish_thumb_thumb.jpg','',9,1,12),
  (46,'banner_inferior/_ab70f__f34f8__70a27__f56d0_3_thumb_thumb.png','',9,3,12),
  (47,'banner_superior/_5194f__e7dfc_1_thumb.png','',9,1,5),
  (48,'banner_superior/_020f5__f51a1__53d25__26d2b__4e023__0fbf0_Chrysanthemum_thumb_thumb_thumb.jpg','',9,1,7),
  (50,'banner_inferior/_177ec__8529a__53d25__26d2b__4e023__0fbf0_Chrysanthemum_thumb_thumb_thumb.jpg','',9,3,7),
  (51,'','Texto en perros perdidos',9,2,7),
  (52,'banner_superior/_06179__9df0b__18b38__28cb4_Jellyfish_thumb_thumb.jpg','',9,1,8),
  (53,'banner_superior/_9f7dd__8bd3d_Hydrangeas_-_copia_thumb.jpg','',9,1,10),
  (54,'banner_superior/_be6d7__4ca8d_Chrysanthemum_thumb.jpg','',9,1,9),
  (55,'banner_inferior/_80f93__c922b_Hydrangeas_-_copia_thumb.jpg','',9,3,9);
COMMIT;

#
# Data for the `usuario` table  (LIMIT -490,500)
#

INSERT INTO `usuario` (`idUsuario`, `nombre`, `apellido`, `telefono`, `correo`, `contrasena`, `recepcionCorreo`, `tipoUsuario`, `status`, `nivel`, `codigoConfirmacion`, `fechaRegistro`, `useragent`, `last_ip_access`, `authKey`, `paqueteGratis`) VALUES

  (2,'admin','admin',1111,'admin@gmail.com','2e0e4da5c11c0f8a73a01a5ddd672211af58c5b1e5179d7412',0,0,1,0,'A7995E2C507D113EF045E8BE6','2014-07-14 21:23:15',NULL,NULL,'7C56D1149F1967741576',1),
  (3,'martha','hdez',1111,'marthahdez2@gmail.com','547bee0d5a4d07320698bc26ca7c68f8dec2af4574a5829b70',1,1,1,1,'EA5A0F1E6DD8358A5ECDC3C6C','2014-07-17 17:24:18',NULL,NULL,'B829FA0A75314428B5A4',1),
  (4,'dddd','dddd',0,'dddd@ssss.com','2e0e4da5c11c0f8a73a01a5ddd672211af58c5b1e5179d7412',0,1,1,1,'A7995E2C507D113EF045E8BE6','2014-08-03 18:24:47',NULL,NULL,'DAE20D308B05D531E511',1),
  (6,'Martha','hh',2147483647,'martha.tain@gmail.com','2e0e4da5c11c0f8a73a01a5ddd672211af58c5b1e5179d7412',0,2,1,2,'A7995E2C507D113EF045E8BE6','2014-08-06 21:23:18',NULL,NULL,'5290D994FE0F37B5BBCF',1),
  (7,'AAA','AAAAAAA',0,'AAAA@AAA.COM','2e0e4da5c11c0f8a73a01a5ddd672211af58c5b1e5179d7412',0,3,1,3,'FA5760A00DBFD87A83B1444D1','2014-08-06 21:27:41',NULL,NULL,'6AED56BB465F54019B1E',1),
  (8,'qwerty','qwerty',0,'marthahdez1@gmail.com','09e9594c4e08da50121b6d96709f0cb82883ed0a589d568e22',1,2,1,2,'A7CB99ED6727A5DC281AECB4D','2014-08-15 18:54:48',NULL,NULL,'BABB34C62A44A2772CC8',1),
  (9,'ADMIN','ADMIN',1234567890,'marthahdez22@gmail.com','ce837a193dcf8a0928f833783098d1618022daa182d8b46285',1,0,1,0,'257F06E49C44489737D3BBD31','2014-08-24 03:08:24',NULL,NULL,'727E36D81670749F9ADC',1),
  (10,'ADMIN','ADMIN',1234567890,'marthahdez3@gmail.com','dbc69d29174adbf8ce36f3dcfc0f59e71ba84994beeda33375',1,0,1,0,'B26B7969336756D19A6AEA3B3','2014-08-24 03:13:22',NULL,NULL,'F5D6087BCAFD0F5DA5CB',1),
  (11,'adminadmin','adminadmin',0,'marthahdez4@gmail.com','24da39cb7e92b5194a1139a352eff6414cf1a844b3fb968d33',1,0,1,0,'E17BCBA6035A2D74A239BEF0F','2014-08-24 03:15:23',NULL,NULL,'8E90D61BADDC5BE38ACB',1);
COMMIT;

#
# Data for the `carrito` table  (LIMIT -496,500)
#

INSERT INTO `carrito` (`cartID`, `usuarioID`, `productoID`, `cantidad`, `precio`, `nombre`, `talla`, `color`) VALUES

  (3,2,17,10,78.00,'MMM','3','AMARILLO'),
  (4,2,3,1,123.00,'AAA','0','0'),
  (5,3,1,1,999.99,'BOTAS DE LLUVIA','0','0');
COMMIT;

#
# Data for the `carritototal` table  (LIMIT -496,500)
#

INSERT INTO `carritototal` (`carritoTotalID`, `usuarioID`, `totalProductos`, `totalPrecio`, `subtotal`, `descuento`) VALUES

  (1,2,11.00,903.00,903.00,0),
  (2,7,0.00,0.00,0.00,0),
  (3,3,1.00,949.99,999.99,5);
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
  (16,'LLL','ssssssssssssss','LLL',80.00),
  (17,'MMM','Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ut aliquam arcu. Aliquam lectus ante, aliquam vitae consectetur eu, blandit at massa. Suspendisse nec elementum leo. Nullam auctor neque eu nulla tincidunt consequat. Nullam ut massa eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Suspendisse gravida nec sapien a tempor. ','MMM',78.00);
COMMIT;

#
# Data for the `ci_sessions` table  (LIMIT -497,500)
#

INSERT INTO `ci_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES

  ('53da9b6955d856e6b2a1a8dbbef0b949','127.0.0.1','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.143 Safari/537.36',1408970549,'a:14:{s:9:\"user_data\";s:0:\"\";s:6:\"banner\";a:42:{i:0;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:1:\"6\";s:8:\"imgbaner\";s:40:\"banner_lateral/_9ad4a__0019e_3_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"4\";s:9:\"seccionID\";s:2:\"17\";}i:1;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:1:\"7\";s:8:\"imgbaner\";s:35:\"/_29f25__15bf6_Hydrangeas_thumb.jpg\";s:5:\"texto\";s:11:\"texto apoyo\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"1\";}i:2;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"11\";s:8:\"imgbaner\";s:53:\"banner_superior/_b2fea__fce75_Chrysanthemum_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"1\";}i:3;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"13\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:5:\"Apoyo\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"2\";}i:4;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"16\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:15:\"APOYO EN PERFIL\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"5\";}i:5;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"17\";s:8:\"imgbaner\";s:46:\"banner_superior/_53b24__cab21_accept_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"6\";}i:6;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"18\";s:8:\"imgbaner\";s:46:\"banner_inferior/_3dc5d__fb4d1_accept_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:1:\"6\";}i:7;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"19\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:33:\"TEXTO DE APOYO EN ADOPCION ZONA 9\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"6\";}i:8;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"20\";s:8:\"imgbaner\";s:47:\"banner_superior/_822d8__10821_accept1_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"4\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"6\";}i:9;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"21\";s:8:\"imgbaner\";s:47:\"banner_inferior/_88e8c__a065d_accept1_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"4\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:1:\"6\";}i:10;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"22\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:36:\"TEXTO DE APOYO EN ADOPCION EN ZONA 4\";s:6:\"zonaID\";s:1:\"4\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"6\";}i:11;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"23\";s:8:\"imgbaner\";s:46:\"banner_superior/_dc6b7__993f9_accept_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:2:\"11\";}i:12;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"24\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:21:\"APOYO EN ASOCIACIONES\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:2:\"11\";}i:13;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"25\";s:8:\"imgbaner\";s:46:\"banner_inferior/_cae83__edf42_accept_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:2:\"11\";}i:14;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"26\";s:8:\"imgbaner\";s:46:\"banner_superior/_cc08c__6dc52_cancel_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"3\";}i:15;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"27\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:14:\"APOYO EN CRUZA\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"3\";}i:16;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"28\";s:8:\"imgbaner\";s:46:\"banner_inferior/_ae18e__766e9_cancel_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:1:\"3\";}i:17;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"29\";s:8:\"imgbaner\";s:34:\"/_2d53b__bd399_900x500_1_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"1\";}i:18;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"30\";s:8:\"imgbaner\";s:34:\"/_d6b77__32fe3_900x500_2_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"1\";}i:19;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"31\";s:8:\"imgbaner\";s:34:\"/_32586__d5ea9_900x500_3_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"1\";}i:20;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"32\";s:8:\"imgbaner\";s:41:\"banner_superior/_166ef__2c8e3_2_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"1\";}i:21;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"33\";s:8:\"imgbaner\";s:55:\"banner_superior/_58322__060cc__166ef__2c8e3_2_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"1\";}i:22;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"34\";s:8:\"imgbaner\";s:73:\"banner_superior/_129a3__05901__4e023__0fbf0_Chrysanthemum_thumb_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"2\";}i:23;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"36\";s:8:\"imgbaner\";s:70:\"banner_superior/_ea1f1__d803d__3bbd0__55d73_Hydrangeas_thumb_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:2:\"16\";}i:24;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"37\";s:8:\"imgbaner\";s:73:\"banner_inferior/_53d25__26d2b__4e023__0fbf0_Chrysanthemum_thumb_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:2:\"16\";}i:25;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"38\";s:8:\"imgbaner\";s:69:\"banner_superior/_c95b5__56c48__7fa10__f1a51_Jellyfish_thumb_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"2\";}i:26;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"39\";s:8:\"imgbaner\";s:61:\"banner_superior/_bc22e__3527e__166ef__2c8e3_2_thumb_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"2\";}i:27;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"40\";s:8:\"imgbaner\";s:41:\"banner_superior/_538f2__c3f56_1_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"4\";}i:28;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"41\";s:8:\"imgbaner\";s:73:\"banner_superior/_37a6d__acac4__4e023__0fbf0_Chrysanthemum_thumb_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"4\";}i:29;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"42\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:28:\"texto de apoyo en directorio\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"4\";}i:30;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"43\";s:8:\"imgbaner\";s:41:\"banner_inferior/_aa110__287d6_1_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:1:\"2\";}i:31;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"44\";s:8:\"imgbaner\";s:41:\"banner_inferior/_70a27__f56d0_3_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:1:\"4\";}i:32;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"45\";s:8:\"imgbaner\";s:69:\"banner_superior/_2ef37__170fb__18b38__28cb4_Jellyfish_thumb_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:2:\"12\";}i:33;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"46\";s:8:\"imgbaner\";s:61:\"banner_inferior/_ab70f__f34f8__70a27__f56d0_3_thumb_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:2:\"12\";}i:34;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"47\";s:8:\"imgbaner\";s:41:\"banner_superior/_5194f__e7dfc_1_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"5\";}i:35;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"48\";s:8:\"imgbaner\";s:93:\"banner_superior/_020f5__f51a1__53d25__26d2b__4e023__0fbf0_Chrysanthemum_thumb_thumb_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"7\";}i:36;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"50\";s:8:\"imgbaner\";s:93:\"banner_inferior/_177ec__8529a__53d25__26d2b__4e023__0fbf0_Chrysanthemum_thumb_thumb_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:1:\"7\";}i:37;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"51\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:24:\"Texto en perros perdidos\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"7\";}i:38;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"52\";s:8:\"imgbaner\";s:69:\"banner_superior/_06179__9df0b__18b38__28cb4_Jellyfish_thumb_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"8\";}i:39;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"53\";s:8:\"imgbaner\";s:58:\"banner_superior/_9f7dd__8bd3d_Hydrangeas_-_copia_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:2:\"10\";}i:40;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"54\";s:8:\"imgbaner\";s:53:\"banner_superior/_be6d7__4ca8d_Chrysanthemum_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"9\";}i:41;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"55\";s:8:\"imgbaner\";s:58:\"banner_inferior/_80f93__c922b_Hydrangeas_-_copia_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:1:\"9\";}}s:6:\"logged\";b:1;s:9:\"idUsuario\";s:1:\"2\";s:6:\"correo\";s:15:\"admin@gmail.com\";s:6:\"nombre\";s:5:\"admin\";s:8:\"apellido\";s:5:\"admin\";s:8:\"telefono\";s:4:\"1111\";s:11:\"tipoUsuario\";s:1:\"0\";s:7:\"authKey\";s:20:\"FAC37ACC9A61595AECBE\";s:5:\"nivel\";s:1:\"0\";s:13:\"idUsuarioDato\";s:1:\"2\";s:3:\"rol\";i:0;s:14:\"manuallyLogged\";b:1;}'),
  ('61d558791d87217f45059e54a4aa4f50','127.0.0.1','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.143 Safari/537.36',1408967932,'a:2:{s:9:\"user_data\";s:0:\"\";s:6:\"banner\";a:42:{i:0;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:1:\"6\";s:8:\"imgbaner\";s:40:\"banner_lateral/_9ad4a__0019e_3_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"4\";s:9:\"seccionID\";s:2:\"17\";}i:1;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:1:\"7\";s:8:\"imgbaner\";s:35:\"/_29f25__15bf6_Hydrangeas_thumb.jpg\";s:5:\"texto\";s:11:\"texto apoyo\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"1\";}i:2;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"11\";s:8:\"imgbaner\";s:53:\"banner_superior/_b2fea__fce75_Chrysanthemum_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"1\";}i:3;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"13\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:5:\"Apoyo\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"2\";}i:4;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"16\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:15:\"APOYO EN PERFIL\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"5\";}i:5;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"17\";s:8:\"imgbaner\";s:46:\"banner_superior/_53b24__cab21_accept_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"6\";}i:6;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"18\";s:8:\"imgbaner\";s:46:\"banner_inferior/_3dc5d__fb4d1_accept_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:1:\"6\";}i:7;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"19\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:33:\"TEXTO DE APOYO EN ADOPCION ZONA 9\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"6\";}i:8;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"20\";s:8:\"imgbaner\";s:47:\"banner_superior/_822d8__10821_accept1_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"4\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"6\";}i:9;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"21\";s:8:\"imgbaner\";s:47:\"banner_inferior/_88e8c__a065d_accept1_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"4\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:1:\"6\";}i:10;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"22\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:36:\"TEXTO DE APOYO EN ADOPCION EN ZONA 4\";s:6:\"zonaID\";s:1:\"4\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"6\";}i:11;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"23\";s:8:\"imgbaner\";s:46:\"banner_superior/_dc6b7__993f9_accept_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:2:\"11\";}i:12;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"24\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:21:\"APOYO EN ASOCIACIONES\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:2:\"11\";}i:13;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"25\";s:8:\"imgbaner\";s:46:\"banner_inferior/_cae83__edf42_accept_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:2:\"11\";}i:14;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"26\";s:8:\"imgbaner\";s:46:\"banner_superior/_cc08c__6dc52_cancel_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"3\";}i:15;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"27\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:14:\"APOYO EN CRUZA\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"3\";}i:16;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"28\";s:8:\"imgbaner\";s:46:\"banner_inferior/_ae18e__766e9_cancel_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:1:\"3\";}i:17;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"29\";s:8:\"imgbaner\";s:34:\"/_2d53b__bd399_900x500_1_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"1\";}i:18;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"30\";s:8:\"imgbaner\";s:34:\"/_d6b77__32fe3_900x500_2_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"1\";}i:19;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"31\";s:8:\"imgbaner\";s:34:\"/_32586__d5ea9_900x500_3_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"1\";}i:20;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"32\";s:8:\"imgbaner\";s:41:\"banner_superior/_166ef__2c8e3_2_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"1\";}i:21;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"33\";s:8:\"imgbaner\";s:55:\"banner_superior/_58322__060cc__166ef__2c8e3_2_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"1\";}i:22;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"34\";s:8:\"imgbaner\";s:73:\"banner_superior/_129a3__05901__4e023__0fbf0_Chrysanthemum_thumb_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"2\";}i:23;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"36\";s:8:\"imgbaner\";s:70:\"banner_superior/_ea1f1__d803d__3bbd0__55d73_Hydrangeas_thumb_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:2:\"16\";}i:24;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"37\";s:8:\"imgbaner\";s:73:\"banner_inferior/_53d25__26d2b__4e023__0fbf0_Chrysanthemum_thumb_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:2:\"16\";}i:25;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"38\";s:8:\"imgbaner\";s:69:\"banner_superior/_c95b5__56c48__7fa10__f1a51_Jellyfish_thumb_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"2\";}i:26;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"39\";s:8:\"imgbaner\";s:61:\"banner_superior/_bc22e__3527e__166ef__2c8e3_2_thumb_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"2\";}i:27;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"40\";s:8:\"imgbaner\";s:41:\"banner_superior/_538f2__c3f56_1_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"4\";}i:28;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"41\";s:8:\"imgbaner\";s:73:\"banner_superior/_37a6d__acac4__4e023__0fbf0_Chrysanthemum_thumb_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"4\";}i:29;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"42\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:28:\"texto de apoyo en directorio\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"4\";}i:30;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"43\";s:8:\"imgbaner\";s:41:\"banner_inferior/_aa110__287d6_1_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:1:\"2\";}i:31;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"44\";s:8:\"imgbaner\";s:41:\"banner_inferior/_70a27__f56d0_3_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:1:\"4\";}i:32;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"45\";s:8:\"imgbaner\";s:69:\"banner_superior/_2ef37__170fb__18b38__28cb4_Jellyfish_thumb_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:2:\"12\";}i:33;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"46\";s:8:\"imgbaner\";s:61:\"banner_inferior/_ab70f__f34f8__70a27__f56d0_3_thumb_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:2:\"12\";}i:34;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"47\";s:8:\"imgbaner\";s:41:\"banner_superior/_5194f__e7dfc_1_thumb.png\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"5\";}i:35;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"48\";s:8:\"imgbaner\";s:93:\"banner_superior/_020f5__f51a1__53d25__26d2b__4e023__0fbf0_Chrysanthemum_thumb_thumb_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"7\";}i:36;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"50\";s:8:\"imgbaner\";s:93:\"banner_inferior/_177ec__8529a__53d25__26d2b__4e023__0fbf0_Chrysanthemum_thumb_thumb_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:1:\"7\";}i:37;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"51\";s:8:\"imgbaner\";s:0:\"\";s:5:\"texto\";s:24:\"Texto en perros perdidos\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"2\";s:9:\"seccionID\";s:1:\"7\";}i:38;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"52\";s:8:\"imgbaner\";s:69:\"banner_superior/_06179__9df0b__18b38__28cb4_Jellyfish_thumb_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"8\";}i:39;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"53\";s:8:\"imgbaner\";s:58:\"banner_superior/_9f7dd__8bd3d_Hydrangeas_-_copia_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:2:\"10\";}i:40;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"54\";s:8:\"imgbaner\";s:53:\"banner_superior/_be6d7__4ca8d_Chrysanthemum_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"1\";s:9:\"seccionID\";s:1:\"9\";}i:41;O:8:\"stdClass\":6:{s:8:\"bannerID\";s:2:\"55\";s:8:\"imgbaner\";s:58:\"banner_inferior/_80f93__c922b_Hydrangeas_-_copia_thumb.jpg\";s:5:\"texto\";s:0:\"\";s:6:\"zonaID\";s:1:\"9\";s:8:\"posicion\";s:1:\"3\";s:9:\"seccionID\";s:1:\"9\";}}}');
COMMIT;

#
# Data for the `compra` table  (LIMIT -467,500)
#

INSERT INTO `compra` (`compraID`, `usuarioID`, `subtotal`, `idCuponAdquirido`, `descuento`, `total`, `fecha`, `pagado`) VALUES

  (1,3,425.00,NULL,20,340.00,'2014-08-06 00:11:56',1),
  (2,3,123.00,NULL,5,116.85,'2014-08-13 00:38:34',1),
  (3,3,999.99,NULL,0,999.99,'2014-08-13 00:45:08',1),
  (4,7,999.99,NULL,NULL,999.99,'2014-08-14 01:40:51',1),
  (5,3,999.99,NULL,NULL,999.99,'2014-08-14 09:34:45',1),
  (6,3,5.00,0,5,4.75,'2014-08-15 02:36:22',0),
  (7,3,100.00,0,5,95.00,'2014-08-15 02:38:14',0),
  (8,3,100.00,0,0,100.00,'2014-08-15 03:07:56',0),
  (9,3,100.00,0,0,100.00,'2014-08-15 03:08:04',1),
  (10,3,5.00,0,5,4.75,'2014-08-15 09:58:24',1),
  (11,3,100.00,0,0,100.00,'2014-08-15 09:59:09',1),
  (12,3,100.00,0,5,95.00,'2014-08-15 10:14:57',1),
  (13,3,100.00,0,5,95.00,'2014-08-15 10:18:25',1),
  (14,3,100.00,0,0,100.00,'2014-08-15 10:26:03',1),
  (15,3,5.00,0,0,5.00,'2014-08-15 10:33:24',1),
  (16,3,5.00,0,0,5.00,'2014-08-15 10:41:40',1),
  (17,3,100.00,0,0,100.00,'2014-08-15 10:44:05',1),
  (18,3,100.00,0,0,100.00,'2014-08-15 11:45:27',1),
  (19,3,100.00,0,0,100.00,'2014-08-15 11:47:47',1),
  (20,3,5.00,0,0,5.00,'2014-08-15 11:57:39',1),
  (21,3,100.00,0,0,100.00,'2014-08-15 12:02:45',1),
  (22,3,100.00,0,0,100.00,'2014-08-15 12:09:54',0),
  (23,3,100.00,0,0,100.00,'2014-08-15 12:10:38',1),
  (24,3,166.00,0,5,157.70,'2014-08-15 12:12:25',1),
  (25,3,5.00,0,0,5.00,'2014-08-15 12:19:55',170),
  (26,3,100.00,0,0,100.00,'2014-08-15 12:22:15',1),
  (27,3,5.00,0,0,5.00,'2014-08-15 16:30:07',1),
  (28,3,100.00,0,0,100.00,'2014-08-15 18:30:16',1),
  (29,7,5.00,0,0,5.00,'2014-08-17 17:38:18',1),
  (30,3,0.00,0,0,0.00,'2014-08-25 07:01:46',1),
  (31,3,0.00,0,0,0.00,'2014-08-25 07:12:20',1),
  (32,3,0.00,0,0,0.00,'2014-08-25 07:36:19',1);
COMMIT;

#
# Data for the `compradetalle` table  (LIMIT -483,500)
#

INSERT INTO `compradetalle` (`compraDetalleID`, `compraID`, `productoID`, `cantidad`, `precio`, `nombre`, `talla`, `color`) VALUES

  (1,1,11,1,56.00,'JJJ','',''),
  (2,1,3,3,123.00,'AAA','',''),
  (3,2,3,1,123.00,'AAA','0','0'),
  (4,3,1,2,999.99,'BOTAS DE LLUVIA','0','0'),
  (5,4,1,4,999.99,'BOTAS DE LLUVIA','0','0'),
  (6,5,1,1,999.99,'BOTAS DE LLUVIA','0','0'),
  (7,23,23,1,100.00,'Regular','',''),
  (8,24,61,1,166.00,'Premium','',''),
  (9,25,62,1,5.00,'Lite','',''),
  (10,26,63,1,100.00,'Regular','',''),
  (11,27,64,1,5.00,'Lite','',''),
  (12,28,65,1,100.00,'Regular','',''),
  (13,29,66,1,5.00,'Lite','',''),
  (14,30,1,1,0.00,'Lite','',''),
  (15,31,1,1,0.00,'Lite','',''),
  (16,32,1,1,0.00,'Lite','','');
COMMIT;

#
# Data for the `contenido` table  (LIMIT -491,500)
#

INSERT INTO `contenido` (`contenidoID`, `seccionID`, `seccionDetalle`, `texto`, `fecha`, `zonaID`, `nombre`, `mes`, `origenes`, `caracter`, `cualidades`, `colores`, `acercaDe`, `horario`, `lugar`, `domicilio`) VALUES

  (3,8,'Raza del mes','','2014-08-25',9,'ssss','Marzo','s','s','s','s','s ',NULL,NULL,NULL),
  (4,8,'Raza del mes','','2014-08-25',0,'4','Abril','d','d','d','d','d  ',NULL,NULL,NULL),
  (5,8,'Raza del mes','','2014-08-24',9,'5','Junio','El Bich�n malt�s es una raza de perro de tama�o peque�o que surgi� en el Mediterr�neo central siendo Italia quien tom� el patrocinio. El nombre de la raza y el origen son, generalmente, asociados a la isla mediterr�nea de Malta, sin embargo, el nombre es a veces descrito con referencia a la isla de Mljet o Meleda','El Bich�n malt�s es una raza de perro de tama�o peque�o que surgi� en el Mediterr�neo central siendo Italia quien tom� el patrocinio. El nombre de la raza y el origen son, generalmente, asociados a la isla mediterr�nea de Malta, sin embargo, el nombre es a veces descrito con referencia a la isla de Mljet o Meleda','El Bich�n malt�s es una raza de perro de tama�o peque�o que surgi� en el Mediterr�neo central siendo Italia quien tom� el patrocinio. El nombre de la raza y el origen son, generalmente, asociados a la isla mediterr�nea de Malta, sin embargo, el nombre es a veces descrito con referencia a la isla de Mljet o Meleda','El Bich�n malt�s es una raza de perro de tama�o peque�o que surgi� en el Mediterr�neo central siendo Italia quien tom� el patrocinio. El nombre de la raza y el origen son, generalmente, asociados a la isla mediterr�nea de Malta, sin embargo, el nombre es a veces descrito con referencia a la isla de Mljet o Meleda','El Bich�n malt�s es una raza de perro de tama�o peque�o que surgi� en el Mediterr�neo central siendo Italia quien tom� el patrocinio. El nombre de la raza y el origen son, generalmente, asociados a la isla mediterr�nea de Malta, sin embargo, el nombre es a veces descrito con referencia a la isla de Mljet o Meleda',NULL,NULL,NULL),
  (6,8,'Raza del mes','','2014-08-25',9,'sssssssssssssss','0','0','0','0','0','0',NULL,NULL,NULL),
  (11,9,'Evento del mes','evento5','evento5',9,'evento5',NULL,NULL,NULL,NULL,NULL,NULL,'evento5','evento5','evento5'),
  (12,9,'Evento del mes','evento5','evento5',9,'evento5',NULL,NULL,NULL,NULL,NULL,NULL,'evento5','evento5','evento5'),
  (13,9,'Evento del mes','evento5','evento5',9,'evento5',NULL,NULL,NULL,NULL,NULL,NULL,'evento5','evento5','evento5'),
  (14,9,'Evento del mes','bbbb','bbb',9,'bbb',NULL,NULL,NULL,NULL,NULL,NULL,'aaaaaaaaaa','b','bbb');
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
# Data for the `cupon` table  (LIMIT -496,500)
#

INSERT INTO `cupon` (`cuponID`, `nombreCupon`, `paqueteID`) VALUES

  (60,'Tienda',2),
  (61,'Paquete',2),
  (62,'Negocio',3);
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

  (1,1,30,30,0,0,0.00,1,1),
  (2,2,300,15,2,1,100.00,2,2),
  (3,3,1000,60,3,2,166.00,3,3);
COMMIT;

#
# Data for the `serviciocontratado` table  (LIMIT -498,500)
#

INSERT INTO `serviciocontratado` (`servicioID`, `cantFotos`, `caracteres`, `vigencia`, `cupones`, `videos`, `precio`, `detalleID`, `paqueteID`, `idUsuario`, `pagado`) VALUES

  (1,1,30,30,0,0,0.00,1,1,3,1);
COMMIT;

#
# Data for the `cupondetalle` table  (LIMIT -496,500)
#

INSERT INTO `cupondetalle` (`cuponDetalleID`, `descripcion`, `valor`, `vigencia`, `tipoCupon`, `cuponID`) VALUES

  (76,'cuponTienda','10',30,1,60),
  (77,'cuponPaquete','80',15,2,61),
  (78,'AAAAA','10',60,3,62);
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
  (11,'Estado de M?xico'),
  (12,'Guanajuato'),
  (13,'Guerrero'),
  (14,'Hidalgo'),
  (15,'Jalisco'),
  (16,'Michoac'),
  (17,'Morelos'),
  (18,'Nayarit'),
  (19,'Nuevo Le'),
  (20,'Oaxaca'),
  (21,'Puebla'),
  (22,'Quer?taro'),
  (23,'Quintana Roo'),
  (24,'San Luis Potos'),
  (25,'Sinaloa'),
  (26,'Sonora'),
  (27,'Tabasco'),
  (28,'Tamaulipas'),
  (29,'Tlaxcala'),
  (30,'Veracruz'),
  (31,'Yucat'),
  (32,'Zacatecas'),
  (33,'Fuera de M?xico');
COMMIT;

#
# Data for the `favoritos` table  (LIMIT -498,500)
#

INSERT INTO `favoritos` (`publicacionID`, `idUsuario`) VALUES

  (1,7);
COMMIT;

#
# Data for the `fotoscontenido` table  (LIMIT -493,500)
#

INSERT INTO `fotoscontenido` (`fotoID`, `foto`, `contenidoID`) VALUES

  (7,'_18b38__28cb4_Jellyfish1.jpg',5),
  (8,'_18b38__28cb4_Jellyfish.jpg',4),
  (9,'Imagen5.png',4),
  (11,'Imagen71.jpg',3),
  (13,'Tulips1.jpg',13),
  (17,'Hydrangeas_-_copia1.jpg',14);
COMMIT;

#
# Data for the `fotospublicacion` table  (LIMIT -460,500)
#

INSERT INTO `fotospublicacion` (`fotoID`, `foto`, `publicacionID`, `servicioID`, `detalleID`, `paqueteID`) VALUES

  (1,'',1,1,1,1),
  (2,'images/anuncios/images',49,57,2,2),
  (3,'images/anuncios/temp',49,57,2,2),
  (4,'images/anuncios/images',50,58,2,2),
  (5,'images/anuncios/temp',50,58,2,2),
  (6,'images/anuncios/',51,59,2,2),
  (7,'images/anuncios/',51,59,2,2),
  (8,'images/anuncios/',52,60,1,1),
  (9,'images/anuncios/',52,60,1,1),
  (10,'images/anuncios/9edbf86a-6af0-4125-b49e-e3da11376c79.png',53,61,1,1),
  (11,'images/anuncios/9edbf86a-6af0-4125-b49e-e3da11376c79.png',53,61,1,1),
  (12,'images/anuncios/a',54,62,2,2),
  (13,'images/anuncios/m',54,62,2,2),
  (14,'images/anuncios/Array',55,63,2,2),
  (15,'images/anuncios/Array',55,63,2,2),
  (16,'images/anuncios/ecda8234-666e-42a3-b122-5e1513cd38ac.png',56,64,2,2),
  (17,'images/anuncios/ecda8234-666e-42a3-b122-5e1513cd38ac.png',56,64,2,2),
  (18,'images/anuncios/e67d900a-87d9-4c02-8de3-b482adb98eb7.png',57,65,1,1),
  (19,'images/anuncios/e67d900a-87d9-4c02-8de3-b482adb98eb7.png',57,65,1,1),
  (20,'images/anuncios/0a1fe7b7-c86d-488e-bdf1-fc7b85f63b4d.png',58,66,2,2),
  (21,'images/anuncios/0a1fe7b7-c86d-488e-bdf1-fc7b85f63b4d.png',58,66,2,2),
  (22,'images/anuncios/b57f0e05-7bba-47b9-ae86-ad6539badd22.png',59,67,2,2),
  (23,'images/anuncios/b57f0e05-7bba-47b9-ae86-ad6539badd22.png',59,67,2,2),
  (24,'images/anuncios/b57f0e05-7bba-47b9-ae86-ad6539badd22.png',60,68,2,2),
  (25,'images/anuncios/b57f0e05-7bba-47b9-ae86-ad6539badd22.png',60,68,2,2),
  (26,'images/anuncios/5ddb3726-f331-4df6-9ed4-c7bb4f497324.png',61,69,3,3),
  (27,'images/anuncios/5ddb3726-f331-4df6-9ed4-c7bb4f497324.png',61,69,3,3),
  (28,'images/anuncios/79f9078e-3692-4db7-980e-1b91287e3082.png',62,70,1,1),
  (29,'images/anuncios/79f9078e-3692-4db7-980e-1b91287e3082.png',62,70,1,1),
  (30,'images/anuncios/aab6366c-532f-478c-ad78-e9acec91f07e.png',63,71,2,2),
  (31,'images/anuncios/aab6366c-532f-478c-ad78-e9acec91f07e.png',63,71,2,2),
  (32,'images/anuncios/c51220ee-4225-445d-b46c-5ec8ed117df9.png',64,72,1,1),
  (33,'images/anuncios/c51220ee-4225-445d-b46c-5ec8ed117df9.png',64,72,1,1),
  (34,'images/anuncios/7421123f-df50-4fbc-b133-709bff1486ce.png',65,73,2,2),
  (35,'images/anuncios/7421123f-df50-4fbc-b133-709bff1486ce.png',65,73,2,2),
  (36,'images/anuncios/662b1e3d-fce8-4a26-afa2-657d14ae0eaf.png',66,74,1,1),
  (37,'images/anuncios/662b1e3d-fce8-4a26-afa2-657d14ae0eaf.png',66,74,1,1),
  (38,'images/anuncios/c0be7f57-3040-4726-bdd1-27940167db58.png',1,1,1,1),
  (39,'images/anuncios/464a25f4-8ee7-45cf-a9db-13dfce3ed760.png',1,1,1,1);
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
  (5,'Centro de sociabilizaci'),
  (6,'Criadero de perros '),
  (7,'Hotel y pensi?n canina '),
  (8,'Alimento y medicamento'),
  (9,'Guarderia de perros'),
  (10,'Tienda de mascotas '),
  (11,'Servicios funerarios '),
  (12,'Servico de paseo');
COMMIT;

#
# Data for the `usuariodetalle` table  (LIMIT -496,500)
#

INSERT INTO `usuariodetalle` (`idusuarioDetalle`, `idUsuario`, `tipoUsuario`, `nombreNegocio`, `giro`, `nombreContacto`, `telefono`, `calle`, `numero`, `idEstado`, `colonia`, `cp`, `correo`, `paginaWeb`, `logo`, `descripcion`, `municipioC`) VALUES

  (1,6,2,'AAAAA',NULL,'','','1111','222',22,'WWWW',0,'DDDD@DDD.COM','','',' AAAAAA',NULL),
  (2,7,3,'','0','','','','',0,'',0,'0','','',' ',NULL),
  (3,8,2,'NEGOCIO',NULL,'CONTACTO','23333','45','34',22,'LLLL',222222,'CORREO@SSSS.COM','WWW.PAGINA.COM','','DATOS DEL NEGOCIO',NULL);
COMMIT;

#
# Data for the `giroempresa` table  (LIMIT -494,500)
#

INSERT INTO `giroempresa` (`giroEmpresaID`, `idUsuarioDetalle`, `giroID`) VALUES

  (1,1,6),
  (2,1,7),
  (3,3,6),
  (4,3,7),
  (5,3,8);
COMMIT;

#
# Data for the `mensajes` table  (LIMIT -498,500)
#

INSERT INTO `mensajes` (`mensajeID`, `asunto`, `mensaje`, `idUsuario`, `tipoMensaje`) VALUES

  (27,'Una Oferta','Una Oferta',3,'Oferta');
COMMIT;

#
# Data for the `mensajesadmin` table  (LIMIT -498,500)
#

INSERT INTO `mensajesadmin` (`mensajeID`, `tipoMensaje`, `asunto`, `contenido`) VALUES

  (8,'Oferta','Una Oferta','Una Oferta');
COMMIT;

#
# Data for the `pais` table  (LIMIT -259,500)
#

INSERT INTO `pais` (`paisID`, `PAIS_ISONUM`, `PAIS_ISO2`, `PAIS_ISO3`, `nombrePais`) VALUES

  (1,4,'AF','AFG','Afganist'),
  (2,248,'AX','ALA','Islas Gland'),
  (3,8,'AL','ALB','Albania'),
  (4,276,'DE','DEU','Alemania'),
  (5,20,'AD','AND','Andorra'),
  (6,24,'AO','AGO','Angola'),
  (7,660,'AI','AIA','Anguilla'),
  (8,10,'AQ','ATA','Ant?rtida'),
  (9,28,'AG','ATG','Antigua y Barbuda'),
  (10,530,'AN','ANT','Antillas Holandesas'),
  (11,682,'SA','SAU','Arabia Saud'),
  (12,12,'DZ','DZA','Argelia'),
  (13,32,'AR','ARG','Argentina'),
  (14,51,'AM','ARM','Armenia'),
  (15,533,'AW','ABW','Aruba'),
  (16,36,'AU','AUS','Australia'),
  (17,40,'AT','AUT','Austria'),
  (18,31,'AZ','AZE','Azerbaiy'),
  (19,44,'BS','BHS','Bahamas'),
  (20,48,'BH','BHR','Bahr?in'),
  (21,50,'BD','BGD','Bangladesh'),
  (22,52,'BB','BRB','Barbados'),
  (23,112,'BY','BLR','Bielorrusia'),
  (24,56,'BE','BEL','B?lgica'),
  (25,84,'BZ','BLZ','Belice'),
  (26,204,'BJ','BEN','Benin'),
  (27,60,'BM','BMU','Bermudas'),
  (28,64,'BT','BTN','Bhut'),
  (29,68,'BO','BOL','Bolivia'),
  (30,70,'BA','BIH','Bosnia y Herzegovina'),
  (31,72,'BW','BWA','Botsuana'),
  (32,74,'BV','BVT','Isla Bouvet'),
  (33,76,'BR','BRA','Brasil'),
  (34,96,'BN','BRN','Brun'),
  (35,100,'BG','BGR','Bulgaria'),
  (36,854,'BF','BFA','Burkina Faso'),
  (37,108,'BI','BDI','Burundi'),
  (38,132,'CV','CPV','Cabo Verde'),
  (39,136,'KY','CYM','Islas Caim'),
  (40,116,'KH','KHM','Camboya'),
  (41,120,'CM','CMR','Camer?n'),
  (42,124,'CA','CAN','Canad'),
  (43,140,'CF','CAF','Rep?blica Centroafricana'),
  (44,148,'TD','TCD','Chad'),
  (45,203,'CZ','CZE','Rep?blica Checa'),
  (46,152,'CL','CHL','Chile'),
  (47,156,'CN','CHN','China'),
  (48,196,'CY','CYP','Chipre'),
  (49,162,'CX','CXR','Isla de Navidad'),
  (50,336,'VA','VAT','Ciudad del Vaticano'),
  (51,166,'CC','CCK','Islas Cocos'),
  (52,170,'CO','COL','Colombia'),
  (53,174,'KM','COM','Comoras'),
  (54,180,'CD','COD','Rep?blica Democr?tica del Congo'),
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
  (65,214,'DO','DOM','Rep?blica Dominicana'),
  (66,218,'EC','ECU','Ecuador'),
  (67,818,'EG','EGY','Egipto'),
  (68,222,'SV','SLV','El Salvador'),
  (69,784,'AE','ARE','Emiratos ?rabes Unidos'),
  (70,232,'ER','ERI','Eritrea'),
  (71,703,'SK','SVK','Eslovaquia'),
  (72,705,'SI','SVN','Eslovenia'),
  (73,724,'ES','ESP','Espa'),
  (74,581,'UM','UMI','Islas ultramarinas de Estados Unidos'),
  (75,840,'US','USA','Estados Unidos'),
  (76,233,'EE','EST','Estonia'),
  (77,231,'ET','ETH','Etiop'),
  (78,234,'FO','FRO','Islas Feroe'),
  (79,608,'PH','PHL','Filipinas'),
  (80,246,'FI','FIN','Finlandia'),
  (81,242,'FJ','FJI','Fiyi'),
  (82,250,'FR','FRA','Francia'),
  (83,266,'GA','GAB','Gab'),
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
  (100,332,'HT','HTI','Hait'),
  (101,334,'HM','HMD','Islas Heard y McDonald'),
  (102,340,'HN','HND','Honduras'),
  (103,344,'HK','HKG','Hong Kong'),
  (104,348,'HU','HUN','Hungr'),
  (105,356,'IN','IND','India'),
  (106,360,'ID','IDN','Indonesia'),
  (107,364,'IR','IRN','Ir'),
  (108,368,'IQ','IRQ','Iraq'),
  (109,372,'IE','IRL','Irlanda'),
  (110,352,'IS','ISL','Islandia'),
  (111,376,'IL','ISR','Israel'),
  (112,380,'IT','ITA','Italia'),
  (113,388,'JM','JAM','Jamaica'),
  (114,392,'JP','JPN','Jap'),
  (115,400,'JO','JOR','Jordania'),
  (116,398,'KZ','KAZ','Kazajst'),
  (117,404,'KE','KEN','Kenia'),
  (118,417,'KG','KGZ','Kirguist'),
  (119,296,'KI','KIR','Kiribati'),
  (120,414,'KW','KWT','Kuwait'),
  (121,418,'LA','LAO','Laos'),
  (122,426,'LS','LSO','Lesotho'),
  (123,428,'LV','LVA','Letonia'),
  (124,422,'LB','LBN','L?bano'),
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
  (136,466,'ML','MLI','Mal'),
  (137,470,'MT','MLT','Malta'),
  (138,238,'FK','FLK','Islas Malvinas'),
  (139,580,'MP','MNP','Islas Marianas del Norte'),
  (140,504,'MA','MAR','Marruecos'),
  (141,584,'MH','MHL','Islas Marshall'),
  (142,474,'MQ','MTQ','Martinica'),
  (143,480,'MU','MUS','Mauricio'),
  (144,478,'MR','MRT','Mauritania'),
  (145,175,'YT','MYT','Mayotte'),
  (146,484,'MX','MEX','M?xico'),
  (147,583,'FM','FSM','Micronesia'),
  (148,498,'MD','MDA','Moldavia'),
  (149,492,'MC','MCO','M?naco'),
  (150,496,'MN','MNG','Mongolia'),
  (151,500,'MS','MSR','Montserrat'),
  (152,508,'MZ','MOZ','Mozambique'),
  (153,104,'MM','MMR','Myanmar'),
  (154,516,'NA','NAM','Namibia'),
  (155,520,'NR','NRU','Nauru'),
  (156,524,'NP','NPL','Nepal'),
  (157,558,'NI','NIC','Nicaragua'),
  (158,562,'NE','NER','N?ger'),
  (159,566,'NG','NGA','Nigeria'),
  (160,570,'NU','NIU','Niue'),
  (161,574,'NF','NFK','Isla Norfolk'),
  (162,578,'NO','NOR','Noruega'),
  (163,540,'NC','NCL','Nueva Caledonia'),
  (164,554,'NZ','NZL','Nueva Zelanda'),
  (165,512,'OM','OMN','Om'),
  (166,528,'NL','NLD','Pa?ses Bajos'),
  (167,586,'PK','PAK','Pakist'),
  (168,585,'PW','PLW','Palau'),
  (169,275,'PS','PSE','Palestina'),
  (170,591,'PA','PAN','Panam'),
  (171,598,'PG','PNG','Pap?a Nueva Guinea'),
  (172,600,'PY','PRY','Paraguay'),
  (173,604,'PE','PER','Per?'),
  (174,612,'PN','PCN','Islas Pitcairn'),
  (175,258,'PF','PYF','Polinesia Francesa'),
  (176,616,'PL','POL','Polonia'),
  (177,620,'PT','PRT','Portugal'),
  (178,630,'PR','PRI','Puerto Rico'),
  (179,634,'QA','QAT','Qatar'),
  (180,826,'GB','GBR','Reino Unido'),
  (181,638,'RE','REU','Reuni'),
  (182,646,'RW','RWA','Ruanda'),
  (183,642,'RO','ROU','Rumania'),
  (184,643,'RU','RUS','Rusia'),
  (185,732,'EH','ESH','Sahara Occidental'),
  (186,90,'SB','SLB','Islas Salom'),
  (187,882,'WS','WSM','Samoa'),
  (188,16,'AS','ASM','Samoa Americana'),
  (189,659,'KN','KNA','San Crist?bal y Nevis'),
  (190,674,'SM','SMR','San Marino'),
  (191,666,'PM','SPM','San Pedro y Miquel'),
  (192,670,'VC','VCT','San Vicente y las Granadinas'),
  (193,654,'SH','SHN','Santa Helena'),
  (194,662,'LC','LCA','Santa Luc'),
  (195,678,'ST','STP','Santo Tom? y Pr?ncipe'),
  (196,686,'SN','SEN','Senegal'),
  (197,891,'CS','SCG','Serbia y Montenegro'),
  (198,690,'SC','SYC','Seychelles'),
  (199,694,'SL','SLE','Sierra Leona'),
  (200,702,'SG','SGP','Singapur'),
  (201,760,'SY','SYR','Siria'),
  (202,706,'SO','SOM','Somalia'),
  (203,144,'LK','LKA','Sri Lanka'),
  (204,748,'SZ','SWZ','Suazilandia'),
  (205,710,'ZA','ZAF','Sud?frica'),
  (206,736,'SD','SDN','Sud'),
  (207,752,'SE','SWE','Suecia'),
  (208,756,'CH','CHE','Suiza'),
  (209,740,'SR','SUR','Surinam'),
  (210,744,'SJ','SJM','Svalbard y Jan Mayen'),
  (211,764,'TH','THA','Tailandia'),
  (212,158,'TW','TWN','Taiw'),
  (213,834,'TZ','TZA','Tanzania'),
  (214,762,'TJ','TJK','Tayikist'),
  (215,86,'IO','IOT','Territorio Brit?nico del Oc?ano ?ndico'),
  (216,260,'TF','ATF','Territorios Australes Franceses'),
  (217,626,'TL','TLS','Timor Oriental'),
  (218,768,'TG','TGO','Togo'),
  (219,772,'TK','TKL','Tokelau'),
  (220,776,'TO','TON','Tonga'),
  (221,780,'TT','TTO','Trinidad y Tobago'),
  (222,788,'TN','TUN','T?nez'),
  (223,796,'TC','TCA','Islas Turcas y Caicos'),
  (224,795,'TM','TKM','Turkmenist'),
  (225,792,'TR','TUR','Turqu'),
  (226,798,'TV','TUV','Tuvalu'),
  (227,804,'UA','UKR','Ucrania'),
  (228,800,'UG','UGA','Uganda'),
  (229,858,'UY','URY','Uruguay'),
  (230,860,'UZ','UZB','Uzbekist'),
  (231,548,'VU','VUT','Vanuatu'),
  (232,862,'VE','VEN','Venezuela'),
  (233,704,'VN','VNM','Vietnam'),
  (234,92,'VG','VGB','Islas V?rgenes Brit?nicas'),
  (235,850,'VI','VIR','Islas V?rgenes de los Estados Unidos'),
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
# Data for the `productodetalle` table  (LIMIT -488,500)
#

INSERT INTO `productodetalle` (`detalleProductoID`, `productoID`, `detalle`, `valor`) VALUES

  (12,15,'talla','4'),
  (19,17,'talla','1'),
  (20,17,'talla','2'),
  (21,17,'talla','3'),
  (22,17,'color','ROSA'),
  (23,17,'color','AZUL'),
  (24,17,'color','AMARILLO'),
  (25,16,'talla','Unitalla'),
  (26,16,'color','Rojo'),
  (27,16,'color','Morado'),
  (28,16,'color','Amarillo');
COMMIT;

#
# Data for the `publicaciones` table  (LIMIT -498,500)
#

INSERT INTO `publicaciones` (`publicacionID`, `seccion`, `titulo`, `vigente`, `fechaCreacion`, `fechaVencimiento`, `numeroVisitas`, `estadoID`, `genero`, `razaID`, `precio`, `descripcion`, `muestraTelefono`, `aprobada`, `servicioID`, `detalleID`, `paqueteID`, `ciudad`) VALUES

  (1,3,'sssssssss',1,'2014-08-25','2014-09-24',0,1,0,'19',999.99,'ddddddddddddcsddd',1,0,1,1,1,'sssssss');
COMMIT;

#
# Data for the `raza` table  (LIMIT -416,500)
#

INSERT INTO `raza` (`razaID`, `raza`) VALUES

  (1,'Akita Inu'),
  (2,'Alaskan Malamute'),
  (3,'Barzoi'),
  (4,'Basset Azul de Gascu�a'),
  (5,'Basset Hound'),
  (6,'Beagle'),
  (7,'Beauceron'),
  (8,'Bich�n Malt�s'),
  (9,'Bobtail'),
  (10,'Border Collie'),
  (11,'Boxer'),
  (12,'Boyero de Berna'),
  (13,'Braco'),
  (14,'Briard'),
  (15,'Bull Terrier Ingl�s'),
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
  (26,'D�lmata'),
  (27,'Doberman'),
  (28,'Dogo'),
  (29,'Epagneul'),
  (30,'Fox Terrier'),
  (31,'Galgo'),
  (32,'Golden Retriever'),
  (33,'Gordon Setter'),
  (34,'Gos d''Atura'),
  (35,'Gran Dan�s'),
  (36,'Husky Siberiano'),
  (37,'Komondor'),
  (38,'Labrador Retriever'),
  (39,'Lebrel'),
  (40,'Mastiff'),
  (41,'Mast�n'),
  (42,'Monta�a de los Pirineos'),
  (43,'Norfolk Terrier'),
  (44,'Norwich Terrier'),
  (45,'Papillon'),
  (46,'Pastor Alem�n'),
  (47,'Pastor Australiano'),
  (48,'Pastor Belga'),
  (49,'Pastor Blanco Suizo'),
  (50,'Pastor de los Pirineos'),
  (51,'Pekin�s'),
  (52,'Peque�o Azul de Gascu�a'),
  (53,'Peque�o Basset Griffon'),
  (54,'Peque�o Brabantino'),
  (55,'Peque�o Perro Le�n'),
  (56,'Peque�o Perro Ruso'),
  (57,'Peque�o Sabueso Suizo'),
  (58,'Perdiguero'),
  (59,'Perro de Agua Espa�ol'),
  (60,'Perro Lobo de Checoslovaquia'),
  (61,'Pinscher miniatura'),
  (62,'Pit Bull'),
  (63,'Podenco'),
  (64,'Pointer Ingl�s'),
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
# Data for the `usuariodato` table  (LIMIT -493,500)
#

INSERT INTO `usuariodato` (`idUsuarioDato`, `idUsuario`, `razonSocial`, `rfc`, `calle`, `noInterior`, `noExterior`, `cp`, `municipio`, `estadoID`, `idPais`) VALUES

  (2,2,'','','','0','',0,'',0,147),
  (3,3,'','','','0','',0,'',0,146),
  (4,4,'','','','0','',0,'',0,147),
  (6,6,'AAAA','AAAAA','AAA','0','222',2222,'QRO',22,147),
  (7,7,'','','','0','0',0,'',0,147),
  (8,8,'rrfc','rfc','33','0','45',45678,'QRO',22,147);
COMMIT;

#
# Data for the `ubicacionusuario` table  (LIMIT -496,500)
#

INSERT INTO `ubicacionusuario` (`ubicacionUsuarioID`, `tipoUsuario`, `latitud`, `longitud`, `idUsuarioDato`, `estadoID`, `zonageograficaID`) VALUES

  (1,2,'20.571765230363617','-100.3824978359375',6,22,4),
  (2,3,'','',7,0,NULL),
  (3,2,'20.557501222898853','-100.41725280898436',8,22,4);
COMMIT;

#
# Data for the `videos` table  (LIMIT -469,500)
#

INSERT INTO `videos` (`videoID`, `link`, `publicacionID`, `servicioID`, `detalleID`, `paqueteID`) VALUES

  (1,'4444 4444 4444 0008',20,28,3,3),
  (2,'fotospublicacion',21,29,2,2),
  (3,'<link type=\"text/css\" rel=\"stylesheet\" href=\"<?php echo base_url() ?>css/reset.css\" media=\"screen\"></link>',22,30,1,1),
  (4,'hhhh',23,31,1,1),
  (5,'tttttttttttttttttt',24,32,2,2),
  (6,'',25,33,2,2),
  (7,'sssssssssssssssss',26,34,1,1),
  (8,'aaaaaaaaaaaaaaaaaaaa',27,35,1,1),
  (9,'aaaaaaaaaaaaaaaaaaaa',28,36,1,1),
  (10,'rrrrrrrrrrrrrrrrrrrrrrrrrrrrr',47,55,1,1),
  (11,'rrrrrrrrrrrrrrrrrrrrrrrrrrrrr',48,56,2,2),
  (12,'QWERTY',49,57,2,2),
  (13,'DDDDDDDD',50,58,2,2),
  (14,'ffffffffffffffffffffff',51,59,2,2),
  (15,'aaaaaaaaaa',52,60,1,1),
  (16,'rrrrrrrrrrr',53,61,1,1),
  (17,'sssssssssssssssss',54,62,2,2),
  (18,'33333',55,63,2,2),
  (19,'44444',56,64,2,2),
  (20,'EEEEEEEEEEEEE',57,65,1,1),
  (21,'sssssssssssssssss',58,66,2,2),
  (22,'ggggggg',59,67,2,2),
  (23,'ggggggg',60,68,2,2),
  (24,'33333',61,69,3,3),
  (25,'RRRRRRR',62,70,1,1),
  (26,'DDDDD',63,71,2,2),
  (27,'http://localhost:82/qup/asociacion/principal/favoritos/',64,72,1,1),
  (28,'https://www.youtube.com/watch?v=-aNxhQKAXxE',65,73,2,2),
  (29,'sssssssssssssssss',66,74,1,1),
  (32,'',1,1,1,1);
COMMIT;

#
# Data for the `visita` table  (LIMIT -498,500)
#

INSERT INTO `visita` (`idVisita`, `numeroVisitas`) VALUES

  (1,2444);
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

