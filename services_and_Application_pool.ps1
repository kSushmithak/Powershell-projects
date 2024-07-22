#changing the username and password of the services and application pool

$ServiceName = "vstsagent.centrica-emt.AZSU-D-WEB-144"
$newAcct = "uk\zz_devops-01"
$newPass = "litne6ldRhqFtqe4iUko#"
 
$service = Get-WmiObject -Class Win32_Service -Filter "Name='$ServiceName'"
  if ($service -eq $null) {
    Write-Host "Service '$ServiceName' not found."
     return
     }
sc.exe config $ServiceName obj= $newAcct password= $newPass
 
Restart-Service -Name $ServiceName
 
Write-Host "Service '$ServiceName' logon details updated successfully."
 
# Ensure the script runs with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
   Write-Warning "You do not have Administrator rights to run this script. Please re-run this script as an Administrator."
   exit
}
 

#######################application pool############################


Import-Module WebAdministration

# Define variables
$AppPoolName = "YourAppPoolName"
$NewUsername = "NewUsername"
$NewPassword = "NewPassword"

# Get the application pool
$AppPool = Get-Item "IIS:\AppPools\$AppPoolName"

if ($AppPool) {
    # Set the new username and password
    $AppPool.processModel.userName = $NewUsername
    $AppPool.processModel.password = $NewPassword

    # Commit the changes
    $AppPool | Set-Item

    Write-Output "Username and password for the application pool '$AppPoolName' have been updated."
} else {
    Write-Output "Application pool '$AppPoolName' not found."
}
