-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3308
-- Tiempo de generación: 03-06-2021 a las 01:50:11
-- Versión del servidor: 10.4.6-MariaDB
-- Versión de PHP: 7.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `isic`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AddAsesoria` (`asesor` INT, `asig` VARCHAR(10), `ini` INT, `fin` INT, `dia` INT)  BEGIN
INSERT INTO `isic`.`asesorias` (`idAsesor`, `clavAsignatura`, `horaInicio`, `horaFin`, `dia`) 
VALUES (asesor, asig, ini, fin, dia);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AddAsignaturaMalla` (`clav` VARCHAR(10), `asig` VARCHAR(60), `sem` INT, `hor` VARCHAR(15), `areatxt` VARCHAR(45), `esp` INT, `pdf` VARCHAR(100))  BEGIN
set @area = (select idareaConocimiento from isic.areaconocimiento  where Nombre = areatxt);
IF @area <> 8 then
	INSERT INTO `isic`.`mallacurricular` (`MC_ClaveAsignatura`, `MC_NombreAsignatura`, `MC_SemestreAsignatura`, `MC_HorasTot`, `MC_Area`, `MC_PdfNombre`) 
	VALUES (clav, asig, sem, hor, @area, pdf);
else 
	INSERT INTO `isic`.`mallacurricular` (`MC_ClaveAsignatura`, `MC_NombreAsignatura`, `MC_SemestreAsignatura`, `MC_HorasTot`, `MC_Area`, `MC_PdfNombre`) 
	VALUES (clav, asig, sem, hor, @area, pdf);
	INSERT INTO `isic`.`asignaturas_esp` (`idespecialidad`, `idasignatura`) 
    VALUES (esp, clav);
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AddColaboradorInv` (`tema` INT, `docent` INT, `cargo` INT)  BEGIN
INSERT INTO `isic`.`linea_investigacion` (`temalinea`, `Docente`, `CargoDocente`) 
VALUES (tema, docent, cargo);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AddEspecialidad` (`nom` VARCHAR(100), `obj` VARCHAR(600), `pdf` VARCHAR(100))  BEGIN
INSERT INTO `isic`.`especialidad` (`Nombre`, `Objetivo`,`pdfReticula`) 
VALUES (nom, obj, pdf);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AddImgExpo` (`idPeri` INT, `descrip` VARCHAR(60), `imagenNom` VARCHAR(60))  BEGIN
INSERT INTO `isic`.`imagenexpo` (`idPeriodo`, `descripcion`, `imagenNom`) 
VALUES (idPeri, descrip, imagenNom);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AddPEgreEsp` (`esp` INT, `cap` VARCHAR(300))  BEGIN
INSERT INTO `isic`.`p_egreso_esp`
(`idespecialidad`, `capacidad`)
VALUES(esp, cap);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AddPeroExpo` (`peri` INT, `an` INT, `carpeta` VARCHAR(25))  BEGIN
INSERT INTO `isic`.`periodoexpo` (`periodo`, `año`, `carpetaImg`) 
VALUES (peri, an, carpeta);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_AddTemaLineaInvest` (`nom` VARCHAR(100))  BEGIN
INSERT INTO `isic`.`tema_linea_investigacion` (`Nombre`) VALUES (nom);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_area` ()  BEGIN
SELECT Nombre, Horas FROM isic.areaconocimiento;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_asignaturasEsp` (`pes` INT)  BEGIN
SELECT es.Nombre, ae.idasignatura, m.MC_NombreAsignatura, ae.descripcion 
FROM  isic.especialidad es join isic.asignaturas_esp ae join isic.mallacurricular m 
on (ae.idasignatura = m.MC_ClaveAsignatura and es.idespecialidad = ae.idespecialidad)
where ae.idespecialidad = pes and ae.Estado = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DesHabAsesoria` (`asesoria` INT, `estado` INT, `op` INT)  BEGIN
IF op = 1 then
UPDATE `isic`.`asesorias` SET `estado` = estado WHERE (`idasesorias` = asesoria);
elseif op = 2 then
DELETE FROM `isic`.`asesorias` WHERE (`idasesorias` = asesoria);
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DesHabAsigEsp` (`idesp` INT, `idasig` VARCHAR(10), `estado` INT, `op` INT)  BEGIN
IF op = 1 then
UPDATE `isic`.`asignaturas_esp` SET `Estado` = estado 
WHERE (`idespecialidad` = idesp) and (`idasignatura` = idasig);

elseif op = 2 then
DELETE FROM `isic`.`asignaturas_esp`
WHERE (`idespecialidad` = idesp) and (`idasignatura` = idasig);

end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DesHabEsp` (`esp` INT, `estado` INT, `op` INT)  BEGIN
IF op = 1 then
UPDATE `isic`.`especialidad` SET `Estado` = estado WHERE (`idespecialidad` = esp);

elseif op = 2 then
DELETE FROM `isic`.`especialidad`
WHERE `idespecialidad` = esp;
end if;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DesHabExpo` (`idPer` INT, `estado` INT, `op` INT)  BEGIN
IF op = 1 then
UPDATE `isic`.`periodoexpo` SET `estado` = estado 
where `idperiodoExpo` = idPer;

elseif op = 2 then
DELETE FROM `isic`.`periodoexpo`
where `idperiodoExpo` = idPer;

end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DesHabImagExpo` (`idImg` INT, `estado` INT, `op` INT)  BEGIN
IF op = 1 then
UPDATE `isic`.`imagenexpo` SET `estado` = estado 
where `idimagenExpo` = idImg;

elseif op = 2 then
DELETE FROM `isic`.`imagenexpo`
where `idimagenExpo` = idImg;

end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DesHabLineaInvDoc` (`tema` INT, `doc` INT, `estado` INT, `op` INT)  BEGIN
IF op = 1 then
UPDATE `isic`.`linea_investigacion` SET `Estado` = estado 
WHERE (`temalinea` = tema) and (`Docente` = doc);

elseif op = 2 then
DELETE FROM `isic`.`linea_investigacion`
WHERE (`temalinea` = tema) and (`Docente` = doc);

end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DesHabMalla` (`clav` VARCHAR(10), `estado` INT, `op` INT)  BEGIN
IF op = 1 then
UPDATE `isic`.`mallacurricular` SET `MC_Estado` = estado 
WHERE (`MC_ClaveAsignatura` = clav);

elseif op = 2 then
DELETE FROM `isic`.`mallacurricular`
WHERE (`MC_ClaveAsignatura` = clav);

end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DesHabPEgreso` (`idesp` INT, `cap` VARCHAR(300), `estado` INT, `op` INT)  BEGIN
IF op = 1 then
UPDATE `isic`.`p_egreso_esp` SET `Estado` = estado
WHERE (`idespecialidad` = idesp and `capacidad` = cap);

elseif op = 2 then
DELETE FROM `isic`.`p_egreso_esp`
WHERE (`idespecialidad` = idesp and `capacidad` = cap);

