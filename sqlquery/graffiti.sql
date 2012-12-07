CREATE TABLE `graffiti` (
  `graffitiid` int(4) unsigned NOT NULL AUTO_INCREMENT,
  `postid` int(4) unsigned NOT NULL,
  `userid` varchar(20) NOT NULL,
  `graffitipath` text NOT NULL,
  `graffititdate` datetime NOT NULL,
  `graffitiip` int(4) unsigned NOT NULL,
  PRIMARY KEY (`graffitiid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

