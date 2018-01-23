function Set-PSSparkConfig {
    <#
    .SYNOPSIS
        Set the PSSpark module configuration

    .DESCRIPTION
        Set the PSSpark module configuration. This will include the Uri for the Cisco Spark API, and a token used for authorization.
        Configuration is stored on the filesystem, and also set in the $PSSpark module variable
        Get your token here: https://developer.ciscospark.com/getting-started.html

    .EXAMPLE
        PS C:\> Set-PSSparkConfig -Uri "https://api.ciscospark.com/v1/" -Token "[your token here]"
    #>
    [cmdletbinding()]
    param(
        $Uri = $Script:PSSpark.Uri,
        $Token = $Script:PSSpark.Token
    )

    switch($PSBoundParameters.Keys) {
        "Uri"   { $Script:PSSpark.Uri = $Uri }
        "Token" { $Script:PSSpark.Token = $Token }
    }

    $Script:PSSpark | Export-Clixml -Path "$Env:TEMP\$Env:USERNAME-$Env:COMPUTERNAME-PSSparkConfig.xml"
}