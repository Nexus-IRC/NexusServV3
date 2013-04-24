/* web.mod - NexusServV3
 * Copyright (C) 2012-2013  #Nexus project
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
// cbase: webinfo
// cbase: v1-history
// cbase: history
if (strtolower($cbase) == "history") {
	sendserv("NOTICE $nick :".chr(31)."NexusServ ".$GLOBALS['bofficial']."".chr(31)." can be found at http://git.nexus-irc.de/?p=NexusServV3.git");
	sendserv("NOTICE $nick :".chr(31)."ArcticServ 2.0".chr(31)." was incomplete and has been removed");
	sendserv("NOTICE $nick :Try \002v1-history\002 for the ".chr(31)."ArcticServ 1.0".chr(31)." history");
}
if (strtolower($cbase) == "webinfo") {
	require_once("inc/Feed.class.php");
	$feed = new FeedClass;
	$data = $feed->parseFeed("http://board.nexus-irc.de/index.php?page=CNewsFeed&categoryID=1");
	foreach($data as $v) {
		sendserv("NOTICE $nick :".$v->title." By ".$v->author." (".$v->pubDate.")");
	}
	sendserv("NOTICE $nick :The latest news can be found at http://board.nexus-irc.de/index.php?page=CNews");
}
elseif (strtolower($cbase) == "v1-history") {
	sendserv("NOTICE $nick :\002ArcticServ 1.0 History\002");
	sendserv("NOTICE $nick :\037Version\037            \037Coder(s)\037");
	sendserv("NOTICE $nick :1.0.0-dev          Calisto");
	sendserv("NOTICE $nick :1.0.0-stable       Calisto");
	sendserv("NOTICE $nick :1.5-dev            Calisto");
	sendserv("NOTICE $nick :1.5-stable         Calisto Zer0n");
	sendserv("NOTICE $nick :1.6                Calisto");
	sendserv("NOTICE $nick :1.6.1              Calisto");
	sendserv("NOTICE $nick :1.6.2              Calisto");
	sendserv("NOTICE $nick :1.6.3              Calisto");
	sendserv("NOTICE $nick :1.6.4              Calisto");
	sendserv("NOTICE $nick :1.6.5              Calisto");
	sendserv("NOTICE $nick :1.6.6              Calisto");
	sendserv("NOTICE $nick :1.6.7              Calisto");
	sendserv("NOTICE $nick :1.6.8              Calisto");
	sendserv("NOTICE $nick :1.6.9              Calisto");
	sendserv("NOTICE $nick :1.6.91             Calisto");
	sendserv("NOTICE $nick :1.6.92             Calisto");
	sendserv("NOTICE $nick :1.7.0              Calisto");
	sendserv("NOTICE $nick :1.7.0-SSL          Calisto");
	sendserv("NOTICE $nick :1.8.0-dev          Calisto");
	sendserv("NOTICE $nick :1.8.0              Calisto");
	sendserv("NOTICE $nick :1.8.1              Calisto");
	sendserv("NOTICE $nick :1.8.1a             Calisto");
	sendserv("NOTICE $nick :1.8.1a-hotfix1     Calisto");
	sendserv("NOTICE $nick :1.8.1a-hotfix2 &");
	sendserv("NOTICE $nick : -hotfix2-wgnpatch Calisto");
	sendserv("NOTICE $nick :1.9.0-wgnpatch     Calisto Zer0n");
}