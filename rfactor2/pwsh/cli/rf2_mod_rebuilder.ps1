#
# simple script to build RFMODs
#
# Dietmar Stein, 03/2024, info@simracingjustfair.org
#

$RF2ROOT="$HOME\rf2ds"
$PROFILE="training1"

$PREFIX="srjf-"
$DATFILE="$PREFIX"+"$PROFILE.dat"
$RFMODFILENAME="$PREFIX"+"$PROFILE.rfmod"

# change folder
cd $RF2ROOT\bmp

copy dummy.mas $PREFIX$PROFILE.mas

$ARGUMENTS=" -c""$RF2ROOT"" -o""$HOME\AppData\Roaming\~MASTEMP\"" -m""$PREFIX$PROFILE.mas"" ""$RF2ROOT\bmp\default.rfm"" ""$RF2ROOT\bmp\icon.dds"" ""$RF2ROOT\bmp\smicon.dds"""
#& "RF2ROOT\bin64\modmgr.exe" -c""$RF2ROOT"" -o""$HOME\AppData\Roaming\~MASTEMP\"" -m""SRJF-$PROFILE.mas"" ""$RF2ROOT\bmp\default.rfm"" ""$RF2ROOT\bmp\icon.dds"" ""$RF2ROOT\bmp\smicon.dds""
#start-process -FilePath "$RF2ROOT\bin64\ModMgr.exe" -ArgumentList $ARGUMENTS -NoNewWindow -Wait

timeout /t 3
copy -v $PREFIX$PROFILE.mas $HOME\AppData\Roaming\~MASTEMP\$PREFIX$PROFILE".mas"

# mod package erzeugen
$ARGUMENTS=" -c""$RF2ROOT"" -o""$RF2ROOT\Packages"" -b""$RF2ROOT\bmp\$DATFILE"" 0"
start-process -FilePath "$RF2ROOT\bin64\ModMgr.exe" -ArgumentList $ARGUMENTS -NoNewWindow -Wait

# mod package installieren ... wir haben keinerlei Kontrolle ob das Paket richtig erzeugt wurde :-( 
# TODO: exit codes abfragen
$ARGUMENTS=" -p""$RF2ROOT\Packages"" -i""$RFMODFILENAME"" -c""$RF2ROOT"" "
start-process -FilePath "$RF2ROOT\bin64\ModMgr.exe" -ArgumentList $ARGUMENTS -NoNewWindow -Wait
