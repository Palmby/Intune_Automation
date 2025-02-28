<#
    Use this as a custom Detection rule for applications within intune apps
#>


$servicename ="" #enter service name here 


Try {

    $service = Get-service "$servicename"
     
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
