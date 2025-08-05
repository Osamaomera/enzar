param(
  [string]$Action = "start",
  [string]$ResourceGroupName = "azure_vm",
  [string]$VMName = "OpenProject"
)

$today = (Get-Date).DayOfWeek.ToString()
if ($today -in @("Friday", "Saturday")) {
    Write-Output "It's a weekend in KSA. No action will be taken."
    return
}

if ($Action -eq "start") {
    Start-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName
    Write-Output "VM started."
} elseif ($Action -eq "stop") {
    Stop-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName -Force
    Write-Output "VM stopped."
}
