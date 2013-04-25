/* modules/help.mod - NexusServV3
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
if (strtolower($cbase) == "help") {
	$helpfile = "./conf/help.txt";
	$params = $paramzz;
	$para = explode(" ",$params);
	if (substr($para[0],0,2) == "::") {
		$helpfile = "./conf/help".substr($para[0],2).".txt";
		$params = substr($params,strlen($para[0]." "));
	}
	global $botnick; global $version;
	$fop = fopen($helpfile,"r+");
	if ($params == "") {
		$paramz = "Main";
	}
	else {
		$paramz = $params;
	}
	$fcont = "";
	$area = "";
	while ($fg = fgets($fop)) {
		$fra = str_replace("\r","",$fg);
		$fra = str_replace("\n","",$fra);
		if ($fra{0} == "[") {
			$area = $fra;
		}
		else {
			if (strtolower($area) == strtolower("[".$paramz."]")) {
				$fcont .= $fra."\r\n";
			}
		}
	}
	if ($fcont == "") {
		sendserv("NOTICE $nick :No help on that topic!");
		return(101);
	}
	$bla = explode("\r\n",$fcont);
	foreach ($bla as $blu) {
		sendserv("NOTICE $nick :".str_replace('$V',$version,str_replace('$B',$botnick,str_replace("[b]","\002",str_replace("[u]","\037",str_replace("[i]","\035",substr($blu,1)))))));
	}
	fclose($fop);
}