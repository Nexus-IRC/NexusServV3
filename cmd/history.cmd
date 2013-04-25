/* cmd/history.cmd - NexusServV3
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
sendserv("NOTICE $nick :".chr(31)."NexusServ ".$GLOBALS['bofficial']."".chr(31)." can be found at http://git.nexus-irc.de/?p=NexusServV3.git");
sendserv("NOTICE $nick :".chr(31)."ArcticServ 2.0".chr(31)." was incomplete and has been removed");
sendserv("NOTICE $nick :Try \002v1-history\002 for the ".chr(31)."ArcticServ 1.0".chr(31)." history");