<#
    Задания необходимые для раздачи тасков на машины
    В данном случае - отключение ПК в 23:00
#>

# Назначаем переменные
$ConfigPath = '\\ilccredits\it\GPO\PCOff'
$TaskName = "PC_Reboot"
$ConfigName = $TaskName + ".xml"
$User = "ilccredits\admin"
$Pass = "P@rabola-2ilc"

# Проводим проверку на серверность ПК 
$Serv = (Get-WmiObject -class Win32_OperatingSystem).Caption 
    if ($Serv -like "*Server*" -or $Serv -like "*Сервер*") {
        $SwitchFlag = '1'
    }
    else {
        $SwitchFlag = '2'
    }

Switch ($SwitchFlag) {

# Выполняем проверку наличия таска и если его нет - тогда создаем
    2 {$FindTask = Get-ScheduledTask -TaskName $TaskName 
        if ($null -eq $FindTask) {
            Register-ScheduledTask -xml `
                (Get-Content $ConfigPath\$ConfigName | Out-String) -TaskName "$TaskName" -TaskPath "\" -User $User -Password $Pass –Force
            }
       }
    
    
