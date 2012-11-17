CREATE TABLE `test`.`MEMBER` (
  `USERID` VARCHAR(20) NOT NULL,
  `USERPASSWORD` VARCHAR(40) NOT NULL,
  `REGISTERDATE` DATETIME NOT NULL,
  `LASTNAME` VARCHAR(20) NOT NULL,
  `FIRSTNAME` VARCHAR(20) NOT NULL,
  `PROFILEPHOTO` VARCHAR(20),
  `GENDER` ENUM('M','F') NOT NULL,
  `EMAIL` VARCHAR(50),
  `INTRODUCE` TEXT,
  `INFO` ENUM('Y','N') NOT NULL,
  `LEVEL` ENUM('1','2','3','4') NOT NULL DEFAULT ''3'',
  PRIMARY KEY(USERID)
) ENGINE=MyISAM;