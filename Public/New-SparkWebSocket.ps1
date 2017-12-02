function New-SparkWebSocket {
    <#
    .SYNOPSIS
        Create a Spark WebSocket

    .DESCRIPTION
        Create a Spark WebSocket

    .EXAMPLE
    #>
    [CmdletBinding()]
    param(
        $Uri = "https://wdm-a.wbx2.com/wdm/api/v1/devices",
        $Token = $Script:PSSpark.Token
    )

    $Body = @{
        deviceName = "PowerShellWebsocket-client"
        deviceType = "DESKTOP"
        name = "PowerShell-spark-client"
        model = "PowerShell"
        localizedModel = "PowerShell"
        systemName = "PowerShell-spark-client"
        systemVersion = "0.0.1"
    }

    $Params = @{
        Uri = $Uri
        ContentType = "application/json; charset=utf-8"
        Headers = @{ "Authorization" = "Bearer $Token" }
        Method = "Post"
        Body = $Body | ConvertTo-Json
    }

    Invoke-RestMethod @Params
}