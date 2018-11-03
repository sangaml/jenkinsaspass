Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
Start-BitsTransfer –Source 'https://jenkinsaspass.blob.core.windows.net/software/jenkins.msi' -Destination 'D:\'
cd D:\
Start-Process jenkins.msi /qn 
Start-Sleep 100
$Password = Get-Content "C:\Program Files (x86)\Jenkins\secrets\initialAdminPassword"
Write-Host "Login from Browser" -ForegroundColor Green  
Write-Host "Initial Admin Password is "$Password"" -ForegroundColor Green
