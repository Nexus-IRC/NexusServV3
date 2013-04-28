<?php
/* inc/dns.class.php - NexusServV3
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
class dns {
	function time2str($time, $anz = 9) {
		$str="";
		if(!$anz) $anz=9;
		if($time>=(60*60*24*365) && $anz > 0) {
			$anz--;
			$years=floor($time/(60*60*24*365));
			$str.=$years."Y";
			$time=$time-((60*60*24*365)*$years);
		}
		if($time>=(60*60*24*30) && $anz > 0) {
			$anz--;
			$months=floor($time/(60*60*24*30));
			if($str != "") $str.=" ";
			$str.=$months."M";
			$time=$time-((60*60*24*30)*$months);
		}
		if($time>=(60*60*24) && $anz > 0) {
			$anz--;
			$days=floor($time/(60*60*24));
			if($str != "") $str.=" ";
			$str.=$days."d";
			$time=$time-((60*60*24)*$days);
		}
		if($time>=(60*60) && $anz > 0) {
			$anz--;
			$stunden=floor($time/(60*60));
			if($str != "") $str.=" ";
			$str.=$stunden."h";
			$time=$time-((60*60)*$stunden);
		}
		if($time>=(60) && $anz > 0) {
			$anz--;
			$min=floor($time/(60));
			if($str != "") $str.=" ";
			$str.=$min."m";
			$time=$time-((60)*$min);
		}
		if(($time>1 || $str == "") && $anz > 0){
			$anz--;
			if($str != "") $str.=" ";
			$str.=$time."s";
		}
		return $str;
	}

	function show_subrecords($host) {
		$return = "";
		$dns = dns_get_record($host, DNS_ALL);
		if(count($dns)) {
			usort($dns, array($this, "sort_records"));
			foreach($dns as $record) {
				switch($record['type']) {
					case "A":
						$return .="   \002A     \002 ".$record['ip'].($record['ttl'] < 86400 ? "  (ttl: ".$this->time2str($record['ttl'],2).")" : "")."\n";
						break;
					case "AAAA":
						$return .="   \002AAAA  \002 ".$record['ipv6'].($record['ttl'] < 86400 ? "  (ttl: ".$this->time2str($record['ttl'],2).")" : "")."\n";
						break;
					case "CNAME":
						$return .="   \002CNAME \002 ".$record['target']."\n";
						break;
				}
			}
		}
		return $return;
	}

	static function sort_records($a, $b) {
		$record_order = array("SOA", "NS", "A", "AAAA", "MX");
		$index_a = array_search($a['type'], $record_order);
		if($index_a === FALSE) $index_a = count($record_order);
		$index_b = array_search($b['type'], $record_order);
		if($index_b === FALSE) $index_b = count($record_order);
		$order = $index_a - $index_b;
		if($order == 0) {
			switch($record['type']) {
			case "A":
				$suborder = "ip";
				break;
			case "AAAA":
				$suborder = "ipv6";
				break;
			case "TXT":
				$suborder = "txt";
				break;
			default:
				$suborder = "target";
				break;
			}
			$order = strcmp($a[$suborder], $b[$suborder]);
		}
		return $order;
	}
	
	function get ($host,$show_record) {
		$pattern_ipv6 = '/^((([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}:[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){5}:([0-9A-Fa-f]{1,4}:)?[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){4}:([0-9A-Fa-f]{1,4}:){0,2}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){3}:([0-9A-Fa-f]{1,4}:){0,3}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){2}:([0-9A-Fa-f]{1,4}:){0,4}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|(([0-9A-Fa-f]{1,4}:){0,5}:((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|(::([0-9A-Fa-f]{1,4}:){0,5}((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|([0-9A-Fa-f]{1,4}::([0-9A-Fa-f]{1,4}:){0,5}[0-9A-Fa-f]{1,4})|(::([0-9A-Fa-f]{1,4}:){0,6}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){1,7}:))(|\/[0-9]{1,3})$/';
		$pattern_ipv4 = '/^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}(|\/[0-9]{1,2})$/';
		$return ="";
		if(strlen($host) && preg_match("#^((([a-z0-9-.]*)\.|)([a-z]{2,5})|).?$#i", $host)) {
			$dns = dns_get_record($host, DNS_ALL);
			$return .="DNS Records for \002".$host."\002:";
			if($show_record != "" && $show_record != "*" && $show_record != "ANY")
				$return .=" (".$show_record.")";
			$return .="\n";
			if(count($dns)) {
				usort($dns, array($this, "sort_records"));
				foreach($dns as $record) {
					if($show_record != "" && $show_record != "*" && $show_record != "ANY" && $show_record != $record['type'])
						continue;
					switch($record['type']) {
						case "A":
							$return .=" \002A     \002 ".$record['ip'].($record['ttl'] < 86400 ? "  (ttl: ".$this->time2str($record['ttl'],2).")" : "")."\n";
							break;
						case "AAAA":
							$return .=" \002AAAA  \002 ".$record['ipv6'].($record['ttl'] < 86400 ? "  (ttl: ".$this->time2str($record['ttl'],2).")" : "")."\n";
							break;
						case "MX":
							$return .=" \002MX    \002 ".$record['target']." (priority: ".$record['pri'].")\n";
							if($show_record == "MX") {
								$return .= $this->show_subrecords($record['target']);
							}
							break;
						case "NS":
							$return .=" \002NS    \002 ".$record['target']."\n";
							if($show_record == "NS") {
								$return .= $this->show_subrecords($record['target']);
							}
							break;
						case "CNAME":
							$return .=" \002CNAME \002 ".$record['target']."\n";
							break;
						case "TXT":
							$return .=" \002TXT   \002 ".$record['txt']."\n";
							break;
						case "SOA":
							if($show_record != "SOA") {
								$return .=" \002SOA   \002 (see: dns ".$host." SOA)\n";
								break;
							}
							$return .=" \002SOA   \002 (Start of Authority):\n";
							$return .="    name:     ".$record['mname']."\n";
							$return .="    serial:   ".$record['serial']."\n";
							$return .="    refresh:  ".$record['refresh']." (".$this->time2str($record['refresh'], 2).")\n";
							$return .="    retry:    ".$record['retry']." (".$this->time2str($record['retry'], 2).")\n";
							$return .="    expire:   ".$record['expire']." (".$this->time2str($record['expire'], 2).")\n";
							$return .="    TTL:      ".$record['minimum-ttl']." (".$this->time2str($record['minimum-ttl'], 2).")\n";
							break;
					}
				}
			} else
				$return .="No records found.\n";
		} else if(preg_match($pattern_ipv4, $host) || preg_match($pattern_ipv6, $host)) {
			$hostname = gethostbyaddr($host);
			$return .="Reverse Lookup for \002".$host."\002:\n";
			$return .= " \002PTR  \002 ".$hostname."\n";
		} else {
			$return .="Invalid Hostname or IP-Address.\n";
		}
		return $return;
	}
}
?>