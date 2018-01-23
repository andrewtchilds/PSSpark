function Parse-SparkTeam {
    [cmdletbinding()]
    param(
        [array]$InputObject
    )

    if($InputObject.items) {
        $InputObject = $InputObject.items
    }

    if($InputObject.count -le 0) {
        return
    }

    foreach($Team in $InputObject) {
        [PSCustomObject]@{
            PSTypeName = "PSSpark.Team"
            Name = $Team.name
            Created = [datetime]($Team.created)
            TeamID = $Team.id
            CreatorID = $Team.creatorId
        }
    }
}