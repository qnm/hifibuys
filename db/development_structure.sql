CREATE TABLE `items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `price` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shop_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shop_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shop_suburb` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shop_state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shop_country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `shop_hash` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shop_city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `fulltext_search` (`name`,`description`,`shop_state`,`shop_suburb`)
) ENGINE=MyISAM AUTO_INCREMENT=784 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO schema_migrations (version) VALUES ('20090906214954');

INSERT INTO schema_migrations (version) VALUES ('20090914212915');

INSERT INTO schema_migrations (version) VALUES ('20090915073952');