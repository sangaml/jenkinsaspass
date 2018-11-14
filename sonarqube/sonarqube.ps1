Start-BitsTransfer -Source "https://jenkinsaspasssto.blob.core.windows.net/software/sonarqube-6.7.5.zip" -Destination "D:\"
Add-Type -AssemblyName System.IO.Compression.FileSystem
function unzip {
   param( [string]$ziparchive, [string]$extractpath )
   [System.IO.Compression.ZipFile]::ExtractToDirectory( $ziparchive, $extractpath )
}
unzip "D:\sonarqube-6.7.5.zip" "D:\"

D:\sonarqube-6.7.5\bin\windows-x86-64\run.vbs
