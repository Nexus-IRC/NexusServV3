/* modules/mode.mod - NexusServV3
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
if (strtolower($cbase) == "mode") {
	$params = $paramzz;
	global $chans; global $userinfo; global $god; global $botnick;
	$ctarg = strtolower($target);
	$axs = array();
	$tsets = array();
	$lnick = strtolower($nick);
	$auth = $userinfo["$lnick"]["auth"];
	$lbotnick = strtolower($botnick);
	if ($auth == "") {
		sendserv("NOTICE $nick :$nick is not authed with \002AuthServ\002.");
		return(0);
	}
	if ($chans["$ctarg"]["name"] == "") {
		sendserv("NOTICE $nick :I'm not in $target.");
		return(0);
	}
	$cname = $chans["$ctarg"]["name"];
	$fop = fopen("./conf/users.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
		}
		else {
			if ($area == $ctarg) {
				$axs["$frg[0]"] = $frg[1];
				$cfound = 1;
			}
		}
	}
	fclose($fop);
	$fop = fopen("./conf/settings.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if ($frg[0] == "-") {
			$area = $frg[1];
		}
		else {
			if ($area == $ctarg) {
				$tsets["$frg[0]"] = substr($fra,strlen($frg[0]." "));
			}
		}
	}
	fclose($fop);
	$modex = explode(" ",$params);
	$modes = $modex[0];
	$modep = explode(" ",substr($params,strlen($modex[0]." ")));
	if (str_replace("o","",$modes) != $modes) {
		sendserv("NOTICE $nick :$modes is an invalid set of channel modes.");
		return(0);
	}
	if (str_replace("v","",$modes) != $modes) {
		sendserv("NOTICE $nick :$modes is an invalid set of channel modes.");
		return(0);
	}
	if (str_replace("b","",$modes) != $modes) {
		sendserv("NOTICE $nick :$modes is an invalid set of channel modes.");
		return(0);
	}
	if ($axs["$auth"] < 200 && $god["$auth"] != "1" && $auth != $userinfo["$lbotnick"]["auth"]) {
		sendserv("NOTICE $nick :You lack sufficient access to $cname to use this command.");
		return(0);
	}
	$umc = 0;
	$x = 0;
	$mset = array();
	$category = "incl";
	while ($mode = $modes[$x]) {
		if ($mode == "-") {
		$category = "excl";
		}
		elseif ($mode == "+") {
		$category = "incl";
		}
		else {
			if ($category == "incl") {
				if ($mode == "k") {
					$mset["modes"] .= "+k";
					$mset["params"] .= " ".$modep[$umc];
					$umc++;
				}
				elseif ($mode == "l") {
					$mset["modes"] .= "+"."l";
					$mset["params"] .= " ".$modep[$umc];
					$umc++;
				}
				else {
					$mset["modes"] .= "+".$mode;
				}
			}
			elseif ($category == "excl") {
				if ($mode == "k") {
					$mset["modes"] .= "-k";
					$mset["params"] .= " ".$chans["$ctarg"]["key"];
					$umc++;
				}
				else {
					$mset["modes"] .= "-".$mode;
				}
			}
		}
		$x++;
	}
	sendserv("MODE $target ".$mset["modes"]." ".$mset["params"]);
	sendserv("NOTICE $nick :Set the modes for $cname.");
}