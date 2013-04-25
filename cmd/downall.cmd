/* cmd/downall.cmd - NexusServV3
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
global $chans;
$ctarg = strtolower($target);
if ($chans["$ctarg"]["name"] == "") {
	sendserv("NOTICE $nick :I'm not in $target.");
	return(0);
}
foreach ($chans as $clname => $clarray) {
	sendserv("MODE ".$chans["$clname"]["name"]." -ov $nick $nick");
}
sendserv("NOTICE $nick :Removed op/voice from you in all channels.");