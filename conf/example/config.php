<?php
/* inc/config.php - NexusServV3
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

# All variables set here are only loaded once into the core on startup,
# any changes made while the bot is running will require a full bot restart.

# Set the bot's trigger
$trigger = "=";

$sendwith = -1;

# Set the server hostname/IP and port to connect to
# Note: To connect using TLS add "+" in front of the port number
$server = "irc.onlinegamesnet.net";
$port = "+7776";

# Set the IRC attributes
$botnick = "NexusServ";
$botident = "NexusServ";
$botreal = "Channel Services - #nexus";

# The bot will connect exclusively using SASL to the server.
# Set the authname and password here
$botauth = "NexusServ";
$pass = "xxxx";

# Configure the usermodes to set upon connecting; usermodes may vary between servers
$botmodes = "xiIn";

# Toggle whether to send extra info to the debugging channel
$showdebug = true;

# Set default channels
$debugchannel = "#nexus-debug";
$staffchan = "#nexus-staff";
$supchan = "#nexus-support";

# Configure versioning system
# Note: $bversion will be set automatically to the latest commit hash if the
# repository was cloned with git
$bcodename = "git";
$bofficial = "3.6.2";
$bversion = "";
$core = "3.1";

# Toggle autojoining registered channels upon connecting
$autojoin = 1;

# Optional: Set the name of the funbot (NexusFun)
$funbot = "";

?>