Write-Output "
1 - Hvem er jeg og hva er navnet på dette scriptet?
2 - Hvor lenge er det siden siste boot?
3 - Hvor mange prosesser og tråder finnes?
4 - Hvor mange context switcher fant sted siste sekund?
5 - Hvor stor andel av CPU-tiden ble benyttet i kernelmode og i usermode siste sekund?
6 - Hvor mange interrupts fant sted siste sekund?
9 - Avslutt dette scriptet
Velg en funksjon:"

while ($sel = Read-Host)
{
    Switch ($sel)
    {
        1 {
            # Print user name
            Write-Output "I am: $env:UserName"

            # Print script file name
            Write-Output "Script name: $($MyInvocation.MyCommand.Name)"

            break
            }

        2 {
            # Print the time since last boot, by getting the current date, subtracting the time of lst boot, to get uptime
            Write-Output "Time since last boot: $((Get-Date) - (Get-CimInstance -ClassName win32_operatingsystem).LastBootUptime)"

            break
            }
        3 {
            # Print nr of processes and threads
            # "Processes" and "Threads" gives me the nr of processes and threads and are stored in "win32_PerfFormattedData_PerfOS_System". 
            Write-Output "Nr processes and threads: $((Get-CimInstance -ClassName win32_PerfFormattedData_PerfOS_System).Processes + 
                                                    (Get-CimInstance -ClassName win32_PerfFormattedData_PerfOS_System).Threads)"

            break
            }

        4 {
            # Print nr of context switches across CPU
            # Stored in "\System`Kontekstvekslinger/sek", this waits a sec, and gives you nr of contextswitches/sec
            Write-Output "Nr context switches across cpu: $([int]$(Get-Counter -Counter "\System\Kontekstvekslinger/sek").CounterSamples.CookedValue)"

            break
            }

        5 {
            # Reset variables for fresh start
            $USER = 0
            $KERNEL = 0

            # Loop through all processes, summing every objects ProcessorTime
            $(Get-Process | ForEach-Object {$USER += [int]$_.UserProcessorTime.TotalMilliseconds})
            $(Get-Process | ForEach-Object {$KERNEL += [int]$_.PrivilegedProcessorTime.TotalMilliseconds})

            # Then, take the time / devide by total to get percentage (betwween 0-1). Times 100 to get percentage (0 - 100)
            # Then print the results
            Write-Output "Usermode percentage: $($USER / ($USER + $KERNEL) * 100)%"
            Write-Output "Kernelmode percentage: $($KERNEL / ($USER + $KERNEL) * 100)%"

            break
            }

        6 {
            # Print nr of interrupts across CPU
            # Total interupt info exsists in "\prosessor(_total)\avbrudd/sek" counteren in "CounterSamples" and finally in "CookedValue"1
            $NR_INTR=$(Get-Counter -Counter "\prosessor(_total)\avbrudd/sek").CounterSamples.CookedValue

            # Print result
            Write-Output "Nr context switches across cpu: $NR_INTR"

            break
            }

        9 { exit; break }
    }

    Write-Output "
1 - Hvem er jeg og hva er navnet på dette scriptet?
2 - Hvor lenge er det siden siste boot?
3 - Hvor mange prosesser og tråder finnes?
4 - Hvor mange context switcher fant sted siste sekund?
5 - Hvor stor andel av CPU-tiden ble benyttet i kernelmode og i usermode siste sekund?
6 - Hvor mange interrupts fant sted siste sekund?
9 - Avslutt dette scriptet
Velg en funksjon:"

}