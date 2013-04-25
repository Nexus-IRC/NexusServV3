/* cmd/staff.cmd - NexusServV3
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
global $userinfo; global $botnick; global $god;
$fop = fopen("./conf/staff.conf","r+");
while ($fra = fgets($fop)) {
	$fra = str_replace("\r","",$fra);
	$fra = str_replace("\n","",$fra);
	$frg = explode(" ",$fra);
	$ustaff["$frg[0]"] = $frg[2];
}
fclose($fop);
foreach ($userinfo as $lnick => $uar) {
	$auth = $userinfo["$lnick"]["auth"];
	if ($ustaff["$auth"] != "" && $god[$auth] == "1") {
		$slevel = $ustaff["$auth"];
		$staffs["$slevel"] .= $userinfo["$lnick"]["nick"]." ";
	}
}
sendserv("NOTICE $nick :\002Developers\002");
sendserv("NOTICE $nick :".$staffs["7"]); // Developers
sendserv("NOTICE $nick :\002Hosters\002");
sendserv("NOTICE $nick :".$staffs["8"]); // Hoster
sendserv("NOTICE $nick :\002Admins\002");
sendserv("NOTICE $nick :".$staffs["5"].$staffs["4"]); // Admin, Botadmin 
sendserv("NOTICE $nick :\002Managers\002");
sendserv("NOTICE $nick :".$staffs["3"]); // Manager
sendserv("NOTICE $nick :\002Helpers\002");
sendserv("NOTICE $nick :".$staffs["2"].$staffs["1"]); // Extended Helper
sendserv("NOTICE $nick :\002Trials\002");
sendserv("NOTICE $nick :".$staffs["0"]); // Trial