Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

  Start-BitsTransfer –Source 'https://jenkinsaspass.blob.core.windows.net/software/artifactory-oss-6.5.2.zip' -Destination 'D:\'

  Start-BitsTransfer –Source 'https://jenkinsaspass.blob.core.windows.net/software/jre-8u191-windows-x64.exe' -Destination 'D:\'

  $Exe = 'D:\jre-8u191-windows-x64.exe'
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

  Start-Sleep 60

  Add-Type -AssemblyName System.IO.Compression.FileSystem
  function unzip {
   param( [string]$ziparchive, [string]$extractpath )
   [System.IO.Compression.ZipFile]::ExtractToDirectory( $ziparchive, $extractpath )
}
  unzip "D:\artifactory-oss-6.5.2.zip" "D:\"

  D:\artifactory-oss-6.5.2\bin\run.vbs

  Write-Host "Login from browser with port 8081" -ForegroundColor Green 

  Write-Host "Login Username and PAssword is admin" -ForegroundColor Green
