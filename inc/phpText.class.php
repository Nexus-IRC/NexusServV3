<?php
/* inc/phpText.class.php - NexusServV3
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
 *
 *
 *TODO:
 *	1.	Add UTF-8 Support                                           [done]
 *	2.	Add more letters (KLMNOPQRSTUVWXYZ)                         [done]
 *	3.	Add more special chars ($ maybe... and.... other chars...)  [ongoing]
*/

class phpText {
	public $talias = array(
		'smiley' => "\007",
		'heart' => "\005",
		'n-reverse' => "\006",
		'zero' => '0',
		'leet' => '1337',
		'and' => '&',
		'triangle' => "\003",
	);
	public $ar1 = array (
		" " => "  ",
		"=" => "   ",
		"," => "  ",
		"#" => " # # ",
		"-" => "     ",
		"!" => "#",
		"A" => "#####",
		"B" => "#### ",
		"C" => "#####",
		"D" => "#### ",
		"E" => "#####",
		"F" => "#####",
		"G" => "#####",
		"H" => "#   #",
		"I" => "#",
		"J" => "  #",
		"K" => "#   #",
		"L" => "#    ",
		"M" => "#####",
		"N" => "##  #",
		"O" => "#####",
		"P" => "#####",
		"Q" => "#####",
		"R" => "#####",
		"S" => "#####",
		"T" => "#####",
		"U" => "#   #",
		"V" => "#   #",
		"W" => "#   #",
		"X" => "#   #",
		"Y" => "#   #",
		"Z" => "#####",
		);
	public $ar2 = array (
		" " => "  ",
		"=" => "###",
		"," => "  ",
		"#" => "#####",
		"-" => "     ",
		"!" => "#",
		"A" => "#   #",
		"B" => "#   #",
		"C" => "#    ",
		"D" => "#   #",
		"E" => "#    ",
		"F" => "#    ",
		"G" => "#    ",
		"H" => "#   #",
		"I" => "#",
		"J" => "  #",
		"K" => "#  # ",
		"L" => "#    ",
		"M" => "# # #",
		"N" => "# # #",
		"O" => "#   #",
		"P" => "#   #",
		"Q" => "#   #",
		"R" => "#   #",
		"S" => "#    ",
		"T" => "  #  ",
		"U" => "#   #",
		"V" => "#   #",
		"W" => "# # #",
		"X" => " # # ",
		"Y" => " # # ",
		"Z" => "   # ",
	);
	public $ar3 = array (
		" " => "  ",
		"=" => "   ",
		"," => "  ",
		"#" => " # # ",
		"-" => "#####",
		"!" => "#",
		"A" => "#####",
		"B" => "#####",
		"C" => "#    ",
		"D" => "#   #",
		"E" => "#####",
		"F" => "#####",
		"G" => "# ###",
		"H" => "#####",
		"I" => "#",
		"J" => "  #",
		"K" => "###  ",
		"L" => "#    ",
		"M" => "# # #",
		"N" => "#  ##",
		"O" => "#   #",
		"P" => "#####",
		"Q" => "# # #",
		"R" => "#####",
		"S" => "#####",
		"T" => "  #  ",
		"U" => "#   #",
		"V" => "#   #",
		"W" => "# # #",
		"X" => "  #  ",
		"Y" => "  #  ",
		"Z" => "  #  ",
	);
	public $ar4 = array (
		" " => "  ",
		"=" => "###",
		"," => " #",
		"#" => "#####",
		"-" => "     ",
		"!" => " ",
		"A" => "#   #",
		"B" => "#   #",
		"C" => "#    ",
		"D" => "#   #",
		"E" => "#    ",
		"F" => "#    ",
		"G" => "#   #",
		"H" => "#   #",
		"I" => "#",
		"J" => "  #",
		"K" => "#  # ",
		"L" => "#    ",
		"M" => "# # #",
		"N" => "#   #",
		"O" => "#   #",
		"P" => "#    ",
		"Q" => "#  # ",
		"R" => "#  # ",
		"S" => "    #",
		"T" => "  #  ",
		"U" => "#   #",
		"V" => " # # ",
		"W" => "# # #",
		"X" => " # # ",
		"Y" => "  #  ",
		"Z" => " #   ",
	);
	public $ar5 = array (
		" " => "  ",
		"=" => "   ",
		"," => "# ",
		"#" => " # # ",
		"-" => "     ",
		"!" => "#",
		"A" => "#   #",
		"B" => "#### ",
		"C" => "#####",
		"D" => "#### ",
		"E" => "#####",
		"F" => "#    ",
		"G" => "#####",
		"H" => "#   #",
		"I" => "#",
		"J" => "## ",
		"K" => "#   #",
		"L" => "#####",
		"M" => "#   #",
		"N" => "#   #",
		"O" => "#####",
		"P" => "#    ",
		"Q" => "### #",
		"R" => "#   #",
		"S" => "#####",
		"T" => "  #  ",
		"U" => "#####",
		"V" => "  #  ",
		"W" => "#####",
		"X" => "#   #",
		"Y" => "  #  ",
		"Z" => "#####",
	);
	function __construct () {
		// here i will add numbers and other additional chars...
			// '
		$this->ar1["'"] = "#";
		$this->ar2["'"] = "#";
		$this->ar3["'"] = " ";
		$this->ar4["'"] = " ";
		$this->ar5["'"] = " ";
			// "
		$this->ar1['"'] = "# #";
		$this->ar2['"'] = "# #";
		$this->ar3['"'] = "   ";
		$this->ar4['"'] = "   ";
		$this->ar5['"'] = "   ";
			// $
		$this->ar1['$'] = "#####";
		$this->ar2['$'] = "# #  ";
		$this->ar3['$'] = "#####";
		$this->ar4['$'] = "  # #";
		$this->ar5['$'] = "#####";
			// N reverse {n-reverse}
		$this->ar1["\006"] = "#   #";
		$this->ar2["\006"] = "#  ##";
		$this->ar3["\006"] = "# # #";
		$this->ar4["\006"] = "##  #";
		$this->ar5["\006"] = "#   #";
			// &
		$this->ar1["&"] = "  ###";
		$this->ar2["&"] = " #   ";
		$this->ar3["&"] = "# # #";
		$this->ar4["&"] = "#  # ";
		$this->ar5["&"] = "##  #";
			// ^
		$this->ar1["^"] = "  #  ";
		$this->ar2["^"] = " # # ";
		$this->ar3["^"] = "     ";
		$this->ar4["^"] = "     ";
		$this->ar5["^"] = "     ";
			// *
		$this->ar1["*"] = " # # # ";
		$this->ar2["*"] = "  ###  ";
		$this->ar3["*"] = "#######";
		$this->ar4["*"] = "  ###  ";
		$this->ar5["*"] = " # # # ";
			// +
		$this->ar1["+"] = "   #   ";
		$this->ar2["+"] = "   #   ";
		$this->ar3["+"] = "#######";
		$this->ar4["+"] = "   #   ";
		$this->ar5["+"] = "   #   ";
			// {triangle}
		$this->ar1[chr(3)] = "       ";
		$this->ar2[chr(3)] = "   #   ";
		$this->ar3[chr(3)] = "  # #  ";
		$this->ar4[chr(3)] = " #   # ";
		$this->ar5[chr(3)] = "#######";
			// {heart}
		$this->ar1[chr(5)] = " ## ## ";
		$this->ar2[chr(5)] = "#  #  #";
		$this->ar3[chr(5)] = " #   # ";
		$this->ar4[chr(5)] = "  # #  ";
		$this->ar5[chr(5)] = "   #   ";
			// {smiley}
		$this->ar1[chr(7)] = "   ";
		$this->ar2[chr(7)] = "* *";
		$this->ar3[chr(7)] = " | ";
		$this->ar4[chr(7)] = " U ";
		$this->ar5[chr(7)] = "   ";
			// Ä
		$this->ar1["Ä"] = " # # ";
		$this->ar2["Ä"] = "#####";
		$this->ar3["Ä"] = "#   #";
		$this->ar4["Ä"] = "#####";
		$this->ar5["Ä"] = "#   #";
			// Ö
		$this->ar1["Ö"] = " # # ";
		$this->ar2["Ö"] = "#####";
		$this->ar3["Ö"] = "#   #";
		$this->ar4["Ö"] = "#   #";
		$this->ar5["Ö"] = "#####";
			// Ü
		$this->ar1["Ü"] = " # # ";
		$this->ar2["Ü"] = "#   #";
		$this->ar3["Ü"] = "#   #";
		$this->ar4["Ü"] = "#   #";
		$this->ar5["Ü"] = "#####";
			// /
		$this->ar1["/"] = "    #";
		$this->ar2["/"] = "   # ";
		$this->ar3["/"] = "  #  ";
		$this->ar4["/"] = " #   ";
		$this->ar5["/"] = "#    ";
			// \
		$this->ar1["\\"] = "#    ";
		$this->ar2["\\"] = " #   ";
		$this->ar3["\\"] = "  #  ";
		$this->ar4["\\"] = "   # ";
		$this->ar5["\\"] = "    #";
			// }
		$this->ar1["}"] = "###  ";
		$this->ar2["}"] = "   # ";
		$this->ar3["}"] = "    #";
		$this->ar4["}"] = "   # ";
		$this->ar5["}"] = "###  ";
			// {
		$this->ar1["{"] = "  ###";
		$this->ar2["{"] = " #   ";
		$this->ar3["{"] = "#    ";
		$this->ar4["{"] = " #   ";
		$this->ar5["{"] = "  ###";
			// )
		$this->ar1[")"] = "#  ";
		$this->ar2[")"] = " # ";
		$this->ar3[")"] = "  #";
		$this->ar4[")"] = " # ";
		$this->ar5[")"] = "#  ";
			// (
		$this->ar1["("] = "  #";
		$this->ar2["("] = " # ";
		$this->ar3["("] = "#  ";
		$this->ar4["("] = " # ";
		$this->ar5["("] = "  #";
			// :
		$this->ar1[":"] = " ";
		$this->ar2[":"] = "#";
		$this->ar3[":"] = " ";
		$this->ar4[":"] = "#";
		$this->ar5[":"] = " ";
			// ?
		$this->ar1["?"] = "#####";
		$this->ar2["?"] = "  ###";
		$this->ar3["?"] = "  #  ";
		$this->ar4["?"] = "     ";
		$this->ar5["?"] = "  #  ";
			// .
		$this->ar1["."] = " ";
		$this->ar2["."] = " ";
		$this->ar3["."] = " ";
		$this->ar4["."] = " ";
		$this->ar5["."] = "#";
			// ;
		$this->ar1[";"] = "  ";
		$this->ar2[";"] = " #";
		$this->ar3[";"] = "  ";
		$this->ar4[";"] = " #";
		$this->ar5[";"] = "# ";
			// 0
		$this->ar1["0"] = "#####";
		$this->ar2["0"] = "#  ##";
		$this->ar3["0"] = "# # #";
		$this->ar4["0"] = "##  #";
		$this->ar5["0"] = "#####";
			// 1
		$this->ar1["1"] = "  #";
		$this->ar2["1"] = " ##";
		$this->ar3["1"] = "# #";
		$this->ar4["1"] = "  #";
		$this->ar5["1"] = "  #";
			// 2
		$this->ar1["2"] = "#####";
		$this->ar2["2"] = "    #";
		$this->ar3["2"] = "#####";
		$this->ar4["2"] = "#    ";
		$this->ar5["2"] = "#####";
			// 3
		$this->ar1["3"] = "#####";
		$this->ar2["3"] = "    #";
		$this->ar3["3"] = "#####";
		$this->ar4["3"] = "    #";
		$this->ar5["3"] = "#####";
			// 4
		$this->ar1["4"] = "#  # ";
		$this->ar2["4"] = "#  # ";
		$this->ar3["4"] = "#####";
		$this->ar4["4"] = "   # ";
		$this->ar5["4"] = "   # ";
			// 5
		$this->ar1["5"] = "#####";
		$this->ar2["5"] = "#    ";
		$this->ar3["5"] = "#####";
		$this->ar4["5"] = "    #";
		$this->ar5["5"] = "#### ";
			// 6
		$this->ar1["6"] = "#####";
		$this->ar2["6"] = "#    ";
		$this->ar3["6"] = "#####";
		$this->ar4["6"] = "#   #";
		$this->ar5["6"] = "#####";
			// 7
		$this->ar1["7"] = "#####";
		$this->ar2["7"] = "   # ";
		$this->ar3["7"] = "  #  ";
		$this->ar4["7"] = " #   ";
		$this->ar5["7"] = "#    ";
			// 8
		$this->ar1["8"] = "#####";
		$this->ar2["8"] = "#   #";
		$this->ar3["8"] = "#####";
		$this->ar4["8"] = "#   #";
		$this->ar5["8"] = "#####";
			// 9
		$this->ar1["9"] = "#####";
		$this->ar2["9"] = "#   #";
		$this->ar3["9"] = "#####";
		$this->ar4["9"] = "    #";
		$this->ar5["9"] = "#####";		
			// ß
		$this->ar1["ß"] = "ß";
		$this->ar2["ß"] = "ß";
		$this->ar3["ß"] = "ß";
		$this->ar4["ß"] = "ß";
		$this->ar5["ß"] = "ß";
			// %
		$this->ar1["%"] = "###   #  ";
		$this->ar2["%"] = "# #  #   ";
		$this->ar3["%"] = "### # ###";
		$this->ar4["%"] = "   #  # #";
		$this->ar5["%"] = "  #   ###";
			// `
		$this->ar1["`"] = "# ";
		$this->ar2["`"] = " #";
		$this->ar3["`"] = "  ";
		$this->ar4["`"] = "  ";
		$this->ar5["`"] = "  ";
			// ~
		$this->ar1["~"] = "       ";
		$this->ar2["~"] = " ##    ";
		$this->ar3["~"] = "#  #  #";
		$this->ar4["~"] = "    ## ";
		$this->ar5["~"] = "       ";
		// --- end ---
		$xchar = (func_get_arg(0) != "") ? func_get_arg(0) : "#"; // The char to use for "big letters"
		$this->xchar = $xchar;
	}
	function bracketCheck ($input, &$error) {
		$i = 0;
		while (@$input[$i] != "") {
			if ($bracket == 0) {
				if ($input[$i] == "{") {
					if (@$escape != true) {
						$bracket = 1;
					} else {
						@$newinput .= "{";
						unset($escape);
					}
				} elseif ($input[$i] == "}") {
					if (@$escape != true) {
						$error = "There is no bracket to be closed.";
						return(0);
					} else {
						@$newinput .= "}";
						unset($escape);
					}
				} elseif ($input[$i] == "\\") {
					if (@$escape == true) {
						@$newinput .= "\\";
						unset($escape);
					} else {
						$escape = true;
					}
				} else {
					if ($escape == true) {
						$error = "Invalid escaping \002outside a bracket\002.";
						return(0);
					} else {
						$newinput .= $input[$i];
					}
				}
			}
			else {
				if ($input[$i] == "}" && $escape != true) {
					$bracket = 0;
					if ($this->talias[$btext] != "") {
						@$newinput .= @$this->talias[$btext];
					} else {
						if ($btext == "?") {
							$error = "List of aliases:\n";
							foreach ($this->talias as $alias => $ali) {
								$error .= "$alias\n";
							}
							return(0);
						}
						elseif ($btext == "[bot]") { // only for ircbots using $botnick global variable
							@$newinput .= $GLOBALS['botnick'];
						}
						elseif ($btext == "null" || $btext == "[null]") {
							// null means nothing. So add nothing!
						}
						elseif (substr($btext,0,6) == "alias ") {
							$newal = explode("=",substr($btext,6));
							$nname = $newal[0];
							unset($newal[0]);
							$xb = implode("=",$newal);
							@$this->talias[$nname] .= $xb;
						}
						elseif (substr($btext,0,5) == "link ") {
							$newal = explode(" ",substr($btext,5));
							if (!isset($this->talias[$newal[1]])) {
								$error = "Alias \"$newal[1]\" is not set.";
								return(0);
							} else {
								$this->talias[$newal[0]] = $this->talias[$newal[1]];
							}
						}
						elseif (substr($btext,0,4) == "new ") {
							$newal = explode("=",substr($btext,4));
							$nname = $newal[0];
							unset($newal[0]);
							foreach ($newal as $int) {
								@$this->talias[$nname] .= chr($int);
							}
						}
						elseif (substr($btext,0,4) == "chr ") {
							$this->xchar = substr($btext,4);
						}
						elseif (substr($btext,0,6) == "color ") {
							$this->xchar = "\003".substr($btext,6).",".substr($btext,6)." \003";
						}
						elseif (substr($btext,0,8) == "nospace ") {
							$error = "This alias was removed due to several bugs.";
							return(0);
						}
						elseif (substr($btext,0,5) == "char ") {
							$spl = explode(" ",$btext);
							@$newinput .= str_repeat(chr($spl[1]),(isset($spl[2]) ? $spl[2] : 1));
						}
						else {
							$error = "Unknown alias \"$btext\"";
							return(0);
						}
					}
					$btext = "";
				}
				else {
					if ($input[$i] == "\\") {
						if (@$escape != true) {
							$escape = true;
						} else {
							@$btext .= "\\";
							unset($escape);
						}
					}
					elseif ($input[$i] == "}") {
						@$btext .= "}";
						unset($escape);
					}
					else {
						if ($escape == true) {
							$error = "Invalid escaping \002inside a bracket\002.";
							return(0);
						} else {
							@$btext .= $input[$i];
						}
					}
				}
			}
			$i++;
		}
		if ($bracket == 1) {
			$error = "Bracket wasn't closed.";
			return(0);
		}
		return($newinput);
	}
	function convert ($input) {
		$this->schar = chr(160);
		if ($input == "") {
			return("You need to provide text that can be converted to big letters.");
		}
		$input = $this->bracketCheck($input,$error);
		$this->ar1 = str_replace("#",$this->xchar,$this->ar1);
		$this->ar2 = str_replace("#",$this->xchar,$this->ar2);
		$this->ar3 = str_replace("#",$this->xchar,$this->ar3);
		$this->ar4 = str_replace("#",$this->xchar,$this->ar4);
		$this->ar5 = str_replace("#",$this->xchar,$this->ar5);
		$input = strtoupper(utf8_decode($input));
		if ($error) {
			return($error);
		}
		$i = 0; $y = 0;
		while (@$input[$i] != "") {
			$line1 = $this->conv1($input[$i]);
			$line2 = $this->conv2($input[$i]);
			$line3 = $this->conv3($input[$i]);
			$line4 = $this->conv4($input[$i]);
			$line5 = $this->conv5($input[$i]);
			if (@$text[1] != "") {
				@$text[1] .= $this->schar.$this->schar.$line1;
			}
			else {
				@$text[1] .= $line1;
			}
			if (@$text[2] != "") {
				@$text[2] .= $this->schar.$this->schar.$line2;
			}
			else {
				@$text[2] .= $line2;
			}
			if (@$text[3] != "") {
				@$text[3] .= $this->schar.$this->schar.$line3;
			}
			else {
				@$text[3] .= $line3;
			}
			if (@$text[4] != "") {
				@$text[4] .= $this->schar.$this->schar.$line4;
			}
			else {
				@$text[4] .= $line4;
			}
			if (@$text[5] != "") {
				@$text[5] .= $this->schar.$this->schar.$line5;
			}
			else {
				@$text[5] .= $line5;
			}
			$i++; $y++;
		}
		foreach ($text as $tnum => $cont) {
		 @$nido .= $cont."\n";
		}
		return($nido);
	}
	function conv1 ($char) {
		return (isset($this->ar1[$char]) ? str_replace(" ",chr(160),$this->ar1[$char]) : str_repeat(chr(160),5));
	}
	function conv2 ($char) {
		return (isset($this->ar2[$char]) ? str_replace(" ",chr(160),$this->ar2[$char]) : str_repeat(chr(160),5));
	}	
	function conv3 ($char) {
		return (isset($this->ar3[$char]) ? str_replace(" ",chr(160),$this->ar3[$char]) : str_repeat(chr(160),2).$char.str_repeat(chr(160),2));
	}	
	function conv4 ($char) {
		return (isset($this->ar4[$char]) ? str_replace(" ",chr(160),$this->ar4[$char]) : str_repeat(chr(160),5));
	}	
	function conv5 ($char) {
		return (isset($this->ar5[$char]) ? str_replace(" ",chr(160),$this->ar5[$char]) : str_repeat(chr(160),5));
	}	
}

?>
