<?php 
     
     if (!function_exists('fnmatch')) { 
         function fnmatch($pattern, $string, $flags = 0) { 
             return(true);
         } 
     } 
     
?>