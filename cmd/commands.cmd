/* cmd/commands.cmd - NexusServV3
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
global $botnick;
$cc = 0;
$lsize = 0;
sendserv("NOTICE $nick :\002$botnick\002 commands:");
$fop = fopen("./conf/bind.conf","r+");
while ($fra = fgets($fop)) {
	$fra = str_replace("\r","",$fra);
	$fra = str_replace("\n","",$fra);
	$fgr = explode(" ",$fra);
	if (strlen($fgr[0]) > $lsize) {
		$lsize = strlen($fgr[0]);
	}
	$cc++;
}
fclose($fop);
$fad = 0;
$fstr = "";
$fop = fopen("./conf/bind.conf","r+");
$bcount = 0;
sendserv("NOTICE $nick :Binding".spaces("Binding",20)." Command");
while ($fra = fgets($fop)) {
	$fra = str_replace("\r","",$fra);
	$fra = str_replace("\n","",$fra);
	$fgr = explode(" ",$fra);
	$cmdp = substr($fra,strlen($fgr[0]." ".$fgr[1]." ".$fgr[2]." ".$fgr[3]." "));
	sendserv("NOTICE $nick :$fgr[0]".spaces($fgr[0],20)." ".$fgr[2]." $fgr[3] ".$cmdp);
	$bcount++;
}
sendserv("NOTICE $nick :There are \002$bcount\002 bindings for \002$botnick\002");