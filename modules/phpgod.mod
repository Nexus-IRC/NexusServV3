if (strtolower($cbase) == "phpgod") {
	// Pre-defined variable functions
	$phppath = 'php'; // Linux Path FOR EVERY FUNCTION IN THIS MODULE!
	$pr = "print_r";
	$par = "print_array";
	$af = "getArrayFromFile";
	$saf = "sendArrayToFile";
	// ----
	// Pre-defined global bot variables
	$ch = $GLOBALS['chans'];
	$ui = $GLOBALS['userinfo'];
	// ---
	$notc=false;
	$params = $paramzz;
	global $userinfo; global $botnick; global $god; $hand = new irc_handle;
	$chans = new IRC_Chan;
	$users = new IRC_User;
	$lnick = strtolower($nick);
	$acc = $userinfo["$lnick"]["auth"];
	$saxs = 0;
	$fop = fopen("staff.conf","r+");
	while ($fra = fgets($fop)) {
		$fra = str_replace("\r","",$fra);
		$fra = str_replace("\n","",$fra);
		$frg = explode(" ",$fra);
		if (strtolower($frg[0]) == strtolower($acc)) {
			$saxs = $frg[1];
		}
	}
	fclose($fop);
	if ($saxs >= 1000) {
		$dic = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890";
		if ($paramzz == "") {
			sendserv("NOTICE $nick :More parameters required:");
			sendserv("NOTICE $nick :Syntax: /MSG $botnick ".$GLOBALS['command']." <php code>");
			sendserv("NOTICE $nick :Missing parameter(s): php code");
			return(0);
		}
		$public = false;
		$la = explode(" ",$params);
		$xy = microtime(true);
		ob_start();
		// PHPGod Begin ------------------------------------------------
		if (substr($paramzz,0,strlen("http://pastebin.com/")) == "http://pastebin.com/") {
			$id = substr($paramzz,strlen("http://pastebin.com/"));
			$codecontent = file_get_contents("http://www.pastebin.com/download.php?i=$id");
			if ($codecontent == "") {
				echo("\0034ERROR\003: Unknown Paste ID.\n");
				$err_code = "yes";
			}
			else {
				echo("Running code from Paste \002ID#$id\002\n\n");
				$ID = "";
				for ($x = 0; $x < 33; $x++) {
					$ID .= $dic[rand(0,62)];
				}
				$fp = fopen("./codes/$ID","w+");
				fwrite($fp,file_get_contents("precode.php").$codecontent);
				fclose($fp);   
			}
		}
		elseif (substr($paramzz,0,strlen("http://pastebin.de/")) == "http://pastebin.de/") {
			$id = substr($paramzz,strlen("http://pastebin.de/"));
			$codecontent = file_get_contents("http://www.pastebin.de/download/?id=$id");
			if ($codecontent == "") {
				echo("\0034ERROR\003: Unknown Paste ID.\n");
				$err_code = "yes";
			}
			else {
				$uline = chr(31);
				echo("Running code from Paste \002ID#$id\002 (pastebin.{$uline}de{$uline})\n\n");
				$ID = "";
				for ($x = 0; $x < 33; $x++) {
					$ID .= $dic[rand(0,62)];
				}
				$fp = fopen("./codes/$ID","w+");
				fwrite($fp,file_get_contents("precode.php").$codecontent);
				fclose($fp);   
			}
		}
		else {
			$ID = "";
			for ($x = 0; $x < 33; $x++) {
				$ID .= $dic[rand(0,62)];
			}
			$fp = fopen("./codes/$ID","w+");
			fwrite($fp,file_get_contents("precode.php")."<?php ".$params." ?>");
			fclose($fp);
		}
		$la = shell_exec($phppath." ./codes/$ID");
		echo($la);
		if ($la == "" && $err_code != "yes") {
			echo("\0034ERROR:\003 Script returned \002nothing\002.");
		}
		// ---------------------------------------------------------------
		$dump .= ob_get_contents();
		if ($dump != "") {
			$domp = explode("\n",$dump);
			foreach ($domp as $pomp) {
				if ($cchan[0] != "#") {
					if ($pomp == "") {
						sendserv("NOTICE $nick : ");
					}
					else {
						sendserv("NOTICE $nick :$pomp");
					}
				}
				else {
					if ($pomp == "") {
						sendserv("PRIVMSG $cchan : ");
					}
					else {
						sendserv("PRIVMSG $cchan :$pomp");
					}
				}
			}
		}
		ob_end_clean();
	}
	else {
		sendserv("NOTICE $nick :You lack sufficient staff access to use this command.");
	}
}