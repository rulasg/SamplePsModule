

function SamplePsModuleTest_TraceMessage{
    
    $param = @{
        WarningVariable = 'warningVar'
        WarningAction = 'SilentlyContinue' 

        InformationAction = 'SilentlyContinue'
        InformationVariable = 'infoVar'

        ErrorAction = 'SilentlyContinue' 
        ErrorVar = 'errorVar'
    }

    # $result = WriteAll @param

    $result = WriteAll -Verbose -Debug  @param 5>&1 4>&1 

    Assert-Contains -Presented $result -Expected "Output message" 
    # We can find the Debug and Verbose streams on the Success stream
    # due to the redirection parameters 5>&1 4>&1
    Assert-Contains -Presented $result -Expected "Debug message" # stream 5
    Assert-Contains -Presented $result -Expected "Verbose message" # stream 4

    Assert-Contains -Presented $infoVar -Expected "Host message" 
    Assert-Contains -Presented $infoVar -Expected "Information message" 

    Assert-Contains -Presented $warningVar -Expected "Warning message" 

    Assert-Contains -Presented $errorVar -Expected "Error message" 

} Export-ModuleMember -Function SamplePsModuleTest_TraceMessage

function WriteAll
{
    [CmdletBinding()]
    param()

    Write-Output "Output message"

    Write-Host "Host message"
    Write-Information "Information message"

    Write-Warning "Warning message"
    
    Write-Error "Error message"
    
    Write-Debug "Debug message"
    
    Write-Verbose "Verbose message"

}