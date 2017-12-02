function New-SparkWebhook {
    <#
    .SYNOPSIS
        Create a Spark Webhook

    .DESCRIPTION
        Create a Spark Webhook

    .EXAMPLE
    #>
    [CmdletBinding()]
    param(
        $Name,
        $URL,
        $Resource = "messages",
        $Event = "created",
        $Filter,
        $Secret,
        $Token = $Script:PSSpark.Token
    )

    $Body = @{}

    switch ($PSBoundParameters.Keys) {
        "Name"      { $Body.Add("name", $Name) }
        "URL"       { $Body.Add("targetUrl", $URL) }
        "Resource"  { $Body.Add("resource", $Resource) }
        "Event"     { $Body.Add("event", $Event) }
        "Filter"    { $Body.Add("filter", $Filter) }
        "Secret"    { $Body.Add("secret", $Secret) }
    }

    $Params = @{
        Uri = $Script:PSSpark.Uri + "webhooks"
        ContentType = "application/json; charset=utf-8"
        Headers = @{ "Authorization" = "Bearer $Token" }
        Method = "Post"
        Body = $Body | ConvertTo-Json
    }

    $Params | Out-String | Write-Verbose

    $rawWebhooks = Invoke-RestMethod @Params
    Parse-SparkWebhook $rawWebhooks
}