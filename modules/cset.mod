if (strtolower($cbase) == "cset") {
	$params = $paramzz;
	$tchan = strtolower($target);
	$lnick = strtolower($nick);
	$area = "";
	$axs = 0;
	$cfound = 0;
	global $userinfo; global $chans; global $botnick; global $god;
	$acc = $userinfo["$lnick"]["auth"];
	$fop = fopen("users.conf","r+");
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
	$fop = fopen("settings.conf","r+");
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
			$tsets["trigger"] = "=";
		}
		if ($tsets["spamservtrigger"] == "") {
			$tsets["spamservtrigger"] = "$";
		}
		if ($axs >= $tsets["setters"] or $god["$acc"] == 1) {
			if ($params == "") {
				sendserv("NOTICE $nick :\002".$chans["$tchan"]["name"]."\002 setting overview:");
				sendserv("NOTICE $nick :\002DefaultTopic           \002 ".strsetting($tsets["defaulttopic"]));
				sendserv("NOTICE $nick :\002TopicMask              \002 ".strsetting($tsets["topicmask"]));
				sendserv("NOTICE $nick :\002AltTopic               \002 ".strsetting($tsets["alttopic"]));
				sendserv("NOTICE $nick :\002AltTopicMask           \002 ".strsetting($tsets["alttopicmask"]));
				sendserv("NOTICE $nick :\002Greeting               \002 ".strsetting($tsets["greeting"]));
				sendserv("NOTICE $nick :\002UserGreeting           \002 ".strsetting($tsets["usergreeting"]));
				sendserv("NOTICE $nick :\002Modes                  \002 ".strsetting($tsets["modes"]));
				sendserv("NOTICE $nick :\002EnfModes               \002 ".asetting($tsets["enfmodes"]));
				sendserv("NOTICE $nick :\002EnfTopic               \002 ".asetting($tsets["enftopic"]));
				sendserv("NOTICE $nick :\002ChangeTopic            \002 ".asetting($tsets["changetopic"]));
				sendserv("NOTICE $nick :\002ModTopic               \002 ".asetting($tsets["modtopic"]));
				sendserv("NOTICE $nick :\002EnhancedTopic          \002 ".binsetting($tsets["enhancedtopic"]));
				sendserv("NOTICE $nick :\002PubCmd                 \002 ".asetting($tsets["pubcmd"]));
				sendserv("NOTICE $nick :\002Setters                \002 ".asetting($tsets["setters"]));
				sendserv("NOTICE $nick :\002GiveOps                \002 ".asetting($tsets["giveops"]));
				sendserv("NOTICE $nick :\002GiveVoice              \002 ".asetting($tsets["givevoice"]));
				sendserv("NOTICE $nick :\002EnfOps                 \002 ".asetting($tsets["enfops"]));
				sendserv("NOTICE $nick :\002EnfVoice               \002 ".asetting($tsets["enfvoice"]));
				sendserv("NOTICE $nick :\002Uset                   \002 ".asetting($tsets["uset"]));
				sendserv("NOTICE $nick :\002ChangeUsers            \002 ".asetting($tsets["changeusers"]));
				sendserv("NOTICE $nick :\002AddUser                \002 ".asetting($tsets["adduser"]));
				sendserv("NOTICE $nick :\002DelUser                \002 ".asetting($tsets["deluser"]));
				sendserv("NOTICE $nick :\002Clvl                   \002 ".asetting($tsets["clvl"]));
				sendserv("NOTICE $nick :\002WipeInfo               \002 ".asetting($tsets["wipeinfo"]));
				sendserv("NOTICE $nick :\002Votings                \002 ".binsetting($tsets["votings"]));
				sendserv("NOTICE $nick :\002AutoOpChan             \002 ".binsetting($tsets["autoopchan"]));
				sendserv("NOTICE $nick :\002Vote                   \002 ".asetting($tsets["vote"]));
				sendserv("NOTICE $nick :\002ChangeVote             \002 ".asetting($tsets["changevote"]));
				sendserv("NOTICE $nick :\002Successor              \002 ".asetting($tsets["successor"]));
				sendserv("NOTICE $nick :\002InviteMe               \002 ".asetting($tsets["inviteme"]));
				sendserv("NOTICE $nick :\002DynLimit               \002 ".a2setting($tsets["dynlimit"]));
				sendserv("NOTICE $nick :\002ShowClones             \002 ".binsetting($tsets["showclones"]));
				sendserv("NOTICE $nick :\002SpamServ               \002 ".binsetting($tsets["spamserv"]));
				sendserv("NOTICE $nick :\002Watchdog               \002 ".binsetting($tsets["watchdog"]));
				if ($tsets['watchdog'] == '1') {
					sendserv("NOTICE $nick :\002        ScanOps        \002 ".binsetting($tsets["watchdogscanops"]));
					sendserv("NOTICE $nick :\002        ScanVoiced     \002 ".binsetting($tsets["watchdogscanvoiced"]));
					sendserv("NOTICE $nick :\002        ScanRegular    \002 ".binsetting($tsets["watchdogscanregular"]));
					sendserv("NOTICE $nick :\002        ExceptLevel    \002 ".asetting($tsets["watchdogexceptlevel"]));
				}
				sendserv("NOTICE $nick :\002NoDelete               \002 ".binsetting($tsets["nodelete"]));
				sendserv("NOTICE $nick :\002Toys                   \002 ".toyssetting($tsets["toys"]));
				sendserv("NOTICE $nick :\002Protect                \002 ".protsetting($tsets["protect"]));
				sendserv("NOTICE $nick :\002Trigger                \002 ".strsetting($tsets['trigger']));
			}
			else {
				$pp = explode(" ",$params);
				$pe = substr($params,strlen($pp[0]." "));
				if (strtolower($pp[0]) == "greeting" && $pe == "") {
					sendserv("NOTICE $nick :\002Greeting               \002 ".strsetting($tsets["greeting"]));
				}
				elseif (strtolower($pp[0]) == "trigger" && $pe == "") {
					sendserv("NOTICE $nick :\002Trigger                \002 ".strsetting($tsets['trigger']));
				}
				elseif (strtolower($pp[0]) == "spamservtrigger" && $pe == "" && binsetting($tsets["spamserv"]) == "On") {
					sendserv("NOTICE $nick :\002SpamServTrigger        \002 ".strsetting($tsets['spamservtrigger']));
				}
				elseif (strtolower($pp[0]) == "modes" && $pe == "") {
					sendserv("NOTICE $nick :\002Modes                  \002 ".strsetting($tsets["modes"]));
				}
				elseif (strtolower($pp[0]) == "modtopic" && $pe == "") {
					sendserv("NOTICE $nick :\002ModTopic               \002 ".asetting($tsets["modtopic"]));
				}
				elseif (strtolower($pp[0]) == "defaults") {
					if ($axs < 500) {
						sendserv("NOTICE $nick :To reset all settings to default, you must be the owner of \002$target\002.");
						return(0);
					}
					if ($pe != "!".substr(md5($cname.date("d.m-H.i").$nick),0,8)."!") {
						sendserv("NOTICE $nick :To really reset all settings to their defaults, use \002set defaults !".substr(md5($cname.date("d.m-H.i").$nick),0,8)."!");
					}
					else {
						$fcont = "";
						$fop = fopen("settings.conf","r+");
						while ($fra = fgets($fop)) {
							$fra = str_replace("\r","",$fra);
							$fra = str_replace("\n","",$fra);
							$frg = explode(" ",$fra);
							if ($frg[0] == "-") {
								$area = $frg[1];
								if ($area != $tchan) {
									$fcont .= "- $frg[1]\r\n";
								}
							}
							else {
								if ($area == $tchan) {
									$sfound = 1;
									$fcont .= ""; // Ignore the data.
								}
								else {
									$fcont .= "$fra\r\n";
								}
							}
						}
						fclose($fop);
						$fop = fopen("settings.conf","w+");
						fwrite($fop,$fcont);
						fclose($fop);
						sendserv("NOTICE $nick :Channel settings for ".$chans["$tchan"]["name"]." have been reset to default.");
					}
				}
				elseif (strtolower($pp[0]) == "showclones" && $pe == "") {
					sendserv("NOTICE $nick :\002ShowClones             \002 ".binsetting($tsets["showclones"]));
				}
				elseif (strtolower($pp[0]) == "votings" && $pe == "") {
					sendserv("NOTICE $nick :\002Votings                \002 ".binsetting($tsets["votings"]));
				}
				elseif (strtolower($pp[0]) == "autoopchan" && $pe == "") {
					sendserv("NOTICE $nick :\002AutoOpChan             \002 ".binsetting($tsets["autoopchan"]));
				}
				elseif (strtolower($pp[0]) == "enhancedtopic" && $pe == "") {
					sendserv("NOTICE $nick :\002EnhancedTopic          \002 ".binsetting($tsets["enhancedtopic"]));
				}
				elseif (strtolower($pp[0]) == "spamserv" && $pe == "") {
					sendserv("NOTICE $nick :\002SpamServ               \002 ".binsetting($tsets["spamserv"]));
				}
				elseif (strtolower($pp[0]) == "watchdog" && $pe == "") {
					sendserv("NOTICE $nick :\002Watchdog               \002 ".binsetting($tsets["watchdog"]));
					if ($tsets['watchdog'] == '1') {
						sendserv("NOTICE $nick :\002        ScanOps        \002 ".binsetting($tsets["watchdogscanops"]));
						sendserv("NOTICE $nick :\002        ScanVoiced     \002 ".binsetting($tsets["watchdogscanvoiced"]));
						sendserv("NOTICE $nick :\002        ScanRegular    \002 ".binsetting($tsets["watchdogscanregular"]));
						sendserv("NOTICE $nick :\002        ExceptLevel    \002 ".asetting($tsets["watchdogexceptlevel"]));
					}
				}
				elseif (strtolower($pp[0]) == "watchdog" && strtolower($pe) == "scanops") {
					sendserv("NOTICE $nick :\002Watchdog               \002 ".binsetting($tsets["watchdog"]));
					sendserv("NOTICE $nick :\002        ScanOps        \002 ".binsetting($tsets["watchdogscanops"]));
				}
				elseif (strtolower($pp[0]) == "watchdog" && strtolower($pe) == "scanvoiced") {
					sendserv("NOTICE $nick :\002Watchdog               \002 ".binsetting($tsets["watchdog"]));
					sendserv("NOTICE $nick :\002        ScanVoiced     \002 ".binsetting($tsets["watchdogscanvoiced"]));
				}
				elseif (strtolower($pp[0]) == "watchdog" && strtolower($pe) == "exceptlevel") {
					sendserv("NOTICE $nick :\002Watchdog               \002 ".binsetting($tsets["watchdog"]));
					sendserv("NOTICE $nick :\002        ExceptLevel    \002 ".asetting($tsets["watchdogexceptlevel"]));
				}
				elseif (strtolower($pp[0]) == "watchdog" && strtolower($pe) == "scanregular") {
					sendserv("NOTICE $nick :\002Watchdog               \002 ".binsetting($tsets["watchdog"]));
					sendserv("NOTICE $nick :\002        ScanRegular    \002 ".binsetting($tsets["watchdogscanregular"]));
				}
				elseif (strtolower($pp[0]) == "nodelete" && $pe == "") {
					sendserv("NOTICE $nick :\002NoDelete               \002 ".binsetting($tsets["nodelete"]));
				}
				elseif (strtolower($pp[0]) == "toys" && $pe == "") {
					sendserv("NOTICE $nick :\002Toys                   \002 ".toyssetting($tsets["toys"]));
				}
				elseif (strtolower($pp[0]) == "protect" && $pe == "") {
					sendserv("NOTICE $nick :\002Protect                \002 ".protsetting($tsets["protect"]));
				}
				elseif (strtolower($pp[0]) == "changetopic" && $pe == "") {
					sendserv("NOTICE $nick :\002ChangeTopic            \002 ".asetting($tsets["changetopic"]));
				}
				elseif (strtolower($pp[0]) == "pubcmd" && $pe == "") {
					sendserv("NOTICE $nick :\002PubCmd                 \002 ".asetting($tsets["pubcmd"]));
				}
				elseif (strtolower($pp[0]) == "defaulttopic" && $pe == "") {
					sendserv("NOTICE $nick :\002DefaultTopic           \002 ".strsetting($tsets["defaulttopic"]));
				}
				elseif (strtolower($pp[0]) == "topic" && $pe == "") {
					sendserv("NOTICE $nick :\002DefaultTopic           \002 ".strsetting($tsets["defaulttopic"]));
				}
				elseif (strtolower($pp[0]) == "topicmask" && $pe == "") {
					sendserv("NOTICE $nick :\002TopicMask              \002 ".strsetting($tsets["topicmask"]));
				}
				elseif (strtolower($pp[0]) == "alttopic" && $pe == "") {
					sendserv("NOTICE $nick :\002AltTopic               \002 ".strsetting($tsets["alttopic"]));
				}
				elseif (strtolower($pp[0]) == "alttopicmask" && $pe == "") {
					sendserv("NOTICE $nick :\002AltTopicMask           \002 ".strsetting($tsets["alttopicmask"]));
				}
				elseif (strtolower($pp[0]) == "usergreeting" && $pe == "") {
					sendserv("NOTICE $nick :\002UserGreeting           \002 ".strsetting($tsets["usergreeting"]));
				}
				elseif (strtolower($pp[0]) == "enftopic" && $pe == "") {
					sendserv("NOTICE $nick :\002EnfTopic               \002 ".asetting($tsets["enftopic"]));
				}
				elseif (strtolower($pp[0]) == "enfmodes" && $pe == "") {
					sendserv("NOTICE $nick :\002EnfModes               \002 ".asetting($tsets["enfmodes"]));
				}
				elseif (strtolower($pp[0]) == "inviteme" && $pe == "") {
					sendserv("NOTICE $nick :\002InviteMe               \002 ".asetting($tsets["inviteme"]));
				}
				elseif (strtolower($pp[0]) == "dynlimit" && $pe == "") {
					sendserv("NOTICE $nick :\002DynLimit               \002 ".a2setting($tsets["dynlimit"]));
				}
				elseif (strtolower($pp[0]) == "setters" && $pe == "") {
					sendserv("NOTICE $nick :\002Setters                \002 ".asetting($tsets["setters"]));
				}
				elseif (strtolower($pp[0]) == "giveops" && $pe == "") {
					sendserv("NOTICE $nick :\002GiveOps                \002 ".asetting($tsets["giveops"]));
				}
				elseif (strtolower($pp[0]) == "givevoice" && $pe == "") {
					sendserv("NOTICE $nick :\002GiveVoice              \002 ".asetting($tsets["givevoice"]));
				}
				elseif (strtolower($pp[0]) == "uset" && $pe == "") {
					sendserv("NOTICE $nick :\002Uset                   \002 ".asetting($tsets["uset"]));
				}
				elseif (strtolower($pp[0]) == "changeusers" && $pe == "") {
					sendserv("NOTICE $nick :\002ChangeUsers            \002 ".asetting($tsets["changeusers"]));
				}
				elseif (strtolower($pp[0]) == "adduser" && $pe == "") {
					sendserv("NOTICE $nick :\002AddUser                \002 ".asetting($tsets["adduser"]));
				}
				elseif (strtolower($pp[0]) == "deluser" && $pe == "") {
					sendserv("NOTICE $nick :\002DelUser                \002 ".asetting($tsets["deluser"]));
				}
				elseif (strtolower($pp[0]) == "clvl" && $pe == "") {
					sendserv("NOTICE $nick :\002Clvl                   \002 ".asetting($tsets["clvl"]));
				}
				elseif (strtolower($pp[0]) == "wipeinfo" && $pe == "") {
					sendserv("NOTICE $nick :\002WipeInfo               \002 ".asetting($tsets["wipeinfo"]));
				}
				elseif (strtolower($pp[0]) == "vote" && $pe == "") {
					sendserv("NOTICE $nick :\002Vote                   \002 ".asetting($tsets["vote"]));
				}
				elseif (strtolower($pp[0]) == "changevote" && $pe == "") {
					sendserv("NOTICE $nick :\002ChangeVote             \002 ".asetting($tsets["changevote"]));
				}
				elseif (strtolower($pp[0]) == "successor" && $pe == "") {
					sendserv("NOTICE $nick :\002Successor              \002 ".asetting($tsets["successor"]));
				}
				elseif (strtolower($pp[0]) == "showclones" && $pe != "") {
					if ($pe != "0" && $pe != "1") {
						sendserv("NOTICE $nick :\002$pe\002 is not a valid binary value.");
						return(0);
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "showclones $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "showclones") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "showclones $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002ShowClones             \002 ".binsetting($pe));
				}
				elseif (strtolower($pp[0]) == "votings" && $pe != "") {
					if ($pe != "0" && $pe != "1") {
						sendserv("NOTICE $nick :\002$pe\002 is not a valid binary value.");
						return(0);
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "votings $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "votings") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "votings $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002Votings                \002 ".binsetting($pe));
				}
				elseif (strtolower($pp[0]) == "autoopchan" && $pe != "") {
					if ($pe != "0" && $pe != "1") {
						sendserv("NOTICE $nick :\002$pe\002 is not a valid binary value.");
						return(0);
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "autoopchan $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "autoopchan") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "autoopchan $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002AutoOpChan             \002 ".binsetting($pe));
					if (binsetting($pe) == "On") {
						sendserv("NOTICE $nick :Please be sure to activate \002AutoOpChan\002 ".chr(31)."only".chr(31)." while botwars aren't possible on this channel!");
					}
				}
				elseif (strtolower($pp[0]) == "enhancedtopic" && $pe != "") {
					if ($pe != "0" && $pe != "1") {
						sendserv("NOTICE $nick :\002$pe\002 is not a valid binary value.");
						return(0);
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "enhancedtopic $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "enhancedtopic") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "enhancedtopic $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002EnhancedTopic          \002 ".binsetting($pe));
				}
				elseif (strtolower($pp[0]) == "spamserv" && $pe != "") {
					if ($pe != "0" && $pe != "1") {
						sendserv("NOTICE $nick :\002$pe\002 is not a valid binary value.");
						return(0);
					}
					if ($god["$acc"] != "1") {
						sendserv("NOTICE $nick :You must enable security override (helping mode) to change this setting.");
						return(0);
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "spamserv $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "spamserv") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "spamserv $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002SpamServ               \002 ".binsetting($pe));
				}
				elseif (strtolower($pp[0]) == "watchdog" && substr(strtolower($pe),0,strlen("scanops ")) == "scanops ") {
					$pe = substr($pe,strlen("scanops "));
					if ($pe != "0" && $pe != "1") {
						sendserv("NOTICE $nick :\002$pe\002 is not a valid binary value.");
						return(0);
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "watchdogscanops $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "watchdogscanops") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "watchdogscanops $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002Watchdog               \002 ".binsetting($tsets["watchdog"]));
					sendserv("NOTICE $nick :\002        ScanOps        \002 ".binsetting($pe));
				}
				elseif (strtolower($pp[0]) == "watchdog" && substr(strtolower($pe),0,strlen("scanvoiced ")) == "scanvoiced ") {
					$pe = substr($pe,strlen("scanvoiced "));
					if ($pe != "0" && $pe != "1") {
						sendserv("NOTICE $nick :\002$pe\002 is not a valid binary value.");
						return(0);
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "watchdogscanvoiced $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "watchdogscanvoiced") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "watchdogscanvoiced $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002Watchdog               \002 ".binsetting($tsets["watchdog"]));
					sendserv("NOTICE $nick :\002        ScanVoiced     \002 ".binsetting($pe));
				}
				elseif (strtolower($pp[0]) == "watchdog" && substr(strtolower($pe),0,strlen("scanregular ")) == "scanregular ") {
					$pe = substr($pe,strlen("scanregular "));
					if ($pe != "0" && $pe != "1") {
						sendserv("NOTICE $nick :\002$pe\002 is not a valid binary value.");
						return(0);
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "watchdogscanregular $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "watchdogscanregular") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
					if ($arfound == 0) {
					$fcont .= "- ".$tchan."\r\n";
					$fcont .= "watchdogscanregular $pe\r\n";
					}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002Watchdog               \002 ".binsetting($tsets["watchdog"]));
					sendserv("NOTICE $nick :\002        ScanRegular    \002 ".binsetting($pe));
				}
				elseif (strtolower($pp[0]) == "watchdog" && substr(strtolower($pe),0,strlen("exceptlevel ")) == "exceptlevel ") {
					$pe = substr($pe,strlen("exceptlevel "));
					$xyz = 501;
					$valid = 0;
					while ($xyz > -1) {
						if ($pe == $xyz) {
							$valid = 1;
						}
						$xyz = $xyz - 1;
					}
					if ($valid == 0) {
						sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
						return(0);
					}
					if ($axs != 500 && $god["$acc"] != "1") {
						if ($pe > $axs) {
							sendserv("NOTICE $nick :You may not change this setting above your own access level.");
							return(0);
						}
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "watchdogexceptlevel $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "watchdogexceptlevel") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "watchdogexceptlevel $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002Watchdog               \002 ".binsetting($tsets["watchdog"]));
					sendserv("NOTICE $nick :\002        ExceptLevel    \002 ".asetting($pe));
				}
				elseif (strtolower($pp[0]) == "watchdog" && $pe != "") {
					if ($pe != "0" && $pe != "1") {
						sendserv("NOTICE $nick :\002$pe\002 is not a valid binary value.");
						return(0);
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "watchdog $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "watchdog") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "watchdog $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002Watchdog               \002 ".binsetting($pe));
					if ($pe == '1') {
						sendserv("NOTICE $nick :\002        ScanOps        \002 ".binsetting($tsets["watchdogscanops"]));
						sendserv("NOTICE $nick :\002        ScanVoiced     \002 ".binsetting($tsets["watchdogscanvoiced"]));
						sendserv("NOTICE $nick :\002        ScanRegular    \002 ".binsetting($tsets["watchdogscanregular"]));
						sendserv("NOTICE $nick :\002        ExceptLevel    \002 ".asetting($tsets["watchdogexceptlevel"]));
					}
				}
				elseif (strtolower($pp[0]) == "nodelete" && $pe != "") {
					if ($pe != "0" && $pe != "1") {
						sendserv("NOTICE $nick :\002$pe\002 is not a valid binary value.");
						return(0);
					}
					if ($god["$acc"] != "1") {
						sendserv("NOTICE $nick :You must enable security override (helping mode) to change this setting.");
						return(0);
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "nodelete $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "nodelete") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "nodelete $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002NoDelete               \002 ".binsetting($pe));
				}
				elseif (strtolower($pp[0]) == "toys" && $pe != "") {
					if ($pe != "0" && $pe != "1" && $pe != "2") {
						sendserv("NOTICE $nick :\002$pe\002 is not a valid binary value.");
						return(0);
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "toys $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "toys") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "toys $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002Toys                   \002 ".toyssetting($pe));
				}
				elseif (strtolower($pp[0]) == "protect" && $pe != "") {
					if ($pe != "0" && $pe != "1" && $pe != "2" && $pe != "3") {
						sendserv("NOTICE $nick :\002$pe\002 is not a valid binary value.");
						return(0);
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "protect $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "protect") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "protect $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002Protect                \002 ".protsetting($pe));
				}
				elseif (strtolower($pp[0]) == "setters" && $pe != "") {
					$xyz = 500;
					$valid = 0;
					while ($xyz > -1) {
						if ($pe == $xyz) {
							$valid = 1;
						}
						$xyz = $xyz - 1;
					}
					if ($valid == 0) {
						sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
						return(0);
					}
					if ($axs != 500 && $god["$acc"] != "1") {
						if ($pe > $axs) {
							sendserv("NOTICE $nick :You may not change this setting above your own access level.");
							return(0);
						}
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "setters $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "setters") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "setters $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002Setters                \002 ".asetting($pe));
				}
				elseif (strtolower($pp[0]) == "modtopic" && $pe != "") {
					$xyz = 501;
					$valid = 0;
					while ($xyz > -1) {
						if ($pe == $xyz) {
							$valid = 1;
						}
						$xyz = $xyz - 1;
					}
					if ($valid == 0) {
						sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
						return(0);
					}
					if ($axs != 500 && $god["$acc"] != "1") {
						if ($pe > $axs) {
							sendserv("NOTICE $nick :You may not change this setting above your own access level.");
							return(0);
						}
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "modtopic $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "modtopic") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "modtopic $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002ModTopic               \002 ".asetting($pe));
				}
				elseif (strtolower($pp[0]) == "dynlimit" && $pe != "") {
					if ($pe > 200) {
						sendserv("NOTICE $nick :\002$pe\002 is too high of a value for this setting.");
						return(0);
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "dynlimit $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "dynlimit") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "dynlimit $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					$xx = 0;
					foreach($chans["$tchan"]["users"] as $unick => $ustat) {
						$xx++;
					}
					$xxlimit = $xx + $pe;
					if ($pe != 0) {
						sendserv("MODE $target +l ".$xxlimit);
					}
					else {
						sendserv("MODE $target -l");
					}
					sendserv("NOTICE $nick :\002DynLimit               \002 ".a2setting($pe));
				}
				elseif (strtolower($pp[0]) == "inviteme" && $pe != "") {
					$xyz = 501;
					$valid = 0;
					while ($xyz > -1) {
						if ($pe == $xyz) {
							$valid = 1;
						}
						$xyz = $xyz - 1;
					}
					if ($valid == 0) {
						sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
						return(0);
					}
					if ($axs != 500 && $god["$acc"] != "1") {
						if ($pe > $axs) {
							sendserv("NOTICE $nick :You may not change this setting above your own access level.");
							return(0);
						}
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "inviteme $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "inviteme") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "inviteme $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002InviteMe               \002 ".asetting($pe));
				}
				elseif (strtolower($pp[0]) == "giveops" && $pe != "") {
					$xyz = 501;
					$valid = 0;
					while ($xyz > -1) {
						if ($pe == $xyz) {
							$valid = 1;
						}
						$xyz = $xyz - 1;
					}
					if ($valid == 0) {
						sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
						return(0);
					}
					if ($axs != 500 && $god["$acc"] != "1") {
						if ($pe > $axs) {
							sendserv("NOTICE $nick :You may not change this setting above your own access level.");
							return(0);
						}
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "giveops $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "giveops") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "giveops $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002GiveOps                \002 ".asetting($pe));
				}
				elseif (strtolower($pp[0]) == "givevoice" && $pe != "") {
					$xyz = 501;
					$valid = 0;
					while ($xyz > -1) {
						if ($pe == $xyz) {
							$valid = 1;
						}
						$xyz = $xyz - 1;
					}
					if ($valid == 0) {
						sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
						return(0);
					}
					if ($axs != 500 && $god["$acc"] != "1") {
						if ($pe > $axs) {
							sendserv("NOTICE $nick :You may not change this setting above your own access level.");
							return(0);
						}
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "givevoice $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "givevoice") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "givevoice $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002GiveVoice              \002 ".asetting($pe));
				}
				elseif (strtolower($pp[0]) == "uset" && $pe != "") {
					$xyz = 501;
					$valid = 0;
					while ($xyz > -1) {
						if ($pe == $xyz) {
							$valid = 1;
						}
						$xyz = $xyz - 1;
					}
					if ($valid == 0) {
						sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
						return(0);
					}
					if ($axs != 500 && $god["$acc"] != "1") {
						if ($pe > $axs) {
							sendserv("NOTICE $nick :You may not change this setting above your own access level.");
							return(0);
						}
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "uset $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "uset") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "uset $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002Uset                   \002 ".asetting($pe));
				}	
				elseif (strtolower($pp[0]) == "changeusers" && $pe != "") {
					$xyz = 501;
					$valid = 0;
					while ($xyz > -1) {
						if ($pe == $xyz) {
							$valid = 1;
						}
						$xyz = $xyz - 1;
					}
					if ($valid == 0) {
						sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
						return(0);
					}
					if ($axs != 500 && $god["$acc"] != "1") {
						if ($pe > $axs) {
							sendserv("NOTICE $nick :You may not change this setting above your own access level.");
							return(0);
						}
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "changeusers $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "changeusers") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "changeusers $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002ChangeUsers            \002 ".asetting($pe));
				}

				elseif (strtolower($pp[0]) == "adduser" && $pe != "") {
					$xyz = 501;
					$valid = 0;
					while ($xyz > -1) {
						if ($pe == $xyz) {
							$valid = 1;
						}
						$xyz = $xyz - 1;
					}
					if ($valid == 0) {
						sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
						return(0);
					}
					if ($axs != 500 && $god["$acc"] != "1") {
						if ($pe > $axs) {
							sendserv("NOTICE $nick :You may not change this setting above your own access level.");
							return(0);
						}
					}
					if ($pe == "*") {
						$pe = "";
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "adduser $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "adduser") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "adduser $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					if ($pe != "") {
						sendserv("NOTICE $nick :\002AddUser                \002 ".asetting($pe));
					}
					else {
						sendserv("NOTICE $nick :\002AddUser                \002 ".$tsets['changeusers']);
					}
				}	
				elseif (strtolower($pp[0]) == "deluser" && $pe != "") {
					$xyz = 501;
					$valid = 0;
					while ($xyz > -1) {
						if ($pe == $xyz) {
							$valid = 1;
						}
						$xyz = $xyz - 1;
					}
					if ($valid == 0) {
						sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
						return(0);
					}
					if ($axs != 500 && $god["$acc"] != "1") {
						if ($pe > $axs) {
							sendserv("NOTICE $nick :You may not change this setting above your own access level.");
							return(0);
						}
					}
					if ($pe == "*") {
						$pe = "";
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "deluser $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "deluser") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "deluser $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					if ($pe != "") {
						sendserv("NOTICE $nick :\002DelUser                \002 ".asetting($pe));
					}
					else {
						sendserv("NOTICE $nick :\002DelUser                \002 ".$tsets['changeusers']);
					}
				}
				elseif (strtolower($pp[0]) == "clvl" && $pe != "") {
					$xyz = 501;
					$valid = 0;
					while ($xyz > -1) {
						if ($pe == $xyz) {
							$valid = 1;
						}
						$xyz = $xyz - 1;
					}
					if ($valid == 0) {
						sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
						return(0);
					}
					if ($axs != 500 && $god["$acc"] != "1") {
						if ($pe > $axs) {
							sendserv("NOTICE $nick :You may not change this setting above your own access level.");
							return(0);
						}
					}
					if ($pe == "*") {
						$pe = "";
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
						while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "clvl $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "clvl") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "clvl $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					if ($pe != "") {
						sendserv("NOTICE $nick :\002Clvl                   \002 ".asetting($pe));
					}
					else {
						sendserv("NOTICE $nick :\002Clvl                   \002 ".$tsets['changeusers']);
					}
				}	
				elseif (strtolower($pp[0]) == "wipeinfo" && $pe != "") {
					$xyz = 501;
					$valid = 0;
					while ($xyz > -1) {
						if ($pe == $xyz) {
							$valid = 1;
						}
						$xyz = $xyz - 1;
					}
					if ($valid == 0) {
						sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
						return(0);
					}
					if ($axs != 500 && $god["$acc"] != "1") {
						if ($pe > $axs) {
							sendserv("NOTICE $nick :You may not change this setting above your own access level.");
							return(0);
						}
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "wipeinfo $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "wipeinfo") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "wipeinfo $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002WipeInfo               \002 ".asetting($pe));
				}
				elseif (strtolower($pp[0]) == "changevote" && $pe != "") {
					$xyz = 501;
					$valid = 0;
					while ($xyz > -1) {
						if ($pe == $xyz) {
							$valid = 1;
						}
						$xyz = $xyz - 1;
					}
					if ($valid == 0) {
						sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
						return(0);
					}
					if ($axs != 500 && $god["$acc"] != "1") {
						if ($pe > $axs) {
							sendserv("NOTICE $nick :You may not change this setting above your own access level.");
							return(0);
						}
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "changevote $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "changevote") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "changevote $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002ChangeVote             \002 ".asetting($pe));
				}
				elseif (strtolower($pp[0]) == "vote" && $pe != "") {
					$xyz = 501;
					$valid = 0;
					while ($xyz > -1) {
						if ($pe == $xyz) {
							$valid = 1;
						}
						$xyz = $xyz - 1;
					}
					if ($valid == 0) {
						sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
						return(0);
					}
					if ($axs != 500 && $god["$acc"] != "1") {
						if ($pe > $axs) {
							sendserv("NOTICE $nick :You may not change this setting above your own access level.");
							return(0);
						}
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "vote $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "vote") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "vote $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002Vote                   \002 ".asetting($pe));
				}
				elseif (strtolower($pp[0]) == "successor" && $pe != "") {
					$xyz = 501;
					$valid = 0;
					while ($xyz > -1) {
						if ($pe == $xyz) {
							$valid = 1;
						}
						$xyz = $xyz - 1;
					}
					if ($valid == 0) {
						sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
						return(0);
					}
					if ($axs != 500 && $god["$acc"] != "1") {
						if ($pe > $axs) {
							sendserv("NOTICE $nick :You may not change this setting above your own access level.");
							return(0);
						}
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "successor $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "successor") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "successor $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002Successor              \002 ".asetting($pe));
				}
				elseif (strtolower($pp[0]) == "enftopic" && $pe != "") {
					$xyz = 501;
					$valid = 0;
					while ($xyz > -1) {
						if ($pe == $xyz) {
							$valid = 1;
						}
						$xyz = $xyz - 1;
					}
					if ($valid == 0) {
						sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
						return(0);
					}
					if ($axs != 500 && $god["$acc"] != "1") {
						if ($pe > $axs) {
							sendserv("NOTICE $nick :You may not change this setting above your own access level.");
							return(0);
						}
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "enftopic $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "enftopic") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "enftopic $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002EnfTopic               \002 ".asetting($pe));
				}
				elseif (strtolower($pp[0]) == "enfmodes" && $pe != "") {
					$xyz = 501;
					$valid = 0;
					while ($xyz > -1) {
						if ($pe == $xyz) {
							$valid = 1;
						}
						$xyz = $xyz - 1;
					}
					if ($valid == 0) {
						sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
						return(0);
					}
					if ($axs != 500 && $god["$acc"] != "1") {
						if ($pe > $axs) {
							sendserv("NOTICE $nick :You may not change this setting above your own access level.");
							return(0);
						}
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "enfmodes $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "enfmodes") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "enfmodes $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002EnfModes               \002 ".asetting($pe));
				}
				elseif (strtolower($pp[0]) == "changetopic" && $pe != "") {
					$xyz = 501;
					$valid = 0;
					while ($xyz > -1) {
						if ($pe == $xyz) {
							$valid = 1;
						}
						$xyz = $xyz - 1;
					}
					if ($valid == 0) {
						sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
						return(0);
					}
					if ($axs != 500 && $god["$acc"] != "1") {
						if ($pe > $axs) {
							sendserv("NOTICE $nick :You may not change this setting above your own access level.");
							return(0);
						}
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "changetopic $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "changetopic") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}	
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "changetopic $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002ChangeTopic            \002 ".asetting($pe));
				}
				elseif (strtolower($pp[0]) == "pubcmd" && $pe != "") {
					$xyz = 501;
					$valid = 0;
					while ($xyz > -1) {
						if ($pe == $xyz) {
							$valid = 1;
						}
						$xyz = $xyz - 1;
					}
					if ($valid == 0) {
						sendserv("NOTICE $nick :\002$pe\002 is an invalid access level.");
						return(0);
					}
					if ($axs != 500 && $god["$acc"] != "1") {
						if ($pe > $axs) {
							sendserv("NOTICE $nick :You may not change this setting above your own access level.");
							return(0);
						}
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "pubcmd $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "pubcmd") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "pubcmd $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002PubCmd                 \002 ".asetting($pe));
				}
				elseif (strtolower($pp[0]) == "modes" && $pe != "") {
					if ($pe == "*") {
						$pe = "";
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "modes $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "modes") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "modes $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					bot_mod_mod($nick,$user,$host,$cchan,$target,"chan.mod mode ".$pe);
					sendserv("NOTICE $nick :\002Modes                  \002 ".strsetting($pe));
				}
				elseif (strtolower($pp[0]) == "greeting" && $pe != "") {
					if ($pe == "*") {
						$pe = "";
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "greeting $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "greeting") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "greeting $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002Greeting               \002 ".strsetting($pe));
				}
				elseif (strtolower($pp[0]) == "trigger" && $pe != "") {
					if ($pe == " ") {
						$pe = "=";
					}
					if (strlen($pe) > 1) {
						sendserv("NOTICE $nick :The trigger can't be longer than 1 character.");
						return(0);
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "trigger $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "trigger") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "trigger $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002Trigger                \002 ".strsetting($pe));
				}
				elseif (strtolower($pp[0]) == "spamservtrigger" && $pe != "" && binsetting($tsets["spamserv"]) == "On") {
					if ($pe == " ") {
						$pe = "=";
					}
					if (strlen($pe) > 1) {
						sendserv("NOTICE $nick :The trigger can't be longer than 1 character.");
						return(0);
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "spamservtrigger $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "spamservtrigger") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "spamservtrigger $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002SpamServTrigger        \002 ".strsetting($pe));
				}
				elseif (strtolower($pp[0]) == "usergreeting" && $pe != "") {
					if ($pe == "*") {
						$pe = "";
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "usergreeting $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "usergreeting") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "usergreeting $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002UserGreeting           \002 ".strsetting($pe));
				}
				elseif (strtolower($pp[0]) == "funbot" && $pe != "") {
					if ($pe == "*") {
						$pe = "";
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "funbot $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "funbot") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "funbot $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002FunBot           \002 ".strsetting($pe));
					if($pe == "0") {
						sendserv("PRIVMSG NexusFun :unreg ".$tchan);
					}elseif($pe == "1"){
						sendserv("INVITE NexusFun ".$tchan);
						sendserv("PRIVMSG NexusFun :reg ".$tchan);
					}else{
						sendserv("PRIVMSG NexusFun :unreg ".$tchan);
					}
				}
				elseif (strtolower($pp[0]) == "topic" && $pe != "") {
					if ($pe == "*") {
						$pe = "";
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "defaulttopic $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "defaulttopic") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "defaulttopic $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("TOPIC $target :$pe");
					sendserv("NOTICE $nick :\002DefaultTopic           \002 ".strsetting($pe));
				}
				elseif (strtolower($pp[0]) == "alttopic" && $pe != "") {
					if ($pe == "*") {
						$pe = "";
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "alttopic $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "alttopic") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "alttopic $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("TOPIC $target :$pe");
					sendserv("NOTICE $nick :\002AltTopic               \002 ".strsetting($pe));
				}
				elseif (strtolower($pp[0]) == "defaulttopic" && $pe != "") {
					if ($pe == "*") {
						$pe = "";
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "defaulttopic $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "defaulttopic") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
						}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "defaulttopic $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("TOPIC $target :$pe");
					sendserv("NOTICE $nick :\002DefaultTopic           \002 ".strsetting($pe));
				}
				elseif (strtolower($pp[0]) == "topicmask" && $pe != "") {
					if ($pe == "*") {
						$pe = "";
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "topicmask $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "topicmask") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "topicmask $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002TopicMask              \002 ".strsetting($pe));
				}
				elseif (strtolower($pp[0]) == "alttopicmask" && $pe != "") {
					if ($pe == "*") {
						$pe = "";
					}
					$fcont = "";
					$area = "";
					$sfound = 0;
					$arfound = 0;
					$fop = fopen("settings.conf","r+");
					while ($fra = fgets($fop)) {
						$fra = str_replace("\r","",$fra);
						$fra = str_replace("\n","",$fra);
						$frg = explode(" ",$fra);
						if ($frg[0] == "-") {
							$area = $frg[1];
							$fcont .= "- $frg[1]\r\n";
							if ($area == $tchan) {
								$arfound = 1;
								$fcont .= "alttopicmask $pe\r\n";
							}
						}
						else {
							if ($area == $tchan && $frg[0] == "alttopicmask") {
								$sfound = 1;
								$fcont .= ""; // Ignore old data.
							}
							else {
								$fcont .= "$fra\r\n";
							}
						}
					}
					fclose($fop);
					if ($sfound == 0) {
						if ($arfound == 0) {
							$fcont .= "- ".$tchan."\r\n";
							$fcont .= "alttopicmask $pe\r\n";
						}
					}
					unlink("settings.conf");
					$fop = fopen("settings.conf","w+");
					fwrite($fop,$fcont);
					fclose($fop);
					sendserv("NOTICE $nick :\002AltTopicMask           \002 ".strsetting($pe));
				}
				else {
					sendserv("NOTICE $nick :\002$pp[0]\002 is an unknown channel setting, or you may not modify it.");
				}
			}
		}
		else {
			sendserv("NOTICE $nick :You lack sufficient access to ".$chans["$tchan"]["name"]." to use this command.");
		}
	}
}