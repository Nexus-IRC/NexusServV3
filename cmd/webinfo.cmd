/* cmd/webinfo.cmd - NexusServV3
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
require_once("./inc/Feed.class.php");
$feed = new FeedClass;
$data = $feed->parseFeed("https://nexus-irc.de/news/NewsFeed");
foreach($data as $v) {
	sendserv("NOTICE $nick :".$v->title." By ".$v->author." (".$v->pubDate.")");
}
sendserv("NOTICE $nick :The latest news can be found at https://nexus-irc.de/news/NewsOverview");