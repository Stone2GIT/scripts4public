function getdlcinfo {

# we need to make sure script is executed with Powershell 7
if ( $PSVersionTable.PSVersion.Major -lt 7 )
    { write-host "Function requires Powershell 7 or greater"
        exit 1
    }

# we need to have an SteamAPI key
if ( $STEAMAPIKEY )
    {}
else
    { write-host "No API key given - exiting." 
        exit 1 
    }

rm dlc*.csv

# getting digest key
$DIGEST=((invoke-webrequest -method get "https://api.steampowered.com/IInventoryService/GetItemDefMeta/v1/?key=$STEAMAPIKEY&appid=365960").content|convertfrom-json|select-object -Property response -ExpandProperty response|select-object -Property digest|ft -hide | Out-String | ForEach-Object { $_.Trim() } )

# this seems to be older then invoke-restmethod
#$CONTENT=((invoke-webrequest -method get "https://api.steampowered.com/IGameInventory/GetItemDefArchive/v1/?key=$STEAMAPIKEY&appid=365960&digest=$DIGEST").content)

# requesting DLC information and storing it into an array
[ARRAY]$CONTENT=(invoke-restmethod "https://api.steampowered.com/IGameInventory/GetItemDefArchive/v1/?key=$STEAMAPIKEY&appid=365960&digest=$DIGEST")

# this will generate a json file but we do not need it ...
#$CONTENT| ConvertTo-Json -Depth 2 | Out-File dlccontent.json

# this will generate a csv file with all available dlc content
$CONTENT|Export-Csv -NoTypeInformation -Path $CSVCONTENTFILE -Delimiter "," -Encoding UTF8

# preparing csv files with headers
"""CarName"",""SteamId""" | Out-File $CSVCARFILE -Append
"""TrackName"",""SteamId""" | Out-File $CSVTRACKFILE -Append

# filling the files with tracks and cars
ForEach($CSVCONTENTENTRY in Import-CSV $CSVCONTENTFILE)
{

    # we rely on store_tags property in content array ... and that cars start with cars (think of cars;featured as store_tag)
    if($CSVCONTENTENTRY.store_tags.StartsWith("cars"))
    {
        $CARNAME=$CSVCONTENTENTRY.name
        $CARWORKSHOPID=$CSVCONTENTENTRY.workshopid
        """$CARNAME"",""$CARWORKSHOPID"""| Out-File $CSVCARFILE -Append
    }

    # same as above but with tracks (think of cars;featured as store_tag)
    if($CSVCONTENTENTRY.store_tags.Startswith("tracks"))
    {
        $TRACKNAME=$CSVCONTENTENTRY.name
        $TRACKWORKSHOPID=$CSVCONTENTENTRY.workshopid
        """$TRACKNAME"",""$TRACKWORKSHOPID"""| Out-File $CSVTRACKFILE -Append
    }

}
}