end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DesHabTemaInv` (`idTemaInv` INT, `estado` INT, `op` INT)  BEGIN
IF op = 1 then
UPDATE `isic`.`tema_linea_investigacion` SET `Estado` = estado 
WHERE (`idtema_linea_investigacion` = idTemaInv);

elseif op = 2 then
DELETE FROM `isic`.`tema_linea_investigacion`
WHERE (`idtema_linea_investigacion` = idTemaInv);

end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editarAsig` (`nclav` VARCHAR(10), `nasig` VARCHAR(60), `nsem` INT, `nhor` VARCHAR(15), `narea` VARCHAR(45), `clav` VARCHAR(10), `esp` INT, `nesp` INT, `op` INT, `pdf` VARCHAR(100))  BEGIN
set @area = (select idareaConocimiento from isic.areaconocimiento  where Nombre = narea);
IF @area <> 8 then
	UPDATE `isic`.`mallacurricular` 
	SET `MC_ClaveAsignatura` = nclav, `MC_NombreAsignatura` = nasig, `MC_SemestreAsignatura` = nsem, `MC_HorasTot` = nhor, `MC_Area` = @area, `MC_PdfNombre` = pdf 
	WHERE (`MC_ClaveAsignatura` = clav);
ELSEIF @area = 8 and op = 0 then  
	UPDATE `isic`.`mallacurricular` 
	SET `MC_ClaveAsignatura` = nclav, `MC_NombreAsignatura` = nasig, `MC_SemestreAsignatura` = nsem, `MC_HorasTot` = nhor, `MC_Area` = @area, `MC_PdfNombre` = pdf  
	WHERE (`MC_ClaveAsignatura` = clav); 
    IF (Select count(idasignatura) FROM isic.asignaturas_esp where idasignatura = nclav)>0 then
		UPDATE `isic`.`asignaturas_esp` SET `idespecialidad` = nesp WHERE `idasignatura` = nclav;
	ELSE
		INSERT INTO `isic`.`asignaturas_esp` (`idespecialidad`, `idasignatura`) VALUES (nesp, nclav);
	END IF;
ELSEIF @area = 8 and op = 1 then 
	UPDATE `isic`.`mallacurricular` 
	SET `MC_ClaveAsignatura` = nclav, `MC_NombreAsignatura` = nasig, `MC_SemestreAsignatura` = nsem, `MC_HorasTot` = nhor, `MC_Area` = @area, `MC_PdfNombre` = pdf  
	WHERE (`MC_ClaveAsignatura` = clav); 
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editarEsp` (`idesp` INT, `nom` VARCHAR(100), `obj` VARCHAR(600), `pdf` VARCHAR(100))  BEGIN
UPDATE `isic`.`especialidad` SET `Nombre` = nom, `Objetivo` = obj, `pdfReticula` = pdf 
WHERE (`idespecialidad` = idesp);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editarLineaInv` (`temaOri` INT, `docOri` INT, `tema` INT, `doc` INT, `cargo` INT)  BEGIN
UPDATE `isic`.`linea_investigacion` SET `temalinea` = tema, `Docente` = doc, `CargoDocente` = cargo 
WHERE (`temalinea` = temaOri) and (`Docente` = docOri);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editAsesoria` (`idasesoria` INT, `asesor` INT, `asig` VARCHAR(10), `ini` INT, `fin` INT, `dia` INT)  BEGIN
UPDATE `isic`.`asesorias` 
SET `idAsesor` = asesor, `clavAsignatura` = asig, `horaInicio` = ini, `horaFin` = fin, `dia` = dia  
WHERE (`idasesorias` = idasesoria);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editAsigEsp` (`idesp` INT, `idasig` VARCHAR(10), `des` VARCHAR(600))  BEGIN
UPDATE `isic`.`asignaturas_esp` SET `descripcion` = des 
WHERE (`idespecialidad` = idesp) and (`idasignatura` = idasig);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editImgExpo` (`idImg` INT, `descrip` VARCHAR(60), `imagenNom` VARCHAR(60))  BEGIN
UPDATE `isic`.`imagenexpo`
SET `descripcion` = descrip, `imagenNom` = imagenNom
where `idimagenExpo` = idImg;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editPEgreso` (`idesp` INT, `capOri` VARCHAR(300), `cap` VARCHAR(300))  BEGIN
UPDATE `isic`.`p_egreso_esp` SET `capacidad` = cap
WHERE (`idespecialidad` = idesp and `capacidad` = capOri);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editPeriodoExpo` (`idExpo` INT, `periodo` INT, `año` INT, `carpeta` VARCHAR(25))  BEGIN
UPDATE `isic`.`periodoexpo` SET `periodo` = periodo, `año` = año, `carpetaImg` = carpeta 
WHERE (`idperiodoExpo` = idExpo);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_editTemaIvs` (`idTema` INT, `tema` VARCHAR(100))  BEGIN
UPDATE `isic`.`tema_linea_investigacion` SET `Nombre` = tema 
WHERE (`idtema_linea_investigacion` = idTema);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_egreso` (`pes` INT)  BEGIN
SELECT capacidad FROM isic.p_egreso_esp
where idespecialidad = pes and Estado = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_especialidad` (`pes` INT)  BEGIN
SELECT Nombre, Objetivo, pdfReticula
FROM isic.especialidad
where idespecialidad = pes;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_especialidad_lista` ()  BEGIN
SELECT idespecialidad,Nombre FROM isic.especialidad
where Estado = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getAsesor` ()  BEGIN
SELECT concat(d.Nombre, " ", d.APaterno, " ", d.AMaterno) asesor 
FROM isic.asesorias a join isic.docente d
on (a.idAsesor = d.iddocente)
group by a.idAsesor; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getAsesorias` ()  BEGIN
SELECT a.idasesorias, a.idAsesor, concat(d.Nombre, " ", d.APaterno, " ", d.AMaterno) asesor,
a.clavAsignatura, m.MC_NombreAsignatura asignatura, a.horaInicio,  a.horaFin, a.dia, a.estado
FROM isic.asesorias a join isic.docente d join isic.mallacurricular m
on (a.idAsesor = d.iddocente and a.clavAsignatura = m.MC_ClaveAsignatura)
order by a.idAsesor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getAsignatura` (`clav` VARCHAR(10))  BEGIN
SELECT m.MC_SemestreAsignatura , m.MC_ClaveAsignatura, m.MC_HorasTot, m.MC_NombreAsignatura, a.Nombre
FROM isic.mallacurricular m join isic.areaconocimiento a on (m.MC_Area = a.idareaConocimiento)
where  m.MC_ClaveAsignatura like clav;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getAsignaturaEspAdmin` ()  BEGIN
SELECT es.idespecialidad, es.Nombre, ae.idasignatura, ae.descripcion, ae.Estado
FROM isic.asignaturas_esp ae join isic.especialidad es
on ae.idespecialidad = es.idespecialidad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getDocente` ()  BEGIN
select iddocente, concat_ws(" ", Nombre, APaterno, AMaterno) as Docente
FROM isic.docente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getEgresoAdmin` ()  BEGIN
SELECT eg.idespecialidad, es.Nombre, eg.capacidad, eg.Estado
FROM isic.p_egreso_esp eg join isic.especialidad es
on es.idespecialidad = eg.idespecialidad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getEspecialidadAdmin` ()  BEGIN
SELECT * FROM isic.especialidad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getImagenesExpo` (`per` INT)  BEGIN
SELECT i.idimagenExpo, i.descripcion, i.estado, i.imagenNom, p.carpetaImg 
FROM isic.imagenexpo i join isic.periodoexpo p 
on i.idPeriodo = p.idperiodoExpo
where idPeriodo = per;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getListaPE` ()  BEGIN
SELECT * FROM isic.tipo_pe;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getListaServicios` ()  BEGIN
SELECT idservicios, Nombre_Servicio FROM isic.servicios;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getMalla_Admin` ()  BEGIN
SELECT m.MC_SemestreAsignatura , m.MC_ClaveAsignatura, m.MC_HorasTot, m.MC_NombreAsignatura, a.Nombre, m.MC_Estado, m.MC_PdfNombre
FROM isic.mallacurricular m join isic.areaconocimiento a on (m.MC_Area = a.idareaConocimiento)
order by m.MC_SemestreAsignatura;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getPEDescrip` (`tipo` INT)  BEGIN
SELECT d.idpe_isic, t.Nombre, d.DescripcionPE 
FROM isic.pe_isic d join isic.tipo_pe t
on (d.idPETipo = t.idtipo_PE)
where d.idPETipo = tipo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getPeriodo` ()  BEGIN
SELECT * FROM isic.periodoexpo order by año, periodo;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getServicio` (`idServ` INT)  BEGIN
SELECT Nombre_Servicio, Objetivo FROM isic.servicios
WHERE idservicios = idServ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getTemaInv` ()  BEGIN
SELECT * FROM isic.tema_linea_investigacion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_ListaMateriasEsp` ()  BEGIN
SELECT ae.idespecialidad, es.Nombre, ae.idasignatura
FROM  isic.especialidad es join isic.asignaturas_esp ae
on (es.idespecialidad = ae.idespecialidad);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_lineaInvs` ()  BEGIN
SELECT li.temalinea, tl.Nombre, d.GradoAcademico, li.Docente as idDocente, 
concat_ws(" ", d.Nombre, d.APaterno, d.AMaterno) as Docente, 
li.CargoDocente, li.Estado, tl.Estado as EstadoTema
FROM isic.linea_investigacion li join isic.tema_linea_investigacion tl join isic.docente d
on (li.temalinea = tl.idtema_linea_investigacion and li.Docente = d.iddocente)
order by Nombre, CargoDocente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_malla` (`psem` INT, `pes` INT)  BEGIN 
SELECT m.MC_ClaveAsignatura, m.MC_HorasTot, m.MC_NombreAsignatura, a.Nombre, a.Horas, m.MC_PdfNombre
FROM isic.mallacurricular m join isic.areaconocimiento a on (m.MC_Area = a.idareaConocimiento)
where m.MC_SemestreAsignatura = psem and m.MC_Estado = 1
and m.MC_NombreAsignatura not in 
(SELECT m.MC_NombreAsignatura
FROM isic.asignaturas_esp ae join isic.mallacurricular m 
on (ae.idasignatura = m.MC_ClaveAsignatura) where ae.idespecialidad <> pes);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areaconocimiento`
--

