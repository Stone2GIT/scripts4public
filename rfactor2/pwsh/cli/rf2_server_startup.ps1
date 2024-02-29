#
# command line version of server shutdown for rFactor 2
#
# 02/2024 Dietmar Stein, info@simracingjustfair.org
#

# mandatory
#
# - script needs to be copied to rf2 root
#

# variable definitions
if ( $args[0] ) {
    $PROFILE=$args[0]
 }
 else {
    $PROFILE="player"
 }

$RF2USERDATA="userdata\$PROFILE"
$RF2UIPORT=(((gc $RF2USERDATA\$PROFILE.JSON)| select-string -Pattern "WebUI port""") -split ":")
$RF2UIPORT=($RF2UIPORT[1] -replace ",",'')

function start_server {

    write-host "starting server"

    # specifying rfm file ... modname + version ... 
    # $ARGUMENTS=" +profile=player +rfm=dummy_10.rfm +oneclick"

    # as it might have run before we could try oneclick option ...
    $ARGUMENTS=" +profile=$PROFILE +oneclick"

    start-process -FilePath "bin64\rFactor2 Dedicated.exe" -ArgumentList $ARGUMENTS -NoNewWindow
    
}

# check if we can find / read / modify multiplayer.json ...
if (Test-Path $RF2USERDATA\multiplayer.json -PathType Leaf)
{
    # if so ... run the script
    write-host "multiplayer.json exists"
    
    start_server
    
}
else
{
    write-host "could not find multiplayer.json - please copy the script to rFactor 2 dedicated server root"
}
