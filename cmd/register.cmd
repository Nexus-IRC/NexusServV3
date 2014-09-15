/* cmd/register.cmd - NexusServV3
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
$params = $paramzz;
global $userinfo, $botnick, $god, $chans, $waitfor;
$lnick = strtolower($nick);
$lchan = strtolower($target);
$lpam = strtolower($params);
$acc = $userinfo["$lnick"]["auth"];
$saxs = 0;
$fop = fopen("./conf/staff.conf","r+t");
while ($fra = fgets($fop)) {
	$fra = str_replace("\r","",$fra);
	$fra = str_replace("\n","",$fra);
	$frg = explode(" ",$fra);
	if (strtolower($frg[0]) == strtolower($acc)) {
		$saxs = $frg[1];
	}
}
fclose($fop);
if ($saxs >= 200) {
	if ($god["$acc"] != 1) {
		sendserv("NOTICE $nick :You must enable security override (helping mode) to use this command.");
	}
	else {
		$arfound = 0;
		$fop = fopen("./conf/users.conf","r+t");
		while ($fra = fgets($fop)) {
			$fra = str_replace("\r","",$fra);
			$fra = str_replace("\n","",$fra);
			$frg = explode(" ",$fra);
			if ($frg[0] == "-" && $frg[1] == strtolower($target)) {
				$arfound = 1;
			}
		}
		fclose($fop);
		if ($arfound == 1) {
			sendserv("NOTICE $nick :".$chans["$lchan"]["name"]." is already registered to someone else.");
		}
		else {
			if ($params[0] == "*") {
				$accfound = "";
				$fop = fopen("./conf/accs.conf","r+t");
				while ($fra = fgets($fop)) {
					$fra = str_replace("\r","",$fra);
					$fra = str_replace("\n","",$fra);
					$frg = explode(" ",$fra);
					if (strtolower($frg[0]) == strtolower(substr($params,1))) {
						$accfound = $frg[0]; 
					}
				}
				fclose($fop);
				if ($accfound != "") {
					$fop = fopen("./conf/users.conf","a+");
					fwrite($fop,"\r\n- ".$lchan." ".$acc." ".time()."\r\n");
					fwrite($fop,"$accfound 500");
					fclose($fop);
					sendserv("JOIN $target");
					sendserv("NOTICE $nick :$target has been registered to $accfound.");
					if($showdebug == true){
						sendserv("PRIVMSG $debugchannel :$nick ($acc) registered $target to $accfound.");
					}
				}
				else {
					sendserv("NOTICE $nick :This account (\002".substr($params,1)."\002) is unknown to me.");
				}
			}
			elseif ($params == "") {
				$fop = fopen("./conf/users.conf","a+");
				fwrite($fop,"\r\n- ".$lchan." ".$acc." ".time()."\r\n");
				fwrite($fop,"$acc 500");
				sendserv("JOIN $target");
				sendserv("NOTICE $nick :$target has been registered to $acc");
				if($showdebug == true){
					sendserv("PRIVMSG $debugchannel :$nick ($acc) registered $target to $nick ($acc)");
				}
			}
			else {
				if ($userinfo["$lpam"]["nick"] == "") {
					if ($userinfo["$lpam"]["unknown"] != "1") {
						$wfc = count($waitfor["$lpam"]) + 1;
						$waitfor["$lpam"][$wfc] = "CMD register $nick $user $host $cchan $target $params";
						sendserv("WHOIS $lpam");
						return(0);
					}
					else {
						sendserv("NOTICE $nick :User \002$params\002 doesn't exist.");
					}
				}
				else {
					$racc = $userinfo["$lpam"]["auth"];
					if ($racc == "") {
						sendserv("NOTICE $nick :".$userinfo["$lpam"]["nick"]." is not authed with \002AuthServ\002.");
						return(0);
					}
					$fop = fopen("./conf/users.conf","a+");
					fwrite($fop,"\r\n- ".$lchan." ".$acc." ".time()."\r\n");
					fwrite($fop,"$racc 500");
					fclose($fop);
					sendserv("JOIN $target");
					sendserv("NOTICE $nick :$target has been registered to ".$userinfo["$lpam"]["nick"]." ($racc).");
					if($showdebug == true){
						sendserv("PRIVMSG $debugchannel :$nick ($acc) registered $target to ".$userinfo["$lpam"]["nick"]." ($racc).");
					}
				}
			}
		}
	}
}
else {
	sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
}