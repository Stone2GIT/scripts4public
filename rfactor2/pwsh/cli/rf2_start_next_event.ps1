$RF2ROOT="$HOME\rf2ds"
$RF2USERDATA="$RF2ROOT\userdata"

cd $RF2ROOT

.\rf2_server_shutdown.ps1 player

start-sleep -seconds 10

.\rf2_session_switcher.ps1 player

start-sleep -seconds 10

cd $RF2ROOT\bin64

$ARGUMENTS=" +path="".."" +profile=player +rfm=SRJF-20240515_10.rfm +oneclick"
start-process -FilePath "$RF2ROOT\bin64\rFactor2 Dedicated.exe" -ArgumentList $ARGUMENTS -NoNewWindow