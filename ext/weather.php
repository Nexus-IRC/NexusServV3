<?php
/* ext/weather.php - NexusServV3
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
$apikey = "";   //you can get your key here: http://www.worldweatheronline.com/register.aspx after account activation you can create your apikey
                //when you have add your key bind this script with this command =bind weather extscript weather.php
$param = explode(" ",$params);
if($param[0] == "") { echo("NOTICE $nick :\002weather\002 requires more parameters."); die(); }
$url = "https://api.worldweatheronline.com/free/v1/weather.ashx?q=".urlencode($params)."&format=xml&num_of_days=5&key=".$apikey;
$data = str_replace("]]>", "", str_replace("<![CDATA[", "", file_get_contents($url)));
function object_to_array($object){
	$new=NULL;
	if(is_object($object)){
		$object=(array)$object;
	}
	if(is_array($object)){
		$new=array();
		foreach($object as $key => $val) {
			$key=preg_replace("/^\\0(.*)\\0/","",$key);
			$new[$key]=object_to_array($val);
		}
	}else{
		$new=$object;
	}
	return $new;
}
$data = simplexml_load_string($data);
$data = object_to_array($data);
if ($chan[0] == "#") {
	if ($toys == "" || $toys == "0") {
		echo("NOTICE $nick :Toys are disabled in \002$chan\002.\n");
	}
	elseif ($toys == "1") {
		if(isset($data['error']['msg'])) {
			echo("notice $nick :Unable to find a match.");
		} else {
			echo "NOTICE $nick :".$data["request"]['query']." :\n";
			echo "NOTICE $nick :".$data["weather"]['0']['date']." ".str_replace('  ', ' ', $data["weather"]['0']['weatherDesc']." ")."and min ".$data["weather"]['0']['tempMinF']."°F/".$data["weather"]['0']['tempMinC']."°C max ".$data["weather"]['0']['tempMaxF']."°F/".$data["weather"]['0']['tempMaxC']."°C\n";
			echo "NOTICE $nick :".$data["weather"]['1']['date']." ".str_replace('  ', ' ', $data["weather"]['1']['weatherDesc']." ")."and min ".$data["weather"]['1']['tempMinF']."°F/".$data["weather"]['1']['tempMinC']."°C max ".$data["weather"]['1']['tempMaxF']."°F/".$data["weather"]['1']['tempMaxC']."°C\n";
			echo "NOTICE $nick :".$data["weather"]['2']['date']." ".str_replace('  ', ' ', $data["weather"]['2']['weatherDesc']." ")."and min ".$data["weather"]['2']['tempMinF']."°F/".$data["weather"]['2']['tempMinC']."°C max ".$data["weather"]['2']['tempMaxF']."°F/".$data["weather"]['2']['tempMaxC']."°C\n";
			echo "NOTICE $nick :".$data["weather"]['3']['date']." ".str_replace('  ', ' ', $data["weather"]['3']['weatherDesc']." ")."and min ".$data["weather"]['3']['tempMinF']."°F/".$data["weather"]['3']['tempMinC']."°C max ".$data["weather"]['3']['tempMaxF']."°F/".$data["weather"]['3']['tempMaxC']."°C\n";
			echo "NOTICE $nick :".$data["weather"]['4']['date']." ".str_replace('  ', ' ', $data["weather"]['4']['weatherDesc']." ")."and min ".$data["weather"]['4']['tempMinF']."°F/".$data["weather"]['4']['tempMinC']."°C max ".$data["weather"]['4']['tempMaxF']."°F/".$data["weather"]['4']['tempMaxC']."°C\n";
		}
	}
	elseif ($toys == "2") {
		if(isset($data['error']['msg'])) {
			echo("PRIVMSG $chan :Unable to find a match.");
		} else {
			echo "PRIVMSG $chan :".$data["request"]['query']." :\n";
			echo "PRIVMSG $chan :".$data["weather"]['0']['date']." ".str_replace('  ', ' ', $data["weather"]['0']['weatherDesc']." ")."and min ".$data["weather"]['0']['tempMinF']."°F/".$data["weather"]['0']['tempMinC']."°C max ".$data["weather"]['0']['tempMaxF']."°F/".$data["weather"]['0']['tempMaxC']."°C\n";
			echo "PRIVMSG $chan :".$data["weather"]['1']['date']." ".str_replace('  ', ' ', $data["weather"]['1']['weatherDesc']." ")."and min ".$data["weather"]['1']['tempMinF']."°F/".$data["weather"]['1']['tempMinC']."°C max ".$data["weather"]['1']['tempMaxF']."°F/".$data["weather"]['1']['tempMaxC']."°C\n";
			echo "PRIVMSG $chan :".$data["weather"]['2']['date']." ".str_replace('  ', ' ', $data["weather"]['2']['weatherDesc']." ")."and min ".$data["weather"]['2']['tempMinF']."°F/".$data["weather"]['2']['tempMinC']."°C max ".$data["weather"]['2']['tempMaxF']."°F/".$data["weather"]['2']['tempMaxC']."°C\n";
			echo "PRIVMSG $chan :".$data["weather"]['3']['date']." ".str_replace('  ', ' ', $data["weather"]['3']['weatherDesc']." ")."and min ".$data["weather"]['3']['tempMinF']."°F/".$data["weather"]['3']['tempMinC']."°C max ".$data["weather"]['3']['tempMaxF']."°F/".$data["weather"]['3']['tempMaxC']."°C\n";
			echo "PRIVMSG $chan :".$data["weather"]['4']['date']." ".str_replace('  ', ' ', $data["weather"]['4']['weatherDesc']." ")."and min ".$data["weather"]['4']['tempMinF']."°F/".$data["weather"]['4']['tempMinC']."°C max ".$data["weather"]['4']['tempMaxF']."°F/".$data["weather"]['4']['tempMaxC']."°C\n";
		}
	}
}
else {
	if(isset($data['error']['msg'])) {
		echo("notice $nick :Unable to find a match.");
	} else {
		echo "NOTICE $nick :".$data["request"]['query']." :\n";
		echo "NOTICE $nick :".$data["weather"]['0']['date']." ".str_replace('  ', ' ', $data["weather"]['0']['weatherDesc']." ")."and min ".$data["weather"]['0']['tempMinF']."°F/".$data["weather"]['0']['tempMinC']."°C max ".$data["weather"]['0']['tempMaxF']."°F/".$data["weather"]['0']['tempMaxC']."°C\n";
		echo "NOTICE $nick :".$data["weather"]['1']['date']." ".str_replace('  ', ' ', $data["weather"]['1']['weatherDesc']." ")."and min ".$data["weather"]['1']['tempMinF']."°F/".$data["weather"]['1']['tempMinC']."°C max ".$data["weather"]['1']['tempMaxF']."°F/".$data["weather"]['1']['tempMaxC']."°C\n";
		echo "NOTICE $nick :".$data["weather"]['2']['date']." ".str_replace('  ', ' ', $data["weather"]['2']['weatherDesc']." ")."and min ".$data["weather"]['2']['tempMinF']."°F/".$data["weather"]['2']['tempMinC']."°C max ".$data["weather"]['2']['tempMaxF']."°F/".$data["weather"]['2']['tempMaxC']."°C\n";
		echo "NOTICE $nick :".$data["weather"]['3']['date']." ".str_replace('  ', ' ', $data["weather"]['3']['weatherDesc']." ")."and min ".$data["weather"]['3']['tempMinF']."°F/".$data["weather"]['3']['tempMinC']."°C max ".$data["weather"]['3']['tempMaxF']."°F/".$data["weather"]['3']['tempMaxC']."°C\n";
		echo "NOTICE $nick :".$data["weather"]['4']['date']." ".str_replace('  ', ' ', $data["weather"]['4']['weatherDesc']." ")."and min ".$data["weather"]['4']['tempMinF']."°F/".$data["weather"]['4']['tempMinC']."°C max ".$data["weather"]['4']['tempMaxF']."°F/".$data["weather"]['4']['tempMaxC']."°C\n";
	}
}
?>