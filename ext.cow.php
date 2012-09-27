<?php
if ($chan[0] == "#") {
	if ($toys == "" || $toys == "0") {
		echo("NOTICE $nick :Toys are disabled in \002$chan\002.\n");
	}
	elseif ($toys == "1") {
		echo("NOTICE $nick :\002The cow is coming!!!\002\n");
		echo("NOTICE $nick : \n");
		$xx = shell_exec("apt-get moo");
		$xy = explode("\n",str_replace("\r","",$xx));
		foreach ($xy as $xl) {
			echo("NOTICE $nick :$xl\n");
		}
		echo("NOTICE $nick : \n");
		echo("NOTICE $nick :Yeehaw!!!\n");
	}
	elseif ($toys == "2") {
		echo("PRIVMSG $chan :\002The cow is coming!!!\002\n");
		echo("PRIVMSG $chan : \n");
		$xx = shell_exec("apt-get moo");
		$xy = explode("\n",str_replace("\r","",$xx));
		foreach ($xy as $xl) {
			echo("PRIVMSG $chan :$xl\n");
		}
		echo("PRIVMSG $chan : \n");
		echo("PRIVMSG $chan :Yeehaw!!!\n");
	}
}
else {
	echo("NOTICE $nick :\002The cow is coming!!!\002\n");
	echo("NOTICE $nick : \n");
	$xx = shell_exec("apt-get moo");
	$xy = explode("\n",str_replace("\r","",$xx));
	foreach ($xy as $xl) {
		echo("NOTICE $nick :$xl\n");
	}
	echo("NOTICE $nick : \n");
	echo("NOTICE $nick :Yeehaw!!!\n");
}
?>
