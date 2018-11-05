Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
Start-BitsTransfer -Source "https://jenkinsaspass.blob.core.windows.net/software/sonarqube-6.7.5.zip" -Destination "D:\"
Start-BitsTransfer -Source "https://jenkinsaspass.blob.core.windows.net/software/jre-8u191-windows-x64.exe" -Destination "D:\"

$path = "C:\Program Files\Java"

if (! (Test-path $path ))
{
 
 $Exe = "D:\jre-8u191-windows-x64.exe"
$ExeArgs = @(
   "INSTALL_SILENT=1"
   "STATIC=0"
   "AUTO_UPDATE=0"
   "WEB_JAVA=1"
   "WEB_JAVA_SECURITY_LEVEL=H"
   "WEB_ANALYTICS=0"
   "EULA=0"
   "REBOOT=0"
   "NOSTARTMENU=0"
   "SPONSORS=0"
)
Start-Process $Exe -ArgumentList $ExeArgs -NoNewWindow -Wait 
Restart-Computer
Start-Sleep 120

Add-Type -AssemblyName System.IO.Compression.FileSystem
function unzip {
   param( [string]$ziparchive, [string]$extractpath )
   [System.IO.Compression.ZipFile]::ExtractToDirectory( $ziparchive, $extractpath )
}
unzip "D:\sonarqube-6.7.5.zip" "D:\"

D:\sonarqube-6.7.5\bin\windows-x86-64\StartSonar.bat

 }
 else { 
 Add-Type -AssemblyName System.IO.Compression.FileSystem
function unzip {
   param( [string]$ziparchive, [string]$extractpath )
   [System.IO.Compression.ZipFile]::ExtractToDirectory( $ziparchive, $extractpath )
}
unzip "D:\sonarqube-6.7.5.zip" "D:\"

D:\sonarqube-6.7.5\bin\windows-x86-64\StartSonar.bat

 }
