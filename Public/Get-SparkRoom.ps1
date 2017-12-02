function Get-SparkRoom {
    <#
    .SYNOPSIS
        Get a Spark Room

    .DESCRIPTION
        Get a Spark Room

    .EXAMPLE
        PS C:\> Get-SparkRoom -Name Test

        Name         : Test
        Type         : group
        IsLocked     : True
        LastActivity : 2017-11-20 12:05:43 PM
        Created      : 2017-03-23 7:03:00 PM
        RoomID       : [RoomID]
        CreatorID    : [CreatorID]
        TeamID       : [TeamID]
    #>
    [cmdletbinding(DefaultParameterSetName = "Param")]
    param(
        [Parameter(ParameterSetName = "Param")]
        [string[]]$Name,

        [Parameter(ParameterSetName = "Param")]
        [ValidateSet("Group","Direct")]
        $GroupType,

        [Parameter(ParameterSetName = "Param",
                   ValueFromPipelineByPropertyName)]
        $TeamID,

        [Parameter(ParameterSetName = "SparkRoom",
                   ValueFromPipelineByPropertyName)]
        $RoomID,

        $Token = $Script:PSSpark.Token
    )

    process {
        if($PSCmdlet.ParameterSetName -eq "SparkRoom") {
            $Params = @{
                Method = "rooms/$RoomID"
            }
        } else {
            $Params = @{
                Method = "rooms"
            }
        }

        $Params.Query = @()

        switch($PSBoundParameters.Keys) {
            "GroupType" { $Params.Query += "type=$($GroupType.toLower())" }
            "TeamID"    { $Params.Query += "teamId=$($TeamID)" }
        }

        $rawRooms = Send-SparkAPI @Params
        $parsedRooms = Parse-SparkRoom $rawRooms

        if(-not $Name) {
            $parsedRooms
            return
        }

        $Rooms = @()

        foreach($n in $Name) {
            if($n -match "\*") {
                $Wildcard = $true
            }

            if(-not $Wildcard) {
                $Rooms += $parsedRooms | Where-Object { $_.Name -eq $n -and $Rooms -notcontains $_ }
            }

            if($Wildcard) {
                $Rooms += $parsedRooms | Where-Object { $_.Name -like $n -and $Rooms -notcontains $_ }
            }
        }

        $Rooms
    }
}