/* modules/webinfo.mod - NexusServV3
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
 if (strtolower($cbase) == "webinfo") {
	require_once("./inc/Feed.class.php");
	$feed = new FeedClass;
	$data = $feed->parseFeed("http://board.nexus-irc.de/index.php?page=CNewsFeed&categoryID=1");
	foreach($data as $v) {
		sendserv("NOTICE $nick :".$v->title." By ".$v->author." (".$v->pubDate.")");
	}
	sendserv("NOTICE $nick :The latest news can be found at http://board.nexus-irc.de/index.php?page=CNews");
}