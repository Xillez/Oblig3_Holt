ForEach ($arg in $args)
{
    # Ready the file name
    $FILE_NAME="$arg-$(Get-Date -Format "ddMMyy").meminfo"

    # Loop through all items in "ITEM_NAMES" and find them in "/proc/$PID/status"
    $VMSIZE = $(Get-Process -Id $arg).VirtualMemorySize / 1MB
    $WSSIZE = $(Get-Process -Id $arg).WorkingSet / 1MB
    # Format file output and dump it to file
    "******** Minne info om prosess med PID $arg ********
Total bruk av virtuelt minne:   $VMSIZE MB
Størrelse av working Set:       $WSSIZE MB" | Set-Content $FILE_NAME
}
