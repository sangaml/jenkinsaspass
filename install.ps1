Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

  Start-BitsTransfer –Source 'https://jenkinsaspass.blob.core.windows.net/software/jenkins.msi' -Destination 'D:\'
  cd D:\
  Start-Process jenkins.msi /qn
  Start-Sleep 100
