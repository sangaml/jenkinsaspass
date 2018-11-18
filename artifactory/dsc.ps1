Configuration Installartifactory {   
    Node localhost
     { 
    
      Script Download-xActiveDirectory {  
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
      Archive Uncompress-xActiveDirectory {  
        Ensure = 'Present'  
        Path = 'D:\artifactory-oss-6.5.2.zip'  
        Destination = 'D:\'  
        DependsOn = '[Script]Download-xActiveDirectory'  
      }
      Package InstallExe
      {
          Ensure          = "Present"
          Name            = "Install Java"
          Path            = "D:\jre-8u191-windows-x64.exe"
          Arguments       = '/b"C:\Windows\Temp\PerforceClient" /S /V"/qn ALLUSERS=1 REBOOT=ReallySuppress"'
          ProductId       = ''
          DependsOn       = '[Script]Download-xActiveDirectory'
      }
      Script Startartifactory {
        GetScript = {
          }  
          SetScript = { 
            Invoke-Command -ScriptBlock {D:\artifactory-oss-6.5.2\bin\run.vbs}
          }  
          TestScript = { 
          }
        
      }
    }  
  }
