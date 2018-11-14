Start-BitsTransfer -Source "https://jenkinsaspasssto.blob.core.windows.net/software/artifactory-oss-6.5.2.zip" -Destination "D:\"

  Add-Type -AssemblyName System.IO.Compression.FileSystem
  function unzip {
   param( [string]$ziparchive, [string]$extractpath )
   [System.IO.Compression.ZipFile]::ExtractToDirectory( $ziparchive, $extractpath )
    }
  unzip "D:\artifactory-oss-6.5.2.zip" "D:\"

  D:\artifactory-oss-6.5.2\bin\run.vbs
