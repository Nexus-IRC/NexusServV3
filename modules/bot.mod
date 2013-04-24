/* mod.mod - NexusServV3
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
// cbase: clone
if (strtolower($cbase) == "clone") {
	sendserv("NOTICE $nick :Under construction.");
	$paz = explode(" ",$paramzz);
	if (strtolower($paz[0]) == "add") {
		sendserv("NOTICE $nick :SYNTAX clone add <nick> <realname>");
		sendserv("NOTICE $nick : Adds a clone to the bot and connects to the default clones server");
	}
}