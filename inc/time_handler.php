<?php
/* inc/time_handler.php - NexusServV3
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
function str2time ($line) {
	$ttime = 0;
	$x = 0;
	$cache = "";
	while ($line[$x] != "") {
		if ($line[$x] == "1" or $line[$x] == "2" or $line[$x] == "3" or $line[$x] == "4" or $line[$x] == "5" or $line[$x] == "6" or $line[$x] == "7" or $line[$x] == "8" or $line[$x] == "9" or $line[$x] == "0") {
			$cache = $cache.$line[$x];
			$y = $x + 1;
			if ($line[$y] == "") {
				$ttime = $ttime + $cache;
				$cache = "";
			}
		}
		elseif ($line[$x] == "y") {
			$ttime = $ttime + $cache * 60 * 60 * 24 * 30 * 12;
			$cache = "";
		}
		elseif ($line[$x] == "M") {
			$ttime = $ttime + $cache * 60 * 60 * 24 * 30;
			$cache = "";
		}
		elseif ($line[$x] == "w") {
			$ttime = $ttime + $cache * 60 * 60 * 24 * 7;
			$cache = "";
		}
		elseif ($line[$x] == "d") {
			$ttime = $ttime + $cache * 60 * 60 * 24;
			$cache = "";
		}
		elseif ($line[$x] == "h") {
			$ttime = $ttime + $cache * 60 * 60;
			$cache = "";
		}
		elseif ($line[$x] == "m") {
			$ttime = $ttime + $cache * 60;
			$cache = "";
		}
		elseif ($line[$x] == "s") {
			$ttime = $ttime + $cache;;
			$cache = "";
		}
		else {
			return("I");
		}
		$x++;
	}
	return($ttime);
}

function time2str ($line) {
	$str = "";
	$years = 0;
	$months = 0;
	$wks = 0;
	$days = 0;
	$hrs = 0;
	$mins = 0;
	$secs = 0;
	$secs = $line;
	while ($secs >= 60 * 60 * 24 * 30 * 12) {
		$years++;
		$secs = $secs - 60 * 60 * 24 * 30 * 12;
	}
	while ($secs >= 60 * 60 * 24 * 30) {
		$months++;
		$secs = $secs - 60 * 60 * 24 * 30;
	}
	while ($secs >= 60 * 60 * 24 * 7) {
		$wks++;
		$secs = $secs - 60 * 60 * 24 * 7;
	}
	while ($secs >= 60 * 60 * 24) {
		$days++;
		$secs = $secs - 60 * 60 * 24;
	}
	while ($secs >= 60 * 60) {
		$hrs++;
		$secs = $secs - 60 * 60;
	}
	while ($secs >= 60) {
		$mins++;
		$secs = $secs - 60;
	}
	if ($years > 0) {
		$str = $str.$years." years ";
	}
	if ($months > 0) {
		$str = $str.$months." months ";
	}
	if ($wks > 0) {
		$str = $str.$wks." weeks ";
	}
	if ($days > 0) {
		$str = $str.$days." days ";
	}
	if ($hrs > 0) {
		$str = $str.$hrs." hours ";
	}
	if ($mins > 0) {
		$str = $str.$mins." minutes ";
	}
	if ($secs > 0 or $str == "") {
		$str = $str.$secs." seconds";
	}
	if (substr($str,strlen($str) - 1) == " ") {
		$str = substr($str,0,strlen($str) - 1);
	}
	return($str);
}
?>
