-- This can change in any moment, this resource is WIP and this database import file can be edited and rfr in any moment. 

CREATE TABLE `guille_jobcreator` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
	`label` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`points` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
	`data` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`ranks` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
	`blips` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`publicvehicles` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
	`privatevehicles` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
	`inventory` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`wardrobe` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `name` (`name`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=7
;

CREATE TABLE `guille_jobcreator_members` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`license` VARCHAR(100) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`job1` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
	`job2` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `license` (`license`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=8
;