#
# simple script to build RFMODs
#
# Dietmar Stein, 03/2024, info@simracingjustfair.org
#

# simple documentation ...
#
# - we need a folder "bmp" (build mod package) in $RF2ROOT
# - place a file called $PREFIX"-"$PROFILE".dat" in there
# - file needs to contain entry / entries of pkginfo.dat (which can be found in $HOME/Applicationdata)


$RF2ROOT="$HOME\rf2ds"
$PROFILE="training1"

$PREFIX="srjf-"
$DATFILE="$PREFIX"+"$PROFILE.dat"
$RFMODFILENAME="$PREFIX"+"$PROFILE.rfmod"

# change directory ...
cd $RF2ROOT\bmp

# copy dummy.mas ... for some reason modmgr sometimes does not accept a path different from mastemp
copy dummy.mas $PREFIX$PROFILE.mas
copy -v $PREFIX$PROFILE.mas $HOME\AppData\Roaming\~MASTEMP\$PREFIX$PROFILE".mas"
timeout /t 3

# mod package creation
$ARGUMENTS=" -c""$RF2ROOT"" -o""$RF2ROOT\Packages"" -b""$RF2ROOT\bmp\$DATFILE"" 0"
start-process -FilePath "$RF2ROOT\bin64\ModMgr.exe" -ArgumentList $ARGUMENTS -NoNewWindow -Wait

# mod package install ... there is not chance to "see" if the package has been created :-(
# TODO: check for exit code
$ARGUMENTS=" -p""$RF2ROOT\Packages"" -i""$RFMODFILENAME"" -c""$RF2ROOT"" "
start-process -FilePath "$RF2ROOT\bin64\ModMgr.exe" -ArgumentList $ARGUMENTS -NoNewWindow -Wait
