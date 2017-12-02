function Parse-SparkWebhook {
    [cmdletbinding()]
    param(
        $InputObject
    )

    if($InputObject.items) {
        $InputObject = $InputObject.items
    }

    if(($InputObject.count -le 0) -and ($InputObject -is [Object[]])) {
        return
    }

    foreach($Webhook in $InputObject) {
        [PSCustomObject]@{
            PSTypeName = "PSSpark.Webhook"
            WebhookID = $Webhook.id
            Name = $Webhook.name
            URL = $Webhook.targetUrl
            Resource = $Webhook.resource
            Event = $Webhook.event
            Filter = $Webhook.filter
            Secret = $Webhook.secret
            Created = [datetime]($Message.created)
        }
    }
}