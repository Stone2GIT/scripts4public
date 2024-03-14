﻿#
# simple script in order to update workshop items
#
# Dietmar Stein, 03/2024, info@simracingjustfair.org
#

# source variables
. ./variables.ps1

# getting SteamIDs by simply using gci
$STEAMIDS=(gci -Path $RF2WORKSHOPPKGS|select -Expand Name)

# what to do with the given IDs
foreach ($STEAMID in $STEAMIDS)
 {  
    # simple message  
    write-host "Downloading SteamID "$STEAMID

    # generating arguments string
    $ARGUMENTS=" +force_install_dir ""$RF2ROOT"" +login anonymous +workshop_download_item 365960 $STEAMID +quit"
    
    # downloading the workshop item
    start-process "$STEAMINSTALLDIR\steamcmd" -ArgumentList $ARGUMENTS -NoNewWindow -wait

    # looking for RFCMP to install (need to be sorted, think of GT3 vehicles, 3.60 base, 3.61 update)
    $RFCMPS=(gci $RF2WORKSHOPPKGS\$STEAMID *.rfcmp -recurse| select -Expand Name|sort)
    
    # install each RFCMP with modmgr ... assuming modmgr is configured
    foreach ($RFCMP in $RFCMPS)
    {
        #& "$RF2ROOT\bin64\ModMgr.exe" -i"$RFCMP" -p"$RF2WORKSHOPPKGS\$STEAMID" -d"$RF2ROOT"
        $ARGUMENTS=" -i""$RFCMP"" -p""$RF2WORKSHOPPKGS\$STEAMID"" -d""$RF2ROOT"" "
        start-process -FilePath "$RF2ROOT\bin64\ModMgr.exe" -ArgumentList $ARGUMENTS -nonewwindow -wait

        # start-process does not really wait for modmgr having finished so we need some xtra wait
        start-sleep -seconds 3
    }
 }