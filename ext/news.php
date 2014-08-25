<?php
/* ext/news.php - NexusServV3
 * Copyright (C) 2014  #Nexus project
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License 
 * along with this program. If not, see <http://www.gnu.org/licenses/>. 
 */
$param = explode(" ",$params);
require_once("./inc/Feed.class.php");
$feed = new FeedClass;

if (($param[0] == "") || ($param[0] == "world")) {
	$data = $feed->parseFeed("http://feeds.reuters.com/Reuters/worldNews");
	for ($i=0;$i<5;$i++) {
		echo "NOTICE $nick :".$data[$i]->title."\n";
	}
}
elseif ($param[0] == "onion") {
	$data = $feed->parseFeed("http://feeds.theonion.com/theonion/daily");
	for ($i=0;$i<5;$i++) {
		echo "NOTICE $nick :".$data[$i]->title."\n";
	}
}
elseif (($param[0] == "spiegel") || ($param[0] == "spiegel.de")) {
	$data = $feed->parseFeed("http://www.spiegel.de/schlagzeilen/tops/index.rss");
	for ($i=0;$i<5;$i++) {
		echo "NOTICE $nick :".$data[$i]->title."\n";
	}
}
elseif (($param[0] == "spiegel.en") || ($param[0] == "spiegel.int")) {
	$data = $feed->parseFeed("http://www.spiegel.de/international/index.rss");
	for ($i=0;$i<5;$i++) {
		echo "NOTICE $nick :".$data[$i]->title."\n";
	}
}
elseif (($param[0] == "tech") || ($param[0] == "arstechnica")) {
	$data = $feed->parseFeed("http://feeds.arstechnica.com/arstechnica/index");
	for ($i=0;$i<5;$i++) {
		echo "NOTICE $nick :".$data[$i]->title."\n";
	}
}
elseif ($param[0] == "rt") {
	$data = $feed->parseFeed("http://rt.com/rss/");
	for ($i=0;$i<5;$i++) {
		echo "NOTICE $nick :".$data[$i]->title."\n";
	}
}
else {
	echo "NOTICE $nick :".$param[0]." is not a valid news source.\n";
}
?>