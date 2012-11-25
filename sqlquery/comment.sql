CREATE TABLE `project`.`comment` (
  `commentid` INT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `postid` INT(4) UNSIGNED NOT NULL,
  `userid` VARCHAR(20) NOT NULL,
  `commentcontent` TEXT NOT NULL,
  `commentdate` DATETIME NOT NULL,
  `ipaddress` INT(4) UNSIGNED NOT NULL,
  PRIMARY KEY(commentid)
) ENGINE=MyISAM;