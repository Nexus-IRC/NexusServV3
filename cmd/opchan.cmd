/* cmd/opchan.cmd - NexusServV3
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
sendserv("NOTICE $nick :If I'm not opped on ".$target.", I'll attempt to reop myself now.");
sendserv("PRIVMSG ChanServ :UP $target");
sendserv("PRIVMSG Centravi :UP $target");
sendserv("PRIVMSG NeonServ :UP $target");
sendserv("PRIVMSG NexusZNC :ZNC ADMIN_SIMUL NexusFun mode $target +o $botnick");
sendserv("PRIVMSG NexusZNC :ZNC ADMIN_SIMUL NexusStats mode $target +o $botnick");