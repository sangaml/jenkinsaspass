Configuration Installartifactory {   
    Node localhost
     { 
    
      Script Download-Software {  
        GetScript = {  
          @{Result = Test-Path 'D:\artifactory-oss-6.5.2.zip'}
          @{Result = Test-Path 'D:\jre-8u191-windows-x64.exe'}  
        }  
        SetScript = { 
          Enable-PSRemoting -Force
          Invoke-WebRequest -Uri 'https://csgdfe49495dc73x47efxabf.blob.core.windows.net/grt/artifactory-oss-6.5.2.zip' -OutFile 'D:\artifactory-oss-6.5.2.zip'  
          Invoke-WebRequest -Uri 'https://csgdfe49495dc73x47efxabf.blob.core.windows.net/grt/jre-8u191-windows-x64.exe' -OutFile 'D:\jre-8u191-windows-x64.exe'
          Unblock-File -Path 'D:\jre-8u191-windows-x64.exe'
          Unblock-File -Path 'D:\artifactory-oss-6.5.2.zip'  
            
        }  
        TestScript = {  
          Test-Path 'D:\jre-8u191-windows-x64.exe'
          Test-Path 'D:\artifactory-oss-6.5.2.zip'  
        }   
      } 
      Archive Uncompress {  
        Ensure = 'Present'  
        Path = 'D:\artifactory-oss-6.5.2.zip'  
        Destination = 'D:\'  
        DependsOn = '[Script]Download-Software'  
      }
      Package InstallExe
      {
          Ensure          = "Present"
          Name            = "Install Java"
          Path            = "D:\jre-8u191-windows-x64.exe"
          Arguments       = '/s REBOOT=0 SPONSORS=0 REMOVEOUTOFDATEJRES=0 INSTALL_SILENT=1 AUTO_UPDATE=0 EULA=0 /l*v "C:\Windows\Temp\jreInstaller.exe.log"'
          ProductId       = ''
          DependsOn       = '[Script]Download-Software'
      }
      Service CreateService
    {
        Name   = "artifactory"
        Ensure = "Present"
        Path   = "D:\artifactory-oss-6.5.2\bin\artifactory.bat"
    }
    }  
}
