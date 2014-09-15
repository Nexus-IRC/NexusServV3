/* cmd/rename.cmd - NexusServV3
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
$paz = explode(" ",$params);
global $userinfo, $botnick, $god;
$lnick = strtolower($nick);
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
	$fcont = "";
	$found = "";
	$fope = fopen("./conf/accs.conf","r+t");
	while ($frae = fgets($fope)) {
		$frae = str_replace("\r","",$frae);
		$frae = str_replace("\n","",$frae);
		if (strtolower($frae) == strtolower($paz[0])) {
			$fcont .= $paz[1]."\n";
			$found = $frae;
		}
		else {
			$fcont .= $frae."\n";
		}
	}
	fclose($fope);
	$ffcont = "";
	$fope = fopen("./conf/users.conf","r+t");
	while ($frae = fgets($fope)) {
		$frae = str_replace("\r","",$frae);
		$frae = str_replace("\n","",$frae);
		$frge = explode(" ",$frae);
		if (strtolower($frge[0]) == strtolower($paz[0])) {
			$ffcont .= $paz[1]." ".substr($frae,strlen($frge[0]." "))."\n";
		}
		else {
			$ffcont .= $frae."\n";
		}
	}
	fclose($fope);
	$fffcont = "";
	$fope = fopen("./conf/staff.conf","r+t");
	while ($frae = fgets($fope)) {
		$frae = str_replace("\r","",$frae);
		$frae = str_replace("\n","",$frae);
		$frge = explode(" ",$frae);
		if (strtolower($frge[0]) == strtolower($paz[0])) {
			$fffcont .= $paz[1]." ".substr($frae,strlen($frge[0]." "))."\n";
		}
		else {
			$fffcont .= $frae."\n";
		}
	}
	fclose($fope);
	if ($found != "") {
		sendserv("NOTICE $nick :The account $found has been renamed to $paz[1].");
		if($showdebug == true){
			sendserv("PRIVMSG $debugchannel :$nick renamed account $found to $paz[1].");
		}
		$fope = fopen("./conf/accs.conf","w+t");
		fwrite($fope,$fcont);
		fclose($fope);
		$fope = fopen("./conf/users.conf","w+t");
		fwrite($fope,$ffcont);
		fclose($fope);
		$fope = fopen("./conf/staff.conf","w+t");
		fwrite($fope,$fffcont);
		fclose($fope);
	}
	else {
		sendserv("NOTICE $nick :The account \002$paz[0]\002 is unknown to me.");
	}
}