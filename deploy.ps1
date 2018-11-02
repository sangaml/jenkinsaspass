$Software = Read-Host -Prompt "Enter the Software Name (A, J, S, J+A, J+S, A+S, A+J, J+A+S)"
#$drive = Read-Host -Prompt "Enter Drive to search a file (Like D:\folder\)"
#$Check = (Get-ChildItem -Attributes Encrypted -Path "$drive" | Select-Object).name
if ($Check -eq $null ) { $Check = "You are not put any thing" }

switch ( "$Software" )
{
    J { $result = 'https://raw.githubusercontent.com/sangaml/jenkinsaspass/master/installjenkins.ps1' }
    A { $result = 'Monday'    }
    S { $result = 'Tuesday'   }
    J+A { $result = 'https://raw.githubusercontent.com/sangaml/jenkinsaspass/master/installjenkins.ps1' }
    J+S { $result = 'Thursday'  }
    A+S { $result = 'Friday'    }
    A+J { $result = 'Saturday'  }
    J+S+A { $result = 'Saturday1'  }
}

"$result"
New-AzureRmResourceGroup -Name loadbalancer -Location "eastasia"
New-AzureRmResourceGroupDeployment -Name loadbalancer -ResourceGroupName loadbalancer  -customfile $result `
  -TemplateFile D:\POC29-11\scripts\condition.json `
  -TemplateParameterFile D:\POC29-11\scripts\condition.parameters.json 
