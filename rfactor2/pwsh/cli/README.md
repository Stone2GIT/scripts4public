# Command Line Interface scripts for rFactor 2

## rf2_session_switcher.ps1

This is a Windows Powershell script which can be used with rFactor 2 Dedicated Server. It needs to be copied to *rfactor 2 root*.

If the server is running in *test day mode* it will change to normal *race weekend* and set *no pause* option; if the server is
running in *race weekend* the script will change to *test day mode* with *zero players* option enabled, which causes the DS to
write back all logfiles when the last driver leaves the server / session.

Limitations:

- needs to be copied and executed at *rfactor 2 root*

Usage:

- .\rf2_session_switcher.ps1 \<profile\> *profile defaults to player*

## rf2_server_shutdown.ps1

This is a Windows Powershell script which can be used with rFactor 2 Dedicated Server. It needs to be copied to *rfactor 2 root*.

It shuts down rFactor 2 Dedicated Server after sending a chat message to connected players and by waiting about a minute.

Limitations:

- needs to be copied and executed at *rfactor 2 root*

Usage:

- .\rf2_server_shutdown.ps1 \[profile]> *shutdown ds for all profiles if not specified*

## rf2_server_startup.ps1

This is a Windows Powershell script which can be used with rFactor 2 Dedicated Server. It needs to be copied to *rfactor 2 root*.

It starts rFactor 2 Dedicated Server.

Limitations:

- needs to be copied and executed at *rfactor 2 root*

Usage:

- .\rf2_server_startup.ps1 \[profile]> *starts ds for all profiles if not specified*

## rf2_revert_grid.ps1

This is a Windows Powershell script which can be used with rFactor 2 Client. It needs to be copied to *rfactor 2 root*.

Once executed the scripts waits until race has been finsihed and then restarts the race weekend in order to proceed
to warmup, reverting the grid and switch to second race afterwards.

Grid reversion is based on race results of first session.

Usage:

- .\rf2_revert_grid.ps1

## rf2_ws_item_installer.ps1

This is a Windows Powershell script which can be used with rFactor 2 Dedicated Server and Client. It needs to be copied to *rfactor 2 root*.

Given workshop item IDs will be installed.

Usage:

- .\rf2_ws_item_installer.ps1 \<steamid\> \<steamid\> ...

