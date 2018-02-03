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
        if($Room.lastActivity) {
            $Room.lastActivity = [datetime]($Room.lastActivity)
        }

        if($Room.created) {
            $Room.created = [datetime]($Room.created)
        }

        [PSCustomObject]@{
            PSTypeName = "PSSpark.Room"
            Name = $Room.title
            Type = $Room.type
            IsLocked = $Room.isLocked
            LastActivity = $Room.lastActivity
            Created = $Room.created
            RoomID = $Room.id
            CreatorID = $Room.creatorId
            TeamID = $Room.teamId
        }
    }
}