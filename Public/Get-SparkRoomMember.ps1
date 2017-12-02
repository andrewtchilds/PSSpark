function Get-SparkRoomMember {
    <#
    .SYNOPSIS
        Get a Spark Room Member

    .DESCRIPTION
        Get a Spark Room Member

    .EXAMPLE
        PS C:\> Get-SparkRoom -Name Test | Get-SparkRoomMember

        RoomMemberID : [RoomMemberID]
        RoomID       : [RoomID]
        UserID       : [UserID]
        Email        : johndoe@example.com
        UserOrgID    : [OrgID]
        Moderator    : False
        Monitor      : False
        Created      : 2017-10-28 2:25:49 AM
    #>
    [cmdletbinding()]
    param(
        [Parameter(ValueFromPipelineByPropertyName)]
        $RoomID,

        $Token = $Script:PSSpark.Token
    )

    process {
        $Params = @{
            Method = "memberships"
        }

        $Params.Query = @()

        switch($PSBoundParameters.Keys) {
            "RoomID" { $Params.Query += "roomId=$($RoomID)" }
        }

        $rawRoomMembers = Send-SparkAPI @Params
        Parse-SparkRoomMember $rawRoomMembers
    }
}