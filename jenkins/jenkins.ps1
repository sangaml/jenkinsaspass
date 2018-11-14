Start-BitsTransfer -Source "https://jenkinsaspasssto.blob.core.windows.net/software/jenkins.msi" -Destination "D:\"
  
Start-Process D:\jenkins.msi /qn -Wait
