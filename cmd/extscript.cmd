/* cmd/extscript.cmd - NexusServV3
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
$phppath = 'php'; // Linux Path FOR EVERY FUNCTION IN THIS MODULE!
$tchan = strtolower($cchan);
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
$toyz = $tsets['toys'];

$la = explode(" ",$paramzz);
ob_start();
$pe = substr($paramzz,strlen($la[0]." "));
$fp = fopen("god_code.php","w+t");
$xn = '$nicklist = unserialize(file_get_contents("nicklist.af"));';
$extnick = '<?php $nick = "'.addslashes($nick).'"; $params = \''.addslashes($pe).'\'; $chan = \''.addslashes($cchan).'\'; $toys = \''.$toyz.'\'; '.$xn.'; $useragent = "'.$GLOBALS["useragent"].'"; ?>';
global $chans, $userinfo;
$xx = fopen("nicklist.af","w+t");
$nicklist = array();
foreach ($chans[strtolower($tchan)]['users'] as $nickname => $status) {
	$nicklist[$userinfo[$nickname]['nick']] = $status;
}
fwrite($xx,serialize($nicklist));
fclose($xx);
fwrite($fp,$extnick.file_get_contents("ext/".$la[0]));
// Relay the nick to the external script and - whuuush - start it!
// We'll see how it goes.
fclose($fp);
$la = shell_exec($phppath." god_code.php");
unlink("nicklist.af");
echo($la);
unlink("god_code.php");
$dump .= ob_get_contents();

if ($dump != "") {
	$domp = explode("\n",$dump);
	foreach ($domp as $pomp) {
		if ($cchan[0] == "#") {
			sendserv("$pomp");
		}
		else {
			sendserv("$pomp");
		}
	}
}
ob_end_clean();