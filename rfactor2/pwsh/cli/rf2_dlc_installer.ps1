#
# GUI version of DLC content installer for rFactor 2
#
# 03/2024 Dietmar Stein, info@simracingjustfair.org
#

# mandatory
#
# - script needs to be copied to rf2 root
#

# source variables
. ./variables.ps1

# source functions
. ./functions.ps1

function dlccontentinstall {

# Initialisierung Form
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# the window / frame itself
$form = New-Object System.Windows.Forms.Form
$form.Text = 'rFactor 2 DLC Content Installer'
$form.Size = New-Object System.Drawing.Size(800,600)
#$form.StartPosition = 'CenterScreen'
$form.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

# OK button
$installButton = New-Object System.Windows.Forms.Button
$installButton.Location = New-Object System.Drawing.Point(25,500)
$installButton.Size = New-Object System.Drawing.Size(75,23)
$installButton.Text = 'Install'
$installButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $installButton
$form.Controls.Add($installButton)

# Cancel button
$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(105,500)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

# window which will display choices
$label = ""
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(680,20)
$label.Text = 'Choose items to download (multiple selection possible)'
$form.Controls.Add($label)

# ListBox inside the choices' window
$listBox = ""
$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,40)
$listBox.Size = New-Object System.Drawing.Size(300,20)
$listBox.Height = 300
$listBox.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$listBox.SelectionMode = 'MultiExtended'

$listBox1 = ""
$listBox1 = New-Object System.Windows.Forms.ListBox
$listBox1.Location = New-Object System.Drawing.Point(310,40)
$listBox1.Size = New-Object System.Drawing.Size(300,200)
$listBox1.Height = 300
$listBox1.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$listBox1.SelectionMode = 'MultiExtended'

# items for choice
$CSVCARENTRIES=Import-CSV $CSVCARFILE | sort CarName
$CSVTRACKENTRIES=Import-CSV $CSVTRACKFILE | sort TrackName

@($CSVCARENTRIES.CarName) | ForEach-Object {[void] $listBox.Items.Add($_)}
@($CSVTRACKENTRIES.TrackName) | ForEach-Object {[void] $listBox1.Items.Add($_)}

$form.Controls.Add($listBox)
$form.Controls.Add($listBox1)

$form.Topmost = $true

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,375)
$textBox.Size = New-Object System.Drawing.Size(600,100)
$textBox.Multiline = $True
$textBox.AcceptsReturn = $True
$textBox.Font = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
$textBox.Scrollbars = "Vertical"

$form.Controls.Add($textBox)

# display the whole form
$result = $form.ShowDialog()

#
# what to do after choice
if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{

#
# be aware of the trailing s at Items ;-)
$CARSELECTION=$listBox.SelectedItems
$TRACKSELECTION=$listBox1.SelectedItems

#
# For each entry in CSV file ... compare ...
ForEach($CSVCARENTRY in Import-CSV $CSVCARFILE)
 {
  #
  # if the car name is like the vehicle we gonna check ...
  ForEach($OBJECT in $CARSELECTION)
  {
  if($CSVCARENTRY.CarName -match $OBJECT)
   {
    #
    # if there is a SteamID entry for the car we gonna download it
    if ($CSVCARENTRY.SteamID)
     {
      #
      # we need to use a substitute variable, because CSVENTRY.SteamId contains an array when used in ARGUMENTS
      $textBox.AppendText("`r`nDownloading and installing "+$CSVCARENTRY.CarName+".")
      $STEAMID=$CSVCARENTRY.SteamId
      
      $ARGUMENTS=" +force_install_dir $RF2ROOT +login anonymous +workshop_download_item 365960 $STEAMID +quit"
      start-process "$STEAMINSTALLDIR\steamcmd" -ArgumentList $ARGUMENTS -NoNewWindow -wait

 $RFCMPS=(gci $RF2WORKSHOPPKGS\$STEAMID *.rfcmp -recurse| select -Expand Name|sort)
 foreach ($RFCMP in $RFCMPS)
{
$ARGUMENTS=" -i""$RFCMP"" -p""$RF2WORKSHOPPKGS\$STEAMID"" -d""$RF2ROOT"" "
start-process "$RF2ROOT\bin64\ModMgr.exe" -ArgumentList $ARGUMENTS -NoNewWindow -wait
# & "$RF2ROOT\bin64\ModMgr.exe" -i"$RFCMP" -p"$RF2WORKSHOPPKGS\$STEAMID" -d"$RF2ROOT"
 }
      # extract and install ...
      #& $RF2SRVMGRDIR\helper\rfcmp_extractor.ps1 $STEAMID
     }
   }
  }
 }

#
# For each entry in CSV file ... compare ...
ForEach($CSVTRACKENTRY in Import-CSV $CSVTRACKFILE)
 {
  
  #
  # if the track name is like the track we gonna check ...
  ForEach($OBJECT in $TRACKSELECTION)
  {
  if($CSVTRACKENTRY.TrackName -match $OBJECT)
   {
    #
    # if there is a SteamID entry for the car we gonna download it
    if ($CSVTRACKENTRY.SteamID)
     {
      #
      # we need to use a substitute variable, because CSVENTRY.SteamId contains an array when used in ARGUMENTS
      $textBox.AppendText("`r`nDownloading and installing "+$CSVTRACKENTRY.TrackName+".")
      $STEAMID=$CSVTRACKENTRY.SteamId
      
      $ARGUMENTS=" +force_install_dir $RF2ROOT +login anonymous +workshop_download_item 365960 $STEAMID +quit"
      start-process "$STEAMINSTALLDIR\steamcmd" -ArgumentList $ARGUMENTS -NoNewWindow -wait
      #
      #
# ModMgr.exe -i"AstonMartin_Vantage_GT3_2019_v3.60.rfcmp" -p"[packages folder]" -d"$RF2ROOT"
# gci .\2103827617\ *.rfcmp -recurse| select -Expand Name|sort
      # extract and install ...
       $RFCMPS=(gci $RF2WORKSHOPPKGS\$STEAMID *.rfcmp -recurse| select -Expand Name|sort)
 foreach ($RFCMP in $RFCMPS)
{
$ARGUMENTS=" -i""$RFCMP"" -p""$RF2WORKSHOPPKGS\$STEAMID"" -d""$RF2ROOT"" "
start-process "$RF2ROOT\bin64\ModMgr.exe" -ArgumentList $ARGUMENTS -NoNewWindow -wait
# & "$RF2ROOT\bin64\ModMgr.exe" -i"$RFCMP" -p"$RF2WORKSHOPPKGS\$STEAMID" -d"$RF2ROOT"
 start-sleep -seconds 5
 }
     # & $RF2SRVMGRDIR\helper\rfcmp_extractor.ps1 $STEAMID
     }
   }
  }
 }

#
# if cancel was pressed
  } elseif ($result -eq [System.Windows.Forms.DialogResult]::Cancel)
    {
    $textBox.AppendText("`r`nNo items chosen, installation canceled.")
    exit
    }

    $textBox.AppendText("`r`n`r`nFinished content installation.")

}

#getdlcinfo


while (-not $result -eq [System.Windows.Forms.DialogResult]::Cancel)
{
dlccontentinstall
}