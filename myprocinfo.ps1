Write-Host "
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
            Write-Host "I am: $env:UserName"

            # Print script file name
            Write-Host "Script name: $($MyInvocation.MyCommand.Name)"

            break
            }

        2 {
            # Print the time since last boot, by getting the current date, subtracting the time of lst boot, to get uptime
            Write-Host "Time since last boot: $((Get-Date) - (Get-CimInstance -ClassName win32_operatingsystem).LastBootUptime)"

            break
            }
        3 {
            # Print nr of processes and threads
            # Using -AL on ps to get both processes and threads and counts them with wc -l (counts nr of lines)
            $count = 0
            Get-Process | ForEach-Object {$count = $([int]$count + $_.Threads.Count)}
            Write-Host "Nr processes and threads: $([int]@(Get-Process).Count + $count)"

            break
            }

        4 {
            # Print nr of context switches across CPU
            Write-Host "Nr context switches across cpu: $([int]$(Get-Counter -Counter "\System\Kontekstvekslinger/sek").CounterSamples.CookedValue)"

            break
            }

        5 {
            # Use grep to find first cpu line which is the total of all cpu lines below it and use awk to get 2nd (userspace) and 4th (kernelspace) column
            #FIRST_USER=$(grep cpu -m 1 /proc/stat | awk '{ print $2 }')
            #FIRST_KERNEL=$(grep cpu -m 1 /proc/stat | awk '{ print $4 }')

            # Sleep for 1 sec
            #sleep 1

            # Fetch results again using grep and awk
            #DIFF_USER=$(( $(grep cpu -m 1 /proc/stat | awk '{ print $2 }') - FIRST_USER ))
            #DIFF_KERNEL=$(( $(grep cpu -m 1 /proc/stat | awk '{ print $4 }') - FIRST_KERNEL ))

            # Divide time in kernel and user on total time in both, and get "bc" to calculate (for floats)
            # Then print the results
            #Write-Host "Usermode percentage: $(Write-Host "scale=2; $DIFF_USER / ($DIFF_USER + $DIFF_KERNEL) * 100" | bc)%"
            #Write-Host "Kernelmode percentage: $(Write-Host "scale=2; $DIFF_KERNEL / ($DIFF_USER + $DIFF_KERNEL) * 100" | bc)%"

            break
            }

        6 {
            # Print nr of interrupts across CPU
            # Interupt info exsists in /proc/stat and the "intr" field hold all context switches across the cpu
            # Using grep to get the line, and then using awk to select second column (splitting on spaces)
            #FIRST_INTR=$(grep intr /proc/stat | awk '{ print $2 }')

            # Then sleep for 1 sec
            #sleep 1

            # Fetch results again
            #RESULT=$(($(grep intr /proc/stat | awk '{ print $2 }') - FIRST_INTR))

            # Print result
            #Write-Host "Nr context switches across cpu: $RESULT"

            break
            }

        9 { exit; break }
    }

    Write-Host "
1 - Hvem er jeg og hva er navnet på dette scriptet?
2 - Hvor lenge er det siden siste boot?
3 - Hvor mange prosesser og tråder finnes?
4 - Hvor mange context switcher fant sted siste sekund?
5 - Hvor stor andel av CPU-tiden ble benyttet i kernelmode og i usermode siste sekund?
6 - Hvor mange interrupts fant sted siste sekund?
9 - Avslutt dette scriptet
Velg en funksjon:"

}