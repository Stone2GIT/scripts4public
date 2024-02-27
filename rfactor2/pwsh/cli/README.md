# Command Line Interface scripts for rFactor 2

## rf2_session_switcher.ps1

This is a Windows Powershell script which can be used with rFactor 2 Dedicated Server. It needs to be copied to *rfactor 2 root*.

If the server is running in *test day mode* it will change to normal *race weekend* and set *no pause* option; if the server is
running in *race weekend* the script will change to *test day mode* with *zero players* option enabled, which causes the DS to
write back all logfiles when the last driver leaves the server / session.

Limitations:
- needs to be copied and executed at *rfactor 2 root*
- assumes rFactor 2 dedicated server is running at default port 5397 (can be changed inside script)
- assumes rFactor 2 dedicated server profile is *player* (can be changed inside script)

Usage:

- .\rf2_session_switcher.ps1 <profile> 

*profile defaults to player*
