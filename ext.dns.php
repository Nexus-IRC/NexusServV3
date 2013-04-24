<?php
/* ext.dns.php - NexusServV3
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
if (str_replace("::ip","",$params) != $params) {
	$params = implode(".",array_reverse(explode(".",str_replace("::ip","",$params)))).".in-addr.arpa";
}
$param = explode(" ",$params);
if ($chan[0] == "#") {
	if ($toys == "" || $toys == "0") {
		echo("NOTICE $nick :Toys are disabled in \002$chan\002.\n");
	}
	elseif ($toys == "1") {
		if($param[0] == NULL){ echo("PRIVMSG $chan :Invalid Hostname.\n"); } 
		else {
			if(strtolower($param[1]) == "soa"){
				$xx = dns_get_record($param[0]);
				echo("NOTICE $nick :DNS Records for \002".$param[0]."\002: (SOA)\n");
				foreach ($xx as $ipar) {
					if ($ipar['type'] == 'SOA') {
						$mname = $ipar['mname'];
						$serial = $ipar['serial'];
						$refresh = $ipar['refresh'];
						$retry = $ipar['retry'];
						$expire = $ipar['expire'];
						$ttl = $ipar['ttl'];
					}
				}
				echo("NOTICE $nick : SOA    (Start of Authority):\n");
				echo("NOTICE $nick :    name:     ".$mname."\n");
				echo("NOTICE $nick :    serial:   ".$serial."\n");
				echo("NOTICE $nick :    refresh:  ".$refresh."\n");
				echo("NOTICE $nick :    retry:    ".$retry."\n");
				echo("NOTICE $nick :    expire:   ".$expire."\n");
				echo("NOTICE $nick :    TTL:      ".$ttl."\n");	   
			}else{
				$xx = dns_get_record($param[0]);
				$xc = 0;
				echo("NOTICE $nick :DNS Records for \002".$param[0]."\002:\n");
				foreach ($xx as $ipar) {
					if ($ipar['type'] == 'AAAA') {
						$ip = '   '.$ipar['ipv6'];
					}
					if ($ipar['type'] == 'A') {
						$ip = '      '.$ipar['ip'];
					}
					if ($ipar['type'] == 'SOA') {
						$ip = '    (see: dns '.$param[0].' SOA)';
					}
					if ($ipar['type'] == 'TXT') {
						$ip = '    '.$ipar['txt'];
					}
					if ($ipar['type'] == 'CNAME') {
						$ip = '  '.$ipar['target'];
					}
					if ($ipar['type'] == 'NS') {
						$ip = '     '.$ipar['target'];
					}
					if ($ipar['type'] == 'MX') {
						$ip = '     '.$ipar['target'].' (priority: '.$ipar['pri'].')';
					}
					if ($ipar['type'] == 'PTR') {
						$ip = $ipar['target'];
					}
					if ($ipar['type'] == '') {
						$ipar['type'] = '0';
						$ip = '      EMPTY_DNS';
					}
					if ($ipar['type'] == 'NAPTR') {
						$ipar['type'] = '0';
						$ip = '  EMPTY_DNS';
					}
					if($ipar['type'] == "0"){
					}else{
						echo("NOTICE $nick :\002".$ipar['type']."\002 ".$ip."\n");
					}
					$xc++;
				}
				echo("NOTICE $nick :\002$xc\002 records found.\n");
			}
		}
	}
	elseif ($toys == "2") {
		if($param[0] == NULL){ echo("PRIVMSG $chan :Invalid Hostname.\n"); } 
		else {
			if(strtolower($param[1]) == "soa"){ 
				$xx = dns_get_record($param[0]);
				echo("PRIVMSG $chan :DNS Records for \002".$param[0]."\002: (SOA)\n");
				foreach ($xx as $ipar) {
					if ($ipar['type'] == 'SOA') {
						$mname = $ipar['mname'];
						$serial = $ipar['serial'];
						$refresh = $ipar['refresh'];
						$retry = $ipar['retry'];
						$expire = $ipar['expire'];
						$ttl = $ipar['ttl'];
					}
				}
				echo("PRIVMSG $chan : SOA    (Start of Authority):\n");
				echo("PRIVMSG $chan :    name:     ".$mname."\n");
				echo("PRIVMSG $chan :    serial:   ".$serial."\n");
				echo("PRIVMSG $chan :    refresh:  ".$refresh."\n");
				echo("PRIVMSG $chan :    retry:    ".$retry."\n");
				echo("PRIVMSG $chan :    expire:   ".$expire."\n");
				echo("PRIVMSG $chan :    TTL:      ".$ttl."\n");	   
			}else{
				$xx = dns_get_record($param[0]);
				$xc = 0;
				echo("PRIVMSG $chan :DNS Records for \002".$param[0]."\002:\n");
				foreach ($xx as $ipar) {
					if ($ipar['type'] == 'AAAA') {
						$ip = '   '.$ipar['ipv6'];
					}
					if ($ipar['type'] == 'A') {
						$ip = '      '.$ipar['ip'];
					}
					if ($ipar['type'] == 'SOA') {
						$ip = '    (see: dns '.$param[0].' SOA)';
					}
					if ($ipar['type'] == 'TXT') {
						$ip = '    '.$ipar['txt'];
					}
					if ($ipar['type'] == 'CNAME') {
						$ip = '  '.$ipar['target'];
					}
					if ($ipar['type'] == 'NS') {
						$ip = '     '.$ipar['target'];
					}
					if ($ipar['type'] == 'MX') {
						$ip = '     '.$ipar['target'].' (priority: '.$ipar['pri'].')';
					}
					if ($ipar['type'] == 'PTR') {
						$ip = $ipar['target'];
					}
					if ($ipar['type'] == '') {
						$ipar['type'] = '0';
						$ip = '      EMPTY_DNS';
					}
					if ($ipar['type'] == 'NAPTR') {
						$ipar['type'] = '0';
						$ip = '  EMPTY_DNS';
					}
					if($ipar['type'] == "0"){
					}else{
						echo("PRIVMSG $chan :\002".$ipar['type']."\002 ".$ip."\n");
					}
					$xc++;
				}
				echo("PRIVMSG $chan :\002$xc\002 records found.\n");
			}
		}
	}
}
else {
	if($param[0] == NULL){ echo("PRIVMSG $chan :Invalid Hostname.\n"); } 
	else {
		if(strtolower($param[1]) == "soa"){
			$xx = dns_get_record($param[0]);
			echo("NOTICE $nick :DNS Records for \002".$param[0]."\002: (SOA)\n");
			foreach ($xx as $ipar) {
					if ($ipar['type'] == 'SOA') {
					$mname = $ipar['mname'];
					$serial = $ipar['serial'];
					$refresh = $ipar['refresh'];
					$retry = $ipar['retry'];
					$expire = $ipar['expire'];
					$ttl = $ipar['ttl'];
				}
			}
			echo("NOTICE $nick : SOA    (Start of Authority):\n");
			echo("NOTICE $nick :    name:     ".$mname."\n");
			echo("NOTICE $nick :    serial:   ".$serial."\n");
			echo("NOTICE $nick :    refresh:  ".$refresh."\n");
			echo("NOTICE $nick :    retry:    ".$retry."\n");
			echo("NOTICE $nick :    expire:   ".$expire."\n");
			echo("NOTICE $nick :    TTL:      ".$ttl."\n");	   
		}else{
			$xx = dns_get_record($param[0]);
			$xc = 0;
			echo("NOTICE $nick :DNS Records for \002".$param[0]."\002:\n");
			foreach ($xx as $ipar) {
				if ($ipar['type'] == 'AAAA') {
					$ip = '   '.$ipar['ipv6'];
				}
				if ($ipar['type'] == 'A') {
					$ip = '      '.$ipar['ip'];
				}
				if ($ipar['type'] == 'SOA') {
					$ip = '    (see: dns '.$param[0].' SOA)';
				}
				if ($ipar['type'] == 'TXT') {
					$ip = '    '.$ipar['txt'];
				}
				if ($ipar['type'] == 'CNAME') {
					$ip = '  '.$ipar['target'];
				}
				if ($ipar['type'] == 'NS') {
					$ip = '     '.$ipar['target'];
				}
				if ($ipar['type'] == 'MX') {
					$ip = '     '.$ipar['target'].' (priority: '.$ipar['pri'].')';
				}
					if ($ipar['type'] == 'PTR') {
				$ip = $ipar['target'];
				}
				if ($ipar['type'] == '') {
					$ipar['type'] = '0';
					$ip = '      EMPTY_DNS';
				}
				if ($ipar['type'] == 'NAPTR') {
					$ipar['type'] = '0';
					$ip = '  EMPTY_DNS';
				}
				if($ipar['type'] == "0"){
				}else{
					echo("NOTICE $nick :\002".$ipar['type']."\002 ".$ip."\n");
				}
				$xc++;
			}
			echo("NOTICE $nick :\002$xc\002 records found.\n");
		}
	}
}
?>
