
New-AzureRmResourceGroup -Name loadbalancer -Location "centralus"
New-AzureRmResourceGroupDeployment -Name testloadbalan -ResourceGroupName loadbalancer `
  -TemplateFile D:\POC29-11\jumpserver.json `
  -TemplateParameterFile D:\POC29-11\jumpserver.parameters.json
