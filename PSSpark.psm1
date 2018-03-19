# Enable TLS 1.1 and 1.2 support
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12, [System.Net.SecurityProtocolType]::Tls11, [System.Net.SecurityProtocolType]::Tls

# Create a configuration file if it doesn't exist to store the Spark API token
if(-not (Test-Path "$Env:TEMP\$Env:USERNAME-$Env:COMPUTERNAME-PSSparkConfig.xml")) {
    [PSCustomObject]@{
        Uri = "https://api.ciscospark.com/v1/"
        Token = $null
    } | Export-Clixml -Path "$Env:TEMP\$Env:USERNAME-$Env:COMPUTERNAME-PSSparkConfig.xml"
}

$PSSpark = Import-Clixml -Path "$Env:TEMP\$Env:USERNAME-$Env:COMPUTERNAME-PSSparkConfig.xml"

# Taken from http://overpoweredshell.com/Working-with-Plaster/

$functionFolders = @('Public', 'Private', 'Classes')
ForEach ($folder in $functionFolders)
{
    $folderPath = Join-Path -Path $PSScriptRoot -ChildPath $folder
    If (Test-Path -Path $folderPath)
    {
        Write-Verbose -Message "Importing from $folder"
        $functions = Get-ChildItem -Path $folderPath -Filter '*.ps1'
        ForEach ($function in $functions)
        {
            Write-Verbose -Message "  Importing $($function.BaseName)"
            . $($function.FullName)
        }
    }
}
$publicFunctions = (Get-ChildItem -Path "$PSScriptRoot\Public" -Filter '*.ps1').BaseName
Export-ModuleMember -Function $publicFunctions