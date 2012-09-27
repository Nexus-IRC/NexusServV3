<?php
/* ext.nicklist.php - NexusServV3
 * Copyright (C) 2012  #Nexus project
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
if ($chan[0] == "#") {
	$uc = 0;
	echo("NOTICE $nick :On \002$chan\002 there are the following users:\n");
	foreach ($nicklist as $nickname => $status) {
		$uc++;
		echo("NOTICE $nick : $nickname\n");
	}
	echo("NOTICE $nick :\002$uc\002 users found.\n");
} else {
}
?>