-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 30, 2021 at 09:49 PM
-- Server version: 8.0.23-0ubuntu0.20.04.1
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `omeka_main`
--

-- --------------------------------------------------------

--
-- Table structure for table `omeka_collections`
--

CREATE TABLE `omeka_collections` (
  `id` int UNSIGNED NOT NULL,
  `public` tinyint NOT NULL,
  `featured` tinyint NOT NULL,
  `added` timestamp NOT NULL DEFAULT '2000-01-01 00:00:00',
  `modified` timestamp NOT NULL DEFAULT '2000-01-01 00:00:00',
  `owner_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `omeka_elements`
--

CREATE TABLE `omeka_elements` (
  `id` int UNSIGNED NOT NULL,
  `element_set_id` int UNSIGNED NOT NULL,
  `order` int UNSIGNED DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `comment` text CHARACTER SET utf8 COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `omeka_elements`
--

INSERT INTO `omeka_elements` (`id`, `element_set_id`, `order`, `name`, `description`, `comment`) VALUES
(1, 3, NULL, 'Text', 'Any textual data included in the document', NULL),
(2, 3, NULL, 'Interviewer', 'The person(s) performing the interview', NULL),
(3, 3, NULL, 'Interviewee', 'The person(s) being interviewed', NULL),
(4, 3, NULL, 'Location', 'The location of the interview', NULL),
(5, 3, NULL, 'Transcription', 'Any written text transcribed from a sound', NULL),
(6, 3, NULL, 'Local URL', 'The URL of the local directory containing all assets of the website', NULL),
(7, 3, NULL, 'Original Format', 'The type of object, such as painting, sculpture, paper, photo, and additional data', NULL),
(10, 3, NULL, 'Physical Dimensions', 'The actual physical size of the original image', NULL),
(11, 3, NULL, 'Duration', 'Length of time involved (seconds, minutes, hours, days, class periods, etc.)', NULL),
(12, 3, NULL, 'Compression', 'Type/rate of compression for moving image file (i.e. MPEG-4)', NULL),
(13, 3, NULL, 'Producer', 'Name (or names) of the person who produced the video', NULL),
(14, 3, NULL, 'Director', 'Name (or names) of the person who produced the video', NULL),
(15, 3, NULL, 'Bit Rate/Frequency', 'Rate at which bits are transferred (i.e. 96 kbit/s would be FM quality audio)', NULL),
(16, 3, NULL, 'Time Summary', 'A summary of an interview given for different time stamps throughout the interview', NULL),
(17, 3, NULL, 'Email Body', 'The main body of the email, including all replied and forwarded text and headers', NULL),
(18, 3, NULL, 'Subject Line', 'The content of the subject line of the email', NULL),
(19, 3, NULL, 'From', 'The name and email address of the person sending the email', NULL),
(20, 3, NULL, 'To', 'The name(s) and email address(es) of the person to whom the email was sent', NULL),
(21, 3, NULL, 'CC', 'The name(s) and email address(es) of the person to whom the email was carbon copied', NULL),
(22, 3, NULL, 'BCC', 'The name(s) and email address(es) of the person to whom the email was blind carbon copied', NULL),
(23, 3, NULL, 'Number of Attachments', 'The number of attachments to the email', NULL),
(24, 3, NULL, 'Standards', '', NULL),
(25, 3, NULL, 'Objectives', '', NULL),
(26, 3, NULL, 'Materials', '', NULL),
(27, 3, NULL, 'Lesson Plan Text', '', NULL),
(28, 3, NULL, 'URL', '', NULL),
(29, 3, NULL, 'Event Type', '', NULL),
(30, 3, NULL, 'Participants', 'Names of individuals or groups participating in the event', NULL),
(31, 3, NULL, 'Birth Date', '', NULL),
(32, 3, NULL, 'Birthplace', '', NULL),
(33, 3, NULL, 'Death Date', '', NULL),
(34, 3, NULL, 'Occupation', '', NULL),
(35, 3, NULL, 'Biographical Text', '', NULL),
(36, 3, NULL, 'Bibliography', '', NULL),
(37, 1, 8, 'Contributor', 'An entity responsible for making contributions to the resource', NULL),
(38, 1, 15, 'Coverage', 'The spatial or temporal topic of the resource, the spatial applicability of the resource, or the jurisdiction under which the resource is relevant', NULL),
(39, 1, 4, 'Creator', 'An entity primarily responsible for making the resource', NULL),
(40, 1, 7, 'Date', 'A point or period of time associated with an event in the lifecycle of the resource', NULL),
(41, 1, 3, 'Description', 'An account of the resource', NULL),
(42, 1, 11, 'Format', 'The file format, physical medium, or dimensions of the resource', NULL),
(43, 1, 14, 'Identifier', 'An unambiguous reference to the resource within a given context', NULL),
(44, 1, 12, 'Language', 'A language of the resource', NULL),
(45, 1, 6, 'Publisher', 'An entity responsible for making the resource available', NULL),
(46, 1, 10, 'Relation', 'A related resource', NULL),
(47, 1, 9, 'Rights', 'Information about rights held in and over the resource', NULL),
(48, 1, 5, 'Source', 'A related resource from which the described resource is derived', NULL),
(49, 1, 2, 'Subject', 'The topic of the resource', NULL),
(50, 1, 1, 'Title', 'A name given to the resource', NULL),
(51, 1, 13, 'Type', 'The nature or genre of the resource', NULL),
(52, 4, 1, 'Original @id', '', ''),
(53, 4, 2, 'JSON Data', '', ''),
(54, 5, 1, 'Display as IIIF?', '', ''),
(55, 5, 2, 'Original @id', '', ''),
(56, 5, 3, 'JSON Data', '', ''),
(57, 6, 1, 'Original @id', '', ''),
(58, 6, 2, 'IIIF Type', '', ''),
(59, 6, 3, 'JSON Data', '', ''),
(60, 3, NULL, 'On Canvas', 'URI of the attached canvas', ''),
(61, 3, NULL, 'Selector', 'The SVG boundary area of the annotation', ''),
(62, 3, NULL, 'Annotated Region', 'The rectangular region of the annotation, in xywh format.', NULL),
(63, 6, 4, 'UUID', '', ''),
(64, 5, 4, 'UUID', '', ''),
(65, 6, NULL, 'Parent Collection', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `omeka_element_sets`
--

CREATE TABLE `omeka_element_sets` (
  `id` int UNSIGNED NOT NULL,
  `record_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `omeka_element_sets`
--

INSERT INTO `omeka_element_sets` (`id`, `record_type`, `name`, `description`) VALUES
(1, NULL, 'Dublin Core', 'The Dublin Core metadata element set is common to all Omeka records, including items, files, and collections. For more information see, http://dublincore.org/documents/dces/.'),
(3, 'Item', 'Item Type Metadata', 'The item type metadata element set, consisting of all item type elements bundled with Omeka and all item type elements created by an administrator.'),
(4, 'File', 'IIIF File Metadata', ''),
(5, 'Item', 'IIIF Item Metadata', ''),
(6, 'Collection', 'IIIF Collection Metadata', '');

-- --------------------------------------------------------

--
-- Table structure for table `omeka_element_texts`
--

CREATE TABLE `omeka_element_texts` (
  `id` int UNSIGNED NOT NULL,
  `record_id` int UNSIGNED NOT NULL,
  `record_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `element_id` int UNSIGNED NOT NULL,
  `html` tinyint NOT NULL,
  `text` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `omeka_exhibits`
--

CREATE TABLE `omeka_exhibits` (
  `id` int UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `credits` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `featured` tinyint(1) DEFAULT '0',
  `public` tinyint(1) DEFAULT '0',
  `theme` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `theme_options` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `slug` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `added` timestamp NOT NULL DEFAULT '2000-01-01 00:00:00',
  `modified` timestamp NOT NULL DEFAULT '2000-01-01 00:00:00',
  `owner_id` int UNSIGNED DEFAULT NULL,
  `use_summary_page` tinyint(1) DEFAULT '1',
  `cover_image_file_id` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `omeka_exhibit_block_attachments`
--

CREATE TABLE `omeka_exhibit_block_attachments` (
  `id` int UNSIGNED NOT NULL,
  `block_id` int UNSIGNED NOT NULL,
  `item_id` int UNSIGNED NOT NULL,
  `file_id` int UNSIGNED DEFAULT NULL,
  `caption` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `order` smallint UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `omeka_exhibit_pages`
--

CREATE TABLE `omeka_exhibit_pages` (
  `id` int UNSIGNED NOT NULL,
  `exhibit_id` int UNSIGNED NOT NULL,
  `parent_id` int UNSIGNED DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `order` smallint UNSIGNED DEFAULT NULL,
  `added` timestamp NOT NULL DEFAULT '2000-01-01 00:00:00',
  `modified` timestamp NOT NULL DEFAULT '2000-01-01 00:00:00',
  `short_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `omeka_exhibit_page_blocks`
--

CREATE TABLE `omeka_exhibit_page_blocks` (
  `id` int UNSIGNED NOT NULL,
  `page_id` int UNSIGNED NOT NULL,
  `layout` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `options` text CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `text` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `order` smallint UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `omeka_files`
--

CREATE TABLE `omeka_files` (
  `id` int UNSIGNED NOT NULL,
  `item_id` int UNSIGNED NOT NULL,
  `order` int UNSIGNED DEFAULT NULL,
  `size` bigint UNSIGNED NOT NULL,
  `has_derivative_image` tinyint(1) NOT NULL,
  `authentication` char(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `mime_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `type_os` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `filename` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `original_filename` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `added` timestamp NOT NULL DEFAULT '2000-01-01 00:00:00',
  `stored` tinyint(1) NOT NULL DEFAULT '0',
  `metadata` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `omeka_iiif_items_cached_json_data`
--

CREATE TABLE `omeka_iiif_items_cached_json_data` (
  `id` int NOT NULL,
  `record_id` int NOT NULL,
  `record_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `data` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `generated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `omeka_iiif_items_job_statuses`
--

CREATE TABLE `omeka_iiif_items_job_statuses` (
  `id` int NOT NULL,
  `source` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `dones` int NOT NULL,
  `skips` int NOT NULL,
  `fails` int NOT NULL,
  `status` varchar(32) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `progress` int NOT NULL DEFAULT '0',
  `total` int NOT NULL DEFAULT '100',
  `added` timestamp NOT NULL DEFAULT '2016-11-01 00:00:00',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `omeka_iiif_items_job_statuses`
--

INSERT INTO `omeka_iiif_items_job_statuses` (`id`, `source`, `dones`, `skips`, `fails`, `status`, `progress`, `total`, `added`) VALUES
(1, 'Adding UUID to collections and items', 0, 0, 0, 'Completed', 0, 0, '2017-11-01 17:56:51');

-- --------------------------------------------------------

--
-- Table structure for table `omeka_items`
--

CREATE TABLE `omeka_items` (
  `id` int UNSIGNED NOT NULL,
  `item_type_id` int UNSIGNED DEFAULT NULL,
  `collection_id` int UNSIGNED DEFAULT NULL,
  `featured` tinyint NOT NULL,
  `public` tinyint NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `added` timestamp NOT NULL DEFAULT '2000-01-01 00:00:00',
  `owner_id` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `omeka_item_types`
--

CREATE TABLE `omeka_item_types` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `omeka_item_types`
--

INSERT INTO `omeka_item_types` (`id`, `name`, `description`) VALUES
(1, 'Text', 'A resource consisting primarily of words for reading. Examples include books, letters, dissertations, poems, newspapers, articles, archives of mailing lists. Note that facsimiles or images of texts are still of the genre Text.'),
(3, 'Moving Image', 'A series of visual representations imparting an impression of motion when shown in succession. Examples include animations, movies, television programs, videos, zoetropes, or visual output from a simulation.'),
(4, 'Oral History', 'A resource containing historical information obtained in interviews with persons having firsthand knowledge.'),
(5, 'Sound', 'A resource primarily intended to be heard. Examples include a music playback file format, an audio compact disc, and recorded speech or sounds.'),
(6, 'Still Image', 'A static visual representation. Examples include paintings, drawings, graphic designs, plans and maps. Recommended best practice is to assign the type Text to images of textual materials.'),
(7, 'Website', 'A resource comprising of a web page or web pages and all related assets ( such as images, sound and video files, etc. ).'),
(8, 'Event', 'A non-persistent, time-based occurrence. Metadata for an event provides descriptive information that is the basis for discovery of the purpose, location, duration, and responsible agents associated with an event. Examples include an exhibition, webcast, conference, workshop, open day, performance, battle, trial, wedding, tea party, conflagration.'),
(9, 'Email', 'A resource containing textual messages and binary attachments sent electronically from one person to another or one person to many people.'),
(10, 'Lesson Plan', 'A resource that gives a detailed description of a course of instruction.'),
(11, 'Hyperlink', 'A link, or reference, to another resource on the Internet.'),
(12, 'Person', 'An individual.'),
(13, 'Interactive Resource', 'A resource requiring interaction from the user to be understood, executed, or experienced. Examples include forms on Web pages, applets, multimedia learning objects, chat services, or virtual reality environments.'),
(14, 'Dataset', 'Data encoded in a defined structure. Examples include lists, tables, and databases. A dataset may be useful for direct machine processing.'),
(15, 'Physical Object', 'An inanimate, three-dimensional object or substance. Note that digital representations of, or surrogates for, these objects should use Moving Image, Still Image, Text or one of the other types.'),
(16, 'Service', 'A system that provides one or more functions. Examples include a photocopying service, a banking service, an authentication service, interlibrary loans, a Z39.50 or Web server.'),
(17, 'Software', 'A computer program in source or compiled form. Examples include a C source file, MS-Windows .exe executable, or Perl script.'),
(18, 'Annotation', 'An OA-compliant annotation');

-- --------------------------------------------------------

--
-- Table structure for table `omeka_item_types_elements`
--

CREATE TABLE `omeka_item_types_elements` (
  `id` int UNSIGNED NOT NULL,
  `item_type_id` int UNSIGNED NOT NULL,
  `element_id` int UNSIGNED NOT NULL,
  `order` int UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `omeka_item_types_elements`
--

INSERT INTO `omeka_item_types_elements` (`id`, `item_type_id`, `element_id`, `order`) VALUES
(1, 1, 7, NULL),
(2, 1, 1, NULL),
(3, 6, 7, NULL),
(6, 6, 10, NULL),
(7, 3, 7, NULL),
(8, 3, 11, NULL),
(9, 3, 12, NULL),
(10, 3, 13, NULL),
(11, 3, 14, NULL),
(12, 3, 5, NULL),
(13, 5, 7, NULL),
(14, 5, 11, NULL),
(15, 5, 15, NULL),
(16, 5, 5, NULL),
(17, 4, 7, NULL),
(18, 4, 11, NULL),
(19, 4, 15, NULL),
(20, 4, 5, NULL),
(21, 4, 2, NULL),
(22, 4, 3, NULL),
(23, 4, 4, NULL),
(24, 4, 16, NULL),
(25, 9, 17, NULL),
(26, 9, 18, NULL),
(27, 9, 20, NULL),
(28, 9, 19, NULL),
(29, 9, 21, NULL),
(30, 9, 22, NULL),
(31, 9, 23, NULL),
(32, 10, 24, NULL),
(33, 10, 25, NULL),
(34, 10, 26, NULL),
(35, 10, 11, NULL),
(36, 10, 27, NULL),
(37, 7, 6, NULL),
(38, 11, 28, NULL),
(39, 8, 29, NULL),
(40, 8, 30, NULL),
(41, 8, 11, NULL),
(42, 12, 31, NULL),
(43, 12, 32, NULL),
(44, 12, 33, NULL),
(45, 12, 34, NULL),
(46, 12, 35, NULL),
(47, 12, 36, NULL),
(48, 18, 60, 1),
(49, 18, 61, 2),
(50, 18, 1, 3),
(51, 18, 62, 4);

-- --------------------------------------------------------

--
-- Table structure for table `omeka_keys`
--

CREATE TABLE `omeka_keys` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `label` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `key` char(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ip` varbinary(16) DEFAULT NULL,
  `accessed` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `omeka_options`
--

CREATE TABLE `omeka_options` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8 COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `omeka_options`
--

INSERT INTO `omeka_options` (`id`, `name`, `value`) VALUES
(2, 'administrator_email', 'dicksonlaw583@gmail.com'),
(3, 'copyright', ''),
(4, 'site_title', 'Omeka in a Box'),
(5, 'author', ''),
(6, 'description', ''),
(7, 'thumbnail_constraint', '200'),
(8, 'square_thumbnail_constraint', '200'),
(9, 'fullsize_constraint', '800'),
(10, 'per_page_admin', '10'),
(11, 'per_page_public', '10'),
(12, 'show_empty_elements', '0'),
(13, 'path_to_convert', '/usr/bin'),
(14, 'admin_theme', 'default'),
(15, 'public_theme', 'default'),
(16, 'file_extension_whitelist', 'aac,aif,aiff,asf,asx,avi,bmp,c,cc,class,css,divx,doc,docx,exe,gif,gz,gzip,h,ico,j2k,jp2,jpe,jpeg,jpg,m4a,m4v,mdb,mid,midi,mov,mp2,mp3,mp4,mpa,mpe,mpeg,mpg,mpp,odb,odc,odf,odg,odp,ods,odt,ogg,opus,pdf,png,pot,pps,ppt,pptx,qt,ra,ram,rtf,rtx,swf,tar,tif,tiff,txt,wav,wax,webm,wma,wmv,wmx,wri,xla,xls,xlsx,xlt,xlw,zip'),
(17, 'file_mime_type_whitelist', 'application/msword,application/ogg,application/pdf,application/rtf,application/vnd.ms-access,application/vnd.ms-excel,application/vnd.ms-powerpoint,application/vnd.ms-project,application/vnd.ms-write,application/vnd.oasis.opendocument.chart,application/vnd.oasis.opendocument.database,application/vnd.oasis.opendocument.formula,application/vnd.oasis.opendocument.graphics,application/vnd.oasis.opendocument.presentation,application/vnd.oasis.opendocument.spreadsheet,application/vnd.oasis.opendocument.text,application/x-ms-wmp,application/x-ogg,application/x-gzip,application/x-msdownload,application/x-shockwave-flash,application/x-tar,application/zip,audio/aac,audio/aiff,audio/mid,audio/midi,audio/mp3,audio/mp4,audio/mpeg,audio/mpeg3,audio/ogg,audio/wav,audio/wma,audio/x-aac,audio/x-aiff,audio/x-m4a,audio/x-midi,audio/x-mp3,audio/x-mp4,audio/x-mpeg,audio/x-mpeg3,audio/x-mpegaudio,audio/x-ms-wax,audio/x-realaudio,audio/x-wav,audio/x-wma,image/bmp,image/gif,image/icon,image/jpeg,image/pjpeg,image/png,image/tiff,image/x-icon,image/x-ms-bmp,text/css,text/plain,text/richtext,text/rtf,video/asf,video/avi,video/divx,video/mp4,video/mpeg,video/msvideo,video/ogg,video/quicktime,video/webm,video/x-m4v,video/x-ms-wmv,video/x-msvideo'),
(18, 'disable_default_file_validation', ''),
(20, 'display_system_info', '1'),
(21, 'html_purifier_is_enabled', '1'),
(22, 'html_purifier_allowed_html_elements', 'p,br,strong,em,span,div,ul,ol,li,a,h1,h2,h3,h4,h5,h6,address,pre,table,tr,td,blockquote,thead,tfoot,tbody,th,dl,dt,dd,q,small,strike,sup,sub,b,i,big,small,tt'),
(23, 'html_purifier_allowed_html_attributes', '*.style,*.class,a.href,a.title,a.target'),
(24, 'tag_delimiter', ','),
(25, 'public_navigation_main', '[{\"can_delete\":false,\"uid\":\"\\/omeka-main\\/items\\/browse\",\"label\":\"Browse Items\",\"fragment\":null,\"id\":null,\"class\":null,\"title\":null,\"target\":null,\"accesskey\":null,\"rel\":[],\"rev\":[],\"customHtmlAttribs\":[],\"order\":1,\"resource\":null,\"privilege\":null,\"active\":false,\"visible\":true,\"type\":\"Omeka_Navigation_Page_Mvc\",\"pages\":[],\"action\":\"browse\",\"controller\":\"items\",\"module\":null,\"params\":[],\"route\":\"default\",\"reset_params\":true,\"encodeUrl\":true,\"scheme\":null},{\"can_delete\":false,\"uid\":\"\\/omeka-main\\/collections\\/browse\",\"label\":\"Browse Collections\",\"fragment\":null,\"id\":null,\"class\":null,\"title\":null,\"target\":null,\"accesskey\":null,\"rel\":[],\"rev\":[],\"customHtmlAttribs\":[],\"order\":2,\"resource\":null,\"privilege\":null,\"active\":false,\"visible\":true,\"type\":\"Omeka_Navigation_Page_Mvc\",\"pages\":[],\"action\":\"browse\",\"controller\":\"collections\",\"module\":null,\"params\":[],\"route\":\"default\",\"reset_params\":true,\"encodeUrl\":true,\"scheme\":null}]'),
(26, 'search_record_types', 'a:3:{s:4:\"Item\";s:4:\"Item\";s:4:\"File\";s:4:\"File\";s:10:\"Collection\";s:10:\"Collection\";}'),
(27, 'api_enable', ''),
(28, 'api_per_page', '50'),
(29, 'show_element_set_headings', '1'),
(30, 'use_square_thumbnail', '1'),
(35, 'iiifitems_file_element_set', '4'),
(36, 'iiifitems_file_atid_element', '52'),
(37, 'iiifitems_file_json_element', '53'),
(38, 'iiifitems_item_element_set', '5'),
(39, 'iiifitems_item_display_element', '54'),
(40, 'iiifitems_item_atid_element', '55'),
(41, 'iiifitems_item_json_element', '56'),
(46, 'iiifitems_annotation_item_type', '18'),
(47, 'iiifitems_annotation_on_element', '60'),
(48, 'iiifitems_annotation_selector_element', '61'),
(49, 'iiifitems_annotation_elements', '[60,61]'),
(50, 'iiifitems_annotation_text_element', '1'),
(51, 'iiifitems_annotation_xywh_element', '62'),
(57, 'iiifitems_item_uuid_element', '64'),
(58, 'iiifitems_bridge_prefix', 'http://127.0.0.1:8181/loris/omeka-main/{FULLNAME}'),
(59, 'iiifitems_mirador_path', 'http://127.0.0.1:8080/omeka-main/plugins/IiifItems/views/shared/js/mirador'),
(60, 'iiifitems_mirador_css', 'css/mirador-combined.css'),
(61, 'iiifitems_mirador_js', 'mirador.js'),
(63, 'iiifitems_collection_element_set', '6'),
(64, 'iiifitems_collection_atid_element', '57'),
(65, 'iiifitems_collection_type_element', '58'),
(66, 'iiifitems_collection_parent_element', '65'),
(67, 'iiifitems_collection_json_element', '59'),
(68, 'iiifitems_collection_uuid_element', '63'),
(69, 'iiifitems_show_public_catalogue', '1'),
(70, 'iiifitems_show_mirador_collections', '1'),
(71, 'iiifitems_show_mirador_manifests', '1'),
(72, 'iiifitems_show_mirador_items', '1'),
(73, 'iiifitems_show_mirador_files', '1'),
(77, 'omeka_version', '2.8'),
(78, 'omeka_update', 'a:2:{s:14:\"latest_version\";s:4:\"2.8\n\";s:12:\"last_updated\";i:1619819348;}'),
(79, 'exhibit_builder_sort_browse', 'added');

-- --------------------------------------------------------

--
-- Table structure for table `omeka_plugins`
--

CREATE TABLE `omeka_plugins` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint NOT NULL,
  `version` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `omeka_plugins`
--

INSERT INTO `omeka_plugins` (`id`, `name`, `active`, `version`) VALUES
(1, 'Coins', 1, '2.1'),
(2, 'ExhibitBuilder', 1, '3.4.3'),
(3, 'SimplePages', 1, '3.1.3'),
(4, 'IiifItems', 1, '1.1.0');

-- --------------------------------------------------------

--
-- Table structure for table `omeka_processes`
--

CREATE TABLE `omeka_processes` (
  `id` int UNSIGNED NOT NULL,
  `class` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `pid` int UNSIGNED DEFAULT NULL,
  `status` enum('starting','in progress','completed','paused','error','stopped') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `args` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `started` timestamp NOT NULL DEFAULT '2000-01-01 00:00:00',
  `stopped` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `omeka_processes`
--

INSERT INTO `omeka_processes` (`id`, `class`, `user_id`, `pid`, `status`, `args`, `started`, `stopped`) VALUES
(1, 'Omeka_Job_Process_Wrapper', 1, NULL, 'completed', 'a:1:{s:3:\"job\";s:104:\"{\"className\":\"IiifItems_Job_AddUuid\",\"options\":[],\"createdAt\":\"2017-11-01T17:56:48+00:00\",\"createdBy\":1}\";}', '2017-11-01 17:56:48', '2017-11-01 17:56:51');

-- --------------------------------------------------------

--
-- Table structure for table `omeka_records_tags`
--

CREATE TABLE `omeka_records_tags` (
  `id` int UNSIGNED NOT NULL,
  `record_id` int UNSIGNED NOT NULL,
  `record_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `tag_id` int UNSIGNED NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `omeka_schema_migrations`
--

CREATE TABLE `omeka_schema_migrations` (
  `version` varchar(16) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `omeka_schema_migrations`
--

INSERT INTO `omeka_schema_migrations` (`version`) VALUES
('20100401000000'),
('20100810120000'),
('20110113000000'),
('20110124000001'),
('20110301103900'),
('20110328192100'),
('20110426181300'),
('20110601112200'),
('20110627223000'),
('20110824110000'),
('20120112100000'),
('20120220000000'),
('20120221000000'),
('20120224000000'),
('20120224000001'),
('20120402000000'),
('20120516000000'),
('20120612112000'),
('20120623095000'),
('20120710000000'),
('20120723000000'),
('20120808000000'),
('20120808000001'),
('20120813000000'),
('20120914000000'),
('20121007000000'),
('20121015000000'),
('20121015000001'),
('20121018000001'),
('20121110000000'),
('20121218000000'),
('20130422000000'),
('20130426000000'),
('20130429000000'),
('20130701000000'),
('20130809000000'),
('20140304131700'),
('20150211000000'),
('20150310141100'),
('20150814155100'),
('20151118214800'),
('20151209103299'),
('20151209103300'),
('20161209171900'),
('20170331084000'),
('20170405125800'),
('20200127165700');

-- --------------------------------------------------------

--
-- Table structure for table `omeka_search_texts`
--

CREATE TABLE `omeka_search_texts` (
  `id` int UNSIGNED NOT NULL,
  `record_type` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `record_id` int UNSIGNED NOT NULL,
  `public` tinyint(1) NOT NULL,
  `title` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `text` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `omeka_search_texts`
--

INSERT INTO `omeka_search_texts` (`id`, `record_type`, `record_id`, `public`, `title`, `text`) VALUES
(1, 'SimplePagesPage', 1, 1, 'About', 'About <p>This is an example page. Feel free to replace this content, or delete the page and start from scratch.</p> ');

-- --------------------------------------------------------

--
-- Table structure for table `omeka_sessions`
--

CREATE TABLE `omeka_sessions` (
  `id` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `modified` bigint DEFAULT NULL,
  `lifetime` int DEFAULT NULL,
  `data` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `omeka_sessions`
--

INSERT INTO `omeka_sessions` (`id`, `modified`, `lifetime`, `data`) VALUES
('3khk23m9p74aipt9rv3h4b8nf7', 1619819386, 1209600, 0x44656661756c747c613a313a7b733a383a227265646972656374223b733a313a222f223b7d);

-- --------------------------------------------------------

--
-- Table structure for table `omeka_simple_pages_pages`
--

CREATE TABLE `omeka_simple_pages_pages` (
  `id` int UNSIGNED NOT NULL,
  `modified_by_user_id` int UNSIGNED NOT NULL,
  `created_by_user_id` int UNSIGNED NOT NULL,
  `is_published` tinyint(1) NOT NULL,
  `title` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `slug` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `text` mediumtext CHARACTER SET utf8 COLLATE utf8_unicode_ci,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `inserted` timestamp NOT NULL DEFAULT '2000-01-01 00:00:00',
  `order` int UNSIGNED NOT NULL,
  `parent_id` int UNSIGNED NOT NULL,
  `template` tinytext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `use_tiny_mce` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `omeka_simple_pages_pages`
--

INSERT INTO `omeka_simple_pages_pages` (`id`, `modified_by_user_id`, `created_by_user_id`, `is_published`, `title`, `slug`, `text`, `inserted`, `order`, `parent_id`, `template`, `use_tiny_mce`) VALUES
(1, 1, 1, 1, 'About', 'about', '<p>This is an example page. Feel free to replace this content, or delete the page and start from scratch.</p>', '2017-11-01 17:56:41', 0, 0, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `omeka_tags`
--

CREATE TABLE `omeka_tags` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `omeka_users`
--

CREATE TABLE `omeka_users` (
  `id` int UNSIGNED NOT NULL,
  `username` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `name` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `salt` varchar(16) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint NOT NULL,
  `role` varchar(40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'default'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `omeka_users`
--

INSERT INTO `omeka_users` (`id`, `username`, `name`, `email`, `password`, `salt`, `active`, `role`) VALUES
(1, 'superuser', 'Super User', 'super@admin.com', 'd82dd8cf884fdc1284733b01455024f15c7fac7f', '7f670f00451d0887', 1, 'super');

-- --------------------------------------------------------

--
-- Table structure for table `omeka_users_activations`
--

CREATE TABLE `omeka_users_activations` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `added` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `omeka_collections`
--
ALTER TABLE `omeka_collections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `public` (`public`),
  ADD KEY `featured` (`featured`),
  ADD KEY `owner_id` (`owner_id`);

--
-- Indexes for table `omeka_elements`
--
ALTER TABLE `omeka_elements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_element_set_id` (`element_set_id`,`name`),
  ADD UNIQUE KEY `order_element_set_id` (`element_set_id`,`order`),
  ADD KEY `element_set_id` (`element_set_id`);

--
-- Indexes for table `omeka_element_sets`
--
ALTER TABLE `omeka_element_sets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `record_type` (`record_type`);

--
-- Indexes for table `omeka_element_texts`
--
ALTER TABLE `omeka_element_texts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `record_type_record_id` (`record_type`,`record_id`),
  ADD KEY `element_id` (`element_id`),
  ADD KEY `text` (`text`(20));

--
-- Indexes for table `omeka_exhibits`
--
ALTER TABLE `omeka_exhibits`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `public` (`public`);

--
-- Indexes for table `omeka_exhibit_block_attachments`
--
ALTER TABLE `omeka_exhibit_block_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `block_id_order` (`block_id`,`order`);

--
-- Indexes for table `omeka_exhibit_pages`
--
ALTER TABLE `omeka_exhibit_pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `exhibit_id_parent_id_slug` (`exhibit_id`,`parent_id`,`slug`),
  ADD KEY `exhibit_id_order` (`exhibit_id`,`order`);

--
-- Indexes for table `omeka_exhibit_page_blocks`
--
ALTER TABLE `omeka_exhibit_page_blocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `page_id_order` (`page_id`,`order`);

--
-- Indexes for table `omeka_files`
--
ALTER TABLE `omeka_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `omeka_iiif_items_cached_json_data`
--
ALTER TABLE `omeka_iiif_items_cached_json_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `omeka_iiif_items_job_statuses`
--
ALTER TABLE `omeka_iiif_items_job_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `omeka_items`
--
ALTER TABLE `omeka_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_type_id` (`item_type_id`),
  ADD KEY `collection_id` (`collection_id`),
  ADD KEY `public` (`public`),
  ADD KEY `featured` (`featured`),
  ADD KEY `owner_id` (`owner_id`);

--
-- Indexes for table `omeka_item_types`
--
ALTER TABLE `omeka_item_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `omeka_item_types_elements`
--
ALTER TABLE `omeka_item_types_elements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `item_type_id_element_id` (`item_type_id`,`element_id`),
  ADD KEY `item_type_id` (`item_type_id`),
  ADD KEY `element_id` (`element_id`);

--
-- Indexes for table `omeka_keys`
--
ALTER TABLE `omeka_keys`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `key` (`key`);

--
-- Indexes for table `omeka_options`
--
ALTER TABLE `omeka_options`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `omeka_plugins`
--
ALTER TABLE `omeka_plugins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `active_idx` (`active`);

--
-- Indexes for table `omeka_processes`
--
ALTER TABLE `omeka_processes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `pid` (`pid`),
  ADD KEY `started` (`started`),
  ADD KEY `stopped` (`stopped`);

--
-- Indexes for table `omeka_records_tags`
--
ALTER TABLE `omeka_records_tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tag` (`record_type`,`record_id`,`tag_id`),
  ADD KEY `tag_id` (`tag_id`);

--
-- Indexes for table `omeka_schema_migrations`
--
ALTER TABLE `omeka_schema_migrations`
  ADD UNIQUE KEY `unique_schema_migrations` (`version`);

--
-- Indexes for table `omeka_search_texts`
--
ALTER TABLE `omeka_search_texts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `record_name` (`record_type`,`record_id`);
ALTER TABLE `omeka_search_texts` ADD FULLTEXT KEY `text` (`text`);

--
-- Indexes for table `omeka_sessions`
--
ALTER TABLE `omeka_sessions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `omeka_simple_pages_pages`
--
ALTER TABLE `omeka_simple_pages_pages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `is_published` (`is_published`),
  ADD KEY `inserted` (`inserted`),
  ADD KEY `updated` (`updated`),
  ADD KEY `created_by_user_id` (`created_by_user_id`),
  ADD KEY `modified_by_user_id` (`modified_by_user_id`),
  ADD KEY `order` (`order`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `omeka_tags`
--
ALTER TABLE `omeka_tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `omeka_users`
--
ALTER TABLE `omeka_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `active_idx` (`active`);

--
-- Indexes for table `omeka_users_activations`
--
ALTER TABLE `omeka_users_activations`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `omeka_collections`
--
ALTER TABLE `omeka_collections`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `omeka_elements`
--
ALTER TABLE `omeka_elements`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `omeka_element_sets`
--
ALTER TABLE `omeka_element_sets`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `omeka_element_texts`
--
ALTER TABLE `omeka_element_texts`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `omeka_exhibits`
--
ALTER TABLE `omeka_exhibits`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `omeka_exhibit_block_attachments`
--
ALTER TABLE `omeka_exhibit_block_attachments`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `omeka_exhibit_pages`
--
ALTER TABLE `omeka_exhibit_pages`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `omeka_exhibit_page_blocks`
--
ALTER TABLE `omeka_exhibit_page_blocks`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `omeka_files`
--
ALTER TABLE `omeka_files`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `omeka_iiif_items_cached_json_data`
--
ALTER TABLE `omeka_iiif_items_cached_json_data`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `omeka_iiif_items_job_statuses`
--
ALTER TABLE `omeka_iiif_items_job_statuses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `omeka_items`
--
ALTER TABLE `omeka_items`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `omeka_item_types`
--
ALTER TABLE `omeka_item_types`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `omeka_item_types_elements`
--
ALTER TABLE `omeka_item_types_elements`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `omeka_keys`
--
ALTER TABLE `omeka_keys`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `omeka_options`
--
ALTER TABLE `omeka_options`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `omeka_plugins`
--
ALTER TABLE `omeka_plugins`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `omeka_processes`
--
ALTER TABLE `omeka_processes`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `omeka_records_tags`
--
ALTER TABLE `omeka_records_tags`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `omeka_search_texts`
--
ALTER TABLE `omeka_search_texts`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `omeka_simple_pages_pages`
--
ALTER TABLE `omeka_simple_pages_pages`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `omeka_tags`
--
ALTER TABLE `omeka_tags`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `omeka_users`
--
ALTER TABLE `omeka_users`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `omeka_users_activations`
--
ALTER TABLE `omeka_users_activations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
