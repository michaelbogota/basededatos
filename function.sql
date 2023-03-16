#--------------------------------------------------------------
#--------------------------------------------------------------
#------- Se elimina la tabla si existe
#--------------------------------------------------------------
#--------------------------------------------------------------
DROP TABLE IF EXISTS `entity_types`;

#--------------------------------------------------------------
#--------------------------------------------------------------
#------- Se crean las tablas con la definicion de cada columna
#--------------------------------------------------------------
#--------------------------------------------------------------
CREATE TABLE `entity_types` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `name_machine` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `module` int(11) DEFAULT NULL,
  `entity_fields` int(11) DEFAULT 0,
  `view_mode` int(11) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

#--------------------------------------------------------------
#--------------------------------------------------------------
#------- Se insertan unos valores
#--------------------------------------------------------------
#--------------------------------------------------------------
INSERT INTO `entity_types` (`id`, `name`, `name_machine`, `type`, `module`, `entity_fields`, `view_mode`, `created_at`, `updated_at`)
VALUES
	(4,'Empleados','empleados',NULL,3,0,1,'2021-05-26 07:39:40','2021-05-26 07:39:40'),
	(5,'EPS','eps',NULL,3,0,1,'2021-05-26 11:20:16','2021-09-29 09:06:09'),
	(6,'ARL','arl',NULL,3,0,1,'2021-05-26 11:31:28','2021-09-29 09:05:59'),
	(7,'Fondo de pensiones','fondodepensiones',NULL,3,0,1,'2021-05-26 11:32:39','2021-05-26 11:32:39'),
	(8,'Cesantías','cesantias',NULL,3,0,1,'2021-05-26 11:33:51','2021-05-26 11:33:51'),
	(9,'Caja de compensación','cajadecompensacion',NULL,3,0,1,'2021-05-26 11:34:16','2021-05-26 11:34:16'),
	(10,'Serie documental','seriedocumental',NULL,1,1,1,'2021-07-11 08:00:21','2021-11-30 17:48:54'),
	(11,'Subserie documental','subseriedocumental',NULL,1,1,1,'2021-07-11 08:03:03','2021-11-01 11:39:21'),
	(12,'Tipo documental','tipodocumental',NULL,1,1,1,'2021-07-11 08:03:24','2021-09-19 16:11:34'),
	(13,'Expedientes','expedientes',NULL,1,0,2,'2021-07-11 08:27:07','2021-12-01 16:48:32'),
	(14,'Usuarios','usuarios',NULL,5,0,1,'2021-09-18 08:43:26','2021-09-18 08:48:05'),
	(15,'Roles','roles',NULL,5,0,1,'2021-09-18 08:44:18','2021-09-18 08:48:01'),
	(16,'Vistas','vistas',1,5,0,1,'2021-09-27 12:09:42','2021-10-03 13:59:29'),
	(17,'Código incapacidades','codigoincapacidades',NULL,3,0,1,'2021-10-09 13:34:54','2021-10-09 13:34:54'),
	(18,'Flujo de trabjo','flujodetrabjo',2,1,0,1,'2021-11-06 20:05:50','2021-11-10 05:24:06'),
	(19,'Plantillas','plantillas',3,1,0,1,'2021-11-15 10:32:30','2021-11-27 14:54:03'),
	(20,'Remitente','remitente',NULL,1,0,1,'2021-11-30 09:47:29','2021-11-30 09:47:29'),
	(21,'Tipo de radicado','tipoderadicado',NULL,1,0,1,'2021-11-30 09:54:17','2021-11-30 09:54:17');


#--------------------------------------------------------------
#--------------------------------------------------------------
#------- Se elimina la tabla si existe
#--------------------------------------------------------------
#--------------------------------------------------------------
DROP TABLE IF EXISTS `modules`;

#--------------------------------------------------------------
#--------------------------------------------------------------
#------- Se crean las tablas con la definicion de cada columna
#--------------------------------------------------------------
#--------------------------------------------------------------
CREATE TABLE `modules` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `machine_name` varchar(255) DEFAULT NULL,
  `has_entities` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
#--------------------------------------------------------------
#--------------------------------------------------------------
#------- Se insertan unos valores
#--------------------------------------------------------------
#--------------------------------------------------------------
INSERT INTO `modules` (`id`, `name`, `machine_name`, `has_entities`)
VALUES
	(1,'Gestor documental','manager',1),
	(2,'Encuestas','forms',0),
	(3,'Recursos Humanos','rrhh',1),
	(4,'Inventario','inventory',1),
	(5,'Configuración','settings',1);

#--------------------------------------------------------------
#--------------------------------------------------------------
#------- Se crea la funcion
#--------------------------------------------------------------
#--------------------------------------------------------------
DELIMITER ;;
CREATE FUNCTION GetTotalUsedModules ()
RETURNS INT
BEGIN
	DECLARE total INT;
	SET total = 0;
	SELECT COUNT(*) INTO total FROM `modules` WHERE `id` IN(
		SELECT module FROM `entity_types` GROUP BY module
	);
	RETURN total;
END;;
DELIMITER ;
