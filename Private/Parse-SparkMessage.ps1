function Parse-SparkMessage {
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

    foreach($Message in $InputObject) {
        if($Message.created) {
            $Message.created = [datetime]($Message.created)
        }

        [PSCustomObject]@{
            PSTypeName = "PSSpark.Message"
            MessageID = $Message.id
            RoomID = $Message.roomId
            RoomType = $Message.roomType
            Text = $Message.text
            UserID = $Message.personId
            Email = $Message.personEmail
            Created = $Message.created
        }
    }
}