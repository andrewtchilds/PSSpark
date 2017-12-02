function Send-SparkAPI {
    <#
    .SYNOPSIS
        Helper function for talking to the Spark API

    .DESCRIPTION
        Helper function for talking to the Spark API

    .EXAMPLE
    #>
    [cmdletbinding()]
    param(
        $Method,
        $Query,
        $Token = $Script:PSSpark.Token
    )

    $Params = @{
        Uri = $Script:PSSpark.Uri + $Method
        ContentType = "application/json; charset=utf-8"
        Headers = @{ "Authorization" = "Bearer $Token" }
    }

    if($Query) {
        $Params.Uri += "?"

        foreach($q in $Query) {
            $Params.Uri += "$q&"
        }
    }

    $Params | Out-String | Write-Verbose

    Invoke-RestMethod @Params
}