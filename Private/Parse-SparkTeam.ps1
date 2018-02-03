function Parse-SparkTeam {
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

    foreach($Team in $InputObject) {
        if($Team.created) {
            $Team.created = [datetime]($Team.created)
        }

        [PSCustomObject]@{
            PSTypeName = "PSSpark.Team"
            Name = $Team.name
            Created = $Team.created
            TeamID = $Team.id
            CreatorID = $Team.creatorId
        }
    }
}