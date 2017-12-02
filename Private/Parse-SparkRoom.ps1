function Parse-SparkRoom {
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

    foreach($Room in $InputObject) {
        [PSCustomObject]@{
            PSTypeName = "PSSpark.Room"
            Name = $Room.title
            Type = $Room.type
            IsLocked = $Room.isLocked
            LastActivity = [datetime]($Room.lastActivity)
            Created = [datetime]($Room.created)
            RoomID = $Room.id
            CreatorID = $Room.creatorId
            TeamID = $Room.teamId
        }
    }
}