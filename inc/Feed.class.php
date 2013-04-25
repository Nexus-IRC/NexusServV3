<?php
/* inc/Feed.class.php - NexusServV3
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
class FeedClass {
	public static function parseFeed($url = null, $xml = null) {
        if ($xml === null) {
            $file = file_get_contents($url);
            $xml = simplexml_load_string($file);
        }
        $type = self::getFeedType(null, $xml);
        $data = null;
        switch($type) {
            case 'rss':
                $data = self::parseRSSFeed($xml);
                break;
            case 'atom':
                $data = self::parseAtomFeed($xml);
                break;
            default:
                return null;
                break;
        }
        return $data;  
    }

    private static function parseRSSFeed($xml) {
		foreach ($xml->channel->item as $item) {
			$item->pubDate = self::getTime($item->pubDate);
			$item->description = html_entity_decode($item->description);
			$data[] = $item;
		} 
		return $data;
    }

    private static function parseAtomFeed($xml) {
		$entries = $xml->children()->entry;
		foreach ($entries as $entry) {
			$entry->children()->author = $entry->children()->author->name;
			$entry->children()->link = $entry->link->attributes()->href;
			$entry->children()->updated = self::getTimeStamp($entry->children()->updated);
			$data[] = $entry->children();
		}
		return $data;
    }

    private static function getTime($time) {
		return date("d.m.Y H:i:s",intval(strtotime($time)));;
	}
	
    private static function getTimeStamp($time) {
		return intval(strtotime($time));;
	}

    public static function getFeedType($url = null, $xml = null) {
        $type = false;

        if ($xml === null) {
            $file = FileUtil::downloadFileFromHttp($url);
            $xml = simplexml_load_file($file);
            @unlink($file);
        }

        if (isset($xml->channel->item)) $type = 'rss';
        if (isset($xml->entry)) $type = 'atom';

        return $type;
    }
}
/*
$feed = new FeedClass;
$data = $feed->parseFeed("http://board.nexus-irc.de/index.php?page=CNewsFeed&categoryID=1");
echo"<pre>";
print_r($data);
echo $data[0]["title"];
*/
?>