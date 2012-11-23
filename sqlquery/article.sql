CREATE TABLE `project`.`article` (
  `postid` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` CHAR(20) NOT NULL,
  `albumid` CHAR(20) NOT NULL,
  `photo` VARCHAR(50) NOT NULL,
  `content` TEXT NOT NULL,
  `postdate` DATETIME NOT NULL,
  `category` VARCHAR(20) NOT NULL,
  `hits` INT(4) UNSIGNED NOT NULL,
  `likehits` INT(4) UNSIGNED NOT NULL,
  `ipaddress` INT(4) UNSIGNED NOT NULL,
  PRIMARY KEY(postid)
) ENGINE=MyISAM;