#get local admin users on comps and log to remote
#test the remote path in terminal on a comp to make sure you have rw rights to the directory first
#ran with a rmm

$report_file_unc = ""

if(!(Test-Path -Path "C:\temp")){
    New-Item -Path "C:\" -Name "temp" -ItemType "directory"
}

try {

    $local_admin_members = Get-LocalGroupMember -Group Administrators | Select-Object -Property name

    $report_content = "Computer Name: $($env:COMPUTERNAME)`nAccounts: $(foreach($m in $local_admin_members){"`n $($m.name)"})`n"

    $report_content | Out-File -FilePath $report_file_unc -NoClobber -Append

    exit
}
catch {
    $time = Get-Date -UFormat %s
    $_.Exception.Message | Out-File -FilePath "C:\temp\local-admin-report-err-$($time).log"
    exit
}
exit
