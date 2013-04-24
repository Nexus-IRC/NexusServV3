/* vote.mod - NexusServV3
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
// cbase: addvote
// cbase: delvote
// cbase: addoption
// cbase: deloption
// cbase: startvote
// cbase: vote
// cbase: voting
if (strtolower($cbase) == "addvote") {
	global $userinfo; global $chans; global $botnick; global $god;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$fop = fopen("users.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
		}
		else {
			if ($area == $tchan) {
				if ($frg[0] == $userinfo["$lnick"]["auth"]) {
					$axs = $frg[1];
				}
				$uaxs["$frg[0]"] = $frg[1];
				$cfound = 1;
			}
		}
	}
	fclose($fop);
	$area = "";
	$fop = fopen("settings.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
		}
		else {
			if ($area == $tchan) {
				$tsets["$frg[0]"] = substr($fra,strlen($frg[0]." "));
			}
		}
	}
	fclose($fop);
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
		return(0);
	}
	$cname = $chans["$tchan"]["name"];
	if ($tsets['votings'] != '1') {
		sendserv("NOTICE $nick :Votings are disabled in \002$cname\002.");
		return(0);
	}
	if ($tsets['changevote'] == '') {
		$tsets['changevote'] = '400';
	}
	if ($axs < $tsets['changevote']) {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
	}
	else {
		if ($paramzz == "") {
			sendserv("NOTICE $nick :\002addvote\002 requires more parameters:");
			sendserv("NOTICE $nick : <QUESTION>");
			return(0);
		}
		$ffop = fopen('votes.conf','r+');
		while ($ffg = fgets($ffop)) {
			$ffg = str_replace("\r","",$ffg);
			$ffg = str_replace("\n","",$ffg);
			$varray = unserialize($ffg);
		}
		fclose($ffop);
		if ($varray[$tchan] != "") {
			sendserv("NOTICE $nick :There is already a voting on \002$cname\002.");
			return(0);
		}
		$varray[$tchan] = array('question' => $paramzz);
		$ffop = fopen('votes.conf','w+');
		fwrite($ffop,serialize($varray));
		fclose($ffop);
		sendserv("NOTICE $nick :Voting was added to \002$cname\002 with question \002$paramzz\002");
	}
}
if (strtolower($cbase) == "delvote") {
	global $userinfo; global $chans; global $botnick; global $god;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$fop = fopen("users.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
		}
		else {
			if ($area == $tchan) {
				if ($frg[0] == $userinfo["$lnick"]["auth"]) {
					$axs = $frg[1];
				}
				$uaxs["$frg[0]"] = $frg[1];
				$cfound = 1;
			}
		}
	}
	fclose($fop);
	$area = "";
	$fop = fopen("settings.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
		}
		else {
			if ($area == $tchan) {
				$tsets["$frg[0]"] = substr($fra,strlen($frg[0]." "));
			}
		}
	}
	fclose($fop);
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
		return(0);
	}
	$cname = $chans["$tchan"]["name"];
	if ($axs < 400) {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
	}
	else {
		$ffop = fopen('votes.conf','r+');
		while ($ffg = fgets($ffop)) {
			$ffg = str_replace("\r","",$ffg);
			$ffg = str_replace("\n","",$ffg);
			$varray = unserialize($ffg);
		}
		fclose($ffop);
		if ($varray[$tchan] == "") {
			sendserv("NOTICE $nick :There is no voting on \002$cname\002.");
			return(0);
		}
		unset($varray[$tchan]);
		$ffop = fopen('votes.conf','w+');
		fwrite($ffop,serialize($varray));
		fclose($ffop);
		sendserv("NOTICE $nick :Voting from \002$cname\002 was deleted.");
	}
}
if (strtolower($cbase) == "addoption") {
	global $userinfo; global $chans; global $botnick; global $god;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$fop = fopen("users.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
		$area = $frg[1];
		}
		else {
			if ($area == $tchan) {
				if ($frg[0] == $userinfo["$lnick"]["auth"]) {
					$axs = $frg[1];
				}
				$uaxs["$frg[0]"] = $frg[1];
				$cfound = 1;
			}
		}
	}
	fclose($fop);
	$area = "";
	$fop = fopen("settings.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
		}
		else {
			if ($area == $tchan) {
				$tsets["$frg[0]"] = substr($fra,strlen($frg[0]." "));
			}
		}
	}
	fclose($fop);
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
		return(0);
	}
	$cname = $chans["$tchan"]["name"];
	if ($tsets['votings'] != '1') {
		sendserv("NOTICE $nick :Votings are disabled in \002$cname\002.");
		return(0);
	}
	if ($tsets['changevote'] == '') {
		$tsets['changevote'] = '400';
	}
	if ($axs < $tsets['changevote']) {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
	}
	else {
		if ($paramzz == "") {
			sendserv("NOTICE $nick :\002addoption\002 requires more parameters:");
			sendserv("NOTICE $nick : <ANSWER>");
			return(0);
		}
		$ffop = fopen('votes.conf','r+');
		while ($ffg = fgets($ffop)) {
			$ffg = str_replace("\r","",$ffg);
			$ffg = str_replace("\n","",$ffg);
			$varray = unserialize($ffg);
		}
		fclose($ffop);
		if ($varray[$tchan] == "") {
			sendserv("NOTICE $nick :There is no voting on \002$cname\002.");
			return(0);
		}
		if ($varray[$tchan]['start'] == 1) {
			sendserv("NOTICE $nick :The voting on \002$cname\002 was already started.");
			return(0);
		}
		$varray[$tchan]['options'][] = $paramzz;
		$ffop = fopen('votes.conf','w+');
		fwrite($ffop,serialize($varray));
		fclose($ffop);
		sendserv("NOTICE $nick :Question on \002$cname\002 is: ".$varray[$tchan]['question']);
		sendserv("NOTICE $nick :Option was added.");
	}
}
if (strtolower($cbase) == "deloption") {
	global $userinfo; global $chans; global $botnick; global $god;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$fop = fopen("users.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
		}
		else {
			if ($area == $tchan) {
				if ($frg[0] == $userinfo["$lnick"]["auth"]) {
					$axs = $frg[1];
				}
				$uaxs["$frg[0]"] = $frg[1];
				$cfound = 1;
			}
		}
	}
	fclose($fop);
	$area = "";
	$fop = fopen("settings.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
		}
		else {
			if ($area == $tchan) {
				$tsets["$frg[0]"] = substr($fra,strlen($frg[0]." "));
			}
		}
	}
	fclose($fop);
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
		return(0);
	}
	$cname = $chans["$tchan"]["name"];
	if ($tsets['votings'] != '1') {
		sendserv("NOTICE $nick :Votings are disabled in \002$cname\002.");
		return(0);
	}
	if ($tsets['changevote'] == '') {
		$tsets['changevote'] = '400';
	}
	if ($axs < $tsets['changevote']) {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
	}
	else {
		if ($paramzz == "") {
			sendserv("NOTICE $nick :\002deloption\002 requires more parameters:");
			sendserv("NOTICE $nick : <OPTION-ID>");
			return(0);
		}
		$ffop = fopen('votes.conf','r+');
		while ($ffg = fgets($ffop)) {
			$ffg = str_replace("\r","",$ffg);
			$ffg = str_replace("\n","",$ffg);
			$varray = unserialize($ffg);
		}
		fclose($ffop);
		if ($varray[$tchan] == "") {
			sendserv("NOTICE $nick :There is no voting on \002$cname\002.");
			return(0);
		}
		if ($varray[$tchan]['start'] == 1) {
			sendserv("NOTICE $nick :The voting on \002$cname\002 was already started.");
			return(0);
		}
		if ($varray[$tchan]['options'][$paramzz] == "") {
			sendserv("NOTICE $nick :This option ID is not existing on \002$cname\002.");
			return(0);
		}
		unset($varray[$tchan]['options'][$paramzz]);
		$vk = $varray[$tchan]['options'];
		unset($varray[$tchan]['options']);
		foreach ($vk as $vkint) {
			$varray[$tchan]['options'][] = $vkint;
		}
		$ffop = fopen('votes.conf','w+');
		fwrite($ffop,serialize($varray));
		fclose($ffop);
		sendserv("NOTICE $nick :Option was deleted.");
	}
}
if (strtolower($cbase) == "startvote") {
	global $userinfo; global $chans; global $botnick; global $god;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$fop = fopen("users.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
		}
		else {
			if ($area == $tchan) {
				if ($frg[0] == $userinfo["$lnick"]["auth"]) {
					$axs = $frg[1];
				}
				$uaxs["$frg[0]"] = $frg[1];
				$cfound = 1;
			}
		}
	}
	fclose($fop);
	$area = "";
	$fop = fopen("settings.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
		}
		else {
			if ($area == $tchan) {
				$tsets["$frg[0]"] = substr($fra,strlen($frg[0]." "));
			}
		}
	}
	fclose($fop);
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
		return(0);
	}
	$cname = $chans["$tchan"]["name"];
	if ($tsets['votings'] != '1') {
		sendserv("NOTICE $nick :Votings are disabled in \002$cname\002.");
		return(0);
	}
	if ($tsets['changevote'] == '') {
		$tsets['changevote'] = '400';
	}
	if ($axs < $tsets['changevote']) {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
	}
	else {
		$ffop = fopen('votes.conf','r+');
		while ($ffg = fgets($ffop)) {
			$ffg = str_replace("\r","",$ffg);
			$ffg = str_replace("\n","",$ffg);
			$varray = unserialize($ffg);
		}
		fclose($ffop);
		if ($varray[$tchan] == "") {
			sendserv("NOTICE $nick :There is no voting on \002$cname\002.");
			return(0);
		}
		if ($varray[$tchan]['start'] == 1) {
			sendserv("NOTICE $nick :The voting on \002$cname\002 was already started.");
			return(0);
		}
		$vo = 0;
		foreach ($varray[$tchan]['options'] as $vkint) {
			$vo++;
		}
		if ($vo < 2) {
			sendserv("NOTICE $nick :Please add at least 2 options to the voting of \002$cname\002.");
			return(0);
		}
		$varray[$tchan]['start'] = 1;
		$ffop = fopen('votes.conf','w+');
		fwrite($ffop,serialize($varray));
		fclose($ffop);
		sendserv("NOTICE $nick :The voting was started.");
		sendserv("PRIVMSG $cname :\002$nick\002 started a voting");
		sendserv("PRIVMSG $cname :Question: ".$varray[$tchan]['question']);
		foreach ($varray[$tchan]['options'] as $vnr => $vtx) {
		sendserv("PRIVMSG $cname :   $vnr -> $vtx");
		}
		sendserv("PRIVMSG $cname :Use \002vote <ID>\002 to vote.");
	}
}
if (strtolower($cbase) == "vote") {
	global $userinfo; global $chans; global $botnick; global $god;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$fop = fopen("users.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
		}
		else {
			if ($area == $tchan) {
				if ($frg[0] == $userinfo["$lnick"]["auth"]) {
					$axs = $frg[1];
				}
				$uaxs["$frg[0]"] = $frg[1];
				$cfound = 1;
			}
		}
	}
	fclose($fop);
	$area = "";
	$fop = fopen("settings.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
		}
		else {
			if ($area == $tchan) {
				$tsets["$frg[0]"] = substr($fra,strlen($frg[0]." "));
			}
		}
	}
	fclose($fop);
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
		return(0);
	}
	$cname = $chans["$tchan"]["name"];
	if ($tsets['votings'] != '1') {
		sendserv("NOTICE $nick :Votings are disabled in \002$cname\002.");
		return(0);
	}
	if ($tsets['changevote'] == '') {
		$tsets['changevote'] = '400';
	}
	if ($axs < $tsets['vote']) {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
	}
	else {
		if ($paramzz == "") {
			sendserv("NOTICE $nick :\002vote\002 requires more parameters:");
			sendserv("NOTICE $nick : <OPTION-ID>");
			return(0);
		}
		$ffop = fopen('votes.conf','r+');
		while ($ffg = fgets($ffop)) {
			$ffg = str_replace("\r","",$ffg);
			$ffg = str_replace("\n","",$ffg);
			$varray = unserialize($ffg);
		}
		fclose($ffop);
		if ($varray[$tchan] == "") {
			sendserv("NOTICE $nick :There is no voting on \002$cname\002.");
			return(0);
		}
		$uauth = strtolower($userinfo[$lnick]['auth']);
		if ($varray[$tchan]['voted'][$uauth] == 1) {
			sendserv("NOTICE $nick :You already voted.");
			return(0);
		}
		if ($varray[$tchan]['start'] != 1) {
			sendserv("NOTICE $nick :The voting on \002$cname\002 is not started.");
			return(0);
		}
		if ($varray[$tchan]['options'][$paramzz] == "") {
			sendserv("NOTICE $nick :This option ID is not existing on \002$cname\002.");
			return(0);
		}
		$varray[$tchan]['votes'][$paramzz]++;
		$varray[$tchan]['voted'][$uauth] = 1;
		$ffop = fopen('votes.conf','w+');
		fwrite($ffop,serialize($varray));
		fclose($ffop);
		sendserv("NOTICE $nick :You voted for ID#$paramzz (".$varray[$tchan]['options'][$paramzz].")");
	}
}
if (strtolower($cbase) == "voting") {
	global $userinfo; global $chans; global $botnick; global $god;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$fop = fopen("users.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
		}
		else {
			if ($area == $tchan) {
				if ($frg[0] == $userinfo["$lnick"]["auth"]) {
					$axs = $frg[1];
				}
				$uaxs["$frg[0]"] = $frg[1];
				$cfound = 1;
			}
		}
	}
	fclose($fop);
	$area = "";
	$fop = fopen("settings.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
		}
		else {
			if ($area == $tchan) {
				$tsets["$frg[0]"] = substr($fra,strlen($frg[0]." "));
			}
		}
	}
	fclose($fop);
	if ($cfound == 0) {
		sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
		return(0);
	}
	$cname = $chans["$tchan"]["name"];
	if ($tsets['votings'] != '1') {
		sendserv("NOTICE $nick :Votings are disabled in \002$cname\002.");
		return(0);
	}
	if ($axs < -1000) {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
	}
	else {
		$ffop = fopen('votes.conf','r+');
		while ($ffg = fgets($ffop)) {
			$ffg = str_replace("\r","",$ffg);
			$ffg = str_replace("\n","",$ffg);
			$varray = unserialize($ffg);
		}
		fclose($ffop);
		if ($varray[$tchan] == "") {
			sendserv("NOTICE $nick :There is no voting on \002$cname\002.");
			return(0);
		}
		sendserv("NOTICE $nick :\002Voting info for $cname:\002");
		sendserv("NOTICE $nick :Question: ".$varray[$tchan]['question']);
		sendserv("NOTICE $nick :Options:");
		foreach ($varray[$tchan]['options'] as $optnr => $optarg) {
			$vtimes = $varray[$tchan]['votes'][$optnr];
			if ($vtimes == "") {
				$vtimes = "0";
			}
			sendserv("NOTICE $nick :    $optnr -> $optarg (Voted ".$vtimes." times)");
		}
		if ($varray[$tchan]['start'] == 1) {
			sendserv("NOTICE $nick :- The voting on \002$cname\002 is started.");
		}
		$ffop = fopen('votes.conf','w+');
		fwrite($ffop,serialize($varray));
		fclose($ffop);
	}
}