# Imports
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

# Constants
$logo = 'https://avatars.githubusercontent.com/u/16618068'
$taskName = 'ScoopAutoUpdate'

# Set up BurntToast
if(-not (Get-Module -ListAvailable -Name 'BurntToast'))
{
    $mbresult = [System.Windows.Forms.MessageBox]::Show("This script needs an additional module called 'BurntToast'. Do you want to install it?", 'scoop', 'OkCancel', 'Information')
    if($mbresult -eq 'OK') {
        Start-Process 'powershell' -Verb RunAs -ArgumentList ('-Command Install-Module -Name BurntToast') -Wait
    } else {
        [System.Windows.Forms.MessageBox]::Show("'BurntToast' installation denied. Aborting 🥺.", 'scoop', 'Ok', 'Warning')
        exit
    }
}
Import-Module -Name BurntToast

# Set up scheduled task
$taskExists = Get-ScheduledTask | Where-Object { $_.TaskName -eq $taskName }
if (!$taskExists) {
  echo 'Scheduled Task not installed, doing that now...'
  $trigger = New-ScheduledTaskTrigger -Daily -At 0am
  $action = New-ScheduledTaskAction -Execute 'PowerShell.exe' -Argument "-WindowStyle hidden -NonInteractive -File $($MyInvocation.MyCommand.PSPath)"
  $user = whoami
  Register-ScheduledTask -TaskName $taskName -Trigger $trigger -Action $action -User $user
  echo 'Installed scheduled task.'
}


# Updating
scoop update
$output = scoop status
$isUpToDate = $output.Contains('Everything is ok!')
$outdatedPackages = $output | ForEach-Object { $_.Name }

if ($outdatedPackages.Length -eq 0 ) {
  New-BurntToastNotification -AppLogo $logo -Text 'scoop', 'Your packages are up-to-date.'
} else {
  $messageBoxResult = [System.Windows.Forms.MessageBox]::Show("scoop can update $($outdatedPackages.Length) packages.`nDo you want to update?", 'scoop', 'YesNo','Question')
  if($messageBoxResult -eq 'Yes') {
    scoop update *
    New-BurntToastNotification -AppLogo $logo -Text 'scoop', 'Packages were updated:', $($outdatedPackages -join ', ')
  }
}    

