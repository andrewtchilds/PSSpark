function Parse-SparkUser {
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

    foreach($User in $InputObject) {
        if($User.lastActivity) {
            $User.lastActivity = [datetime]($User.lastActivity)
        }

        if($User.created) {
            $User.created = [datetime]($User.created)
        }

        [PSCustomObject]@{
            PSTypeName = "PSSpark.User"
            Email = $User.emails
            Name = $User.displayName
            NickName = $User.nickName
            FirstName = $User.firstName
            LastName = $User.lastName
            Avatar = $User.avatar
            OrgID = $User.orgId
            Created = $User.created
            LastActivity = $User.lastActivity
            Status = $User.status
            Type = $User.type
            UserID = $User.id
        }
    }
}