CREATE TABLE `areaconocimiento` (
  `idareaConocimiento` int(11) NOT NULL,
  `Nombre` varchar(45) DEFAULT NULL,
  `Horas` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `areaconocimiento`
--

INSERT INTO `areaconocimiento` (`idareaConocimiento`, `Nombre`, `Horas`) VALUES
(1, 'Ciencias Basicas', 832),
(2, 'Ciencias de la Ingenieria', 558),
(3, 'Ingenieria Aplicada', 512),
(4, 'Diseño en Ingenieria', 864),
(5, 'Ciencias Sociales y Humanidades', 256),
(6, 'Cursos complementarios', 400),
(7, 'Ciencias economico administrativa', 288),
(8, 'Especialidad', 400),
(9, 'Residencia', 500);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asesorias`
--

CREATE TABLE `asesorias` (
  `idasesorias` int(11) NOT NULL,
  `idAsesor` int(11) DEFAULT NULL,
  `clavAsignatura` varchar(10) DEFAULT NULL,
  `horaInicio` int(2) DEFAULT NULL,
  `horaFin` int(2) DEFAULT NULL,
  `dia` int(1) DEFAULT 1,
  `estado` int(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `asesorias`
--

INSERT INTO `asesorias` (`idasesorias`, `idAsesor`, `clavAsignatura`, `horaInicio`, `horaFin`, `dia`, `estado`) VALUES
(30, 9, 'TDAM-2003', 15, 16, 1, 1),
(31, 9, 'SCC-1017', 16, 17, 1, 1),
(32, 9, 'ACA-0909', 12, 13, 5, 1),
(33, 5, 'SCD-1015', 12, 14, 1, 1),
(35, 5, 'SCD-1020', 16, 18, 3, 1),
(37, 6, 'SCA-1004', 15, 16, 1, 1),
(38, 6, 'SCD-1011', 13, 14, 2, 1),
(39, 3, 'SCC-1019', 15, 16, 1, 1),
(40, 3, 'ACA-0909', 14, 15, 2, 1),
(41, 3, 'CDDT-2004', 11, 12, 3, 1),
(42, 3, 'CDDT-2004', 10, 11, 5, 1),
(43, 3, 'SCC-1019', 11, 12, 5, 1),
(44, 10, 'SCC-1014', 12, 13, 1, 1),
(45, 10, 'SCC-1014', 17, 18, 2, 1),
(46, 11, 'SCD-1015', 13, 14, 2, 1),
(47, 11, 'SCD-1027', 8, 9, 5, 1),
(48, 11, 'SCC-1019', 12, 13, 5, 1),
(51, 15, 'AEF-1052', 15, 16, 2, 1),
(52, 15, 'SCD-1018', 16, 17, 2, 1),
(53, 13, 'SCD-1020', 10, 12, 1, 1),
(55, 13, 'CDDT-2003', 9, 10, 2, 1),
(56, 13, 'SCD-1020', 12, 13, 3, 1),
(57, 13, 'SCC-1010', 11, 12, 5, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignaturas_esp`
--

CREATE TABLE `asignaturas_esp` (
  `idespecialidad` int(11) NOT NULL,
  `idasignatura` varchar(10) NOT NULL,
  `descripcion` varchar(600) DEFAULT NULL,
  `Estado` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `asignaturas_esp`
--

INSERT INTO `asignaturas_esp` (`idespecialidad`, `idasignatura`, `descripcion`, `Estado`) VALUES
(1, 'CDDT-2001', 'Identifica y aplica los conceptos de ciencia de datos con relación a la estadística para dar solución de proyectos que demanda de procesamiento de datos y toma de decisiones.', 1),
(1, 'CDDT-2002', 'Diseñar e implementar herramientas de programación que requieran procesar grandes volúmenes de información en situaciones reales y de ingeniería, de tal forma que le permitan obtener información valiosa para la toma de decisiones.', 1),
(1, 'CDDT-2003', 'Aplicar técnicas de minería de datos, a fin de analizar la información de un data warehouse o una estructura de big data, para obtener el conocimiento que le ayude a tomar decisiones estratégicas y operacionales en una organización. ', 1),
(1, 'CDDT-2004', 'Desarrollar aplicaciones y sistemas que utilicen técnicas de aprendizaje computacional para la obtención de un modelo a partir de la extracción automática de información y conocimiento de grandes volúmenes de datos.', 1),
(1, 'CDDT-2005', 'Analiza problemas que requieran la toma decisiones tomando como base la información que se genera en una empresa, procesa la información usando las técnicas y herramientas que mejor se ajusten al problema y genera resultados para la toma de decisiones.', 1),
(2, 'TDAM-2001', 'Analiza y aplica las herramientas y metodologías para el desarrollo de aplicaciones móviles según su evolución en hardware y software.', 1),
(2, 'TDAM-2002', 'Desarrolla, depura y coloca aplicaciones en dispositivos con software propietario, para  un ambiente de desarrollo móvil.', 1),
(2, 'TDAM-2003', 'Conocer técnicas avanzadas de visión por computadora para que los estudiantes formen una capacidad de resolución de problemas en entornos nuevos o poco conocido dentro de contextos más amplios (o multidisciplinares) relacionados con su área de estudio. Capacidad de integrar tecnologías y algoritmos propios de la visión por computadora, con carácter generalista, y en contextos más amplios y multidisciplinares.', 1),
(2, 'TDAM-2004', 'Conoce e implementa las herramientas y técnicas de un framework propietario y abierto para el desarrollo de aplicaciones móviles multiplataforma.', 1),
(2, 'TDAM-2005', 'Identifica, analiza y simula amenazas cibernéticas que vulneran la integridad de la información y recursos de una infraestructura de red así como técnicas de pruebas para aseverar la calidad en un proyecto.', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docente`
--

CREATE TABLE `docente` (
  `iddocente` int(11) NOT NULL,
  `GradoAcademico` varchar(15) DEFAULT NULL,
  `Nombre` varchar(45) DEFAULT NULL,
  `APaterno` varchar(45) DEFAULT NULL,
  `AMaterno` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `docente`
--

INSERT INTO `docente` (`iddocente`, `GradoAcademico`, `Nombre`, `APaterno`, `AMaterno`) VALUES
(1, 'Ingeniería', 'Javier', 'Pérez', 'Escamilla'),
(2, 'Maestria', 'Lorena', 'Mendoza', 'Gúzman'),
(3, 'Maestria', 'Dulce Jazmín', 'Navarrete', 'Arias'),
(4, 'Maestria', 'Rodolfo', 'Luna', 'Pérez'),
(5, 'Maestria', 'Mario', 'Pérez', 'Bautista'),
(6, 'Maestria', 'Cristy Elizabeth', 'Aguilar', 'Ojeda'),
(7, 'Maestria', 'Héctor Daniel', 'Hernández', 'García'),
(8, 'Maestria', 'Eliud', 'Paredes', 'Reyes'),
(9, 'Doctorado', 'Elizabeth', 'García', 'Ríos'),
(10, 'Maestria', 'Guadalupe', 'Calvo', 'Torres'),
(11, 'Maestria', 'Aline', 'Pérez', 'Martínez'),
(12, 'Maestria', 'Juan Carlos', 'Céron', 'Almaraz'),
(13, 'Maestria', 'Sergio', 'Cruz', 'Pérez'),
(14, 'Maestria', 'Guillermo', 'Castañeda', 'Ortíz'),
(15, 'Ingeniería', 'Jorge Armando', 'Garcia', 'Bautista');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidad`
--

CREATE TABLE `especialidad` (
  `idespecialidad` int(11) NOT NULL,
  `Nombre` varchar(100) DEFAULT NULL,
  `Objetivo` varchar(600) DEFAULT NULL,
  `Estado` int(11) DEFAULT 1,
  `pdfReticula` varchar(100) DEFAULT 'Sin Archivo'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `especialidad`
--

INSERT INTO `especialidad` (`idespecialidad`, `Nombre`, `Objetivo`, `Estado`, `pdfReticula`) VALUES
(1, 'Ciencia de los Datos', 'El especialista En Ciencia de los Datos será capaz de estudiar las diversas fuentes de información disponibles en una organización, extraer, depurar y analizar datos a partir de diversos formatos, idear y desarrollar algoritmos; realizar inferencias, preparar, comunicar resultados y transmitir conclusiones acerca de los estudios que ayude al organismo o compañí­a a tomar decisiones basadas en el conocimiento extraído.', 1, 'RETICULA ISIC 2010-224, Ciencia de datos.pdf'),
(2, 'Tecnologías Emergentes para el Desarrollo de aplicaciones móviles', 'El especialista en tecnologías emergentes para el desarrollo de aplicaciones móviles será capaz de diseñar, construir e implementar aplicaciones móviles utilizando tecnología emergente que resuelva problemáticas y necesidades en las empresas e instituciones públicas y privadas.', 1, 'RETICULA ISIC 2010-224, Tecnologias emergentes para el desarrollo de aplicaciones mo¦üviles .pdf');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagenexpo`
--

CREATE TABLE `imagenexpo` (
  `idimagenExpo` int(11) NOT NULL,
  `idPeriodo` int(11) NOT NULL,
  `descripcion` varchar(60) DEFAULT NULL,
  `estado` int(1) DEFAULT 1,
  `imagenNom` varchar(60) DEFAULT 'Sin Imagen'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `imagenexpo`
--

INSERT INTO `imagenexpo` (`idimagenExpo`, `idPeriodo`, `descripcion`, `estado`, `imagenNom`) VALUES
(29, 6, 'Participante de Expo-Sistemas', 1, '01.jpg'),
(31, 6, 'Participante de Expo-Sistemas', 1, '02.jpg'),
(35, 6, 'Participante de Expo-Sistemas', 1, '03.jpg'),
(36, 6, 'Participante de Expo-Sistemas', 1, '04.jpg'),
(37, 6, 'Participante de Expo-Sistemas', 1, '05.jpg'),
(40, 6, 'Participante de Expo-Sistemas', 1, '06.jpg'),
(41, 6, 'Participante de Expo-Sistemas', 1, '07.jpg'),
(42, 9, 'Entrega de Reconocimientos', 1, '01.jpg'),
(43, 9, 'Participante de Expo-Sistemas', 1, '02.jpg'),
(44, 9, 'Participante de Expo-Sistemas', 1, '03.jpg'),
(45, 9, 'Participante de Expo-Sistemas', 1, '04.jpg'),
(46, 9, 'Participante de Expo-Sistemas', 1, '05.jpg'),
(47, 9, 'Participante de Expo-Sistemas', 1, '06.jpg'),
(48, 9, 'Entrega de Reconocimientos', 1, '07.jpg'),
(49, 9, 'Entrega de Reconocimientos', 1, '08.jpg'),
(50, 1, 'Participante de Expo-Sistemas', 1, '01.png'),
(53, 6, 'Participante de Expo-Sistemas', 1, '08.jpg'),
(54, 1, 'Participante de Expo-Sistemas', 1, '02.png'),
(55, 1, 'Participante de Expo-Sistemas', 1, '03.png'),
(56, 1, 'Participante de Expo-Sistemas', 1, '04.png'),
(57, 1, 'Participante de Expo-Sistemas', 1, '05.png'),
(58, 1, 'Participante de Expo-Sistemas', 1, '06.jpg'),
(59, 1, 'Participante de Expo-Sistemas', 1, '07.png'),
(60, 1, 'Participante de Expo-Sistemas', 1, '08.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `linea_investigacion`
--

CREATE TABLE `linea_investigacion` (
  `temalinea` int(11) NOT NULL,
  `Docente` int(11) NOT NULL,
  `CargoDocente` int(11) DEFAULT NULL,
  `Estado` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `linea_investigacion`
--

INSERT INTO `linea_investigacion` (`temalinea`, `Docente`, `CargoDocente`, `Estado`) VALUES
(1, 1, 2, 1),
(1, 2, 2, 1),
(1, 8, 1, 1),
(2, 3, 1, 1),
(2, 4, 2, 1),
(2, 9, 2, 1),
(3, 5, 2, 1),
(3, 6, 2, 1),
(3, 7, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mallacurricular`
--

CREATE TABLE `mallacurricular` (
  `MC_ClaveAsignatura` varchar(10) NOT NULL,
  `MC_NombreAsignatura` varchar(60) DEFAULT NULL,
  `MC_SemestreAsignatura` int(1) DEFAULT NULL,
  `MC_HorasTot` varchar(15) DEFAULT NULL,
  `MC_Area` int(11) DEFAULT NULL,
  `MC_Estado` tinyint(4) DEFAULT 1,
  `MC_PdfNombre` varchar(100) DEFAULT 'Sin Archivo'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `mallacurricular`
--

INSERT INTO `mallacurricular` (`MC_ClaveAsignatura`, `MC_NombreAsignatura`, `MC_SemestreAsignatura`, `MC_HorasTot`, `MC_Area`, `MC_Estado`, `MC_PdfNombre`) VALUES
('***', 'Residencia', 9, '10', 9, 1, 'Sin Archivo'),
('ACA-0907', 'Taller de Etica', 1, '0-4-4 -> 64Hrs', 5, 1, 'AC007 Taller de Etica.pdf'),
('ACA-0909', 'Taller de Investigacion I', 6, '0-4-4 -> 64Hrs', 5, 1, 'Sin Archivo'),
('ACA-0910', 'Taller de Investigacion II', 8, '0-4-4 -> 64Hrs', 5, 1, 'Sin Archivo'),
('ACC-0906', 'Fundamentos de Investigacion', 1, '2-2-4 -> 64Hrs', 5, 1, 'AC006 Fundamentos de Investigacion.pdf'),
('ACD-0908', 'Desarollo Sustentable', 5, '2-3-5 -> 80Hrs', 7, 1, 'Sin Archivo'),
('ACF-0901', 'Calculo Diferencial', 1, '3-2-5 -> 80Hrs', 1, 1, 'AC001 Calculo Diferencial.pdf'),
('ACF-0902', 'Calculo Integral', 2, '3-2-5 -> 80Hrs', 1, 1, 'AC002 Calculo Integral.pdf'),
('ACF-0903', 'Algebra Lineal', 2, '3-2-5 -> 80Hrs', 1, 1, 'Sin Archivo'),
('ACF-0904', 'Calculo Vectorial', 3, '3-2-5 -> 80Hrs', 1, 1, 'Sin Archivo'),
('ACF-0905', 'Ecuaciones Diferenciales', 4, '3-2-5 -> 80Hrs', 1, 1, 'Sin Archivo'),
('ACM-0001', 'Actividad Complementaria I', 2, '0-1-1 -> 16Hrs', 6, 1, 'Sin Archivo'),
('ACM-0002', 'Actividad Complementaria II', 3, '0-1-1 -> 16Hrs', 6, 1, 'Sin Archivo'),
('ACM-0003', 'Actividad Complementaria III', 4, '0-1-1 -> 16Hrs', 6, 1, 'Sin Archivo'),
('ACM-0004', 'Actividad Complementaria IV', 5, '0-1-1 -> 16Hrs', 6, 1, 'Sin Archivo'),
('ACM-0005', 'Actividad Complementaria V', 6, '0-1-1 -> 16Hrs', 6, 1, 'Sin Archivo'),
('AEB-1055', 'Programacion WEB', 5, '1-4-5 -> 80Hrs', 4, 1, 'Sin Archivo'),
('AEC-1008', 'Contabilidad Financiera', 2, '2-2-4 -> 64Hrs', 7, 1, 'AE008 Contabilidad Financiera.pdf'),
('AEC-1034', 'Fundamentos de Telecomunicaciones', 5, '2-2-4 -> 64Hrs', 2, 1, 'Sin Archivo'),
('AEC-1058', 'Quimica General', 2, '2-2-4 -> 64Hrs', 1, 1, 'AE058 Quimica.pdf'),
('AEC-1061', 'Sistemas Operativos', 3, '2-2-4 -> 64Hrs', 2, 1, 'Sin Archivo'),
('AED-1026', 'Estructura de Datos', 3, '2-3-5 -> 80Hrs', 2, 1, 'Sin Archivo'),
('AEF-1031', 'Fundamentos de Base de Datos', 4, '3-2-5 -> 80Hrs', 3, 1, 'Sin Archivo'),
('AEF-1041', 'Matematicas Discretas', 1, '3-2-5 -> 80Hrs', 1, 1, 'AE041 Matematicas Discretas.pdf'),
('AEF-1052', 'Probabilidad y Estadistica', 2, '3-2-5 -> 80Hrs', 1, 1, 'Sin Archivo'),
('CDDT-2001', 'Introduccion a la Ciencia de los Datos', 7, '2-3-5 -> 80Hrs', 8, 1, 'Sin Archivo'),
('CDDT-2002', 'Lenguajes de Programacion para Ciencia de los Datos', 7, '2-3-5 -> 80Hrs', 8, 1, 'Sin Archivo'),
('CDDT-2003', 'Mineria de Datos', 8, '2-3-5 -> 80Hrs', 8, 1, 'Sin Archivo'),
('CDDT-2004', 'Aprendizaje Maquina', 8, '2-3-5 -> 80Hrs', 8, 1, 'Sin Archivo'),
('CDDT-2005', 'Inteligencia de Negocios', 8, '2-3-5 -> 80Hrs', 8, 1, 'Sin Archivo'),
('SCA-1004', 'Administracion de Redes', 8, '0-4-4 -> 64Hrs', 4, 1, 'Administración de redes..pdf'),
('SCA-1025', 'Taller de Base de Datos', 5, '0-4-4 -> 64Hrs', 4, 1, 'Sin Archivo'),
('SCA-1026', 'Taller de Sistemas Operativos', 4, '0-4-4 -> 64Hrs', 4, 1, 'Sin Archivo'),
('SCB-1001', 'Administracion de Base de Datos', 6, '1-4-5 -> 80Hrs', 4, 1, 'Sin Archivo'),
('SCC-1005', 'Cultura Empresarial', 3, '2-2-4 -> 64Hrs', 7, 1, 'Sin Archivo'),
('SCC-1007', 'Fundamentos de Ing. de Software', 5, '2-2-4 -> 64Hrs', 3, 1, 'Sin Archivo'),
('SCC-1010', 'Graficacion', 8, '2-2-4 -> 64Hrs', 4, 1, 'Sin Archivo'),
('SCC-1012', 'Inteligencia Artificial', 7, '2-2-4 -> 64Hrs', 4, 1, 'Sin Archivo'),
('SCC-1013', 'Investigacion de Operaciones', 3, '2-2-4 -> 64Hrs', 1, 1, 'Sin Archivo'),
('SCC-1014', 'Lenguajes de Interfaz', 6, '2-2-4 -> 64Hrs', 3, 1, 'Sin Archivo'),
('SCC-1017', 'Metodos Numericos', 4, '2-2-4 -> 64Hrs', 1, 1, 'Sin Archivo'),
('SCC-1019', 'Programacion Logica y Funcional', 6, '2-2-4 -> 64Hrs', 3, 1, 'Sin Archivo'),
('SCC-1023', 'Sistemas Programables', 7, '2-2-4 -> 64Hrs', 4, 1, 'Sin Archivo'),
('SCD-1003', 'Arquitectura de Computadoras', 5, '2-3-5 -> 80Hrs', 3, 1, 'Sin Archivo'),
('SCD-1004', 'Conmutacion y Enrutamiento de Redes de Datos', 7, '2-3-5 -> 80Hrs', 4, 1, 'Sin Archivo'),
('SCD-1008', 'Fundamentos de Programacion', 1, '2-3-5 -> 80Hrs', 2, 1, 'AE085 Fundamentos de Programacion.pdf'),
('SCD-1011', 'Ingenieria de Software', 6, '2-3-5 -> 80Hrs', 4, 1, 'Sin Archivo'),
('SCD-1015', 'Lenguajes y Automatas I', 6, '2-3-5 -> 80Hrs', 3, 1, 'Sin Archivo'),
('SCD-1016', 'Lenguajes y Automatas II', 7, '2-3-5 -> 80Hrs', 4, 1, 'Sin Archivo'),
('SCD-1018', 'Principios Electricos y Aplicaciones Digitale', 4, '2-3-5 -> 80Hrs', 2, 1, 'Sin Archivo'),
('SCD-1020', 'Programacion Orientada a Objetos', 2, '2-3-5 -> 80Hrs', 2, 1, 'AE086 Programacion Orientada a Objetos.pdf'),
('SCD-1021', 'Redes de Computadora', 6, '2-3-5 -> 80Hrs', 4, 1, 'Sin Archivo'),
('SCD-1022', 'Simulacion', 5, '2-3-5 -> 80Hrs', 3, 1, 'Sin Archivo'),
('SCD-1027', 'Topicos Avanzados de Programacion', 4, '2-3-5 -> 80Hrs', 2, 1, 'Sin Archivo'),
('SCF-1006', 'Fisica General', 3, '3-2-5 -> 80Hrs', 1, 1, 'Sin Archivo'),
('SCG-1009', 'Gestion de Proyectos de Software', 7, '3-3-6 -> 96Hrs', 3, 1, 'Sin Archivo'),
('SCH-1024', 'Taller de Administracion', 1, '1-3-4 -> 64Hrs', 7, 1, 'Taller de Administración.pdf'),
('TDAM-2001', 'Aplicaciones nativas para moviles de codigo abierto', 7, '2-3-5 -> 80Hrs', 8, 1, 'Sin Archivo'),
('TDAM-2002', 'Programacion movil nativo para sistema propietario', 7, '2-3-5 -> 80Hrs', 8, 1, 'Sin Archivo'),
('TDAM-2003', 'Visión por computadora en dispositivos moviles', 8, '2-3-5 -> 80Hrs', 8, 1, 'Sin Archivo'),
('TDAM-2004', 'Lenguajes multiplataforma para el desarrollo movil', 8, '2-3-5 -> 80Hrs', 8, 1, 'Sin Archivo'),
('TDAM-2005', 'Seguridad y testing en Tecnologia Movil', 8, '2-3-5 -> 80Hrs', 8, 1, 'Sin Archivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `periodoexpo`
--

CREATE TABLE `periodoexpo` (
  `idperiodoExpo` int(11) NOT NULL,
  `periodo` int(1) DEFAULT 1,
  `año` int(4) DEFAULT NULL,
  `estado` int(1) DEFAULT 1,
  `carpetaImg` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `periodoexpo`
--

INSERT INTO `periodoexpo` (`idperiodoExpo`, `periodo`, `año`, `estado`, `carpetaImg`) VALUES
(1, 2, 2017, 1, '2017_Agosto-Diciembre'),
(6, 1, 2018, 1, '2018_Enero-Mayo'),
(9, 2, 2018, 1, '2018_Agosto-Diciembre');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pe_isic`
--

CREATE TABLE `pe_isic` (
  `idpe_isic` int(11) NOT NULL,
  `idPETipo` int(11) DEFAULT NULL,
  `DescripcionPE` varchar(650) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `pe_isic`
--

INSERT INTO `pe_isic` (`idpe_isic`, `idPETipo`, `DescripcionPE`) VALUES
(1, 1, 'Formar ingenieros en sistemas computacionales con conocimientos significativos y habilidades pertinentes; a través de una formación integral en un programa educativo certificado y acreditado con estándares de calidad, que den solución a los problemas de los sectores de la producción, transformación y de servicios.'),
(2, 2, 'Ser un programa educativo actualizado y reconocido por sus estándares de calidad académica, a través de la capacitación y certificación de docentes y estudiantes e infraestructura pertinente; para la formación de profesionistas competentes en el desarrollo de sistemas computacionales.'),
(3, 3, 'Somos una institución de Educación Superior Tecnológico, con programas educativos acreditados que forma profesionistas creativos e innovadores, con sentido crítico, ético y participativo con competencias profesionales capaces de dar respuesta a las necesidades del entorno, que impulsa la investigación y la generación del desarrollo tecnológico com pleno respeto a la diversidad y con firme compromiso con la sociedad.'),
(4, 4, 'El Instituto Tecnológico Superior del Occidente del Estado de Hidalgo es un referente educativo de nivel superior tecnológico en la región del Valle del Mezquital, reconocido por la calidad de sus servicios educativos, que aplica, transfiere y genera conocimientos científicos y tecnológicos en beneficio.'),
(5, 5, 'OE1.- Los egresados diseñan, desarrollan y/o implementan: aplicaciones computacionales, interfaces de automatización de hardware y software, software de propósito específico (como bases de datos, sistemas descentralizados, plataformas y dispositivos), para resolver problemas en un entorno, apegado a las normas y estándares internacionales vigentes y de seguridad aplicables a su entorno.'),
(6, 5, 'OE2.- Los egresados implementan modelos y/o herramientas matemáticas para solucionar problemas complejos que atiendan alguna necesidad en su entorno, mediante la automatización y/o procesamiento de la información a través de la interpretación de datos.'),
(7, 5, 'OE3.- Los egresados coordinan y participan en equipos multidisciplinarios para crear soluciones complejas e innovadoras que atiendan alguna necesidad de un sector, industria o necesidad humana, con sentido ético.'),
(8, 6, 'AE1.- Los egresados Implementan aplicaciones computacionales para solucionar problemas complejos de ingeniería en diversos contextos, integrando hardware y software, plataformas o dispositivos dentro de una empresa o consultoría.'),
(9, 6, 'AE2.- Diseña, desarrolla y aplica modelos computacionales para solucionar problemas complejos de ingeniería, mediante la selección y uso de herramientas matemáticas.'),
(10, 6, 'AE3.- Diseña e implementa interfaces para la automatización de sistemas de hardware y desarrollo del software asociado basado en normas y estándares vigentes.'),
(11, 6, 'AE4.- Coordina y participa en equipos multidisciplinarios para la aplicación de soluciones innovadoras en diferentes contextos, mediante un plan estratégico.'),
(12, 6, 'AE5.- Diseña, implementa y administra bases de datos optimizando los recursos disponibles, conforme a las normas vigentes de manejo y seguridad de la información para apoyar la productividad y eficiencia de las organizaciones.'),
(13, 6, 'AE6.- Desarrolla y administra software para apoyar la productividad y competitividad de las organizaciones cumpliendo con estándares de calidad en diferentes contextos integrando diferentes tecnologías, plataformas y/o dispositivos.'),
(14, 6, 'AE7.- Evalúa tecnologías de hardware para soportar aplicaciones de manera efectiva, tomando en cuenta las diferentes plataformas y/o dispositivos.'),
(15, 6, 'AE8.- Detecta áreas de oportunidad empleando una visión empresarial para crear proyectos aplicando las Tecnologías de la Información.'),
(16, 6, 'AE9.- Diseña, configura y administra redes de computadoras para crear soluciones de conectividad en la organización, aplicando las normas y estándares vigentes.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `p_egreso_esp`
--

CREATE TABLE `p_egreso_esp` (
  `idespecialidad` int(11) NOT NULL,
  `capacidad` varchar(300) DEFAULT NULL,
  `Estado` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `p_egreso_esp`
--

INSERT INTO `p_egreso_esp` (`idespecialidad`, `capacidad`, `Estado`) VALUES
(1, 'Implementa aplicaciones computacionales para solucionar problemas de diversos contextos, integrando diferentes tecnologías, plataformas o dispositivos.', 1),
(1, 'Coordina y participa en equipos multidisciplinarios para la aplicación de soluciones innovadoras en diferentes contextos.', 1),
(1, 'Diseña, implementa y administra bases de datos optimizando los recursos disponibles, conforme a las normas vigentes de manejo y seguridad de la información.', 1),
(1, 'Desarrolla y administra software para apoyar la productividad y competitividad de las organizaciones cumpliendo con estándares de calidad. ', 1),
(1, 'Coordina y participa en proyectos interdisciplinarios.', 1),
(1, 'Posee habilidades metodológicas de investigación que fortalezcan el desarrollo cultural, científico y tecnológico en el ámbito de sistemas computacionales y disciplinas afines.', 1),
(1, 'Identificar fuentes de información que den solución a las necesidades de toma de decisiones de las empresas u organizaciones.', 1),
(1, 'Extraer y depurar los datos de fuentes con formatos diversos que permita su análisis.', 1),
(1, 'Implementar algoritmos inteligentes que evalúen el comportamiento de los datos, ayuden a realizar inferencias y pronósticos basados en la probabilidad y la estadística.', 1),
(2, 'Implementar aplicaciones computacionales para solucionar problemas de diversos contextos, integrando diferentes tecnologías, plataformas o dispositivos.', 1),
(2, 'Coordinar y participar en equipos multidisciplinarios para la aplicación de soluciones innovadoras en diferentes contextos.', 1),
(2, 'Analizar problemas dentro de una empresa e instituciones públicas y privadas para darle solución mediante tecnología móvil.', 1),
(2, 'Desarrollar base de datos locales y en la nube para procesar  información desde aplicaciones móviles.', 1),
(2, 'Aplicar lenguajes de programación para desarrollar aplicaciones móviles según la evolución de software y hardware.', 1),
(2, 'Aplicar metodologías y tecnologías emergentes para el desarrollo de aplicaciones móviles', 1),
(2, 'Aplicar tecnologías y algoritmos de seguridad para la integridad de los datos.', 1),
(2, 'Aplicar algoritmos y técnicas de inteligencia artificial para el internet de las cosas.', 1),
(2, 'Implementar realidad aumentada, visión por computadora, georeferenciación, IoT, utilizando tecnología emergente.', 1),
(2, 'Aplicar esquemas de pruebas en software para el aseguramiento de la calidad.', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `idservicios` int(11) NOT NULL,
  `Nombre_Servicio` varchar(45) DEFAULT NULL,
  `Objetivo` varchar(800) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`idservicios`, `Nombre_Servicio`, `Objetivo`) VALUES
(1, 'Tutorías', 'Establecer la normativa que sustente y sistematice el otorgamiento de la atención tutorial a los estudiantes, a través del Programa Nacional de Tutoría (PNT); propiciando el mejoramiento de la calidad educativa y contribuyendo a su formación integral, mejorando los índices de permanencia, egreso y titulación oportuna en las Instituciones adscritas al TecNM.'),
(2, 'Asesorías Académicas', 'Establece los lineamientos para brindar asesorías académicas a los estudiantes de los diferentes programas educativos del instituto, con la finalidad de disminuir los indices de reprobación en los diferentes cursos.'),
(3, 'Actividades Complementarias', 'Establecer la normativa para el cumplimiento de las actividades complementarias para la formación y desarrollo de competencias profesionales de las Instituciones adscritas al TecNM, con la finalidad de fortalecer la formación integral de los estudiantes.'),
(4, 'Servicios de Apoyo', 'Servicio Médico Edificio IV planta alta Ext 311*Servicio de psicología y asesorías Edificio de biblioteca Ext 309 y 310*Coordinación de idiomas Edificio V planta alta Ext 303*Control escolar y becas Edificio de Dirección General Ext 630 y 631*Servicio de laboratorios de cómputo Edificio VI Ext 111*Servicio de biblioteca Edificio Centro de Información Ext 302*Actividades culturales y deportivas Edificio de Dirección General*Servicio social y residencia profesional Edificio de Dirección General Ext 540 y 541*Centro de cómputo Edificio VI Ext 111*Servicio de cafetería*Plaza del estudiante');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tema_linea_investigacion`
--

CREATE TABLE `tema_linea_investigacion` (
  `idtema_linea_investigacion` int(11) NOT NULL,
  `Nombre` varchar(100) DEFAULT NULL,
  `Estado` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tema_linea_investigacion`
--

INSERT INTO `tema_linea_investigacion` (`idtema_linea_investigacion`, `Nombre`, `Estado`) VALUES
(1, 'Ingeniería de software y sistemas distribuidos', 1),
(2, 'Control inteligente y Procesamiento Digital de Señales', 1),
(3, 'Sistemas, Base de Datos y Plataformas Computacionales', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_pe`
--

CREATE TABLE `tipo_pe` (
  `idtipo_PE` int(11) NOT NULL,
  `Nombre` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_pe`
--

INSERT INTO `tipo_pe` (`idtipo_PE`, `Nombre`) VALUES
(1, 'Misión del programa de estudios'),
(2, 'Visión del programa de estudios'),
(3, 'Misión institucional'),
(4, 'Visión institucional'),
(5, 'Objetivos Educacionales'),
(6, 'Atributos de Egreso');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `areaconocimiento`
--
ALTER TABLE `areaconocimiento`
  ADD PRIMARY KEY (`idareaConocimiento`);

--
-- Indices de la tabla `asesorias`
--
ALTER TABLE `asesorias`
  ADD PRIMARY KEY (`idasesorias`),
  ADD KEY `idDocente_idx` (`idAsesor`),
  ADD KEY `clavAsignatura_idx` (`clavAsignatura`);

--
-- Indices de la tabla `asignaturas_esp`
--
ALTER TABLE `asignaturas_esp`
  ADD PRIMARY KEY (`idespecialidad`,`idasignatura`),
  ADD KEY `idasignatura_idx` (`idasignatura`);

--
-- Indices de la tabla `docente`
--
ALTER TABLE `docente`
  ADD PRIMARY KEY (`iddocente`);

--
-- Indices de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  ADD PRIMARY KEY (`idespecialidad`);

--
-- Indices de la tabla `imagenexpo`
--
ALTER TABLE `imagenexpo`
  ADD PRIMARY KEY (`idimagenExpo`),
  ADD KEY `idPeriodo_idx` (`idPeriodo`);

--
-- Indices de la tabla `linea_investigacion`
--
ALTER TABLE `linea_investigacion`
  ADD PRIMARY KEY (`temalinea`,`Docente`),
  ADD KEY `idDocente_idx` (`Docente`),
  ADD KEY `temalinea_idx` (`temalinea`);

--
-- Indices de la tabla `mallacurricular`
--
ALTER TABLE `mallacurricular`
  ADD PRIMARY KEY (`MC_ClaveAsignatura`);

--
-- Indices de la tabla `periodoexpo`
--
ALTER TABLE `periodoexpo`
  ADD PRIMARY KEY (`idperiodoExpo`);

--
-- Indices de la tabla `pe_isic`
--
ALTER TABLE `pe_isic`
  ADD PRIMARY KEY (`idpe_isic`),
  ADD KEY `idPETipo_idx` (`idPETipo`);

--
-- Indices de la tabla `p_egreso_esp`
--
ALTER TABLE `p_egreso_esp`
  ADD KEY `idespecialidad_idx` (`idespecialidad`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`idservicios`);

--
-- Indices de la tabla `tema_linea_investigacion`
--
ALTER TABLE `tema_linea_investigacion`
  ADD PRIMARY KEY (`idtema_linea_investigacion`);

--
-- Indices de la tabla `tipo_pe`
--
ALTER TABLE `tipo_pe`
  ADD PRIMARY KEY (`idtipo_PE`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `areaconocimiento`
--
ALTER TABLE `areaconocimiento`
  MODIFY `idareaConocimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `asesorias`
--
ALTER TABLE `asesorias`
  MODIFY `idasesorias` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  MODIFY `idespecialidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `imagenexpo`
--
ALTER TABLE `imagenexpo`
  MODIFY `idimagenExpo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT de la tabla `periodoexpo`
--
ALTER TABLE `periodoexpo`
  MODIFY `idperiodoExpo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `pe_isic`
--
ALTER TABLE `pe_isic`
  MODIFY `idpe_isic` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `idservicios` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tema_linea_investigacion`
--
ALTER TABLE `tema_linea_investigacion`
  MODIFY `idtema_linea_investigacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `tipo_pe`
--
ALTER TABLE `tipo_pe`
  MODIFY `idtipo_PE` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asesorias`
--
ALTER TABLE `asesorias`
  ADD CONSTRAINT `clavAsignatura` FOREIGN KEY (`clavAsignatura`) REFERENCES `mallacurricular` (`MC_ClaveAsignatura`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `idAsesor` FOREIGN KEY (`idAsesor`) REFERENCES `docente` (`iddocente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `asignaturas_esp`
--
ALTER TABLE `asignaturas_esp`
  ADD CONSTRAINT `idasignatura` FOREIGN KEY (`idasignatura`) REFERENCES `mallacurricular` (`MC_ClaveAsignatura`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `idespecialidad` FOREIGN KEY (`idespecialidad`) REFERENCES `especialidad` (`idespecialidad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `imagenexpo`
--
ALTER TABLE `imagenexpo`
  ADD CONSTRAINT `idPeriodo` FOREIGN KEY (`idPeriodo`) REFERENCES `periodoexpo` (`idperiodoExpo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `linea_investigacion`
--
ALTER TABLE `linea_investigacion`
  ADD CONSTRAINT `idDocente` FOREIGN KEY (`Docente`) REFERENCES `docente` (`iddocente`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `temalinea` FOREIGN KEY (`temalinea`) REFERENCES `tema_linea_investigacion` (`idtema_linea_investigacion`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pe_isic`
--
ALTER TABLE `pe_isic`
  ADD CONSTRAINT `idPETipo` FOREIGN KEY (`idPETipo`) REFERENCES `tipo_pe` (`idtipo_PE`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `p_egreso_esp`
--
ALTER TABLE `p_egreso_esp`
  ADD CONSTRAINT `especialidadegre` FOREIGN KEY (`idespecialidad`) REFERENCES `especialidad` (`idespecialidad`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
