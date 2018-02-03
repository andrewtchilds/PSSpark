function Parse-SparkWebhook {
    [cmdletbinding()]
    param(
        $InputObject
    )

    if($InputObject.items) {
        $InputObject = $InputObject.items
    }

    if($InputObject.count -le 0) {
        return
    }

    foreach($Webhook in $InputObject) {
        if($Webhook.created) {
            $Webhook.created = [datetime]($Webhook.created)
        }

        [PSCustomObject]@{
            PSTypeName = "PSSpark.Webhook"
            WebhookID = $Webhook.id
            Name = $Webhook.name
            URL = $Webhook.targetUrl
            Resource = $Webhook.resource
            Event = $Webhook.event
            Filter = $Webhook.filter
            Secret = $Webhook.secret
            Created = $Webhook.created
        }
    }
}