$report_file_unc = ""

try {
    if(!(Test-Path -Path "C:\temp")){
        New-Item -Path "C:\" -Name "temp" -ItemType "directory"
    }

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
