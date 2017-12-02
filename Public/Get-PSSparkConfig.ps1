function Get-PSSparkConfig {
    <#
    .SYNOPSIS
        Get the PSSpark module configuration

    .DESCRIPTION
        Get the PSSpark module configuration. This will include the Uri for the Cisco Spark API, and a token used for authorization

    .EXAMPLE
        PS C:\> Get-PSSparkConfig

        Uri                            Token
        ---                            -----
        https://api.ciscospark.com/v1/ [your token here]
    #>
    $Script:PSSpark
}