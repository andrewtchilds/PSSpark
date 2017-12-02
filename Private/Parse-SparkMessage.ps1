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
        [PSCustomObject]@{
            PSTypeName = "PSSpark.Message"
            MessageID = $Message.id
            RoomID = $Message.roomId
            RoomType = $Message.roomType
            Text = $Message.text
            UserID = $Message.personId
            Email = $Message.personEmail
            Created = [datetime]($Message.created)
        }
    }
}