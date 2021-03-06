<?php
/* nexusserv.php - NexusServV3
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
@(include('./inc/fnmatch.php'));
error_reporting(E_ALL & ~E_NOTICE);
$modules = array();
foreach (glob("./cmd/*.cmd") as $filename) {
	$fop = fopen($filename,"r+t");
	while ($fg = fgets($fop)) {
		$modules["$filename"] .= $fg;
	}
	fclose($fop);
}

function d_userinfo ($unick) {
	$nnick = strtolower($unick);
	global $userinfo;
	$ret = "";
	foreach ($userinfo[$nnick] as $aname => $aval) {
		$ret .= "$aname => $aval\n";
	}
	return($ret);
}

include("./inc/time_handler.php");
set_time_limit(0);

$staffl["0"] = "Trial";
$staffl["1"] = "Helper";
$staffl["2"] = "Extended Helper";
$staffl["3"] = "Manager";
$staffl["4"] = "Bot Admin";
$staffl["5"] = "Admin";
$staffl["6"] = "Bot";
$staffl["7"] = "Developer";

$floodtime = time();
$flood = "0";

require_once("./conf/config.php");
if ($port[0] == "+") {
	$socket = fsockopen("tls://".$server,str_replace("+", "", $port),$errstr,$errno,2);
}
else {
	$socket = fsockopen($server,$port,$errstr,$errno,2);
}
$dltimer = array();
$timer = time();
stream_set_blocking($socket,0);
sendserv("PASS :$botauth:$pass");
sendserv("NICK $botnick");
sendserv("USER $botident - - :$botreal");
$god[$botnick] = 1;

if (is_file("./.git/refs/heads/master")) {
	$fop = fopen("./.git/refs/heads/master","r+t");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		$bversion = substr($frg[0], 0, 7);
	}
	fclose($fop);
}

while (true) {
	if (feof($socket)) {
		global $userinfo, $chans;
		unset($userinfo);
		unset($chans);
		// Because the old connection has lost, the bot deletes all its infos to users/channels
		if ($port[0] == "+") {
			$socket = fsockopen("tls://".$server,str_replace("+", "", $port),$errstr,$errno,2);
		}
		else {
			$socket = fsockopen($server,$port,$errstr,$errno,2);
		}
		$dltimer = array();
		$timer = time();
		stream_set_blocking($socket,0);
		sendserv("PASS :$botauth:$pass");
		sendserv("NICK $botnick");
		sendserv("USER $botident - - :$botreal");
	}
	if (time() >= $timer + 1) {
		$timer = time();
		$thistime = time();
		foreach ($dltimer as $thetime => $evntarray) {
		if ($thetime <= time()) {
		timer_evnts($thetime,1);
		}
		}

		$bfcont = "";
		$carea = "";
		$bfop = fopen("./conf/bans.conf","r+t");
		while ($fra = fgets($bfop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$frg = explode(" ",$fra);
			if ($frg[0] == "-") {
				$carea = $frg[1];
				$bfcont .= "$fra\r\n";
			}
			elseif ($fra == "") {
			}
			else {
				if ($frg[2] <= time() && $frg[2] != "p") {
					sendserv("MODE ".$chans["$carea"]["name"]." -b $frg[0]");
				}
				else {
					$bfcont .= "$fra\r\n";
				}
			}
		}
		fclose($bfop);
		$bfop = fopen("./conf/bans.conf","w+t");
		fwrite($bfop,$bfcont);
		fclose($bfop);
	}
	usleep(1000);
	while ($data = fgets($socket)) {
		$glob['dat_in'] = $glob['dat_in'] + strlen($data);
		$data = str_replace("\r","",$data);
		$data = str_replace("\n","",$data);
		$dat = array($data);
		foreach ($dat as $mdata) {
			echo($mdata."\r\n");
			flush();
			$e = explode(" ",$mdata);
			if ($e[0] == "PING") {
				sendserv("PONG $e[1]");
			}
			if ($e[1] == "332") {
				$cchan = strtolower($e[3]);
				$chans["$cchan"]["topic"] = substr($mdata,strlen("$e[0] $e[1] $e[2] $e[3] :"));
			}
			if ($e[1] == "333") {
				$cchan = strtolower($e[3]);
				$chans["$cchan"]["topic_by"] = $e[4];
			}
			if ($e[1] == "TOPIC") {
				$cchan = strtolower($e[2]);
				$tchan = $cchan;
				$lnick = strtolower(getnick($e[0]));
				$area = "";
				$axs = 0;
				$cfound = 0;
				$acc = $userinfo["$lnick"]["auth"];
				$fop = fopen("./conf/users.conf","r+t");
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
							$cfound = 1;
						}
					}
				}
				fclose($fop);
				$area = "";
				$fop = fopen("./conf/settings.conf","r+t");
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
				if ($tsets['modtopic'] == "") {
					$tsets['modtopic'] = "400";
				}
				if ($axs < $tsets["modtopic"] && $god["$acc"] != "1" && getnick($e[0]) != $botnick) {
					sendserv("TOPIC $tchan :".$chans["$tchan"]["topic"]);
					sendserv("NOTICE ".getnick($e[0])." :The $e[2] topic is locked, you may not change it. You need at least \002".$tsets['modtopic']."\002 access.");
				}
				$chans["$cchan"]["topic"] = substr($mdata,strlen("$e[0] $e[1] $e[2] :"));
				$chans["$cchan"]["topic_by"] = getnick($e[0]);
			}
			if ($e[1] == "324") {
				$chan = $e[3];
				$cchan = strtolower($chan);
				$chans["$cchan"]["modes"] = "";
				$chans["$cchan"]["key"] = "";
				$chans["$cchan"]["limit"] = "";
				$modes = substr($mdata,strlen($e[0]." ".$e[1]." ".$e[2]." ".$e[3]." "));
				parse_modes($chan,$chan,$modes);
			}
			if ($e[1] == "354") {
				$chan = $e[3];
				$cchan = strtolower($chan);
				$ident = $e[4];
				$host = $e[5];
				$nick = $e[6];
				$stat = $e[7];
				if ($e[8] != "0") {
				$auth = $e[8];
				}
				else {
				$auth = "";
				}
				$lnick = strtolower($nick);
				if ($lnick != "") {
				$userinfo["$lnick"]["nick"] = $nick;
				$userinfo["$lnick"]["auth"] = $auth;
				$userinfo["$lnick"]["host"] = $host;
				$userinfo["$lnick"]["ident"] = $ident;
				$chans["$cchan"]["users"]["$lnick"] = "-$stat";
				}
				$ident = "";
				$host = "";
				$stat = "";
				$auth = "";
				$lnick = "";
				$nick = "";
			}
			if ($e[1] == "MODE") {
				$sender = getnick($e[0]);
				$target = $e[2];
				$modes = substr($mdata,strlen($e[0]." ".$e[1]." ".$e[2]." "));
				parse_modes($sender, $target, $modes);
				unset($tsets);
				$tchan = strtolower($target);
				$lnick = strtolower(getnick($e[0]));
				$area = "";
				$axs = 0;
				$cfound = 0;
				$acc = $userinfo["$lnick"]["auth"];
				$fop = fopen("./conf/users.conf","r+t");
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
							$cfound = 1;
						}
					}
				}
				fclose($fop);
				$area = "";
				$fop = fopen("./conf/settings.conf","r+t");
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
				if ($tsets['enfmodes'] == "") {
					$tsets['enfmodes'] = "300";
				}
				fclose($fop);
				if ($axs < $tsets["enfmodes"] && $god["$acc"] != "1" && $lnick != strtolower($botnick)) {
					bot_mod_mod($botnick,$botnick,$botnick,$tchan,$tchan,"chan.mod mode ".$tsets["modes"]);
				}
			}
			if ($e[1] == "PART") {
				$cchan = strtolower($e[2]);
				$nick = getnick($e[0]);
				$lnick = strtolower($nick);
				if ($cchan[0] == ":") {
					$cchan = substr($cchan,1);
				}
				global $userinfo;
				$uauth = strtolower($userinfo["$lnick"]["auth"]);
				$fopi = fopen("./conf/users.conf","r+t");
				$temp = file_get_contents("./conf/lastseen.txt");
				$washere = unserialize($temp);
				$washere[$cchan][$uauth] = time();
				$fop = fopen("./conf/lastseen.txt","w+t");
				fwrite($fop,serialize($washere));
				fclose($fop);
				fclose($fopi);

				if ($nick == $botnick) {
					foreach ($chans["$cchan"]["users"] as $unick => $uarray) {
						$ucf = 0;
						foreach ($chans as $cnam => $cnarray) {
							if ($chans["$cnam"]["users"]["$unick"] != "") {
								$ucf++;
							}
						}
						if ($ucf == 1) {
							if($showdebug == true){
								sendserv("PRIVMSG $debugchannel :User $unick not found on any channel. Terminating userinfo.");
							}
							unset($userinfo["$unick"]);
						}
					}
					unset($chans["$cchan"]);
				}

				$nexttime = time() + 10;
				$timcount = count($dltimer["$nexttime"]) + 1;
				$dltimer["$nexttime"][$timcount] = "DYNLIMIT $cchan";
				unset($chans["$cchan"]["users"]["$lnick"]);
				$ucf = 0;
				foreach ($chans as $cname => $sarray) {
					if ($chans["$cname"]["users"]["$lnick"] != "") {
						$ucf++;
					}
				}
				if ($ucf == 0) {
					if($showdebug == true){
						sendserv("PRIVMSG $debugchannel :User $nick not found on any channel. Terminating userinfo.");
					}
					unset($userinfo["$lnick"]);
				}
			}
			if ($e[1] == "QUIT") {
				$nick = getnick($e[0]);
				$lnick = strtolower($nick);
				foreach ($chans as $cname => $sarray) {
					$nexttime = time() + 10;
					$timcount = count($dltimer["$nexttime"]) + 1;
					$dltimer["$nexttime"][$timcount] = "DYNLIMIT $cname";
						if ($chans["$cname"]["users"]["$lnick"] != "") {
						unset($chans["$cname"]["users"]["$lnick"]);
						$uauth = strtolower($userinfo["$lnick"]["auth"]);

						$fop = fopen("./conf/lastseen.txt","r+t");
						while ($fra = fgets($fop)) {
							$fra = str_replace("\r","",$fra);
							$fra = str_replace("\n","",$fra);
							$temp .= $fra;
						}
						fclose($fop);

						$washere = unserialize($temp);
						$washere[$cname][$uauth] = time();
						$fop = fopen("./conf/lastseen.txt","w+t");
						fwrite($fop,serialize($washere));
						fclose($fop);
					}
				}
				unset($userinfo["$lnick"]);
				if($showdebug == true){
					sendserv("PRIVMSG $debugchannel :User $nick quit. Terminating userinfo, removing from all channels.");
				}
			}
			if ($e[1] == "KICK") {
				$xing = explode("!",$e[0]);
				$zing = $xing[0];
				$knick = substr($zing,1);
				$cchan = strtolower($e[2]);
				$nnick = $e[3];
				if ($nnick == $botnick) {
					sendserv("JOIN $cchan");
					sendserv("PRIVMSG $debugchannel :$knick kicked me from $cchan");
				}
				$lnick = strtolower($e[3]);
				$nexttime = time() + 10;
				$timcount = count($dltimer["$nexttime"]) + 1;
				$dltimer["$nexttime"][$timcount] = "DYNLIMIT $cchan";
				unset($chans["$cchan"]["users"]["$lnick"]);
				global $userinfo;
				$uauth = strtolower($userinfo["$lnick"]["auth"]);

				$fop = fopen("./conf/lastseen.txt","r+t");
				while ($fra = fgets($fop)) {
					$fra = str_replace("\r","",$fra);
					$fra = str_replace("\n","",$fra);
					$temp .= $fra;
				}
				fclose($fop);

				$washere = unserialize($temp);
				$washere[$cchan][$uauth] = time();

				$fop = fopen("./conf/lastseen.txt","w+t");
				fwrite($fop,serialize($washere));
				fclose($fop);

				if ($nnick == $botnick) {
					foreach ($chans["$cchan"]["users"] as $unick => $uarray) {
						$ucf = 0;
						foreach ($chans as $cnam => $cnarray) {
							if ($chans["$cnam"]["users"]["$unick"] != "") {
								$ucf++;
							}
						}
						if ($ucf == 1) {
							if($showdebug == true){
								sendserv("PRIVMSG $debugchannel :User $unick not found on any channel. Terminating userinfo.");
							}
							unset($userinfo["$unick"]);
						}
					}
					unset($chans["$cchan"]);
				}

				$ucf = 0;
				foreach ($chans as $cname => $sarray) {
					if ($chans["$cname"]["users"]["$lnick"] != "") {
						$ucf++;
					}
				}
				if ($ucf == 0) {
				if($showdebug == true){
					sendserv("PRIVMSG $debugchannel :User $e[3] not found on any channel. Terminating userinfo.");
				}
				unset($userinfo["$lnick"]);
				}
			}
			if ($e[1] == "311") {
				$lnick = strtolower($e[3]);
				$userinfo["$lnick"]["nick"] = "$e[3]";
				$userinfo["$lnick"]["ident"] = "$e[4]";
				$userinfo["$lnick"]["host"] = "$e[5]";
				$userinfo["$lnick"]["real"] = substr($mdata,strlen($e[0]." ".$e[1]." ".$e[2]." ".$e[3]." ".$e[4]." ".$e[5]." ".$e[6]." :"));
			}
			if ($e[1] == "NICK") {
				$nick = getnick($e[0]);
				$newnick = $e[2];
				if ($newnick[0] == ":") {
					$newnick = substr($newnick,1);
				}
				if ($nick == $botnick) {
					$botnick = $newnick;
				}
				$lnick = strtolower($nick);
				$lnnick = strtolower($newnick);
				foreach ($chans as $cname => $csarray) {
					if ($chans["$cname"]["users"]["$lnick"] != "") {
						$temp = $chans["$cname"]["users"]["$lnick"];
						unset($chans["$cname"]["users"]["$lnick"]);
						$chans["$cname"]["users"]["$lnnick"] = $temp;
						unset($temp);
					}
				}
				$temp = $userinfo["$lnick"];
				unset($userinfo["$lnick"]);
				$userinfo["$lnnick"] = $temp;
				unset($temp);
				$userinfo["$lnnick"]["nick"] = $newnick;
			}
			if ($e[1] == "330") {
				$lnick = strtolower($e[3]);
				$userinfo["$lnick"]["auth"] = "$e[4]";
			}
			if ($e[1] == "318") {
				$nick = $e[3];
				$lnick = strtolower($e[3]);
				foreach ($waitfor["$lnick"] as $wfnum => $wfact) {
					$wfa = explode(" ",$wfact);
					if ($wfa[0] == "JOIN") {
						join_event($nick,$wfa[1],$wfa);
					}
					elseif ($wfa[0] == "CMD") {
						$command = $wfa[1];
						$nick = $wfa[2];
						$ident = $wfa[3];
						$host = $wfa[4];
						$callchan = $wfa[5];
						$target = $wfa[6];
						$params = substr($wfact,strlen($wfa[0]." ".$wfa[1]." ".$wfa[2]." ".$wfa[3]." ".$wfa[4]." ".$wfa[5]." ".$wfa[6]." "));
						cmd_parser($nick,$ident,$host,$command,$callchan,$target,$params);
						$sendwith = -1;
					}
					unset($waitfor["$lnick"][$wfnum]);
				}
				$ucf = 0;
				foreach ($chans as $cname => $sarray) {
					if ($chans["$cname"]["users"]["$lnick"] != "") {
						$ucf++;
					}
				}
				if ($ucf == 0) {
					if($showdebug == true){
						sendserv("PRIVMSG $debugchannel :User $e[3] not found on any channel. Terminating userinfo.");
					}
					unset($userinfo["$lnick"]);
				}
			}
			if ($e[1] == "401") {
				$lnick = strtolower($e[3]);
				$userinfo["$lnick"]["unknown"] = "1";
			}
			if ($e[1] == "JOIN") {
				$chan = $e[2];
				if ($chan[0] == ":") {
					$chan = substr($chan,1);
				}
				$tchan = strtolower($chan);
				$nexttime = time() + 10;
				$timcount = count($dltimer["$nexttime"]) + 1;
				$dltimer["$nexttime"][$timcount] = "DYNLIMIT $chan";
				$cnam = strtolower($chan);
				$nick = getnick($e[0]);
				$ident = getident($e[0]);
				$host = gethost($e[0]);


				$car = "";
				$bfop = fopen("./conf/bans.conf","r+t");
				while ($fra = fgets($bfop)) {
					$fra = str_replace("\r","",$fra);
					$fra = str_replace("\n","",$fra);
					$frg = explode(" ",$fra);
					if ($frg[0] == "-") {
						$car = $frg[1];
					}
					elseif ($fra == "") {
					}
					else {
						if ($car == $tchan) {
							if (fnmatch(bmask(strtolower($frg[0])),strtolower($nick."!".$user."@".$host))) {
								$anick = $frg[1];
								$reason = substr($fra,strlen("$frg[0] $frg[1] $frg[2] "));
								sendserv("MODE $chan +b $frg[0]");
								sendserv("KICK $chan $nick :($anick) $reason");
							}
						}
					}
				}
				fclose($bfop);


				if ($nick == $botnick) {
					sendserv("WHO $chan %cnauhf");
					sendserv("WHO $chan %cnauhf");
					sendserv("MODE $chan");
				}
				$chans["$cnam"]["name"] = str_replace("\r\n","",$chan);
				$lnick = strtolower($nick);
				$chans["$cnam"]["users"]["$lnick"] = "-";
				$userinfo["$lnick"]["nick"] = $nick;
				$userinfo["$lnick"]["ident"] = $ident;
				$userinfo["$lnick"]["host"] = $host;
				if ($userinfo["$lnick"]["auth"] == "") {
					$wfc = count($waitfor["$lnick"]) + 1;
					$waitfor["$lnick"][$wfc] = "JOIN $chan";
					sendserv("WHOIS $nick");
				} else {
					$wfa = array(0 => "JOIN", 1 => "$chan");
					join_event($lnick, $chan, $wfa);
				}
			}
			if ($e[1] == "005") {
				$netdpar = NULL;
				$xi = 3;
				while ($e[$xi]) {
					if ($e[$xi] != ":are" && $e[$xi] != "supported" && $e[$xi] != "by" && $e[$xi] != "this" && $e[$xi] != "server") {
						$netdpar = explode("=",$e[$xi]);
						$netdata[$netdpar[0]] = $netdpar[1];
					}
					$xi++;
				}
			}
			if ($e[1] == "001") {
				$botnick = $e[2];
				sendserv("MODE ".$botnick." +".$botmodes);
				if ($autojoin == 1) {
					$fop = fopen("./conf/users.conf","r+t");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$fgr = explode(" ",$fra);
						if ($fgr[0] == "-") {
							if ($fgr[4] != "") {
								sendserv("JOIN $fgr[4]");
							} else {
								sendserv("JOIN $fgr[1]");
							}
						}
					}
					fclose($fop);
				}
				$stime = time();
			}
			if ($e[1] == "NOTICE") {
				if (stristr($mdata, ":Your connection class is:") == true) {
					$class=explode(":",$mdata);
					$class=str_replace(" ","",$class[3]);
					$netdata["class"]=$class;
				}
				if (stristr($mdata, ":You have no channel number limitation.") == true) {
					$maxchannels = "No Limit";
					$netdata['MAXCHANNELS']=$maxchannels;
				} elseif (stristr($mdata, ":You may join") == true) {
					$maxchannels = explode(":You may join ",$mdata);
					$maxchannels = explode(" channels.",$maxchannels[1]);
					$maxchannels = $maxchannels[0];
					$netdata['MAXCHANNELS']=$maxchannels;
				}
				$nick = getnick($e[0]);
				$msg = str_replace("\002","",unspacer(substr($mdata,strlen($e[0]." ".$e[1]." ".$e[2]." :"))));
				$mm = explode(" ",$msg);
				if (strtolower($nick) == "authserv") {
					if ($mm[0] == "Account") {
						if ($mm[3] == "not" && $mm[5] == "registered.") {
							$thisacc = $mm[1];
							unset($newusers[$mm[1]]); //  The account isn't registered, don't take care.
							sendserv("NOTICE $takelistnick :\002Error\002: Account \002$mm[1]\002 is not registered.");
						} else {
							$thisacc = substr($mm[3],0,(strlen($mm[3])-1));
							foreach ($newusers as $aname => $aaxs) {
								if (strtolower($aname) == strtolower($thisacc)) {
									unset($newusers[$aname]);
									$newusers[$thisacc] = $aaxs;
								}
							}
						}
						if (strtolower($thisacc) == strtolower($lastacc)) {
							foreach ($newusers as $aname => $aaxs) {
								if (addChanUser($takelistchan,$aname,$aaxs) == "Ok") {
									sendserv("NOTICE $takelistnick :$aname has been added to the $takelistchan user list with access \002$aaxs\002.");
								}
								else {
									unset($newusers[$aname]);
								}
							}
							sendserv("NOTICE $takelistnick :Userlist synchronized successfully."); // Yeah, we did it!!
							sendserv("NOTICE $takelistnick :Added \002".count($newusers)."\002 users to the userlist of $takelistchan.");
							$takelista = "false";
							$takelistnick = "";
							$takelistchan = "";
							$tln = "";
							unset($newusers);
						}
					}
				}
				if (validaccess($mm[0]) != "") {
					if ($takelist == $nick) {
						$newusers[$mm[1]] = validaccess($mm[0]);
						$takelista = "true";
					}
				}
				else {
					if ($takelista == "true" && $takelist == $nick) {
						foreach ($newusers as $aname => $aaxs) {
							sendserv("AS ACCOUNTINFO *$aname");
							$lastacc = $aname;
						}
						$takelist = ""; // Interrupt new TAKELIST entries
					}
				}
			}
			if ($e[1] == "PRIVMSG" && $e[3][1] == "\001") {#
				$nick = getnick($e[0]);
				if ($e[3] == ":\001VERSION\001") {
					if (empty($bversion)) {
						sendserv("NOTICE $nick :\001VERSION NexusServ v$bofficial ($bcodename)\001");
					}
					else {
						sendserv("NOTICE $nick :\001VERSION NexusServ v$bofficial ($bcodename-$bversion)\001");
					}
				}
				if ($e[3] == ":\001CHAT\001") {
					sendserv("NOTICE $nick :\001CHAT This bot is not an eggdrop.\001");
				}
				if ($e[3] == ":\001TIME\001") {
					sendserv("NOTICE $nick :\001TIME ".date("D M d H:i:s Y")."\001");
				}
				if ($e[3] == ":\001FINGER\001") {
					sendserv("NOTICE $nick :\001FINGER Stop fingering a bot, man!\001");
				}
				if ($e[3] == ":\001UPTIME\001") {
					sendserv("NOTICE $nick :\001UPTIME ".time2str(time() - $stime)."\001");
				}
				if ($e[3] == ":\001PING") {
					$ping = ($e[4] - (60*60*1337 + 42*60));
					sendserv("NOTICE $nick :\001PING ".$ping."\001");
				}
			}
			elseif ($e[1] == "PRIVMSG") {
				if ($e[2][0] == "#") {
					$nick = getnick($e[0]);
					$lnick = strtolower($nick);
					$ident = getident($e[0]);
					$host = gethost($e[0]);
					$msg = substr($mdata,strlen($e[0]." ".$e[1]." ".$e[2]." :"));
					$mm = explode(" ",$msg);
					$mmg = substr($msg,1); 
					$tchan = strtolower($e[2]);
					$uauth = $userinfo[strtolower($nick)]['auth'];
					$atrig = '';
					$tsets = array();
					$fop = fopen("./conf/settings.conf","r+t");
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
					$fop = fopen("./conf/users.conf","r+t");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
						$area = $frg[1];
						}
						else {
							if ($area == $tchan) {
								if ($frg[0] == $uauth) {
									$axs = $frg[1];
								}
								$cfound = 1;
							}
						}
					}
					fclose($fop);
					$atrig = $tsets['trigger'];
					if ($atrig == "") {
						$atrig = $trigger;
					}
					if ($tsets["watchdogexceptlevel"] == "") {
						$tsets["watchdogexceptlevel"] = "200";
					}
					if (binsetting($tsets["watchdog"]) == "On") {
						foreach ($mm as $text) {
							$wfop = fopen('watchdog.txt','r+t');
							while ($wfr = fgets($wfop)) {
								$wfr = str_replace("\r","",$wfr);
								$wfr = str_replace("\n","",$wfr);
								$wfr = str_replace("]","\\]",$wfr);
								$wfr = str_replace("[","\\[",$wfr);
								$nopunish = 0;
								if (fnmatch(strtolower($wfr),strtolower($text)) && $axs < $tsets["watchdogexceptlevel"]) {
									if (binsetting($tsets["watchdogscanops"]) == "Off" && isop(strtolower($nick),$tchan)) {
										$nopunish = 1;
									}
									if (binsetting($tsets["watchdogscanvoiced"]) == "Off" && isvoice(strtolower($nick),$tchan)) {
										$nopunish = 1;
									}
										if (binsetting($tsets["watchdogscanregular"]) == "Off" && isvoice(strtolower($nick),$tchan) == false && isop(strtolower($nick),$tchan) == false) {
										$nopunish = 1;
									}
									if ($nopunish == 0) {
										sendserv("MODE $tchan -ov+b $nick $nick $host");
										sendserv("KICK $tchan $nick :Watchdog: Illegal word/url found.");
									}
								}
							}
							fclose($wfop);
						}
					}
					if ($mm[0][0] == $atrig && $axs < $tsets["pubcmd"]) {
						$atrig = str_repeat("?",145);
						sendserv("NOTICE $nick :Public commands are restricted in \002".$e[2]."\002.");
					}
					if ($mm[0][0] == $atrig) {
						if ($mm[0][1] == "#") {
							$targetchan = substr($mm[0],1);
							$command = $mm[1];
							$params = substr($msg,strlen($mm[0]." ".$mm[1]." "));
							$ttchan = strtolower($targetchan);
							if (@($chans["$ttchan"]["name"]) == "" && $bn_cs != 0) {
								foreach ($bnclients as $cnum => $csock) {
									$csparams = "";
									$csparams .= 'PCHAN '.$targetchan.' $userinfo["'.addslashes($lnick).'"]["auth"] = "'.addslashes($userinfo[$lnick]["auth"]).'"; ';
									$csparams .= '$userinfo["'.addslashes($lnick).'"]["nick"] = "'.addslashes($nick).'"; ';
									$csparams .= '$userinfo["'.addslashes($lnick).'"]["ident"] = "'.addslashes($ident).'"; ';
									$csparams .= '$userinfo["'.addslashes($lnick).'"]["host"] = "'.addslashes($host).'"; ';
									$csparams .= '$waitfor["'.addslashes($lnick).'"][] = "'.addslashes("CMD $command $nick $ident $host $e[2] $targetchan $params").'"; ';
									$csparams .= 'global $socket; socket_write($socket,"WHOIS '.addslashes($lnick).'\r\n");'."\r\n";
									socket_write($csock,$csparams);
								}
							}
							else {
								if ($userinfo["$lnick"]["auth"] != "") {
									cmd_parser($nick,$ident,$host,$command,$e[2],$targetchan,$params);
								}
								else {
									$wfc = count($waitfor["$lnick"]) + 1;
									$waitfor["$lnick"][$wfc] = "CMD $command $nick $ident $host $e[2] $targetchan $params";
									sendserv("WHOIS $nick");
								}
							}
						}
						elseif ($mm[1][0] == "#") {
							$targetchan = $mm[1];
							$command = substr($mm[0],1);
							$params = substr($msg,strlen($mm[0]." ".$mm[1]." "));
							$ttchan = strtolower($targetchan);
							if (@($chans["$ttchan"]["name"]) == "" && $bn_cs != 0) {
								foreach ($bnclients as $cnum => $csock) {
									$csparams = "";
									$csparams .= 'PCHAN '.$targetchan.' $userinfo["'.addslashes($lnick).'"]["auth"] = "'.addslashes($userinfo[$lnick]["auth"]).'"; ';
									$csparams .= '$userinfo["'.addslashes($lnick).'"]["nick"] = "'.addslashes($nick).'"; ';
									$csparams .= '$userinfo["'.addslashes($lnick).'"]["ident"] = "'.addslashes($ident).'"; ';
									$csparams .= '$userinfo["'.addslashes($lnick).'"]["host"] = "'.addslashes($host).'"; ';
									$csparams .= '$waitfor["'.addslashes($lnick).'"][] = "'.addslashes("CMD $command $nick $ident $host $e[2] $targetchan $params").'"; ';
									$csparams .= 'global $socket; socket_write($socket,"WHOIS '.addslashes($lnick).'\r\n");'."\r\n";
									socket_write($csock,$csparams);
								}
							}
							else {
								if ($userinfo["$lnick"]["auth"] != "") {
									cmd_parser($nick,$ident,$host,$command,$e[2],$targetchan,$params);
								}
								else {
									$wfc = count($waitfor["$lnick"]) + 1;
									$waitfor["$lnick"][$wfc] = "CMD $command $nick $ident $host $e[2] $targetchan $params";
									sendserv("WHOIS $nick");
								}
							}
						}
						else {
							$targetchan = $e[2];
							$command = substr($mm[0],1);
							$params = substr($msg,strlen($mm[0]." "));
							$ttchan = strtolower($targetchan);
							if (@($chans["$ttchan"]["name"]) == "" && $bn_cs != 0) {
								foreach ($bnclients as $cnum => $csock) {
									$csparams = "";
									$csparams .= 'PCHAN '.$targetchan.' $userinfo["'.addslashes($lnick).'"]["auth"] = "'.addslashes($userinfo[$lnick]["auth"]).'"; ';
									$csparams .= '$userinfo["'.addslashes($lnick).'"]["nick"] = "'.addslashes($nick).'"; ';
									$csparams .= '$userinfo["'.addslashes($lnick).'"]["ident"] = "'.addslashes($ident).'"; ';
									$csparams .= '$userinfo["'.addslashes($lnick).'"]["host"] = "'.addslashes($host).'"; ';
									$csparams .= '$waitfor["'.addslashes($lnick).'"][] = "'.addslashes("CMD $command $nick $ident $host $e[2] $targetchan $params").'"; ';
									$csparams .= 'global $socket; socket_write($socket,"WHOIS '.addslashes($lnick).'\r\n");'."\r\n";
									socket_write($csock,$csparams);
								}
							}
							else {
								if ($userinfo["$lnick"]["auth"] != "") {
									cmd_parser($nick,$ident,$host,$command,$e[2],$targetchan,$params);
								}
								else {
									$wfc = count($waitfor["$lnick"]) + 1;
									$waitfor["$lnick"][$wfc] = "CMD $command $nick $ident $host $e[2] $targetchan $params";
									sendserv("WHOIS $nick");
								}
							}
						}
					}
				}
				else {
					$nick = getnick($e[0]);
					$lnick = strtolower($nick);
					$ident = getident($e[0]);
					$host = gethost($e[0]);
					$msg = substr($mdata,strlen($e[0]." ".$e[1]." ".$e[2]." :"));
					$mm = explode(" ",$msg);
					if ($mm[0][0] == "#") {
						$targetchan = $mm[0];
						$command = $mm[1];
						$params = substr($msg,strlen($mm[0]." ".$mm[1]." "));
						$ttchan = strtolower($targetchan);
						if (@($chans["$ttchan"]["name"]) == "" && $bn_cs != 0) {
							foreach ($bnclients as $cnum => $csock) {
								$csparams = "";
								$csparams .= 'PCHAN '.$targetchan.' $userinfo["'.addslashes($lnick).'"]["auth"] = "'.addslashes($userinfo[$lnick]["auth"]).'"; ';
								$csparams .= '$userinfo["'.addslashes($lnick).'"]["nick"] = "'.addslashes($nick).'"; ';
								$csparams .= '$userinfo["'.addslashes($lnick).'"]["ident"] = "'.addslashes($ident).'"; ';
								$csparams .= '$userinfo["'.addslashes($lnick).'"]["host"] = "'.addslashes($host).'"; ';
								$csparams .= '$waitfor["'.addslashes($lnick).'"][] = "'.addslashes("CMD $command $nick $ident $host $e[2] $targetchan $params").'"; ';
								$csparams .= 'global $socket; socket_write($socket,"WHOIS '.addslashes($lnick).'\r\n");'."\r\n";
								socket_write($csock,$csparams);
							}
						}
						else {
							if ($userinfo["$lnick"]["auth"] != "") {
								cmd_parser($nick,$ident,$host,$command,$e[2],$targetchan,$params);
							}
							else {
								$wfc = count($waitfor["$lnick"]) + 1;
								$waitfor["$lnick"][$wfc] = "CMD $command $nick $ident $host $e[2] $targetchan $params";
								sendserv("WHOIS $nick");
							}
						}
					}
					elseif ($mm[1][0] == "#") {
						$targetchan = $mm[1];
						$command = $mm[0];
						$params = substr($msg,strlen($mm[0]." ".$mm[1]." "));
						$ttchan = strtolower($targetchan);
						if (@($chans["$ttchan"]["name"]) == "" && $bn_cs != 0) {
							foreach ($bnclients as $cnum => $csock) {
								$csparams = "";
								$csparams .= 'PCHAN '.$targetchan.' $userinfo["'.addslashes($lnick).'"]["auth"] = "'.addslashes($userinfo[$lnick]["auth"]).'"; ';
								$csparams .= '$userinfo["'.addslashes($lnick).'"]["nick"] = "'.addslashes($nick).'"; ';
								$csparams .= '$userinfo["'.addslashes($lnick).'"]["ident"] = "'.addslashes($ident).'"; ';
								$csparams .= '$userinfo["'.addslashes($lnick).'"]["host"] = "'.addslashes($host).'"; ';
								$csparams .= '$waitfor["'.addslashes($lnick).'"][] = "'.addslashes("CMD $command $nick $ident $host $e[2] $targetchan $params").'"; ';
								$csparams .= 'global $socket; socket_write($socket,"WHOIS '.addslashes($lnick).'\r\n");'."\r\n";
								socket_write($csock,$csparams);
							}
						}
						else {
							if ($userinfo["$lnick"]["auth"] != "") {
								cmd_parser($nick,$ident,$host,$command,$e[2],$targetchan,$params);
							}
							else {
								$wfc = count($waitfor["$lnick"]) + 1;
								$waitfor["$lnick"][$wfc] = "CMD $command $nick $ident $host $e[2] $targetchan $params";
								sendserv("WHOIS $nick");
							}
						}
					}
					else {
						$targetchan = "-";
						$command = $mm[0];
						$params = substr($msg,strlen($mm[0]." "));
						$ttchan = strtolower($targetchan);
						if ($userinfo["$lnick"]["auth"] != "") {
							cmd_parser($nick,$ident,$host,$command,$e[2],$targetchan,$params);
						}
						else {
							$wfc = count($waitfor["$lnick"]) + 1;
							$waitfor["$lnick"][$wfc] = "CMD $command $nick $ident $host $e[2] $targetchan $params";
							sendserv("WHOIS $nick");
						}
					}
				}
			}
		}
	}
}

function cmd_parser ($nick, $user, $host, $command, $cchan, $target, $params) {
	$lnick = strtolower($nick);
	global $isev, $userinfo;
	$cf = 0;
	$fopa = fopen("./conf/bind.conf","r+t");
	while ($fra = fgets($fopa)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$fgr = explode(" ",$fra);
		if (strtolower($fgr[0]) == strtolower($command)) {
			$cmdparams = substr("$fra",strlen("$fgr[0] $fgr[1] "));
			if ($command != "events") {
				$fopb = fopen("./conf/events.log","a+t");
				fwrite($fopb,"\r\n".strtolower($target)." ".time()." ".$nick."?".$userinfo["$lnick"]["auth"]." $command $params");
				fclose($fopb);
			}
			call_user_func("bot_".$fgr[1],$nick,$user,$host,$cchan,$target,$cmdparams.$params);
			$cf = 1;
		}
	}
	fclose($fopa);
	if ($cf == 0 && $cchan[0] != "#") {
		sendserv("NOTICE $nick :\002$command\002 is an unknown command.");
	}
}

function bot_mod_mod ($nick,$user,$host,$cchan,$target,$params) {
	global $modules;
	$pp = explode(" ",$params,2);
	$modbase = $pp[0];
	$paramzz = $pp[1];
	eval($modules["./cmd/".$modbase.".cmd"]);
}

function bmask ($line) { // Escapes patterns
	$ine = str_replace("]","\\]",$line);
	$ine = str_replace("[","\\[",$ine);
	return($ine);
}

function breason ($line) {
	if ($line == "") {
		return("Bye.");
	}
	else {
		return($line);
	}
}

function b_expiry ($line) {
	if ($line == "p") {
		return("Never");
	}
	else {
		return(time2str($line - time()));
	}
}

function strsetting ($val) {
	if ($val == "") {
		return("None");
	}
	else {
		return($val);
	}
}

function binsetting ($val) {
	if ($val == "" or $val == "0") {
		return("Off");
	}
	else {
		return("On");
	}
}

function asetting ($val) {
	if ($val == "") {
		return("0");
	}
	else {
		return($val);
	}
}

function a2setting ($val) {
	if ($val == "" || $val == "0") {
		return("0 - Off.");
	}
	else {
		return($val);
	}
}

function getnick ($line) {
	$x = explode("!",$line);
	return(substr($x[0],1));
}

function getident ($line) {
	$x = explode("!",$line);
	$y = explode("@",$x[1]);
	return($y[0]);
}

function gethost ($line) {
	$x = explode("@",$line);
	return($x[1]);
}

function spaces ($x,$y) {
	return(str_repeat(" ",$y - strlen($x)));
}

function senddata () {
	$list_arg = func_get_args();
	$x = 0;
	while ($list_arg[$x] != "") {
		if ($x > 0) {
			$message .= " ";
		}
		$message .= $list_arg[$x];
		$x++;
	}
	sendserv("$message");
}

function send_privmsg () {
	$list_arg = func_get_args();
	$target = $list_arg[0];
	unset($list_arg[0]);
	sendserv("PRIVMSG $target :".implode($list_arg));
}

function sendserv_dump ($line) {
	$lineex = explode(" ",$line);
	if ($lineex[0] == "PRIVMSG") {
		if ($lineex[2][0] != ":") {
			echo("\0034ERROR:\003 PRIVMSG <TARGET> \002:\002<MESSAGE>\n");
			return(0);
		}
		if ($lineex[1] == "") {
			echo("\0034ERROR:\003 PRIVMSG \002<TARGET>\002 :<MESSAGE>\n");
			return(0);
		}
	}
	sendserv($line);
	echo("Okay.");
}

function sendserv ($line) {
	global $socket, $floodtime, $flood, $bnclients, $sendwith;
	$fopi = fopen("./conf/aset.conf","r+t");
	while ($fro = fgets($fopi)) {
		$fro = str_replace("\r","",$fro);
		$fro = str_replace("\n","",$fro);
		$aset = unserialize($fro);
	}
	fclose($fopi);
	$fopi = fopen("./conf/aset.conf","w+t");
	fwrite($fopi,serialize($aset));
	fclose($fopi);
	$laine = explode(" ",$line);
	if ($laine[0] == "NOTICE") {
		global $userinfo;
		$uauth = $userinfo[strtolower($laine[1])]['auth'];
		if ($aset[strtolower($uauth)]['privmsg'] == 1) {
		$line = "PRIVMSG ".substr($line,strlen("NOTICE "));
		}
	}
	$linez = $line."\n";
	global $glob;
	$glob['dat_out'] = $glob['dat_out'] + strlen($line);
	fwrite($socket,$linez);
}

function parse_modes ($sender, $target, $modes) {
	global $chans, $userinfo, $botnick;
	$chan = strtolower($target);
	$exclmodes = "";
	$inclmodes = "";
	$category = "";
	$pnum = -1;
	$modeR = explode(" ",$modes);
	$modeset = $modeR[0];
	$modeparams = explode(" ",substr($modes,strlen($modeR[0]." ")));
	$x = 0;
	while ($mode = $modeset{$x}) {
		if ($mode == "+") {
			$category = "incl";
		}
		elseif ($mode == "-") {
			$category = "excl";
		}
		else {
			if ($category == "incl") {
				if ($mode == "k") {
					$chans["$chan"]["modes"] .= "k";
					$pnum++;
					$chans["$chan"]["key"] = $modeparams[$pnum];
					protect_modes($sender,$target,"+k",$modeparams[$pnum]);
				}
				elseif ($mode == "o") {
					$pnum++;
					$lnick = strtolower($modeparams[$pnum]);
					$chans["$chan"]["users"]["$lnick"] .= "@";
					if ($lnick == strtolower($botnick)) {
						sendserv("MODE $chan +v $botnick");
						sendserv("MODE $chan");
						sendserv("MODE $chan +b");
					}
					protect_modes($sender,$target,"-o",$lnick);
				}
				elseif ($mode == "b") {
				}
				elseif ($mode == "v") {
					$pnum++;
					$lnick = strtolower($modeparams[$pnum]);
					$chans["$chan"]["users"]["$lnick"] .= "+";
					protect_modes($sender,$target,"+v",$lnick);
				}
				elseif ($mode == "l") {
					if (str_replace("l","",$chans["$chan"]["modes"]) == $chans["$chan"]["modes"]) {
						$chans["$chan"]["modes"] .= "l";
					}
					$pnum++;
					$chans["$chan"]["limit"] = $modeparams[$pnum];
					protect_modes($sender,$target,"+l",$modeparams[$pnum]);
				}
				else {
					$chans["$chan"]["modes"] .= $mode;
				}
			}
			elseif ($category == "excl") {
				if ($mode == "k") {
					$chans["$chan"]["modes"] = str_replace("k","",$chans["$chan"]["modes"]);
					$pnum++;
					$chans["$chan"]["key"] = "";
					protect_modes($sender,$target,"-k","");
				}
				elseif ($mode == "b") {
				}
				elseif ($mode == "o") {
					$pnum++;
					$lnick = strtolower($modeparams[$pnum]);
					$chans["$chan"]["users"]["$lnick"] = str_replace("@","",$chans["$chan"]["users"]["$lnick"]);
					if ($lnick == strtolower($botnick)) {
						sendserv("PRIVMSG $target :I have been deopped. Please use \002opchan\002 to reop me.");
						global $bnclients;
						foreach ($bnclients as $cnum => $csock) {
							socket_write($csock,"RAW MODE $chan +o $botnick\r\n");
						}
					}
					global $userinfo;
					$lbotnick = strtolower($botnick);
					if ($userinfo["$lnick"]["auth"] == $userinfo["$lbotnick"]["auth"]) {
						sendserv("MODE $chan +o $lnick");
						global $bnclients;
						foreach ($bnclients as $cnum => $csock) {
							socket_write($csock,"RAW MODE $chan +o $lbotnick\r\n");
						}
					}
					protect_modes($sender,$target,"-o",$lnick);
				}
				elseif ($mode == "v") {
					$pnum++;
					$lnick = strtolower($modeparams[$pnum]);
					$chans["$chan"]["users"]["$lnick"] = str_replace("+","",$chans["$chan"]["users"]["$lnick"]);
					protect_modes($sender,$target,"-v",$lnick);
				}
				elseif ($mode == "l") {
					$chans["$chan"]["modes"] = str_replace("l","",$chans["$chan"]["modes"]);
					$chans["$chan"]["limit"] = "";
					protect_modes($sender,$target,"-l","");
				}
				else {
					$chans["$chan"]["modes"] = str_replace("$mode","",$chans["$chan"]["modes"]);
				}
			}
		}
		$x++;
	}
	protect_execute($target);
}

function protect_modes ($sender, $target, $mode, $mtarget) {
	// TODO: Create protection & Mode Lock Check Array
}

function protect_execute ($target) {
	// TODO: Execute contents of MODE LOCK and USER PROTECTION array
}

function create_timer ($time, $line) {
	if (str2time($time) == "I") {
		if($showdebug == true){
			sendserv("PRIVMSG $debugchannel :create_timer() invalid: timespan $time is not valid.");
		}
		return(0);
	}
	global $dltimer;
	$ttime = time() + str2time($time);
	$dlc = count($dltimer[$ttime]) + 1;
	$dltimer[$ttime][$dlc] = $line;
}

function create_timer2 ($time, $line) {
	global $dltimer;
	$ttime = $time;
	$dlc = count($dltimer[$ttime]) + 1;
	$dltimer[$ttime][$dlc] = $line;
}

function timer_evnts ($time, $call) {
	global $dltimer, $chans, $socket;
	foreach ($dltimer["$time"] as $timenum => $timeevnt) {
		$timtime = explode(" ",$timeevnt);
		if ($timtime[0] == "RAW") {
		sendserv(substr($timeevnt,strlen($timtime[0]." ")));
		}
		elseif ($timtime[0] == "DYNLIMIT") {
			$cchan = strtolower($timtime[1]);
			$fop = fopen("./conf/settings.conf","r+t");
			while ($fra = fgets($fop)) {
				$fra = str_replace("\r","",$fra);
				$fra = str_replace("\n","",$fra);
				$frg = explode(" ",$fra);
				if ($frg[0] == "-") {
					$area = $frg[1];
				}
				else {
					if ($area == $cchan) {
						$tsets["$frg[0]"] = substr($fra,strlen($frg[0]." "));
					}
				}
			}
			fclose($fop);
			if ($tsets["dynlimit"] != "" && $tsets["dynlimit"] != "0") {
				$xx = 0;
				foreach ($chans["$cchan"]["users"] as $unick => $ustat) {
					$xx++;
				}
				$xxlimit = $xx + $tsets["dynlimit"];
				sendserv("MODE ".$chans["$cchan"]["name"]." +l $xxlimit");
			}
			unset($tsets);
		}
		unset($dltimer["$time"][$timenum]);
	}
}

function staffname ($account) {
	global $staffl;
	$fop = fopen("./conf/staff.conf","r+t");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == $account) {
			$intname = $staffl["$frg[2]"];
			$epithet = substr($fra,strlen("$frg[0] $frg[1] $frg[2] "));
			if ($epithet == "") {
				if ($frg[2] < 3) {
					$epithet = "a wannabe tyrant";
				}
				else {
					$epithet = "a megalomaniacal power hungry tyrant";
				}
			}
		}
	}
	fclose($fop);
	if ($epithet != "") {
		return("$account is $epithet ($intname)");
	}
	else {
		return("");
	}
}

function staffstat ($account) {
	global $staffl;
	$fop = fopen("./conf/staff.conf","r+t");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == $account) {
			$intname = $staffl["$frg[2]"];
			$epithet = substr($fra,strlen("$frg[0] $frg[1] $frg[2] "));
			if ($epithet == "") {
				if ($frg[2] < 3) {
					$epithet = "a wannabe tyrant";
				}
				else {
					$epithet = "a megalomaniacal power hungry tyrant";
				}
			}
		}
	}
	fclose($fop);
	if ($epithet != "") {
		return("$intname");
	}
	else {
		return("");
	}
}

function join_event ($nick, $chan, $wfa) {
	global $chans, $userinfo, $botnick;
	$lnick = strtolower($nick);
	unset($tsets);
	$tlchan = strtolower($chan);
	$area = "";
	$fop = fopen("./conf/settings.conf","r+t");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
		}
		else {
			if ($area == strtolower($wfa[1])) {
				$tsets["$frg[0]"] = substr($fra,strlen($frg[0]." "));
			}
		}
	}
	if ($tsets["showclones"] == "1") {
		$tlchan = strtolower("$wfa[1]");
		$clones = "";
		$cn = 0;
		foreach ($chans["$tlchan"]["users"] as $unick => $ustat) {
			if ($userinfo["$unick"]["auth"] == $userinfo["$lnick"]["auth"] && $userinfo["$unick"]["auth"] != "") {
				$clones .= $userinfo["$unick"]["nick"]." ";
				$cn++;
			}
		}
		if ($cn > 1) {
			sendserv("PRIVMSG $wfa[1] :Clones found: $clones");
		}
	}
	fclose($fop);
	if ($tsets["giveops"] == "") {
		$tsets["giveops"] = "200";
	}
	if ($tsets["givevoice"] == "") {
		$tsets["givevoice"] = "100";
	}
	$autoinvite = 0;
	$noamodes = 0;
	$setinfo = "";
	$axs = "0";
	$fop = fopen("./conf/users.conf","r+t");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$fgr = explode(" ",$fra);
		if ($fgr[0] == "-") {
		$area = $fgr[1];
		}
		else {
			if ($area == strtolower($wfa[1])) {
				if (strtolower($fgr[0]) == strtolower($userinfo["$lnick"]["auth"])) {
					$axs = $fgr[1];
					$autoinvite = $fgr[2];
					$noamodes = $fgr[3];
					$infos = unserialize(substr($fra,strlen("$fgr[0] $fgr[1] $fgr[2] $fgr[3] ")));
				}
			}
		}
	}
	fclose($fop);
	$uauth = strtolower($userinfo["$lnick"]["auth"]);

	$fop = fopen("./conf/lastseen.txt","r+t");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$temp .= $fra;
	}
	fclose($fop);

	$washere = unserialize($temp);
	$washere[$tlchan][$uauth] = time();

	$fop = fopen("./conf/lastseen.txt","w+t");
	fwrite($fop,serialize($washere));
	fclose($fop);

	if ($axs >= $tsets["giveops"] && binsetting($noamodes) != "On") {
		sendserv("MODE $wfa[1] +o $lnick");
	}
	elseif ($axs >= $tsets["givevoice"] && binsetting($noamodes) != "On") {
		sendserv("MODE $wfa[1] +v $lnick");
	}
	if ($infos['info'] != "") {
		sendserv("PRIVMSG $wfa[1] :[".$userinfo["$lnick"]["nick"]."] ".$infos['info']);
	}
	if ($tsets["usergreeting"] != "") {
		if (asetting($axs) > 0) {
			$sendgreeting = $tsets["usergreeting"];
		}
	}
	if ($tsets["greeting"] != "") {
		if (asetting($axs) == 0 or $tsets["usergreeting"] == "") {
			$sendgreeting = $tsets["greeting"];
		}
	}
	if ($sendgreeting != "") {
		$gr = $sendgreeting;
		$grsend = "NOTICE $nick :";
		$grsend .= "($wfa[1]) ";
		$gr = str_replace('$b',"\002",$gr);
		$gr = str_replace('$c',"\003",$gr);
		$gr = str_replace('$u',chr(31),$gr);
		$gr = str_replace('$B',$GLOBALS['botnick'],$gr);
		$gr = str_replace('$N',$userinfo[$lnick]['nick'],$gr);
		$gr = str_replace('$I',$userinfo[$lnick]['ident'],$gr);
		$gr = str_replace('$H',$userinfo[$lnick]['host'],$gr);
		$gr = str_replace('$i',chr(29),$gr);
		if ($userinfo[$lnick]['auth'] != "") {
			$gr = str_replace('$A',$userinfo[$lnick]['auth'],$gr);
		}
		else {
			$gr = str_replace('$A',"%not_authed%",$gr);
		}
		$gr = str_replace('$a',$axs,$gr);
		$gr = str_replace('$C',$wfa[1],$gr);
		$grsend .= $gr;
		sendserv($grsend);
	}
	$xxx = 0;
	foreach ($chans as $clname => $carray) {
		if ($chans["$clname"]["users"]["$lnick"] != "") {
			$xxx++;
		}
	}
	if ($xxx == 1) {
		foreach ($chans as $clname => $carray) {
			$fop = fopen("./conf/users.conf","r+t");
			while ($fra = fgets($fop)) {
				$fra = str_replace("\r","",$fra);
				$fra = str_replace("\n","",$fra);
				$fgr = explode(" ",$fra);
				if ($fgr[0] == "-") {
					$area = $fgr[1];
				}
				else {
					if ($area == $clname) {
						if (strtolower($fgr[0]) == strtolower($userinfo["$lnick"]["auth"])) {
							$autoinvite = $fgr[2];
							if (binsetting($autoinvite) == "On") {
								sendserv("INVITE $nick ".$chans["$clname"]["name"]);
							}
						}
					}
				}
			}
			fclose($fop);
		}
	}
}

function toyssetting ($val) {
	if ($val == "0" || $val == "") {
		return("0 - Toys are disabled.");
	}
	elseif ($val == "1") {
		return("1 - Toys will reply privately.");
	}
	elseif ($val == "2") {
		return("2 - Toys will reply publicly.");
	}
}

function protsetting ($val) {
	if ($val == "0" || $val == "") {
		return("0 - Everybody will be protected from users of equal or lower access.");
	}
	elseif ($val == "1") {
		return("1 - Users will be protected from users of equal or lower access.");
	}
	elseif ($val == "2") {
		return("2 - Users will be protected from users of lower access.");
	}
	elseif($val == "3") {
		return("3 - Nobody will be protected.");
	}
}

function lseen ($account, $chan) {
	global $userinfo, $chans;
	$fp = fopen("./conf/lastseen.txt","r+t");
	while ($fr = fgets($fp)) {
		$fr = str_replace("\r","",$fr);
		$fr = str_replace("\n","",$fr);
		$temp .= $fr;
	}
	fclose($fp);

	$washere = unserialize($temp);

	foreach ($chans["$chan"]['users'] as $uname => $uperms) {
		if (strtolower($userinfo[$uname]['auth']) == $account) {
			return("Here");
		}
	}
	if ($washere[$chan][$account] == "") {
		return("Never");
	}
	return(time2str(time() - $washere[$chan][$account]));
}

function isop ($nick,$chan) {
	global $chans;
	if (str_replace("@","",$chans[$chan]['users'][$nick]) != $chans[$chan]['users'][$nick]) {
		return true;
	}
	else {
		return false;
	}
}
function isvoice ($nick,$chan) {
	global $chans;
	if (str_replace("+","",$chans[$chan]['users'][$nick]) != $chans[$chan]['users'][$nick]) {
		return true;
	}
	else {
		return false;
	}
}

function modulo_str ($string, $modulo) {
	$i = 0;
	while (substr($string,$i,1)) {
		$myascii = $myascii + ord(substr($string,$i,1));
		$i++;
	}
	return($myascii % $modulo);
}

function quit_bot ($message, $die) {
	sendserv("QUIT :".$message);
	if ($die == true) {
		die();
	}
}

function getArrayFromFile ($file) {
	$fp = fopen($file,"r+t");
	while ($fg = fgets($fp)) {
		$fr .= $fg;
	}
	fclose($fp);
	if (is_array(unserialize($fr))) {
		return(unserialize($fr));
	}
	else {
		echo("\0034ERROR:\003 The content of $file is not a valid array.\n");
	}
}

function print_array ($file,$ret) {
	$ar = getArrayFromFile($file);
	foreach ($ar as $ak => $av) {
		if (is_array($av)) {
			$bla .= "\"".addslashes($ak)."\" ".print_r($av,1);
		}
		else {
			$bla .= "$av\n";
		}
	}
	if ($ret != 1) {
		return($bla);
	}
	else {
		echo($bla);
	}
}

function sendArrayToFile ($file, $array) {
	$fp = fopen($file,"w+t");
	fwrite($fp, serialize($array));
	fclose($fp);
}

function removeMultiSpace ($string) {
	$newstring = "";
	$st = explode(" ",$string);
	foreach ($st as $val) {
		if ($val != "") {
			if ($newstring != "") {
				$newstring .= " ".$val;
			}
			else {
				$newstring = $val;
			}
		}
	}
	return($newstring);
}

function removeMultiSpace160 ($string) {
	$newstring = "";
	$st = explode(chr(160),$string);
	foreach ($st as $val) {
		if ($val != "") {
			if ($newstring != "") {
				$newstring .= " ".$val;
			}
			else {
				$newstring = $val;
			}
		}
	}
	return($newstring);
}

function unspacer ($string) {
	$newstring = "";
	$newstring = utf8_decode($string);
	$newstring = removeMultiSpace160($newstring);
	$newstring = removeMultiSpace($newstring);
	return($newstring);
}

function validaccess ($level) { // for takelist
	if ("$level" == "500") {
		return("499");
	}
	for ($x=1;$x<=500+1;$x++) {
		if ("$level" == "$x") {
			return("$level");
		}
	}
	return(NULL);
}
function vaccess ($level,$maxlvl) { // validates 1 to 500 (for staff - adduser <NAME> 500
	for ($x=1;$x<$maxlvl+1;$x++) {
		if ("$level" == "$x") {
			return("yes");
		}
	}
	return("no");
}

function addChanUser ($chan, $auth, $access) {
	$afound = 0;
	$fop = fopen("./conf/accs.conf","r+t");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		if (strtolower($fra) == strtolower($auth)) {
			$afound = 1;
		}
	}
	fclose($fop);
	if ($afound == 0) {
		$fop = fopen("./conf/accs.conf","a+t");
		fwrite($fop,"$auth\n");
		fclose($fop);
	}


	$ctarg = strtolower($chan);
	$fop = fopen("./conf/users.conf","r+t");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
		$area = $frg[1];
		}
		else {
			if ($area == $ctarg) {
				if ($frg[0] == $auth) {
					return("NotOk");
				}
				$cfound = 1;
			}
		}
	}
	fclose($fop);


	$fop = fopen("./conf/users.conf","r+t");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
			$fcont .= $fra."\r\n";
			if ($area == $ctarg) {
				$fcont .= "$auth $access\r\n";
			}
		}
		else {
			$fcont .= $fra."\r\n";
		}
	}
	fclose($fop);
	$fop = fopen("./conf/users.conf","w+t");
	fwrite($fop,$fcont);
	fclose($fop);
	return("Ok");
}

function get_contents ($url) {
	global $useragent;
	$ch = curl_init();
	curl_setopt_array($ch, array(
		CURLOPT_RETURNTRANSFER => 1,
		CURLOPT_URL => $url,
		CURLOPT_USERAGENT => $useragent
	));
	return curl_exec($ch);
	curl_close($ch);
}
?>