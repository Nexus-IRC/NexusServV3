/* modules/topic.mod - NexusServV3
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
 if (strtolower($cbase) == "topic") {
	$params = $paramzz;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$area = "";
	$axs = 0;
	$cfound = 0;
	global $userinfo; global $chans; global $botnick; global $god;
	$acc = $userinfo["$lnick"]["auth"];
	$fop = fopen("./conf/users.conf","r+");
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
	$fop = fopen("./conf/settings.conf","r+");
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
	}
	else {
		if ($tsets["changetopic"] == "") {
			$tsets["changetopic"] = "200";
		}
		if ($tsets["enftopic"] == "") {
		$tsets["enftopic"] = "400";
		}
		if ($axs < $tsets["changetopic"]) {
		sendserv("NOTICE $nick :You lack sufficient access to ".$chans["$tchan"]["name"]." to use this command.");
		}
		else {
			if ($params != "") {
				if ($axs < $tsets["enftopic"]) {
					if (binsetting($tsets["enhancedtopic"]) == "Off") {
						$topicchange = str_replace("*",$params,$tsets["topicmask"]);
						sendserv("TOPIC $target :$topicchange");
						sendserv("NOTICE $nick :Topic should now be:");
						sendserv("NOTICE $nick :$topicchange");
					}
					else {
						$xploder = explode(" ",$paramzz);
						$allowed[1] = 1;
						$allowed[2] = 1;
						$allowed[3] = 1;
						$allowed[4] = 1;
						$allowed[5] = 1;
						$allowed[6] = 1;
						$allowed[7] = 1;
						$allowed[8] = 1;
						$allowed[9] = 1;
						$allowed[10] = 1;
						$allowed[11] = 1;
						$allowed[12] = 1;
						$allowed[13] = 1;
						$allowed[14] = 1;
						$allowed[15] = 1;
						if ($allowed[$xploder[0]] != 1) {
							sendserv("NOTICE $nick :\002$xploder[0]\002 is an invalid \002EnhancedTopic\002-ID");
							return(0);
						}
						$etopics = getArrayFromFile("./conf/etopics.conf");
						if (substr($paramzz,strlen($xploder[0]." ")) != "*") {
							$etopics[$tchan][$xploder[0]] = substr($paramzz,strlen($xploder[0]." "));
							sendArrayToFile("./conf/etopics.conf",$etopics);
						}
						else {
							unset($etopics[$tchan][$xploder[0]]);
							sendArrayToFile("./conf/etopics.conf",$etopics);
						}
						$bla[1] = "";
						$bla[2] = "";
						$bla[3] = "";
						$bla[4] = "";
						$bla[5] = "";
						$bla[6] = "";
						$bla[7] = "";
						$bla[8] = "";
						$bla[9] = "";
						$bla[10] = "";
						$bla[11] = "";
						$bla[12] = "";
						$bla[13] = "";
						$bla[14] = "";
						$bla[15] = "";
						foreach ($bla as $tnr => $tval) {
							if ($etopics[$tchan][$tnr] != "") {
								$bla[$tnr] = $etopics[$tchan][$tnr];
							}
						}
						$topicchange = $tsets["topicmask"];
						$topicchange = vsprintf($topicchange,$bla);
						sendserv("TOPIC $target :$topicchange");
						sendserv("NOTICE $nick :Topic should now be:");
						sendserv("NOTICE $nick :$topicchange");
					}
				}
				else {
					$topicchange = $params;
					sendserv("TOPIC $target :$topicchange");
					sendserv("NOTICE $nick :Topic should now be:");
					sendserv("NOTICE $nick :$topicchange");
				}
			}
			else {
				$topicchange = $tsets["defaulttopic"];
				sendserv("TOPIC $target :$topicchange");
				sendserv("NOTICE $nick :Topic should now be:");
				sendserv("NOTICE $nick :$topicchange");
			}
		}
	}
}