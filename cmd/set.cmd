/* cmd/set.cmd - NexusServV3
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
$tchan = strtolower($target);
$lnick = strtolower($nick);
$area = "";
$axs = 0;
$cfound = 0;
global $userinfo, $chans, $botnick, $god, $trigger, $funbot;
$acc = $userinfo["$lnick"]["auth"];
$fop = fopen("./conf/users.conf","r+t");
while ($fra = fgets($fop)) {
	$fra = str_replace("\r","",$fra);
	$fra = str_replace("\n","",$fra);
	$frg = explode(" ",$fra);
	if ($frg[0] == "-") {
		$area = $frg[1];
	}
	else {
		if ($area == $tchan) {
			if ($frg[0] == $userinfo["$lnick"]["auth"]) {
				$axs = $frg[1];
			}
			$cfound = 1;
		}
	}
}
fclose($fop);
$area = "";
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
if ($cfound == 0) {
	sendserv("NOTICE $nick :Channel \002$target\002 is not registered with \002$botnick\002.");
}
else {
	if ($tsets["setters"] == "") {
		$tsets["setters"] = "400";
	}
	if ($tsets["giveops"] == "") {
		$tsets["giveops"] = "200";
	}
	if ($tsets["givevoice"] == "") {
		$tsets["givevoice"] = "100";
	}
	if ($tsets["changeusers"] == "") {
		$tsets["changeusers"] = "300";
	}
	if ($tsets["adduser"] == "") {
		$tsets["adduser"] = $tsets["changeusers"];
	}
	if ($tsets["deluser"] == "") {
		$tsets["deluser"] = $tsets["changeusers"];
	}
	if ($tsets["clvl"] == "") {
		$tsets["clvl"] = $tsets["changeusers"];
	}
	if ($tsets["wipeinfo"] == "") {
		$tsets["wipeinfo"] = "300";
	}
	if ($tsets["watchdogexceptlevel"] == "") {
		$tsets["watchdogexceptlevel"] = "200";
	}
	if ($tsets["successor"] == "") {
		$tsets["successor"] = "499";
	}
	if ($tsets["changetopic"] == "") {
		$tsets["changetopic"] = "200";
	}
	if ($tsets["enftopic"] == "") {
		$tsets["enftopic"] = "400";
	}
	if ($tsets["modtopic"] == "") {
		$tsets["modtopic"] = "400";
	}
	if ($tsets["enfmodes"] == "") {
		$tsets["enfmodes"] = "300";
	}
	if ($tsets["enfops"] == "") {
		$tsets["enfops"] = "300";
	}
	if ($tsets["enfvoice"] == "") {
		$tsets["enfvoice"] = "200";
	}
	if ($tsets["vote"] == "") {
		$tsets["vote"] = "1";
	}
	if ($tsets["changevote"] == "") {
		$tsets["changevote"] = "400";
	}
	if ($tsets["inviteme"] == "") {
		$tsets["inviteme"] = "1";
	}
	if ($tsets["trigger"] == "") {
		$tsets["trigger"] = $trigger;
	}
	if (!empty($funbot)) {
		if ($tsets["funbot"] == "") {
			sendserv("PRIVMSG ".$funbot." :unreg ".$tchan);
			$tsets["funbot"] = "0";
		}
	}
	if ($axs >= $tsets["setters"] or $god["$acc"] == 1) {
		if ($params == "") {
			/*
			[23:58:21] -ChanServ- Channel Options:
			[23:58:21] -ChanServ- DefaultTopic 2,15-[ #Arctic-Team ]- -[ The Team Channel ]-
			[23:58:21] -ChanServ- TopicMask    2,15-[ #Arctic-Team ]- -[ The Team Channel ]- -[ News: * ]-
			[23:58:21] -ChanServ- Greeting     None
			[23:58:21] -ChanServ- UserGreeting None
			[23:58:21] -ChanServ- Modes        -pircNM+stnza 1
			[23:58:21] -ChanServ- PubCmd       0
			[23:58:21] -ChanServ- InviteMe     1
			[23:58:21] -ChanServ- EnfModes     200
			[23:58:21] -ChanServ- EnfTopic     0
			[23:58:21] -ChanServ- TopicSnarf   501
			[23:58:21] -ChanServ- UserInfo     1
			[23:58:21] -ChanServ- GiveVoice    100
			[23:58:21] -ChanServ- GiveOps      200
			[23:58:21] -ChanServ- EnfOps       300
			[23:58:21] -ChanServ- Setters      400
			[23:58:21] -ChanServ- CTCPReaction 2 - Short timed ban on disallowed CTCPs
			[23:58:21] -ChanServ- Protect      2 - Users will be protected from those of lower access.
			[23:58:21] -ChanServ- funbot       0
			[23:58:21] -ChanServ- Toys         2 - Toys will reply publicly.
			[23:58:21] -ChanServ- DynLimit     Off
			[23:58:21] -ChanServ- NoDelete     Off
			[23:58:21] -ChanServ- Expire       off
			*/
			sendserv("NOTICE $nick :\002".$chans["$tchan"]["name"]."\002 basic settings:");
			sendserv("NOTICE $nick :\002DefaultTopic           \002 ".strsetting($tsets["defaulttopic"]));
			sendserv("NOTICE $nick :\002TopicMask              \002 ".strsetting($tsets["topicmask"]));
			sendserv("NOTICE $nick :\002Greeting               \002 ".strsetting($tsets["greeting"]));
			sendserv("NOTICE $nick :\002UserGreeting           \002 ".strsetting($tsets["usergreeting"]));
			sendserv("NOTICE $nick :\002Modes                  \002 ".strsetting($tsets["modes"]));
			sendserv("NOTICE $nick :\002EnfModes               \002 ".asetting($tsets["enfmodes"]));
			sendserv("NOTICE $nick :\002EnfTopic               \002 ".asetting($tsets["enftopic"]));
			sendserv("NOTICE $nick :\002PubCmd                 \002 ".asetting($tsets["pubcmd"]));
			sendserv("NOTICE $nick :\002Setters                \002 ".asetting($tsets["setters"]));
			sendserv("NOTICE $nick :\002GiveOps                \002 ".asetting($tsets["giveops"]));
			sendserv("NOTICE $nick :\002GiveVoice              \002 ".asetting($tsets["givevoice"]));
			sendserv("NOTICE $nick :\002EnfOps                 \002 ".asetting($tsets["enfops"]));
			sendserv("NOTICE $nick :\002InviteMe               \002 ".asetting($tsets["inviteme"]));
			sendserv("NOTICE $nick :\002DynLimit               \002 ".a2setting($tsets["dynlimit"]));
			sendserv("NOTICE $nick :\002NoDelete               \002 ".binsetting($tsets["nodelete"]));
			if (!empty($funbot)) {
				sendserv("NOTICE $nick :\002FunBot                 \002 ".binsetting($tsets["funbot"]));
			}
			sendserv("NOTICE $nick :\002Toys                   \002 ".toyssetting($tsets["toys"]));
			sendserv("NOTICE $nick :\002Protect                \002 ".protsetting($tsets["protect"]));
			sendserv("NOTICE $nick :For a complete list of channel settings, please use the \002cset\002 command!");
		}
		else {
			cmd_parser($nick,$ident,$host,"cset",$target,$target,$paramzz);
		}
	}
}