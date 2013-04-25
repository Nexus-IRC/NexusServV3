/* modules/aset.mod - NexusServV3
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
 if (strtolower($cbase) == "aset") {
	global $command;
	global $userinfo;
	$lnick = strtolower($nick);
	$uauth = $userinfo[$lnick]['auth'];
	if ($uauth == "") {
		sendserv("NOTICE $nick :You are not authed with \002AuthServ\002.");
		return(0);
	}
	$paz = explode(" ",$paramzz);
	if ($paramzz == "") {
		$aset = getArrayFromFile("./conf/aset.conf");
		sendserv("NOTICE $nick :\002Account settings for $uauth:\002");
		sendserv("NOTICE $nick :\002PrivMsg         \002 ".binsetting($aset[strtolower($uauth)]['privmsg']));
		sendserv("NOTICE $nick :\002Language        \002 ".strsetting("English (en)"));
		sendserv("NOTICE $nick :\002Info            \002 ".strsetting($aset[strtolower($uauth)]['info']));
		sendserv("NOTICE $nick :---");
	}
	elseif (strtolower($paz[0]) == "privmsg") {
		if ($paz[1] == "") {
			$aset = getArrayFromFile("./conf/aset.conf");
			sendserv("NOTICE $nick :\002PrivMsg         \002 ".binsetting($aset[strtolower($uauth)]['privmsg']));
		}
		elseif ($paz[1] == "1" || strtolower($paz[1]) == "on") {
			$aset = getArrayFromFile("./conf/aset.conf");
			$aset[strtolower($uauth)]['privmsg'] = 1;
			sendArrayToFile("./conf/aset.conf",$aset);
			sendserv("NOTICE $nick :\002PrivMsg         \002 ".binsetting($aset[strtolower($uauth)]['privmsg']));
		}
		elseif ($paz[1] == "0" || strtolower($paz[1]) == "off") {
			$aset = getArrayFromFile("./conf/aset.conf");
			unset($aset[strtolower($uauth)]['privmsg']);
			sendArrayToFile("./conf/aset.conf",$aset);
			sendserv("NOTICE $nick :\002PrivMsg         \002 ".binsetting($aset[strtolower($uauth)]['privmsg']));
		}
		else {
			sendserv("NOTICE $nick :\002$paz[1]\002 is not a valid binary value.");
		}
	}
	elseif (strtolower($paz[0]) == "language") {
		sendserv("NOTICE $nick :You currently can't use the \002Language\002 account setting.");
	}
	elseif (strtolower($paz[0]) == "info") {
		if ($paz[1] == "") {
			sendserv("NOTICE $nick :\002Info            \002 ".strsetting($aset[strtolower($uauth)]['info']));
		}
		else {
			if (substr($paramzz,strlen($paz[0]." ")) == "*") {
				$aset = getArrayFromFile("./conf/aset.conf");
				unset($aset[strtolower($uauth)]['info']);
				sendArrayToFile("./conf/aset.conf",$aset);
				sendserv("NOTICE $nick :\002Info            \002 ".strsetting($aset[strtolower($uauth)]['info']));
			}
			else {
				$aset = getArrayFromFile("./conf/aset.conf");
				$aset[strtolower($uauth)]['info'] = substr($paramzz,strlen($paz[0]." "));
				sendArrayToFile("./conf/aset.conf",$aset);
				sendserv("NOTICE $nick :\002Info            \002 ".strsetting($aset[strtolower($uauth)]['info']));
			}
		}
	}
	else {
	sendserv("NOTICE $nick :ERROR: Unknown syntax or unknown setting.");
	}
}