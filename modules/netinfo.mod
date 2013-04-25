/* modules/netinfo.mod - NexusServV3
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
if (strtolower($cbase) == "netinfo") {
	global $server; global $botnick; global $userinfo; global $stime;
	$chancount = 0;
	$fop = fopen("./conf/users.conf","r+");
	while ($fra = fgets($fop)) {
		if ($fra{0} == "-") {
			$chancount++;
		}
	}
	fclose($fop);
	$acccount = 0;
	$fop = fopen("./conf/accs.conf","r+");
	while ($fra = fgets($fop)) {
		$acccount++;
	}
	fclose($fop);
	sendserv("NOTICE $nick :\002\037Network Information\037\002");
	sendserv("NOTICE $nick :\002Network            \002  ".$GLOBALS['netdata']['NETWORK']);
	sendserv("NOTICE $nick :\002Bot Uptime         \002  ".time2str(time() - $stime));
	sendserv("NOTICE $nick :\002Channels registered\002  $chancount");
	sendserv("NOTICE $nick :\002Maximum channels   \002  ".$GLOBALS['netdata']['MAXCHANNELS']);
	sendserv("NOTICE $nick :\002Accounts known     \002  $acccount");
	sendserv("NOTICE $nick :\002Users visible      \002  ".count($userinfo));
	$auc = 0;
	foreach ($userinfo as $uname => $user) {
		if ($userinfo[$uname]['auth'] != "") {
			$auc++;
		}
	}
	if ($userinfo[strtolower($botnick)]["auth"] != "") {
		sendserv("NOTICE $nick :\002Bot Account        \002  ".$userinfo[strtolower($botnick)]["auth"]);
	}
	else {
		sendserv("NOTICE $nick :\002Bot Account        \002  Not logged in");
	}
	sendserv("NOTICE $nick :\002Users authed       \002  $auc");
	sendserv("NOTICE $nick :\002Maximum Memory Use \002  ".round((memory_get_peak_usage()/1024/1024),2)." MB (".round((memory_get_peak_usage()/1024),2)." kB)");
	sendserv("NOTICE $nick :\002         Right now \002  ".round((memory_get_usage()/1024/1024),2)." MB (".round((memory_get_usage()/1024),2)." kB)");
	sendserv("NOTICE $nick :\002Incoming Traffic   \002  ".round(($GLOBALS['glob']['dat_in']/1024/1024),2)." MB (".round(($GLOBALS['glob']['dat_in']/1024),2)." kB)");
	sendserv("NOTICE $nick :\002Outgoing Traffic   \002  ".round(($GLOBALS['glob']['dat_out']/1024/1024),2)." MB (".round(($GLOBALS['glob']['dat_out']/1024/1024),2)." kB)");
	sendserv("NOTICE $nick :\002Parser             \002  php".phpversion());
	sendserv("NOTICE $nick :\002Version            \002  ".$GLOBALS['bversion']." (".$GLOBALS['bcodename'].")");
	sendserv("NOTICE $nick :\002Core Version       \002  NexusServ v".$GLOBALS['core']);
	sendserv("NOTICE $nick :\002Reloads            \002  ".($GLOBALS['rid']+0));
	sendserv("NOTICE $nick :If you have found a bug or if you have a good idea report it on http://bugtracker.nexus-irc.de");
}