'
'  Project: Zabbix Agent windows Installer
'  author: Michel.Manceron@suiviperf.com
'  name: Zabbix_agent.wxs
'  Object: custom action for wix installer script for zabbix agent on windows 32b and 64b

sub ChangeConfig 
  on error resume next
  dim RCMD
  RCMD         = Session.Property("RMTCMD")
  LOGFILE      = Session.Property("LOGFILE")
  HOSTNAME     = Session.Property("HOSTNAME")
  InstallDir   = Session.Property("INSTALLDIR")
  HOSTNAMEFQDN = Session.Property("HOSTNAMEFQDN")
  HOSTMETADATA = Session.Property("HOSTMETADATA")
  
  if RCMD <> "1" then RCMD ="0"
  if HOSTNAMEFQDN <> "1" then HOSTNAMEFQDN="0"
  if LOGFILE = "" then LOGFILE=InstallDir & "Zabbix_agentd.log" 	
  if HOSTNAME = "" then HOSTNAME = session.Property("ComputerName")

  Session.Property("RMTCMD")        = RCMD
  Session.Property("LOGFILE")       = LOGFILE
  Session.Property("HOSTNAME")      = HOSTNAME 
  Session.Property("HOSTNAMEFQDN")  = HOSTNAMEFQDN
  
  

end sub
function readFromRegistry (strRegistryKey, strDefault )
    Dim WSHShell, value

    On Error Resume Next
    Set WSHShell = CreateObject("WScript.Shell")
    value = WSHShell.RegRead( strRegistryKey )

    if err.number <> 0 then
        readFromRegistry= strDefault
    else
        readFromRegistry=value
    end if

    set WSHShell = nothing
end function


sub hostnamefqdn
mydomain = readfromRegistry("HKLM\SYSTEM\CurrentControlSet\services\Tcpip\Parameters\Domain", "local")
HOSTNAME = Session.Property("HOSTNAME")
 if InStr (HOSTNAME,".") = 0 then 
	if mydomain <> "" then HOSTNAME = HOSTNAME + "." + mydomain
	Session.property ("HOSTNAME") =  LCase(HOSTNAME) 
end if 
end sub
