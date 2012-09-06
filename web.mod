// cbase: webinfo
// cbase: v1-history
// cbase: history
if (strtolower($cbase) == "history") {
 sendserv("NOTICE $nick :For the ".chr(29)."ArcticServ 3.0".chr(29)." Code there is no history available.");
 sendserv("NOTICE $nick :The ".chr(29)."Version 2.0 History".chr(29)." was incomplete and has been removed");
 sendserv("NOTICE $nick :Try \002v1-history\002 for the ".chr(29)."Version ".chr(31)."1.0".chr(31).chr(29)."History");
}
if (strtolower($cbase) == "webinfo") {
 sendserv("NOTICE $nick :\0034Error.");
}
elseif (strtolower($cbase) == "v1-history") {
 sendserv("NOTICE $nick :ArcticServ version history:");
 sendserv("NOTICE $nick :Version            Coder(s)");
 sendserv("NOTICE $nick :1.0.0-dev          Calisto");
 sendserv("NOTICE $nick :1.0.0-stable       Calisto");
 sendserv("NOTICE $nick :1.5-dev            Calisto");
 sendserv("NOTICE $nick :1.5-stable         Calisto Zer0n");
 sendserv("NOTICE $nick :1.6                Calisto");
 sendserv("NOTICE $nick :1.6.1              Calisto");
 sendserv("NOTICE $nick :1.6.2              Calisto");
 sendserv("NOTICE $nick :1.6.3              Calisto");
 sendserv("NOTICE $nick :1.6.4              Calisto");
 sendserv("NOTICE $nick :1.6.5              Calisto");
 sendserv("NOTICE $nick :1.6.6              Calisto");
 sendserv("NOTICE $nick :1.6.7              Calisto");
 sendserv("NOTICE $nick :1.6.8              Calisto");
 sendserv("NOTICE $nick :1.6.9              Calisto");
 sendserv("NOTICE $nick :1.6.91             Calisto");
 sendserv("NOTICE $nick :1.6.92             Calisto");
 sendserv("NOTICE $nick :1.7.0              Calisto");
 sendserv("NOTICE $nick :1.7.0-SSL          Calisto");
 sendserv("NOTICE $nick :1.8.0-dev          Calisto");
 sendserv("NOTICE $nick :1.8.0              Calisto");
 sendserv("NOTICE $nick :1.8.1              Calisto");
 sendserv("NOTICE $nick :1.8.1a             Calisto");
 sendserv("NOTICE $nick :1.8.1a-hotfix1     Calisto");
 sendserv("NOTICE $nick :1.8.1a-hotfix2 &");
 sendserv("NOTICE $nick : -hotfix2-wgnpatch Calisto");
 sendserv("NOTICE $nick :1.9.0-wgnpatch     Calisto Zer0n");
 sendserv("NOTICE $nick :--- End of \002History\002 ---");
}