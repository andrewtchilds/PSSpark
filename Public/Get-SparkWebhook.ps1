function Get-SparkWebhook {
    <#
    .SYNOPSIS
        Get a Spark Webhook

    .DESCRIPTION
        Get a Spark Webhook

    .EXAMPLE
    #>
    [CmdletBinding()]
    param(
        $Token = $Script:PSSpark.Token
    )

    $Params = @{
        Method = "webhooks"
    }

    $rawWebhooks = Send-SparkAPI @Params
    Parse-SparkWebhook $rawWebhooks
}