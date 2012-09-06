<?php
include("phpTextWrite.class.php"); // Text writer include...
$phpText = new phpText(chr(22)." ".chr(22));

 if ($chan[0] == "#") {
  if ($toys == "" || $toys == "0") {
   echo("NOTICE $nick :Toys are disabled in \002$chan\002.\n");
  }
  elseif ($toys == "1") {
   		$xy = explode("\n",$phpText->convert($params));
		foreach ($xy as $line) {
			if ($line != "") {
				echo("NOTICE $nick :".utf8_encode($line)."\n");
			}
		}
  }
  elseif ($toys == "2") {
   		$xy = explode("\n",$phpText->convert($params));
		foreach ($xy as $line) {
			if ($line != "") {
				echo("PRIVMSG $chan : ".utf8_encode($line)."\n");
			}
		}
  }
 }
 else {
   		$xy = explode("\n",$phpText->convert($params));
		foreach ($xy as $line) {
			if ($line != "") {
				echo("NOTICE $nick :".utf8_encode($line)."\n");
			}
		}
 }
?>