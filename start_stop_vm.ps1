param(
  [string]$ResourceGroupName = "azure_vm",
  [string]$VMName = "OpenProject"
)

# Get current time in KSA (Arabian Standard Time)
$ksaTimeZone = [System.TimeZoneInfo]::FindSystemTimeZoneById("Arab Standard Time")
$currentKsaTime = [System.TimeZoneInfo]::ConvertTimeFromUtc((Get-Date).ToUniversalTime(), $ksaTimeZone)

$hour = $currentKsaTime.Hour
$today = $currentKsaTime.DayOfWeek.ToString()

# Skip weekends
if ($today -in @("Friday", "Saturday")) {
    Write-Output "Weekend in KSA. No action taken."
    return
}

if ($hour -ge 9 -and $hour -lt 17) {
    # Between 9 AM and before 5 PM — start the VM
    Write-Output "Current time $currentKsaTime — Starting VM"
    Start-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName
} elseif ($hour -ge 17 -or $hour -lt 9) {
    # After 5 PM or before 9 AM — stop the VM
    Write-Output "Current time $currentKsaTime — Stopping VM"
    Stop-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName -Force
}

