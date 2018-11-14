
Write-Host "Initiating PaaS  Deployment ...
" -ForegroundColor Green
$Software = Read-Host -Prompt "Enter Software Name to have custom VM(Separated with comma):
                               Jenkins
                               Artifactory
                               Sonarqube 
                               "

$mystring = New-Object 'System.Collections.Generic.List[String]'
$UserInputList = $Software.Split(",")| ForEach {   
 $value=$_
 if($value.ToLower() -eq "jenkins" -or  $value.ToLower() -eq "artifactory" -or  $value.ToLower() -eq "sonarqube")
 {
 $mystring.Add($_)
 }
 else{
 Write-Host "please enter valid Software Name like Jenkins,Artifactory,Sonarqube"
  break
 }
}
#Variables 
$customscriptname = "mycustomscript"
$vm = "softwareVM"
$RG = "jenkinsaspaas"
$location = "centralus"
New-AzureRmResourceGroup -Name $RG -Location $location
#vm creation
New-AzureRmResourceGroupDeployment -Name jenkinsaspaas -ResourceGroupName $RG `
 -TemplateUri "https://raw.githubusercontent.com/sangaml/jenkinsaspass/master/final.json" `
 -TemplateParameterUri "https://raw.githubusercontent.com/sangaml/jenkinsaspass/master/final.parameters.json"

$IP = (Get-AzureRmPublicIpAddress -Name LBPublicIP -ResourceGroupName $RG).IpAddress
#Insatlling JAVA
if ($value.ToLower() -eq "artifactory" -or  $value.ToLower() -eq "sonarqube") {
Write-Host "Installing Java ..." -ForegroundColor Green
Set-AzureRmVMCustomScriptExtension -ResourceGroupName $RG `
               -VMName $vm -Name $customscriptname `
               -FileUri "https://raw.githubusercontent.com/sangaml/jenkinsaspass/master/installjava.ps1" `
               -Run "installjava.ps1" `
               -Location $location 
               start-sleep 120
               Remove-AzurermVMCustomScriptExtension -ResourceGroupName $RG -VMName $vm -Name $customscriptname  -Force
}
#Loop for VM Extension 

For ($i=0; $i -le $mystring.Count; $i++) {
   
  switch ( $mystring[$i])
 {

  Artifactory {  Write-Host "Installing Artifactory ..." -ForegroundColor Green
               Set-AzureRmVMCustomScriptExtension -ResourceGroupName $RG `
               -VMName $vm -Name $customscriptname `
               -FileUri "https://raw.githubusercontent.com/sangaml/jenkinsaspass/master/artifactory/artifactory.ps1" `
               -Run "artifactory.ps1" `
               -Location $location 
               Write-Host "Login from browser with $IP and port 8080" -ForegroundColor Green 
               Write-Host "Login Username is admin and PAssword is password" -ForegroundColor Green 
               Remove-AzurermVMCustomScriptExtension -ResourceGroupName $RG -VMName $vm -Name $customscriptname -Force
               }
                              
  Jenkins     { Invoke-AzureRmVMRunCommand -ResourceGroupName $RG -Name $vm -CommandId 'RunPowerShellScript' -ScriptPath 'D:\POC29-11\scripts\jenkins.ps1'
                Write-Host "Login from browser with $IP and port 80" -ForegroundColor Green 
                $password = Invoke-AzureRmVMRunCommand -ResourceGroupName $RG -Name $vm -CommandId 'RunPowerShellScript' -ScriptPath 'D:\POC29-11\getcontent.ps1'
                $pass = ($password).Value[0].Message
                Write-Host " Initial Jenkins Password is $pass " -ForegroundColor Green

                               }
  Sonarqube   { Write-Host "Installing Sonarqube ..." -ForegroundColor Green
                 Set-AzureRmVMCustomScriptExtension -ResourceGroupName $RG `
               -VMName $vm -Name $customscriptname `
               -FileUri "https://raw.githubusercontent.com/sangaml/jenkinsaspass/master/sonarqube/sonarqube.ps1" `
               -Run "sonarqube.ps1" `
               -Location $location 
               Write-Host "Login from browser with $IP and port 9090" -ForegroundColor Green 
               Write-Host "Login Username and PAssword is admin" -ForegroundColor Green
               Remove-AzurermVMCustomScriptExtension -ResourceGroupName $RG -VMName $vm -Name $customscriptname   -Force
                               }
 } 
 }
