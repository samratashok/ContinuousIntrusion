function ConvertFrom-Bytes
{
<#
.SYNOPSIS
Script to convert master.key and hudson.util.secret from bytes format to file.

.DESCRIPTION
Script to convert master.key and hudson.util.secret from bytes format to file.
This is a technqiue to decrypt credentials and secrets stored with Jenkins. The technique is detailed
here: http://www.labofapenetrationtester.com/2015/11/week-of-continuous-intrusion-day-1.html

.PARAMETER ByteFile
Path to the file where bytes for one of the files are saved.

.PARAMETER KeyFile
Path where the key created.

.EXAMPLE
PS > ConvertFrom-Bytes -ByteFile C:\ContinuousIntrusion\master.txt -KeyFile C:\ContinuousIntrusion\master.key
Use above command to convert bytes of master.key back to the file.

.EXAMPLE
PS > ConvertFrom-Bytes -ByteFile C:\ContinuousIntrusion\hudson.util.Secret.txt -KeyFile C:\ContinuousIntrusion\hudson.util.Secret
Use above command to convert bytes of hudson.util.Secret back to the file.


.LINK
http://www.labofapenetrationtester.com/2015/11/week-of-continuous-intrusion-day-1.html
https://github.com/samratashok/nishang
#>
    [CmdletBinding()] Param ( 
        [Parameter(Position = 0, Mandatory = $True)]
        [String]
        $ByteFile,
    
        [Parameter(Position = 1, Mandatory = $True)]
        [String]$KeyFile
    )
    
    [String]$hexdump = get-content -path "$ByteFile"
    [Byte[]] $temp = $hexdump -split ' '
    [System.IO.File]::WriteAllBytes($KeyFile, $temp)
    Write-Output "File written to $KeyFile"
}
