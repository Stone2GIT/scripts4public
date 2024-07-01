# Command Line Interface scripts for rFactor 2

## General

All scripts assume that variables in _variables.ps1_ are defined - refer to comments in scripts for examples and syntax.

## Scripts

### rf2_mod_rebuilder.ps1

Script for rebuilding a mod. 

Note: needs _.dat_ file with _mod_ details named _<prefix>-<profile name>.dat_ - assumes directory _$RF2ROOT\bmp_ exists and files are located there.

ToDo: making it more dynamic.

### rf2_revert_grid.ps1

Script for grid reverting after first race session.

Note: needs to be started at client!

### rf2_server_shutdown.ps1

Script for shutting down every server with profile found in _$RF2ROOT\Userdata_ (profiles are identified by _multiplayer.json_).

Note: sends message before shutting down server (1 minute) and sends _NAV_EXIT_ in order to have logs and results written properly.

### rf2_server_startup.ps1

Script for starting up every server found by _multiplayer.json_ in _$RF2ROOT\Userdata_.

### rf2_session_switcher.ps1

Script for switching session from _testday_ to _race_ and vice versa (_td_ will be switched to _race_ and _race_ will be switched to _td_).

Note: profile / server name can be specified as _$1_ argument on command line.

### rf2_start_next_event.ps1

Script for starting next event defined by mod file. 

Note: pretty static at the moment.

ToDo: making it more dynamic.

### rf2_ws_item_installer.ps1

Script for installing items from Steam RF2 workshop by specifying SteamID.

Note: SteamIDs can be specified as a space separated list (e.g. 2547781 2887609 36587619).

### rf2_ws_item_updater.ps1

Script for updating content already being downloaded and installed.

Note: will check for SteamIDs in _$RF2ROOT\steamapps\workshop\content\365960_ and check for updates - will be installed automatically to _$RF2ROOT\Installed_.
