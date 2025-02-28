<#
    Sentinel One application detection script
    Use this to detect if Sentinel One is 
    on the PC 
#>





Try {

       $service = Get-service "SentinelAgent"
        
    if ($service -ne $null)
        {
            write-output 'service exists'
            Exit 0 
        }


    else {Exit 1}    
}
Catch 
{
    Exit 1
}


