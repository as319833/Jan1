$appName = "Hello1"


if(!($myApp = Get-AzureADApplication -Filter "DisplayName eq '$($appName)'"  -ErrorAction SilentlyContinue))
{
	$Guid = New-Guid
	$startDate = Get-Date
	
	$PasswordCredential 				= New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordCredential
	$PasswordCredential.StartDate 		= $startDate
	$PasswordCredential.EndDate 		= $startDate.AddYears(1)
	$PasswordCredential.KeyId 			= $Guid
	$PasswordCredential.Value 			= ([System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes(($Guid))))+"="

	$myApp = New-AzureADApplication -DisplayName $appName -PasswordCredentials $PasswordCredential

	$AppDetailsOutput = "Application Details for the $AADApplicationName application:
=========================================================
Application Name: 	$appName
Application Id:   	$($myApp.AppId)
Secret Key:       	$($PasswordCredential.Value)
"
	Write-Host
	Write-Host $AppDetailsOutput
}
else
{
	Write-Host
	Write-Host -f Yellow Azure AD Application $appName already exists.
}

Write-Host
Write-Host -f Green "Finished"
Write-Host



