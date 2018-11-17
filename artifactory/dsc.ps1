Configuration CopyDSCModuleRemotely {   
    Node localhost
     { 
    
      Script Download-xActiveDirectory {  
        GetScript = {  
          @{Result = Test-Path 'D:\cert\hotfix.zip'}  
        }  
        SetScript = { 
          Invoke-WebRequest -Uri 'https://csgdfe49495dc73x47efxabf.blob.core.windows.net/grt/artifactory-oss-6.5.2.zip' -OutFile 'D:\cert\hotfix.zip'  
          Unblock-File -Path 'D:\artifactory-oss-6.5.2.zip'  
            
        }  
        TestScript = {  
          Test-Path 'D:\artifactory-oss-6.5.2.zip'  
        }   
      } 
      Archive Uncompress-xActiveDirectory {  
        Ensure = 'Present'  
        Path = 'D:\artifactory-oss-6.5.2.zip'  
        Destination = 'D:\'  
        DependsOn = '[Script]Download-xActiveDirectory'  
      }
      Script Startartifactory {
        GetScript = {
          }  
          SetScript = { 
            Invoke-Command -ScriptBlock 'D:\artifactory-oss-6.5.2\bin\run.vbs' 
          }  
          TestScript = { 
          }
        
      }
    }  
  }
