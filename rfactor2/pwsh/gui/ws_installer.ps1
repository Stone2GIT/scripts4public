. ./variables.ps1

$STEAMIDS="2362626369", "2648433641", "2962890868", "553365002"

 foreach ($STEAMID in $STEAMIDS)
 {    
    write-host "Downloading SteamID "$STEAMID 
    $ARGUMENTS=" +force_install_dir $RF2ROOT +login anonymous +workshop_download_item 365960 $STEAMID +quit"
    start-process "$STEAMINSTALLDIR\steamcmd" -ArgumentList $ARGUMENTS -NoNewWindow -wait


    $RFCMPS=(gci $RF2WORKSHOPPKGS\$STEAMID *.rfcmp -recurse| select -Expand Name|sort)
    foreach ($RFCMP in $RFCMPS)
    {
        #& "$RF2ROOT\bin64\ModMgr.exe" -i"$RFCMP" -p"$RF2WORKSHOPPKGS\$STEAMID" -d"$RF2ROOT"
        $ARGUMENTS=" -i""$RFCMP"" -p""$RF2WORKSHOPPKGS\$STEAMID"" -d""$RF2ROOT"" "
        start-process -FilePath "$RF2ROOT\bin64\ModMgr.exe" -ArgumentList $ARGUMENTS -nonewwindow -wait

        # start-process does not really wait for modmgr having finished so we need some xtra wait
        start-sleep -seconds 5
    }
 }