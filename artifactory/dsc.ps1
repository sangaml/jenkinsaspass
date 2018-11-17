Configuration CopyDSCModuleRemotely {   
    Node localhost
     { 
    
      Script Download-xActiveDirectory {  
        GetScript = {  
          @{Result = Test-Path 'D:\cert\hotfix.zip'}  
        }  
        SetScript = { 
          Invoke-WebRequest -Uri 'https://csgdfe49495dc73x47efxabf.blob.core.windows.net/grt/hotfix.zip' -OutFile 'D:\cert\hotfix.zip'  
          Unblock-File -Path 'D:\cert\hotfix.zip'  
            
        }  
        TestScript = {  
          Test-Path 'D:\cert\hotfix.zip'  
        }   
      } 
      Archive Uncompress-xActiveDirectory {  
        Ensure = 'Present'  
        Path = 'D:\cert\hotfix.zip'  
        Destination = 'D:\cert\'  
        DependsOn = '[Script]Download-xActiveDirectory'  
      }
      
      Invoke-Command -ScriptBlock 'D:\artifactory-oss-6.5.2\bin\run.vbs'
      
    }  
  }  
  CopyDSCModuleRemotely
