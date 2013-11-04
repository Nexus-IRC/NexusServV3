/* cmd/version.cmd - NexusServV3
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
global $version, $devline, $secdevline;
sendserv("NOTICE $nick :\002NexusServ ".$GLOBALS['bofficial']."\002");
sendserv("NOTICE $nick :NexusServ ".$GLOBALS['bversion']." (".$GLOBALS['bcodename'].") Release ".$GLOBALS['brelease']." Core ".$GLOBALS['core']."");
sendserv("NOTICE $nick :NexusServ can be found on #Nexus or at http://nexus-irc.de/nexusserv.html");
sendserv("NOTICE $nick :If you have found a bug or if you have a good idea report it on http://bugtracker.nexus-irc.de");