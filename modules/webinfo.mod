if (strtolower($cbase) == "webinfo") {
	require_once("./inc/Feed.class.php");
	$feed = new FeedClass;
	$data = $feed->parseFeed("http://board.nexus-irc.de/index.php?page=CNewsFeed&categoryID=1");
	foreach($data as $v) {
		sendserv("NOTICE $nick :".$v->title." By ".$v->author." (".$v->pubDate.")");
	}
	sendserv("NOTICE $nick :The latest news can be found at http://board.nexus-irc.de/index.php?page=CNews");
}