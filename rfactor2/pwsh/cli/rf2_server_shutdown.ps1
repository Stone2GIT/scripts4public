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

function shutdown_server {

    write-host "shutdown server in 1 minute"

    # sending message to server and players
    if ((Invoke-WebRequest -Uri http://127.0.0.1:$RF2UIPORT/rest/chat -Method POST -Body "Server shutdown in 1 minute"))
    {
        Start-Sleep -Seconds 60
    }

    # shutdown the server (as we need to write to json files and they are opened while server is running), assuming default port
    Invoke-WebRequest -Uri http://127.0.0.1:$RF2UIPORT/navigation/action/NAV_EXIT -Method POST

}

# check if we can find / read / modify multiplayer.json ...
if (Test-Path $RF2USERDATA\multiplayer.json -PathType Leaf)
{
    # if so ... run the script
    write-host "multiplayer.json exists"
    
    shutdown_server
    
}
else
{
    write-host "could not find multiplayer.json - please copy the script to rFactor 2 dedicated server root"
}
