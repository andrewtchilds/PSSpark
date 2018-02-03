function Parse-SparkRoomMember {
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

    foreach($RoomMember in $InputObject) {
        if($RoomMember.created) {
            $RoomMember.created = [datetime]($RoomMember.created)
        }

        [PSCustomObject]@{
            PSTypeName = "PSSpark.RoomMember"
            RoomMemberID = $RoomMember.id
            RoomID = $RoomMember.roomId
            UserID = $RoomMember.personId
            Email = $RoomMember.personEmail
            OrgID = $RoomMember.personOrgId
            Moderator = $RoomMember.isModerator
            Monitor = $RoomMember.isMonitor
            Created = $RoomMember.created
        }
    }
}