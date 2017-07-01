'
'  Project: Zabbix Agent windows Installer
'  author: Michel.Manceron@suiviperf.com
'  name: Zabbix_agent.wxs
'  Object: custom action for wix installer script for zabbix agent on windows 32b and 64b

sub ChangeConfig 
  on error resume next

  LOGFILE      = Session.Property("LOGFILE")
  InstallDir   = Session.Property("INSTALLDIR")
  HOSTNAMEFQDN = Session.Property("HOSTNAMEFQDN")
  HOSTMETADATA = Session.Property("HOSTMETADATA")
  
  if LOGFILE = "" then LOGFILE=InstallDir & "Zabbix_agentd.log" 	

  Session.Property("LOGFILE")       = LOGFILE

  

end sub
