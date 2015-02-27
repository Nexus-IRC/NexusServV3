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
$p = preg_replace("/\s+/", "", strtolower($params));
require_once("./inc/Feed.class.php");
$feed = new FeedClass;

if ($p == "" || $p == "reuters") {
	$data = $feed->parseFeed("http://feeds.reuters.com/Reuters/worldNews");
	for ($i=0;$i<5;$i++) {
		echo "NOTICE $nick :".$data[$i]->title."\n";
	}
}
elseif ($p == "onion" || $p == "theonion") {
	$data = $feed->parseFeed("http://feeds.theonion.com/theonion/daily");
	for ($i=0;$i<5;$i++) {
		echo "NOTICE $nick :".$data[$i]->title."\n";
	}
}
elseif ($p == "spiegel") {
	$data = $feed->parseFeed("http://www.spiegel.de/international/index.rss");
	for ($i=0;$i<5;$i++) {
		echo "NOTICE $nick :".$data[$i]->title."\n";
	}
}
elseif ($p == "arstechnica") {
	$data = $feed->parseFeed("http://feeds.arstechnica.com/arstechnica/index");
	for ($i=0;$i<5;$i++) {
		echo "NOTICE $nick :".$data[$i]->title."\n";
	}
}
elseif ($p == "rt" || $p == "russiatoday") {
	$data = $feed->parseFeed("http://rt.com/rss/");
	for ($i=0;$i<5;$i++) {
		echo "NOTICE $nick :".$data[$i]->title."\n";
	}
}
elseif ($p == "readwrite") {
	$data = $feed->parseFeed("http://readwrite.com/rss.xml");
	for ($i=0;$i<5;$i++) {
		echo "NOTICE $nick :".$data[$i]->title."\n";
	}
}
elseif ($p == "theguardian") {
	$data = $feed->parseFeed("http://www.theguardian.com/world/rss");
	for ($i=0;$i<5;$i++) {
		echo "NOTICE $nick :".$data[$i]->title."\n";
	}
}
elseif ($p == "aljazeera") {
	$data = $feed->parseFeed("http://www.aljazeera.com/xml/rss/all.xml");
	for ($i=0;$i<5;$i++) {
		echo "NOTICE $nick :".$data[$i]->title."\n";
	}
}
elseif ($p == "githubnewfeatures") {
	$data = $feed->parseFeed("https://github.com/blog/ship.atom");
	for ($i=0;$i<5;$i++) {
		echo "NOTICE $nick :".$data[$i]->title."\n";
	}
}
elseif ($p == "githubengineering") {
	$data = $feed->parseFeed("https://github.com/blog/engineering.atom");
	for ($i=0;$i<5;$i++) {
		echo "NOTICE $nick :".$data[$i]->title."\n";
	}
}
elseif ($p == "appledeveloper") {
	$data = $feed->parseFeed("https://developer.apple.com/news/rss/news.rss");
	for ($i=0;$i<5;$i++) {
		echo "NOTICE $nick :".$data[$i]->title."\n";
	}
}
elseif ($p == "applepressrelease" || $p == "applepr") {
	$data = $feed->parseFeed("https://www.apple.com/pr/feeds/pr.rss");
	for ($i=0;$i<5;$i++) {
		echo "NOTICE $nick :".$data[$i]->title."\n";
	}
}
elseif ($p == "linuxkernel") {
	$data = $feed->parseFeed("https://www.kernel.org/feeds/kdist.xml");
	for ($i=0;$i<5;$i++) {
		echo "NOTICE $nick :".$data[$i]->title."\n";
	}
}
else {
	echo "NOTICE $nick :\002".$params."\002 is not a valid news source.\n";
}
?>